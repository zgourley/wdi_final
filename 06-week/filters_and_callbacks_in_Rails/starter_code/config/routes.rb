Rails.application.routes.draw do

  get "users" => "users#index"
  get "users/:id" => "users#show", as: :user
  post "users" => "users#create"
  get "signup" => "users#new"
  get "users/:id/edit" => "users#edit", as: :edit_user
  patch "users/:id" => "users#update"

  #routes for login
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
end
