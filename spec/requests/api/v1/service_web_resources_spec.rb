# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ServiceWebResources', type: :request do
  include RequestSpecHelper

  let!(:resource) { create(:service_web_resource) }
  let(:serialized_resource) do
    {
      'addresses' => [],
      'desc' => 'A place to stay',
      'name' => 'Shelter House',
      'phones' => []
    }
  end

  describe 'GET /index' do
    before do
      get api_v1_service_web_resources_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the expected response' do
      expect(data).to match_array([serialized_resource])
    end
  end

  describe 'GET /show' do
    before do
      get api_v1_service_web_resource_path(resource.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the expected response' do
      expect(data).to eq(serialized_resource)
    end
  end
end
