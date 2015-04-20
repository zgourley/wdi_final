Rails.application.routes.draw do
root  'posts#index'

get   '/posts' => 'posts#index'

post  '/posts' => 'posts#create'

get   '/posts/new' => 'posts#new' , as: 'new_post'

get   'posts/:id/edit' => 'posts#edit', as: 'edit_post'

get   '/posts/:id' => 'posts#show', as: 'post'

put   'posts/:id/' => 'posts#update'
patch 'posts/:id/' => 'posts#update'

delete 'posts/:id' => 'posts#destroy'
end
