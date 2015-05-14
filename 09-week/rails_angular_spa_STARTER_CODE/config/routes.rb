Rails.application.routes.draw do
  namespace :api do
    resources :dogs, only:[:index,:show,:update,:create, :destroy]
  end
end
