module Api
  class SessionsController < ApplicationController
    def authenticate_with_token
      response = send_http_request

      if response.status.eql? 200
        access_token = JSON.parse(response.body)['access_token']
        render json: { access_token: access_token }, status: :ok
      else
        render json: { errors: 'Credentials are incorrect' }, status: :unauthorized
      end
    end

    private

    def send_http_request
      url = 'https://apis-sandbox.fedex.com/oauth/token'
      data = {
        :grant_type => 'client_credentials',
        :client_id => request.headers['HTTP_CLIENT_ID'],
        :client_secret => request.headers['HTTP_CLIENT_SECRET']
      }

      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(data)
      end

      response
    end
  end
end
