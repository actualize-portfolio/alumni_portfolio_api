# frozen_string_literal: true

module CryptoExchanges
  # Binance API
  # https://github.com/binance-us/binance-official-api-docs/blob/master/rest-api.md#general-api-information
  class BinanceApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.binance.us/api'

    def symbol
      "#{base}#{quote}"
    end

    def orderbook
      response = faraday_client.get('v3/depth', { symbol: symbol, limit: 20 })

      return build_orderbook([], []) unless response.success?

      body = JSON.parse(response.body)

      build_orderbook(body['bids'], body['asks'])
    end

    private

    def build_orderbook(bids, asks)
      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = bids.map { |bid| bid[0].to_f }
        r.asks = asks.map { |ask| ask[0].to_f }
        r.exchange = 'Binance.us'
      end
    end
  end
end
