# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET /index' do
    it 'returns http success' do
      get api_v1_books_path, headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
