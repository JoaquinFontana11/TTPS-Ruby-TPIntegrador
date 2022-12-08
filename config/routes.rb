Rails.application.routes.draw do
  get 'branchoffices/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "sessions#home"

  resources :users, only: [:new, :create, :updatePassword]

  get "/login", to: "sessions#login", as: "login"
  post "/login", to: "sessions#create"
  post "/logout", to: "sessions#destroy"
  get "/logout", to: "sessions#destroy"
  get "/register", to: "sessions#register", as: "register"
  post "/register", to: "sessions#create_client"

  get "/users/home", to: "users#home", as: "users_home"
  get "users/:id", to: "users#show", as: "user_show" 
  get "users/:id/edit", to: "users#edit", as: "user_edit"
  post "users/:id/update", to: "users#update", as: "user_update"
  delete "users/:id", to: "users#destroy", as: "user_destroy" 

  get "/updatePassword/:id", to: "users#updatePassword", as: "update_password"
  post "/updatePassword/:id", to: "users#changePasword"

  get "/branchoffices/new", to: "branchoffices#new", as: "branchoffice_new"
  post "/branchoffices/create", to: "branchoffices#create", as: "branchoffice_create"
  get "/branchoffices/:id/edit", to: "branchoffices#edit", as: "branchoffice_edit"
  post "/branchoffices/:id/update", to: "branchoffices#update"
  delete "/branchoffices/home", to: "branchoffices#destroy", as: "branchoffice_destroy"

  get "/schedule/new", to: "branchoffices#new_schedule", as: "schedule_new"
  post "/schedule/create", to: "branchoffices#create_schedule", as: "schedule_create"
  get "/schedule/view", to: "branchoffices#view_schedule", as: "schedule_view"
  get "/schedule/edit", to: "branchoffices#edit_schedule", as: "schedule_edit"
  post "/schedule/update", to: "branchoffices#update_schedule"

  get "turns/home", to: "turns#home", as: "turns_home"
  get "turns/new", to: "turns#new", as:"turn_new"
  post "turn/create", to: "turns#create", as: "turn_create"
  get "turns/:id", to: "turns#show", as: "turn_show"
  get "turns/:id/edit", to: "turns#edit", as:"turn_edit"
  post "turns/:id/update", to: "turns#update", as:"turn_update"
  get "/turns/:id/attend", to: "turns#attend", as: "turn_attend"
  post "turns/:id/attended", to: "turns#attended", as: "turn_attended"
  delete "turns/:id", to: "turns#destroy", as: "turn_destroy"


end
