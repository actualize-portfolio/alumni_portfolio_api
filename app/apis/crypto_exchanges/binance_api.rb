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
  end
end
