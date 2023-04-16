Rails.application.routes.draw do
  mount Fedex::Engine => "/fedex"
end
