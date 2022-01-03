# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CryptoExchanges::BaseApi do
  subject(:base_api) { described_class.new('BTC', 'USDT') }

  describe '#initialize' do
    it 'sets the quote' do
      expect(base_api.quote).to eq('BTC')
    end

    it 'sets the base' do
      expect(base_api.base).to eq('USDT')
    end
  end

  describe 'private#symbol' do
    it 'raises error indicating symbol must be defined in child' do
      expect { base_api.send(:symbol) }.to raise_error(
        RuntimeError,
        'Symbol method must be implemented in subclass'
      )
    end
  end
end
