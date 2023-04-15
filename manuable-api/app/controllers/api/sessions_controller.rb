module Api
  class SessionsController < ApplicationController
    def authenticate_with_token
      conn = Faraday.new(
        url: 'https://apis-sandbox.fedex.com/oauth/token',
        params: user_params,
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
      )

      response = conn.post

      debugger

      render json: { response: response }
    end
  end
end
