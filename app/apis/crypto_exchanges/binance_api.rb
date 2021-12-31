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
      faraday_client.get('v3/depth', { symbol: symbol, limit: 20 })
    end

    def orderbook_result
      orderbook
      response = JSON.parse(orderbook.body)
      cee = format_orderbook_result(response)
      { exchange: cee.exchange, max_bid: cee.min_ask, min_ask: cee.max_bid }
    end

    def orderbook_result_helper(response)
      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = response['bids'].map { |bid| bid[0].to_f }
        r.asks = response['asks'].map { |ask| ask[0].to_f }
        r.exchange = 'Binance.us'
      end
    end
  end
end
