# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users' do
  include RequestSpecHelper

  let!(:user) { create(:user, username:, password:) }
  let(:username) { 'test_user_1' }
  let(:password) { 'p@ssw@rd' }
  let(:user_id) { user.id }
  let(:json_header) { { 'Content-Type' => 'application/json' } }
  let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
  let!(:token) { login_user_for_token(user.username, password) }

  let(:avatar_file) { Rails.root.join('spec/fixtures/images/user_avatar.png') }
  let(:params) do
    {
      username: 'jgates',
      password: 'hello',
      avatar: Rack::Test::UploadedFile.new(avatar_file, 'image/png')
    }
  end

  # Disabling cop because :cloudinary does expose #url but do not
  # want to setup test env with Cloudinary.
  # rubocop:disable RSpec/VerifiedDoubles
  let(:attachment) { double(ActiveStorage::Attached::One, url: 'https://photo.jpg') }
  # rubocop:enable RSpec/VerifiedDoubles

  before do
    allow(ActiveStorage::Attached::One).to receive(:new).and_return(attachment)
  end

  describe 'GET#show' do
    subject(:show_user) do
      get api_v1_user_path(user_id), headers:
    end

    before { show_user }

    context 'when signed in' do
      let(:expected_data) do
        {
          'token' => a_kind_of(String),
          'user' => {
            'username' => user.username,
            'avatar_url' => 'https://photo.jpg'
          }
        }
      end

      it 'returns the user' do
        expect(data).to include(expected_data)
      end
    end

    context 'when not signed in' do
      let(:user_id) { 1 }
      let(:headers) { json_header }
      let(:expected_errors) { { 'message' => 'Please log in' } }

      it 'returns an error' do
        expect(errors).to eq(expected_errors)
      end

      it 'does not return data' do
        expect(data).to be_nil
      end
    end

    context 'when attempting to access a different user by params' do
      let!(:token) { login_user_for_token(user.username, password) }
      let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
      let(:user_id) { user.id + 1 }

      it 'returns the user defined by the JWT' do
        expect(data.dig('user', 'username')).to eq(user.username)
      end
    end
  end

  describe 'POST#create' do
    subject(:create_user) do
      post api_v1_users_path, params:, headers: json_header
    end

    it 'creates a new user in the database' do
      expect { create_user }.to change(User, :count).by(1)
    end

    it 'returns the new user' do
      create_user
      expect(data['user']).to include('username' => 'jgates')
    end

    it 'returns the token' do
      create_user
      expect(data['token']).to be_a(String)
    end
  end

  describe 'PATCH#update' do
    subject(:update_user) do
      patch "/api/v1/users/#{user.id}", params: params.to_json, headers:
    end

    let(:expected_username) { 'jgates' }

    before { update_user }

    it 'updates the username' do
      expect(data.dig('user', 'username')).to eq(expected_username)
    end
  end
end
