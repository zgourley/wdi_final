// Require modules
var express = require('express');
var bodyParser = require('body-parser');
var mongo = require('mongoskin');

// Set up application
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var db = mongo.db("mongodb://localhost:27017/blogger");
db.bind('posts');

// Configure middleware
app.use(bodyParser.urlencoded());
app.use(express.static(__dirname + '/public'));

// Initialize socketio
io.on('connection', function(socket){
  console.log("a client just connected");
  socket.on('new-comment', function(data){
    console.log(data);
    io.emit("server-says", data );
  });
});

// Landing page
app.get('/', function(request, response){
  response.render('index.jade');
});

// Posts index
app.get('/posts', function(request, response){
  db.posts.find().toArray(function(err, result){
    //console.log(result);
    response.render('posts-list.jade', {posts: result });
  });
});

// Post Read
app.get('/posts/:id', function(request, response){
  db.posts.findById(request.params.id, function(err, result){
    response.render('post-show.jade', {post: result });
  });
});

// Post Edit
app.get('/posts/:id/edit', function(request, response){
  response.send("Implement this");
});


// Post Update
app.patch('/posts/:id', function(request, response){
  response.send("Implement here");
});

// Post Create
app.post('/posts', function(request, response){
  //console.log(request.body);
  db.posts.insert(request.body, function(err, result){
    response.redirect("/posts");
    //response.send(result);
  });
});

http.listen(3000);
