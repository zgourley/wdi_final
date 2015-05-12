Rails.application.routes.draw do
  namespace :api do
    resources :todos, only: [:index, :create, :update, :destroy]
  end
end
