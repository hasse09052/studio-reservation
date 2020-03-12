Rails.application.routes.draw do
  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/reservations/table/:week", to: "reservations#index"
  get "/reservations/new/:year/:month/:day/:hour/:minute", to: "reservations#new"
  post "/reservations/new/:year/:month/:day/:hour/:minute", to: "reservations#create"

  post "/mylists/:reservation_id/create", to: "mylists#create"
  delete "/mylists/:reservation_id/destroy", to: "mylists#destroy"
  
  resources :users
  resources :reservations, except: [:index, :new, :create]
  resources :mylists, only: [:create, :destroy]

end
