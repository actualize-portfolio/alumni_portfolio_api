# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/github_repos' do
  path '/api/v1/github_repos' do
    get('list github_repos') do
      tags 'Github Repos'
      description 'Github Repo Index'
      operationId 'githubRepoIndex'
      produces 'application/json'
      response(200, 'successful') do
        schema(
          type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                '$ref' => '#/components/schemas/github_repo'
              }
            },
            errors: {
              type: :array,
              items: {
                type: :object
              }
            }
          }
        )

        run_test!
      end
    end
  end
end
