Rails.application.routes.draw do
  get 'branchoffices/home'
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
  get "/branchoffices/new", to: "branchoffices#new", as: "branchoffice_new"
  post "/branchoffices/create", to: "branchoffices#create", as: "branchoffice_create"
  get "/schedule/new", to: "branchoffices#new_schedule", as: "schedule_new"
  post "/schedule/create", to: "branchoffices#create_schedule", as: "schedule_create"
end
