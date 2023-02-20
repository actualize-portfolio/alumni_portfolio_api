# frozen_string_literal: true

# Provides methods to obtain info about a Repo and to aid in making requests to api.github.com
class GithubRepo < ApplicationRecord
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

    update!(data: response) if response.is_a?(Hash) && response['id']
  end

  private

  def name
    data['name']
  end

  def full_name
    data['full_name']
  end

  def forks_count
    @forks_count ||= data['forks_count'] || 0
  end

  def watchers_count
    @watchers_count ||= data['watchers_count'] || 0
  end

  def popularity_rating
    weighted_average = ((forks_count * FORKS_COUNT_WEIGHT) +
                       (watchers_count * WATCHERS_COUNT_WEIGHT)) / NUMBER_OF_WEIGHTS

    weighted_average.round
  end
end
