# frozen_string_literal: true

module CryptoExchanges
  # Coinbase API
  class CoinbaseApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.exchange.coinbase.com'

    def symbol
      "#{quote}-#{base}"
    end

    def orderbook
      response = faraday_client.get("products/#{symbol}/book", { level: 2 })

      raise "Call to #{self.class::BASE_URL} failed" unless response.success?

      build_orderbook(response)
    end

    private

    def build_orderbook(response)
      body = JSON.parse(response.body)

      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = body['bids'].map { |bid| bid[0].to_f }
        r.asks = body['asks'].map { |ask| ask[0].to_f }
        r.exchange = 'Coinbase Pro'
      end
    end
  end
end
