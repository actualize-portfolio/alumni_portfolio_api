# frozen_string_literal: true

# class for making GithubApi calls
class GithubApi
  attr_reader :username

  BASE_URL = 'https://api.github.com'
  HEADERS = { 'Accept' => 'application/vnd.github.v3+json' }.freeze

  def initialize(username)
    @username = username
  end

  def user
    JSON.parse(faraday_client.get("/users/#{username}").body)
  end

  def repositories(query_params = {})
    JSON.parse(faraday_client.get("/users/#{username}/repos", query_params).body)
  end

  def repository(project)
    JSON.parse(faraday_client.get("/repos/#{username}/#{project}").body)
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
