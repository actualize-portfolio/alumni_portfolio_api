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

  FORKS_COUNT_WEIGHT = 1.2
  WATCHERS_COUNT_WEIGHT = 1.1
  NUMBER_OF_WEIGHTS = 2

  def fetch_repo_data!
    return unless organization && project

    response = GithubApi.new(organization.gsub(' ', '_')).repository(project.gsub(' ', '_'))

    @repo_data = response if response.is_a?(Hash) && response['id']

    save!
  end

  private

  def name
    repo_data['name']
  end

  def full_name
    repo_data['full_name']
  end

  def forks_count
    @forks_count ||= repo_data['forks_count']
  end

  def watchers_count
    @watchers_count ||= repo_data['watchers_count']
  end

  def popularity_rating
    weighted_average = ((forks_count * FORKS_COUNT_WEIGHT) +
                       (watchers_count * WATCHERS_COUNT_WEIGHT)) / NUMBER_OF_WEIGHTS

    weighted_average.round
  end
end
