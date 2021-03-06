# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodeUserRankings', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }
  let!(:bad_episode) { create(:sunny_episode) }
  let!(:good_episode) { create(:sunny_episode) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET /index' do
    it 'returns http success' do
      get api_v1_sunny_episode_user_rankings_path, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    let(:params) do
      { worse_id: bad_episode.id, better_id: good_episode.id }.to_json
    end

    it 'returns http success' do
      post api_v1_sunny_episode_user_rankings_path, params: params, headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
