Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    post "sessions/authenticate/token", to: "sessions#authenticate_with_token"
    namespace :v1 do
      post "/shipping/rates", to: "sessions#shipping_rates"
    end
  end
end
