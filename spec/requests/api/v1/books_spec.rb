# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }
  let!(:book1) { create(:book) }
  let!(:book2) { create(:book) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  before do
    user.books << book2
  end

  describe 'GET /index' do
    let(:expected) do
      [
        {
          'author' => 'MyString',
          'id' => book1.id,
          'img_url' => 'MyString',
          'is_favorite' => false,
          'page_count' => 1,
          'title' => 'MyString'
        },
        {
          'author' => 'MyString',
          'id' => book2.id,
          'img_url' => 'MyString',
          'is_favorite' => true,
          'page_count' => 1,
          'title' => 'MyString'
        }
      ]
    end

    it 'returns http success' do
      get api_v1_books_path, headers: headers
      expect(response).to have_http_status(:success)
    end

    it 'returns book data' do
      get api_v1_books_path, headers: headers
      expect(data).to eq(expected)
    end
  end
end
