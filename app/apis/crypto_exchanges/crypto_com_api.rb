# frozen_string_literal: true

module CryptoExchanges
  # Crypto.com API
  class CryptoComApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.crypto.com/v2/public'

    def symbol
      "#{base}_#{quote}"
    end

    def orderbook
      response = faraday_client.get('get-book', { instrument_name: symbol })
      body = JSON.parse(response.body)
      if body.dig('result', 'data')
        bids = body.dig('result', 'data', 0, 'bids')
        asks = body.dig('result', 'data', 0, 'asks')
        build_orderbook(bids, asks)
      else
        build_orderbook([], [])
      end
    end

    private

    def build_orderbook(bids, asks)
      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = bids.map { |bid| bid[0].to_f }
        r.asks = asks.map { |ask| ask[0].to_f }
        r.exchange = 'Crypto.com'
      end
    end
  end
end
