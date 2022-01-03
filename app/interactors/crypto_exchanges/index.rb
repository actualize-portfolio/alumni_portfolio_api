# frozen_string_literal: true

module CryptoExchanges
  # Compiles results from crypto exchanges APIs and returns them to front end.
  class Index
    include Interactor

    def call
      context.crypto_exchanges = exchange_map
    end

    private

    def exchange_map
      exchanges.map do |exchange|
        boo = exchange.new(context.index_params[:base], context.index_params[:quote]).orderbook
        { exchange: boo.exchange, max_bid: boo.max_bid, min_ask: boo.min_ask }
        # rescue StandardError => e
        #   context.errors = e.full_message
      end
    end

    def exchanges
      [CryptoExchanges::CoinbaseApi,
       CryptoExchanges::BinanceApi]
      #  not working for CryptoCom for some reason.
      # CryptoExchanges::CryptoComApi
    end
  end
end
