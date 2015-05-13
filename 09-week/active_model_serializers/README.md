#Active Model Serializers: A Super Awesome Gem

##Learning Objectives
* Think about API design and how to structure your response data (in this case, JSON)
* Use Active Model Serializers to give you more control over the JSON that your Rails API returns

##Roadmap
We'll start by talking about what we want our JSON to look like and then we'll customize the JSON that our sample blog app returns to the client.

After we finish that, I will give you another starter app and you will be responsible for customizing the JSON response using Active Model Serializers.

##Active Model Serializers: What and Why
Active Model Serializers is a gem that allows us to control the data and structure of our JSON response, without having to make use of a messy solution like extending Rails' "as_json" method.

##Add seed data to our blog app
* Let's start by adding some seed data to our development database:

    ```ruby
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all

    user = User.create(name: "Shawn Rodriguez", email: "shawn@example.com")

    posts = Post.create([
      {link: "https://yahoo.com", title: "Fun Stuff", user: user},
      {link: "https://google.com", title: "More Fun Stuff", user: user},
      {link: "https://espn.com", title: "Awesome Stuff", user: user},
      {link: "https://github.com", title: "This is cool Stuff", user: user}
    ])

    comments = Comment.create([
      {body: "what an awesome link!", user: user, post: Post.first},
      {body: "this link sux!", user: user, post: Post.first},
      {body: "i'm an internet troll, you guys!", user: user, post: Post.first}
    ])
    ```

##What we want our JSON output to look like
* Let's take a look at how our JSON gets rendered by default:

    ```javascript
    [
      {
        id: 1,
        link: "https://www.google.com",
        created_at: "2015-02-01T00:47:13.628Z",
        updated_at: "2015-02-01T00:47:13.628Z",
        title: "This is an awesome post!",
        user_id: 2
      }
    ]
    ```

* Here's what we want our JSON to look like:

    ```javascript
    [
      {
        id: 1,
        title: "This is an awesome post!",
        link: "https://www.google.com",
        created_at: "2015-02-01T00:47:13.628Z",
        poster: {
          name: "Larry Page"
        },
        comments: [
          {
            id: 6,
            body: "i'm an internet troll, you guys!",
            commenter: "Shawn Rodriguez",
            created_at: "2015-02-01T00:47:13.637Z"
          },
          {
            id: 5,
            body: "this link sux!",
            commenter: "Shawn Rodriguez",
            created_at: "2015-02-01T00:47:13.635Z"
          },
          {
            id: 4,
            body: "what an awesome link!",
            commenter: "Shawn Rodriguez",
            created_at: "2015-02-01T00:47:13.633Z"
          }
        ]
      }    
    ]
    ```

##Using Active Model Serializers
1. Next, add Active Model Serializers to your Gemfile:

    ```ruby
    gem 'active_model_serializers'
    ```
    **Don't forget to bundle!**

2. Let's start customizing our JSON:

    ```
    $ rails g serializer Post
    ```

    Let's take a look at the JSON that gets rendered now by going to `localhost:3000/api/posts`.  We need to do two things to make this data useful:

* We want to get rid of the root node in our JSON object. Including the root is a default of Active Model Serializers that we didn't have to deal with when we were just using Rails' defaults to serialize our JSON.  Let's add a method to our Application Controller to change Active Model Serializers' default behavior:

    ```ruby
    def default_serializer_options
      { root: false }
    end
    ```

* Okay, now that the root node called "posts" is gone, it would probably be helpful for us to return more than just an array of post IDs.  Let's open our Post Serializer file to see how we can modify the JSON we return:

    ```ruby
    class PostSerializer < ActiveModel::Serializer
      attributes :id, :title, :link, :created_at
    end
    ```

* Now let's add the user that created the post:

    ```ruby
    class PostSerializer < ActiveModel::Serializer
      attributes :id, :title, :link, :created_at

      has_one :user
    end
    ```

* Perfect, now the user that created the post is included in our JSON.  But "user" in this context isn't very semantic.  Let's give it a name that more clearly describes the user's relationship to this post.  We can pass in an options hash to the `has_one` method to change the root from `:user` to `:poster`:

    ```ruby
    has_one :user, root: :poster
    ```

* This is starting to look good, but perhaps we are returning more data than we want to about the user.  Let's create a serializer file for users to control exactly what data we send to the client:

    ```
    $ rails g serializer User
    ```

* If we look at our JSON now, we can see that we are only returning the user id.  Let's change it to only return the user's name:

  ```ruby
  class UserSerializer < ActiveModel::Serializer
    attributes :name
  end
  ```

* Because we are only returning a single attribute of the user, it doesn't necessarily make sense to nest an entire object inside the "poster" property.  Instead, we could write a method in our post serializer that will just return a string of the user's name:

    ```ruby
        class PostSerializer < ActiveModel::Serializer
          attributes :id, :title, :link, :created_at, :poster

          # has_one :user, root: :poster

          def poster
            object.user.name
          end
        end
    ```

* We also want to include all the comments for each post as an array.  To do that, we can add the following to our post serializer:

    ```ruby
        has_many :comments
    ```

* Alright, we've got an array of comments, but we are including some unneccessary data.  Let's fine tune it by creating a serializer file for comments:

    ```
        $ rails g serializer Comment
    ```

* When a new serializer file is generated, the only attribute that is set is the id of the object.  Let's go into our comment serializer file and start customizing:

    ```ruby
        class CommentSerializer < ActiveModel::Serializer
          attributes :id, :body, :created_at
        end
    ```

* Let's also include the user that made the comment.  One way we could do that is by using the `has_one` method:

    ```ruby
        has_one :user
    ```

* We could further customize the output by changing the root to something more semantic, like "commenter":

    ```ruby
        has_one :user, root: :commenter
    ```

* This would work, but just like with our "poster", it is a bit unneccesary to nest the user data inside an object if we are only returning a name.  Let's write a custom method instead:

    ```ruby
        def commenter
          object.user.name
        end
    ```

##Now It's Your Turn!
I have given you a starter app with the following models: Band, Album, Song, and Genre.  Using Active Model Serializers, customize the JSON that is returned from a GET request to `/api/albums` (hint: this is coming from the index action in the albums controller).

* Here is what your JSON should look like.  Make sure that it has the exact same structure and order as the example below:

    ```javascript  
      [
        {
          name: "Graduation",
          band: "Kanye West",
          year_released: "2007",
          num_songs: "6",
          running_time: "51 minutes",
          genre: "hip hop",
          songs: [
            { track: 1, name: "Good Morning", running_time: "3:15" },
            { track: 2, name: "Champion", running_time: "2:48" },
            { track: 3, name: "Stronger", running_time: "5:12" },
            { track: 4, name: "I Wonder", running_time: "4:03" },
            { track: 5, name: "Good Life", running_time: "3:27" },
            { track: 6, name: "Can't Tell Me Nothing", running_time: "4:32" }
          ]
        }
      ]     
    ```