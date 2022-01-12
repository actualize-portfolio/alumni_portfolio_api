# frozen_string_literal: true

module CryptoExchanges
  # Compiles results from crypto exchanges APIs and returns them to front end.
  class Index
    include Interactor

    def call
      context.crypto_exchanges = exchange_map.map(&:value!).flatten
    end

    private

    def exchange_map
      exchanges.map do |exchange|
        Concurrent::Promise.execute do
          exchange.new(context.index_params[:base], context.index_params[:quote]).orderbook
        end
      end
    end

    def exchanges
      [CryptoExchanges::CoinbaseApi,
       CryptoExchanges::BinanceApi,
       CryptoExchanges::CryptoComApi]
    end
  end
end
