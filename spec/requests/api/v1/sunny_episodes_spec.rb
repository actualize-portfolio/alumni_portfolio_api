# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/sunny_episodes' do
  path '/api/v1/sunny_episodes' do
    get('list sunny_episodes') do
      tags 'Sunny Episodes'
      produces 'application/json'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:user) { create(:user) }
        let(:Authorization) do
          "Bearer #{JWT.encode({ user_id: user.id }, ENV.fetch('RAILS_MASTER_KEY'))}"
        end

        schema(
          type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                top_ten: {
                  type: :array,
                  items: {
                    '$ref' => '#/components/schemas/sunny_episode'
                  }
                },
                top_ten_by_user: {
                  type: :array,
                  items: {
                    '$ref' => '#/components/schemas/sunny_episode'
                  }
                }
              }
            }
          }
        )

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }

        schema(
          type: :object,
          properties: {
            errors: {
              type: :object,
              properties: {
                message: {
                  type: :string
                }
              }
            }
          }
        )

        run_test!
      end
    end
  end
end
