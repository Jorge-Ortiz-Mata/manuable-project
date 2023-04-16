module Api
  module V1
    class RatesController < ApplicationController
      def shipping_rates
        response = send_http_request

        if response.status.eql? 200
          render json: { response: JSON.parse(response.body) }, status: :ok
        else
          render json: { response: 'Error while retrieving information' }, status: :unprocessable_entity
        end
      end

      private

      def send_http_request
        url = 'https://apis-sandbox.fedex.com/rate/v1/rates/quotes'

        response = Faraday.post(url) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['authorization'] = request.headers["HTTP_AUTHORIZATION"]
          req.body = body_params
        end

        response
      end

      def body_params
        {
          "accountNumber": {
              "value": request.headers["HTTP_ACCOUNT"]
          },
          "requestedShipment": {
            "currency": "mxn",
            "preferredCurrency": "NMP",
            "shipper": {
              "address": address_params('address_from')
            },
            "recipient": {
              "address": address_params('address_to')
            },
            "pickupType": "DROPOFF_AT_FEDEX_LOCATION",
            "packagingType": "YOUR_PACKAGING",
            "rateRequestType": [
              "LIST",
              "ACCOUNT"
            ],
            "requestedPackageLineItems": [
              {
                "weight": weight_params,
                "dimensons": parcel_params
              }
            ]
          }
        }.to_json
      end

      def address_params(param)
        {
          'countryCode': params['quote_params'][param]['country'].upcase,
          'postalCode': params['quote_params'][param]['zip'].to_i,
        }
      end

      def parcel_params
        {
          'length': params['quote_params']['parcel']['length'].to_f,
          'height': params['quote_params']['parcel']['height'].to_f,
          'distance_unit': params['quote_params']['parcel']['distance_unit'].upcase,
          'width': params['quote_params']['parcel']['width'].to_f
        }
      end

      def weight_params
        {
          'units': params['quote_params']['parcel']['mass_unit'].upcase,
          'value': params['quote_params']['parcel']['weight'].to_f,
        }
      end
    end
  end
end
