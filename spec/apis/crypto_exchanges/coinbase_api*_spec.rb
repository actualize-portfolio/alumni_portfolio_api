# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchanges::CoinbaseApi do
  subject(:coinbase_api) { described_class.new('BTC', 'USD') }

  it 'has a BASE_URL' do
    expect(described_class::BASE_URL).to eq('https://api.exchange.coinbase.com')
  end

  describe '#symbol' do
    it 'returns the symbol' do
      expect(coinbase_api.symbol).to eq('BTC-USD')
    end
  end

  describe '#orderbook', vcr: true do
    it 'returns result object' do
      expect(coinbase_api.orderbook).to be_a_kind_of(CryptoExchanges::CryptoExchangeResult)
    end

    context 'when symbol is invalid' do
      it 'raises error' do
        expect do
          described_class.new('BTC',
                              'INVALID').orderbook
        end.to raise_error(RuntimeError, 'Call to https://api.exchange.coinbase.com failed')
      end
    end
  end
end
