# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  include RequestSpecHelper

  describe 'POST /login' do
    subject(:attempt_login) do
      post api_v1_login_path, params: params.to_json, headers: headers
    end

    let!(:user) { create(:user, password: password) }

    let(:password) { 'p@ssw@rd' }
    let(:params) { { username: user.username, password: password } }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before { attempt_login }

    context 'when user exists' do
      let(:expected) do
        {
          'token' => a_kind_of(String),
          'user' => { 'username' => user.username, 'avatar_url' => nil, 'age' => user.age }
        }
      end

      it 'returns the logged in user and a token' do
        expect(data).to include(expected)
      end
    end

    context 'when user does not exist' do
      let(:params) { { username: 'non_user', password: password } }
      let(:expected) { { 'error' => 'Invalid username or password' } }

      it 'returns nil data' do
        expect(data).to be_nil
      end

      it 'returns error' do
        expect(errors).to eq(expected)
      end
    end
  end
end
