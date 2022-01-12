# frozen_string_literal: true

module CryptoExchanges
  # Coinbase API
  class CoinbaseApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.exchange.coinbase.com'

    def symbol
      "#{base}-#{quote}"
    end

    def orderbook
      response = faraday_client.get("products/#{symbol}/book", { level: 2 })
      return build_orderbook([], []) unless response.success?

      body = JSON.parse(response.body)
      build_orderbook(body['bids'], body['asks'])
    end

    private

    def build_orderbook(bids, asks)
      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = bids.map { |bid| bid[0].to_f }
        r.asks = asks.map { |ask| ask[0].to_f }
        r.exchange = 'Coinbase Pro'
      end
    end
  end
end
