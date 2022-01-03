# frozen_string_literal: true

module CryptoExchanges
  # Crypto.com API
  class CryptoComApi < CryptoExchanges::BaseApi
    BASE_URL = 'https://api.crypto.com/v2/public'

    def symbol
      "#{quote}_#{base}"
    end

    def orderbook
      response = faraday_client.get('get-book', { instrument_name: symbol })

      raise "Call to #{self.class::BASE_URL} failed" unless response.success?

      build_orderbook(response)
    end

    private

    def build_orderbook(response)
      body = JSON.parse(response.body)
      bids = body.dig('result', 'data', 0, 'bids')
      asks = body.dig('result', 'data', 0, 'asks')

      CryptoExchanges::CryptoExchangeResult.new do |r|
        r.bids = bids.map { |bid| bid[0].to_f }
        r.asks = asks.map { |ask| ask[0].to_f }
        r.exchange = 'Crypto.com'
      end
    end
  end
end
