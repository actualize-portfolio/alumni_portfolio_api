# frozen_string_literal: true

module Api
  module V1
    # GithubRepos Controller
    class GithubReposController < ApplicationController
      before_action :authorize_user

      def index
        result = GithubRepos::Index.call(params: index_params)

        if result.success?
          render_success(result.github_repos.map { |repo| GithubRepoSerializer.new(repo) })
        else
          render_error(result.errors)
        end
      end

      private

      def index_params
        params.permit(:category)
      end
    end
  end
end
