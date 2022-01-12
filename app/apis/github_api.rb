# frozen_string_literal: true

class GithubApi
  attr_reader :base_uri

  BASE_URL = 'https://api.github.com'
  HEADERS = { 'Accept' => 'application/vnd.github.v3+json' }.freeze

  def initialize(username)
    @base_uri = "users/#{username}"
  end

  def user
    JSON.parse(faraday_client.get(base_uri).body)
  end

  def repositories(query_params = {})
    JSON.parse(faraday_client.get("#{base_uri}/repos", query_params).body)
  end

  def repository(project)
    JSON.parse(faraday_client.get("#{base_uri}/repos/#{project}").body)
  end

  private

  def faraday_client
    Faraday.new(BASE_URL) do |conn|
      conn.use(
        Faraday::Request::BasicAuthentication,
        ENV['GITHUB_USERNAME'],
        ENV['GITHUB_API_TOKEN']
      )
      conn.headers = HEADERS
    end
  end
end
