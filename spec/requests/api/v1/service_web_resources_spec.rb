# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ServiceWebResources', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get api_v1_service_web_resources_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get api_v1_service_web_resources_path(1)
      expect(response).to have_http_status(:success)
    end
  end
end
