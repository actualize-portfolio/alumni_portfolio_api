# frozen_string_literal: true

module GithubRepos
  # Compiles results from concert APIs and asynchronously calls a procedure to
  # update or add them to the DB.
  class Index
    include Interactor

    def call
      context.github_repos = repos
    end

    private

    def repos
      category = context.params[:category]

      if category&.in?(GithubRepo.categories.keys)
        GithubRepo.public_send(category)
      else
        GithubRepo.all
      end
    end
  end
end
