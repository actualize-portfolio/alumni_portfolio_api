# frozen_string_literal: true

# Iterates over each GithubRepos and updates the data.
class UpdateGithubReposJob < ApplicationJob
  def perform
    GithubRepo.all.each(&:fetch_repo_data!)
  end
end
