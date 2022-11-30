Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "sessions#home"

  resources :users, only: [:new, :create,:edit,:update, :show, :destroy, :updatePassword]

  get "/login", to: "sessions#login"
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  get "/logout", to: "sessions#destroy"
  get "/updatePassword/:id", to: "users#updatePassword", as: "update_password"
  post "/updatePassword/:id", to: "users#changePasword"
end
