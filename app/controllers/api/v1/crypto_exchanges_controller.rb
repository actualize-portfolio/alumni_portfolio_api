# frozen_string_literal: true

module Api
  module V1
    # CryptoExchanges Controller
    class CryptoExchangesController < ApplicationController
      def index
        pp index_params
        result = CryptoExchanges::Index.call(index_params: index_params)
        if result.success?
          render_success(result[:crypto_exchanges])
        else
          render_error(result.errors)
        end
      end

      private

      def index_params
        { base: 'BTC', quote: 'USD' }
      end
    end
  end
end
