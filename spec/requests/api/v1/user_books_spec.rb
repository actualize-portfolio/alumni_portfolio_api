# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::UserBooks', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }
  let!(:book) { create(:book) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET /create' do
    it 'returns http success' do
      post api_v1_user_books_path, params: { book_id: book.id }.to_json, headers: headers

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      create(:user_book, user: user, book: book)

      delete api_v1_user_book_path(book.id), headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end
