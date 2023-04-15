module Api
  class SessionsController < ApplicationController
    def authenticate_with_token
      client_params
      url = 'https://apis-sandbox.fedex.com/oauth/token'

      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(client_params)
      end

      access_token = JSON.parse(response.body)['access_token']

      render json: { access_token: access_token }
    end

    private

    def client_params
      @data = {
        :grant_type => 'client_credentials',
        :client_id => request.headers['HTTP_CLIENT_ID'],
        :client_secret => request.headers['HTTP_CLIENT_SECRET']
      }
    end
  end
end
