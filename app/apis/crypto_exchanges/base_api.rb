# frozen_string_literal: true

module CryptoExchanges
  # Base api for crypto exchanges
  class BaseApi
    attr_reader :quote, :base

    def initialize(quote, base)
      @quote = quote
      @base = base
    end

    private

    def faraday_client
      Faraday.new(self.class::BASE_URL)
    end

    def symbol
      raise 'Symbol method must be implemented in subclass'
    end
  end
end
