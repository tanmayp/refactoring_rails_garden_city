Rails.application.routes.draw do
  resources :users
  resources :signups

  get '/signup', to: "signups#new"
end
