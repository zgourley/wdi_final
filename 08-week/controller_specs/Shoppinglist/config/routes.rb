Rails.application.routes.draw do
  resources :items

# $ rake routes
# get "items/" => "items#index"
# get "items/:id" => "items#show", as: :item
# get "items/new" => "items#new", as: :new_item


#    items GET    /items(.:format)          items#index
#           POST   /items(.:format)          items#create
#  new_item GET    /items/new(.:format)      items#new
# edit_item GET    /items/:id/edit(.:format) items#edit
#      item GET    /items/:id(.:format)      items#show
#           PATCH  /items/:id(.:format)      items#update
#           PUT    /items/:id(.:format)      items#update
#           DELETE /items/:id(.:format)      items#destroy

end
