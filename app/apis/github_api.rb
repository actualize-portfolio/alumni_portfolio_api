# frozen_string_literal: true

# class for making GithubApi calls
class GithubApi
  attr_reader :user_or_org

  BASE_URL = 'https://api.github.com'
  HEADERS = { 'Accept' => 'application/vnd.github.v3+json' }.freeze

  def initialize(user_or_org)
    @user_or_org = user_or_org
  end

  def user
    parse_response!(faraday_client.get("/users/#{user_or_org}"))
  end

  def repositories(query_params = {})
    parse_response!(faraday_client.get("/users/#{user_or_org}/repos", query_params))
  end

  def repository(project)
    parse_response!(faraday_client.get("/repos/#{user_or_org}/#{project}"))
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

  def parse_response!(response)
    raise 'Sorry Repo or project not found' unless response.success?

    JSON.parse(response.body)
  rescue StandardError
    Rails.logger.error(response.body)
  end
end
