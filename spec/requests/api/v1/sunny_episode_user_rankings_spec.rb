# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodeUserRankings', type: :request do
  xdescribe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/sunny_episode_user_rankings/index'
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/sunny_episode_user_rankings/create'
      expect(response).to have_http_status(:success)
    end
  end
end
