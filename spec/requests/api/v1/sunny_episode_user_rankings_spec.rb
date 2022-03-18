# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodeUserRankings', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/sunny_episode_user_rankings/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/sunny_episode_user_rankings/create'
      expect(response).to have_http_status(:success)
    end
  end
end
