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
  get "/schedule/view", to: "branchoffices#view_schedule", as: "schedule_view"
  get "schedule/edit", to: "branchoffices#edit_schedule", as: "schedule_edit"
  post "schedule/update", to: "branchoffices#update_schedule"
  delete "branchoffices/home", to: "branchoffices#destroy", as: "branchoffice_destroy"
end
