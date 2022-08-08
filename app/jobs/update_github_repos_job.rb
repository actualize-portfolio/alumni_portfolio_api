class UpdateGithubReposJob < ApplicationJob

  def perform
    GithubRepo.all.each { |repo| repo.fetch_repo_data! }
  end
end
