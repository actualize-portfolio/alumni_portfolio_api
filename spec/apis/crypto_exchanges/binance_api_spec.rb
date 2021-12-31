# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchanges::BinanceApi do
  subject(:binance_api) { described_class.new('BTC', 'USDT') }

  it 'has a BASE_URL' do
    expect(described_class::BASE_URL).to eq('https://api.binance.us/api')
  end

  describe '#symbol' do
    it 'returns the symbol' do
      expect(binance_api.symbol).to eq('BTCUSDT')
    end
  end

  describe '#orderbook', vcr: true do
    skip "you need to fill this in because I don't have api access"
  end
end
