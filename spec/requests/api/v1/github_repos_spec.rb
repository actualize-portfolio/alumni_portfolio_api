# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/github_repos', type: :request do
  path '/api/v1/github_repos' do
    get('list github_repos') do
      tags 'Github Repos'
      description 'Github Repo Index'
      operationId 'githubRepoIndex'
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       names: { type: :string },
                       full_name: { type: :string },
                       category: { type: :string },
                       forks_count: { type: :integer },
                       watchers_count: { type: :integer },
                       popularity_rating: { type: :integer }
                     }
                   }
                 },
                 errors: {
                   type: :array,
                   items: {
                     type: :object
                   }
                 }
               }

        run_test!
      end
    end
  end
end
