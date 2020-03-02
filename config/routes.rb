Rails.application.routes.draw do
  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  #get "/reservations/table/:week", to: "reservations#table"
  # /reservations/new/2020/3/4/9
  get "/reservations/new/:year/:month/:day/:hour/:minute", to: "reservations#new"
  post "/reservations/new/:year/:month/:day/:hour/:minute", to: "reservations#create"
  
  resources :users
  resources :reservations, except: [:new, :create]

end
