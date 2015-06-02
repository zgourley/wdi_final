Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show]

  get "/signup" => "users#new", as: :new_user
  get "/login" => "sessions#new", as: :login
  post "/login" => "sessions#create"
end
