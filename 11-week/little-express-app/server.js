var express = require('express');
var bodyParser = require('body-parser');
var mongo = require('mongoskin');

var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var db = mongo.db("mongodb://localhost:27017/blogger");
db.bind('posts');

app.use(bodyParser.urlencoded());
app.use(express.static(__dirname + '/public'));

io.on('connection', function(socket){
  console.log("a client just connected");
  socket.on('new-comment', function(data){
    db.posts.updateById(data._id, {$push: {comments: data.comment} }, function(err, result){
      console.log(data.comment);
      io.emit("server-says", data.comment );
    });
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
  db.posts.findById(request.params.id, function(err, result){
    response.render('post-edit.jade', {post: result });
  });
});

// Post Remove
app.delete('/posts/:id', function(request, response){
  db.posts.removeById(request.params.id, function(err, result){
    response.sendStatus(200);
  });
});

// Post Update
app.patch('/posts/:id', function(request, response){
  var postTitle = request.body.title
    , postBody  = request.body.body
    , updatedPost = {title: postTitle, body: postBody};

  db.posts.updateById(request.params.id, {$set: updatedPost}, function(err, result){
    db.posts.findById(request.params.id, function(err, result){
      response.send(result);
    });
  });
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
