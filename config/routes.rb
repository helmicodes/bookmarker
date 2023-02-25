Rails.application.routes.draw do
  root "static#index"

  resources :users
  get "signup" => "users#new"

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"

  resources :links, as: "saves"
end
