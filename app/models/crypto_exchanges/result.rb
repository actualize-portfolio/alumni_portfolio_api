# frozen_string_literal: true

module CryptoExchanges
  # Class for forming correct response
  class Result
    attr_accessor :bids, :asks, :exchange

    def initialize
      yield self if block_given?
    end

    def max_bid
      bids.max
    end

    def min_ask
      asks.min
    end
  end
end
