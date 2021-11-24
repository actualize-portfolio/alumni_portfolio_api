# frozen_string_literal: true

# Provides methods to obtain info about a Repo and to aid in making requests to api.github.com
class GithubRepo < ApplicationRecord
  attr_reader :repo_data

  enum category: {
    javascript_framework: 0,
    fullstack_framework: 10,
    language: 20
  }

  validates :organization, :project, presence: true
  validates :project, uniqueness: { scope: :organization }
  validate :repo_exists?

  GITHUB_API = 'https://api.github.com'
  HEADERS = { 'Accept' => 'application/vnd.github.v3+json' }.freeze

  FORKS_COUNT_WEIGHT = 1.2
  STARGAZERS_COUNT_WEIGHT = 1.5
  WATCHERS_COUNT_WEIGHT = 1.1
  NUMBER_OF_WEIGHTS = 3

  def fetch_repo_data!
    return unless organization && project

    response = faraday_client(fetch_repo_url).get

    @repo_data = JSON.parse(response.body) if response.success?
    Rails.logger.error(response.body) unless response.success?

    self
  end

  private

  def repo_exists?
    return if fetch_repo_data! && repo_data.present?

    errors.add :base, :invalid, message: 'repo cannot be found'
  end

  def fetch_repo_url
    File.join(GITHUB_API, 'repos', organization.gsub(' ', '_'), project.gsub(' ', '_'))
  end

  def name
    repo_data['name']
  end

  def full_name
    repo_data['full_name']
  end

  def forks_count
    @forks_count ||= repo_data['forks_count']
  end

  def stargazers_count
    @stargazers_count ||= repo_data['stargazers_count']
  end

  def watchers_count
    @watchers_count ||= repo_data['watchers_count']
  end

  def popularity_rating
    weighted_average = ((forks_count * FORKS_COUNT_WEIGHT) +
                       (stargazers_count * STARGAZERS_COUNT_WEIGHT) +
                       (watchers_count * WATCHERS_COUNT_WEIGHT)) / NUMBER_OF_WEIGHTS

    weighted_average.round
  end

  def faraday_client(url)
    Faraday.new(url: url) do |conn|
      conn.use(
        Faraday::Request::BasicAuthentication,
        ENV['GITHUB_USERNAME'],
        ENV['GITHUB_API_TOKEN']
      )
      conn.headers = HEADERS
    end
  end
end
