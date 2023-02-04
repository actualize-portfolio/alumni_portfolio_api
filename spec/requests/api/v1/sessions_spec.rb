# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/sessions' do
  path '/api/v1/login' do
    post('login session') do
      before do
        create(:user, username: 'test@test.com', password: 'p@ssw@rd')
      end

      tags 'Sessions'
      description 'Returns a JWT'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        required: %i[username password],
        properties: {
          username: { type: :string },
          password: { type: :string }
        }
      }
      parameter name: :password, in: :body, type: :string, required: true
      response(200, 'successful') do
        let(:params) do
          {
            username: 'test@test.com',
            password: 'p@ssw@rd'
          }
        end
        schema '$ref' => '#/components/schemas/new_session'

        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) do
          {
            username: 'test@test.com',
            password: 'password'
          }
        end
        schema '$ref' => '#/components/schemas/unauthorized'

        run_test!
      end
    end
  end
end
