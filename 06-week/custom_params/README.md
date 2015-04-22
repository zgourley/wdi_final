Implement a simple search with custom params in RoR
====
Here are the steps:

1. Handle the query in the controller. When a user goes to
   `/users?q=chuck` we will render a view with a list of all
users with the name chuck.

    For this we check the params hash in the controller and then perform
a SQL query based on the `params[:q]` value.
    If you want to have a case insensitive search change `like` for
`ilike`

    ```ruby
    #app/controllers/user_controller.rb
    def index
        if params[:q]
            @users = User.where('name like ?', '%' + params[:q] + '%'
        else
            @users = User.all
        end
    end
    ```
    
2. Create a form in the `app/views/users/index.html.erb` page like so

    ```
    <%= form_tag(users_path, method: 'get')%>
     <%= text_field_tag(:q)%>
     <%= submit_tag("Search") %>
    <%= end %>
    ```
