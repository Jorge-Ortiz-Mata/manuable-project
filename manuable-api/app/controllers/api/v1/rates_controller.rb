module Api
  module V1
    class RatesController < ApplicationController
      def shipping_rates
        res = Fedex::Rates.set_shipping_rates(
          request.headers["HTTP_AUTHORIZATION"],
          request.headers["HTTP_ACCOUNT"],
          params['quote_params']
        )

        if res[:shipping_rates].empty?
          render json: { results: res }, status: :unprocessable_entity
        else
          render json: { results: res[:shipping_rates] }, status: :ok
        end
      end
    end
  end
end
