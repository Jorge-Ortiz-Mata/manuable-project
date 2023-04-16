require_relative 'rates'

module Fedex
  class Engine < ::Rails::Engine
    isolate_namespace Fedex
  end

  module Sessions
    def self.authenticate_token(client_id, client_secret)
      url = 'https://apis-sandbox.fedex.com/oauth/token'
      data = {
        :grant_type => 'client_credentials',
        :client_id => "#{client_id}",
        :client_secret => "#{client_secret}"
      }

      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(data)
      end

      response
    end
  end

  module Rates
    def self.set_shipping_rates(access_token, account_id, params)
      url = 'https://apis-sandbox.fedex.com/rate/v1/rates/quotes'

      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['authorization'] = "#{access_token}"
        req.body = body_params(account_id, params)
      end

      if response.status.eql? 200
        return { shipping_rates: build_reponse(response), status: 200 }
      else
        return { shipping_rates: [], status: response.status }
      end
    end
  end
end
