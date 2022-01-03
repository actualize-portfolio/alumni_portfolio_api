# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::CryptoExchanges', type: :request do
  include RequestSpecHelper
  let!(:base) { 'BTC' }
  let!(:quote) { 'USDC' }

  let(:params) do
    {
      base: base,
      quote: quote
    }
  end

  describe 'GET#index' do
    subject(:index_crypto_exchanges) do
      get api_v1_crypto_exchanges_path, params: params
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns bid-ask data' do
      expect(data).to include({})
    end
  end
end
