#Two Models...At The Same Time!

##Learning Objectives
* Use `accepts_nested_attributes_for` to create two objects from different models using one form
* Check out Active Record's awesome `find_or_create_by` method

##Roadmap
We're going to keep building on our movie reviews app today to add reviewers to the mix. We won't be dealing with authentication or login--the idea is that people will be able to write reviews for this site without signing up for an account first. 

Even though we aren't asking them to sign up/log in, we will make them provide their name and email address when they submit a review. This will allow us to display the name of the reviewer and we can capture data for use behind the scenes to track all the reviews that a particular user has created.

Here's what we're going to need to make this dream come true:

1. A `Reviewer` model
2. An association between our `Reviewer` model and our `Review` model
3. A modified form that will allow us to include information about a reviewer when we submit a new review
4. An updated controller action to handle the creation of new reviewers
5. A place in our view where we can display the name of the reviewer that wrote the review

Let's do this thing!

##A new model
First step: create a new model. We should be getting pretty good at this by now.

```bash
$ rails g model Reviewer name email
```

Before we forget, let's go ahead and run our migration to create that table for reviewers:

```bash
$ rake db:migrate
```

Boom!

##Associating our models
Now we need to set up both sides of our assocation between reviewers and reviews. We've got a one-to-many relationship between reviewers and movies, right? It's the same assocation that exists between movies and reviews.

Let's start on the `Reviewer` side:

```ruby
# app/models/reviewer.rb

class Reviewer < ActiveRecord::Base
  has_many :reviews
end
```

Do we need to add any new columns to our `reviewers` table for this to work? Nope!

Let's tackle the association from the `Review` side:

```ruby
# app/models/review.rb

class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :reviewer
end
```

Alright, pop quiz: do we need to add any new columns to our `reviews` table for this to work? You bet your biscuit we do!

Let's write a migration that will add a column for `reviewer_id` to the `reviews` table:

```bash
$ rails g migration AddReviewerIdToReviews reviewer:references 
```

Before we run this migration, let's take a look at the file that was generated.

Alright, let's run this thing:

```bash
$ rake db:migrate
```

Okay, we've got the basic associations set up, but remember: our goal is to be able to submit a form that will include information to create both a new review and an associated reviewer. We need one more thing in our `Review` model to make that work:

```ruby
class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :reviewer
  accepts_nested_attributes_for :reviewer
end
```

##Modifying our new review form
Now that we have said that reviews can accept nested attributes for a reviewer, we can update our form to accommodate that:

```html
<h2>Add a new review!</h2>
<%= form_for [@movie, @review] do |f| %> 
    
    <%= f.fields_for :reviewer_attributes do |reviewer| %>  
        <div>
            <%= reviewer.label :name, class: "form-label" %>
            <%= reviewer.text_field :name, class: "num-input" %>
        </div>

        <div>
            <%= reviewer.label :email, class: "form-label" %>
            <%= reviewer.text_field :email, class: "num-input" %>
        </div>

    <% end %>

    <div>
        <%= f.label :body, "Review", class: "form-label" %> 
        <%= f.text_area :body, class: "text-area" %>
    </div>

    <div>
        <%= f.label :score, class: "form-label" %> 
        <%= f.number_field :score, class: "num-input" %>
    </div>

    <div>
        <%= f.submit "Add your review!", class: "button" %>
    </div>

<% end %>
```

The new thing in this form is the Rails `fields_for` helper--we haven't seen that before. What it will allow us to do is pass along details about the reviewer when we submit this form.

We can actually see how this data gets submitted by looking at our server logs. The parameters that get passed will look kinda like this:

```ruby
"review"=>{
  "reviewer_attributes"=>{
    "name"=>"Shawn", 
    "email"=>"shawn@example.com"
  }, 
  "body"=>"This is an awesome movie!!!", 
  "score"=>"5"
  }, 
  "commit"=>"Add your review!", "id"=>"4"
}
```

This is awesome! Now that we've got this data being passed by our form, we can use it in our controller to create a new reviewer when we create the new review. Let's do this thing!

##Modifying our controller
First things, first. Let's extract those review parameters into a private method:

```ruby
# app/controllers/reviews_controller.rb

private
def review_params
  params.require(:review).permit(:body, :score)
end
```

Now, we just need to update the line where we instantiate the new review object:

```ruby
# app/controllers/reviews_controller.rb

@review = @movie.reviews.new(review_params)
```

Alright, now we need to update our `review_params` method to make sure that we are permitting the new information about a reviewer to pass through to our controller action:

```ruby
private
def review_params
  params.require(:review).permit(:body, :score, reviewer_attributes: [:name, :email])
end
```

Now we need to actually create the reviewer object. But...we only want to create a new reviewer if we don't already have one in our database with the same email address.

Rails has a great method for that: `.find_or_create_by`!  Here's how we use it:

```ruby
@review.reviewer = Reviewer.find_or_create_by(email: params[:review][:reviewer_attributes][:email]) do |reviewer|
  reviewer.name = params[:review][:reviewer_attributes][:name]
end
```

It looks a little crazy, but all it does is try to find a reviewer by the email address that was passed in from the form. If it finds one, it uses that record. If it doesn't find a match, then it creates a new record with the params that were submitted in the form.  Easy peasy!

So, here's what our whole controller action should look like:

```ruby
class ReviewsController < ApplicationController
  def create
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new(review_params)
    
    @review.reviewer = Reviewer.find_or_create_by(email: params[:review][:reviewer_attributes][:email]) do |reviewer|
      reviewer.name = params[:review][:reviewer_attributes][:name]
    end

    @review.save
    redirect_to movie_path(@movie)
  end

  private
  def review_params
    params.require(:review).permit(:body, :score, reviewer_attributes: [:name, :email])
  end
end
```

##Displaying the reviewer's name in the view
Showing the reviewer's name in the view is pretty dang easy--nothing we haven't done before. Here's what it looks like:

```html
<section>
    <h2>Reviews</h2>

    <% @movie.reviews.each do |review| %>
        <div class="review-details">
            <h3>Review #<%= @movie.reviews.index(review) + 1 %></h3>
            <p><strong>Reviewer:</strong> <%= review.reviewer.name %></p>
            <p><strong>Score:</strong> <%= review.score %></p>
            <p><strong>The verdict:</strong> <%= review.body %></p>
        </div>
    <% end %>
</section>
```
