#Dealer's Choice: Rails or Express Lab!
Here's an opportunity for you to tackle some self-guided practice on some of the topics that we have covered recently. We've given you two prompts to choose from: one Rails option and one Express option. The choice is yours!

Whichever option you choose, the prompts will build on what we learned together in class but will probably require you to do some researching/Googling/problem-solving of your own. That's the life of a developer ;)

Happy hacking!

##The Rails Option
Extend our **Good Reads** app (the one that uses pagination and AJAX) to allow users to "like" books. Here are the details of your mission:

* I have provided some code to get you started. The starter code includes a "like" button for each book and a counter that shows the number of "likes" that each book has. Currently, these don't do anything and there is just a hard-coded value in the HTML for the number of likes. Your job is to make this work using AJAX.
* Don't worry about adding a User model. For the purposes of this lab, just create a Like model that has the proper association with the Book model.
* Each time you click the "like" button, it should send an AJAX request to a Rails controller (you'll need to make a new one). After your controller has processed the request, it should respond with JavaScript that updates the "likes" counter. The page should **not** reload to update the "likes" counter.
* If you refresh the page, the number of "likes" for each book should **not** be reset to 0 (i.e. you need to make sure that you are saving each like to the database).

##The Express Option
Extend our **Blogger** app to add full CRUD functionality for blog posts and, optionally, comments.  This is an opportunity to get some self-guided practice with Express and Jade.  

Here's a few suggestions on how you might approach this.  Feel free to take them or leave them.

* Start by creating a user interface in the view for a given piece of functionality (i.e. updating a post or deleting a post).
* Once you have an interface set up, add a route/action in your Express app to handle the request being initiated by the interface you just created in your view template.
* Once you get full CRUD working, research how to make an application layout template using Jade. This should work like the equivalent of our `application.html.erb` page in Rails.