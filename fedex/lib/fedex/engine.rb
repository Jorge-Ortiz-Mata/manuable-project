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
    def self.shipping_rates
      set_shipping_rates
    end
  end
end
