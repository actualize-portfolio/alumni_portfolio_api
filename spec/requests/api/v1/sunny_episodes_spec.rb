# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodes', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/sunny_episodes/index'
      expect(response).to have_http_status(:success)
    end
  end
end
