# frozen_string_literal: true

# Metaprogammed class for fetching National Weather Service API Data.
# Upon instantiation, the OpenAPI definition is acquired and a method
# is created for each path, named by the operation_id of that path segment and
# accepting any {}-brace wrapped segment parameters as kwargs of the method.
# example:
#   if the path is `/alerts/active/region/{region}`:
# api = NationalWeatherServiceApi.new
#   => #<NationalWeatherServiceApi:0x000000011981bc20
#   @openapi=Openapi3Parser::Document(openapi_version: 3.0, root_source: Openapi3Parser::Source(input: https://api.weather.gov/openapi.json))>
#
# api.alerts_active_region(region: 'AL')
#   DEBUG -- request: GET https://api.weather.gov/alerts/active/region/AL
#   DEBUG -- request: User-Agent: "development123"
#   DEBUG -- response: Status 200
class NationalWeatherServiceApi
  attr_reader :openapi

  BASE_URL = 'https://api.weather.gov'
  USER_AGENT = ENV.fetch('NWS_API_USER_AGENT', 'development123')

  def initialize
    @openapi = Openapi3Parser.load_url("#{BASE_URL}/openapi.json")
    create_methods!
  end

  private

  def create_methods!
    openapi.paths.each do |path, path_item|
      define_singleton_method(path_item.get.operation_id) do |**args|
        parsed_path = NationalWeatherService::PathParser.parse(path, **args)
        response = faraday_client.get(parsed_path)
        response.success? ? JSON.parse(response.body) : response
      end
    end
  end

  def faraday_client
    @faraday_client ||= Faraday.new(url: BASE_URL) do |conn|
      conn.headers['User-Agent'] = USER_AGENT
      conn.response :logger, Rails.logger
    end
  end
end
