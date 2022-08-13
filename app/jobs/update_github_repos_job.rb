# frozen_string_literal: true

class UpdateGithubReposJob < ApplicationJob
  def perform
    GithubRepo.all.each(&:fetch_repo_data!)
  end
end
