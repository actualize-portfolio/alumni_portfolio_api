# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Books' do
  include RequestSpecHelper

  let!(:user) { create(:user, password:) }
  let!(:book1) { create(:book) }
  let!(:book2) { create(:book) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  before do
    user.books << book2
    get api_v1_books_path, headers:
  end

  describe 'GET /index' do
    let(:expected) do
      [
        {
          'id' => book1.id,
          'title' => book1.title,
          'author' => book1.author,
          'img_url' => book1.img_url,
          'page_count' => book1.page_count,
          'is_favorite' => false
        },
        {
          'id' => book2.id,
          'title' => book2.title,
          'author' => book2.author,
          'img_url' => book2.img_url,
          'page_count' => book2.page_count,
          'is_favorite' => true
        }
      ]
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns book data' do
      expect(data).to match_array(expected)
    end
  end
end
