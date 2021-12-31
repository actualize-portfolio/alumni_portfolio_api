# frozen_string_literal: true

module CryptoExchanges
  # Binance API
  # https://github.com/binance-us/binance-official-api-docs/blob/master/rest-api.md#general-api-information
  class BinanceApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.binance.us/api'

    def symbol
      "#{quote}#{base}"
    end

    def orderbook
      response = faraday_client.get('v3/depth', { symbol: symbol, limit: 20 })

      raise "Call to #{self.class::BASE_URL} failed" unless response.success?

      build_orderbook(response)
    end

    private

    def build_orderbook(response)
      body = JSON.parse(response.body)

      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = body['bids'].map { |bid| bid[0].to_f }
        r.asks = body['asks'].map { |ask| ask[0].to_f }
        r.exchange = 'Binance.us'
      end
    end
  end
end
