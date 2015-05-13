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