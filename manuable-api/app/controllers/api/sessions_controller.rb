module Api
  class SessionsController < ApplicationController
    def authenticate_with_token
      response = Fedex::Sessions.authenticate_token(request.headers['HTTP_CLIENT_ID'], request.headers['HTTP_CLIENT_SECRET'])

      if response.status.eql? 200
        access_token = JSON.parse(response.body)['access_token']
        render json: { access_token: access_token }, status: :ok
      else
        render json: { errors: 'Credentials are incorrect' }, status: :unauthorized
      end
    end
  end
end
