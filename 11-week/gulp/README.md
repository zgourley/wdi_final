#gulp!

##Learning Objectives
* Know what build tasks are
* Know what task runners are
* Check out gulp, a popular tool in the JavaScript community for automating build tasks

##WTF is gulp?
###What is a build task?!
Rails' asset pipeline can spoil you by managing your assets for you without you ever having to think very much about it. The asset pipeline handles everything from concatenating and minifying your assets to using pre-processors to compile code written in languages like CoffeeScript and SASS.

These are all build tasks and the asset pipeline automates this process so that we never have to think about it. But, we don't always work in Rails...

###What is a task runner and why the frack would I use one?!
A task runner is a tool that is used to run all of our build tasks (concatenation, minification, compilation, etc.).  Why would you want to use a task runner?  Automation! It saves you from having to manually perform the same repetitive tasks over and over again during devleopment.

###Why should I care about compiling/concatenating/minifying my assets?!
* Browsers can't read things like SASS and CoffeeScript, so we have to compile those into CSS and JavaScript
* Minifying reduces file size so that files are downloaded from the server faster
* Concatenating multiple files into a single file reduces the number of requests a client has to make to a server just to load the webpage.

###What can I do with gulp?!
Everything! Well, not _everything_, but if you find yourself needing to automate a task during your development process, there is probably a gulp plugin out there that can  help. Here's a few examples:

* minifying
* concatenating
* compiling other languages
* auto-prefixing your CSS with vendor prefixes
* watching files for changes and then automatically re-run your build tasks
* live reloading the browser when files have changed
* compressing images to make them smaller and load faster
* run your JavaScript linter
* run your front-end tests

##Let's get started
1. Install gulp globally:
 
  ```
  $ npm install -g gulp
  ```

  If you get a bunch of errors, run it as `sudo`.

2. Now we need to install gulp in the project directory where we want to use it (note that we already have a `package.json` file because I ran `npm init` on the starter code we're using. If you don't have a `package.json` file in your project, you should run `npm init` before installing gulp):

  ```
  $ npm install --save-dev gulp
  ```

3. Let's create a gulp file at the root of our project directory. This is the file that will contain all of the tasks that we would like gulp to run for us.

  ```
  $ touch gulpfile.js
  ```

4. Inside our `gulpfile.js`, we'll start by requiring gulp:

  ```javascript
  var gulp = require("gulp");
  ```

5. Now we are going to create a default task that will run whenever we type the command `gulp` in our terminal:

  ```javascript
  var gulp = require("gulp");

  gulp.task("default", function(){
    console.log("Our first gulp task just ran!");
  });
  ```

  Notice that the first argument in the `gulp.task` method call is `"default"`. This represents the name of our task. If we call the task `"default"`, then it will be the task that gets run everytime we use the `gulp` command. Examples of other task names we might use in the future: `"minifyCss"` or `"concatenateJavaScript"`.

  To run our gulp task:

  ```
  $ gulp
  ```

  This doesn't do anything useful yet, but it gets us started.

##Integrating our first gulp plugin to minify our JavaScript
There are more than 1,500 gulp plugins available and that number is growing all the time. To find plugins, we can search at http://gulpjs.com/plugins/ or https://www.npmjs.com/.

The plugin we are going to use to minify our JavaScript is a plugin called `gulp-uglify`.  Here's how we install it:

  ```
  $ npm install --save-dev gulp-uglify
  ```

Now we need to require it in our `gulpfile.js`:

  ```javascript
  var gulp   = require("gulp");
  var uglify = require("gulp-uglify");
  ```

Let's get rid of that `console.log` in our default task and change it to do something useful:

  ```javascript
  var gulp   = require("gulp");
  var uglify = require("gulp-uglify");

  gulp.task("default", function(){
    gulp.src("js/*.js") //allows us to target the file(s) we want to minify
      .pipe(uglify()) //performs the task
      .pipe(gulp.dest("build/js")); //save the output of the task
  });
  ```

If we run this task using the `gulp` command, we can see that a `build/js` directory got created and our JavaScript inside it is minified. 

Indeed, if we compare the size of our unminified file and our minified file, we can see it is now about 1/3 the size. Boom!

##Named gulp tasks
Instead of putting our `uglify` task inside our `"default"` task, we should really break this out into a named task and then just call that task inside of `"default"`. Here's how we do that:

  ```javascript
  gulp.task("scripts", function(){ //all our tasks related to our script files
    gulp.src("js/*.js")
      .pipe(uglify())
      .pipe(gulp.dest("build/js"));
  });
  ```

To run this task, we can use the command `gulp scripts` in our terminal.

Now, let's clean up our `"default"` task:

  ```javascript
  gulp.task("default", ["scripts"]); //we pass all the tasks we want to run into the array
  ```

##Watching files with gulp
So far, we have to manually run our tasks each time we want them to update our code.  But if we're using gulp to do something like, say, compile SASS into CSS, it would be really handy for that to happen automatically everytime we save our SASS file (like Rails' asset pipeline does).  

We can make that dream come true by writing a `watch` task. Here's how:

  ```javascript
  gulp.task("watch", function(){
    gulp.watch("js/*.js", ["scripts"]);
  });
  ```

If we run `gulp watch`, we can see in our terminal that it uglifies our JavaScript and that it continues to run. Then if we go into our unminified jQuery file, add a comment, and then save the file, we can see that our `scripts` task runs again. That's pretty sweet!

We could make this a little bit better by adding the `watch task` to our `"default"` task.  We want to make sure that it is the last task we pass into the array:

  ```javascript
  gulp.task("default", ["scripts", "watch"]); 
  ```

##Compiling SASS with gulp
The first thing we need to do to begin compiling our SASS is install a package.  Here's the one we want:

  ```
  npm install gulp-sass --save-dev
  ```

Now we need to add it to our `gulpfile.js`:

  ```javascript
  var sass = require("gulp-sass");
  ```

With that taken care of, this will work very much like our uglifier task:

  ```javascript
  gulp.task("process-scss", function(){
    gulp.src("scss/*.scss")
      .pipe(sass().on("error", sass.logError))
      .pipe(gulp.dest("build/css"));
  });
  ```

Notice that we're listening for "error" events and then calling `sass.logError` if there is an error in our .scss file that can't be properly compiled.

If we run this, we can see that our SASS is now being compiled. Boomzilla!  Let's make sure to add this to our `watch` task, so that it will happen automatically everytime any of our .scss files change:

  ```javascript
  gulp.task("watch", function(){
    gulp.watch("js/*.js", ["scripts"]);
    gulp.watch("scss/*.scss", ["process-scss"]);
  });
  ```

We might also want to minify our CSS once it's been compiled, but I'll leave that as an exercise for the reader ;)

##Autoprefixing your CSS
When we're building websites, we need to make sure that our CSS includes all the proper vendor prefixes.  This is of course a major pain, but have no fear...gulp is here!

We're going to use the `gulp-autoprefixer` package to automatically add vendor prefixes to our CSS everywhere that they're needed. Let's start by installing the package:

  ```
  $ npm install --save-dev gulp-autoprefixer
  ```

And then we need to add it to our `gulpfile.js`:

  ```javascript
  var autoprefixer = require("gulp-autoprefixer");
  ```

We can use this by adding it to our `"process-scss"` task.  In this case, the order in which we add it to that task matters. We want to run autoprefixer _after_ we compile our SASS to CSS but _before_ we save the CSS to the destination file.  Here's how we do it:

  ```javascript
  gulp.task("process-scss", function(){
    gulp.src("scss/*.scss")
      .pipe(sass().on("error", sass.logError))
      .pipe(autoprefixer({browsers: ["last 2 versions"]}))
      .pipe(gulp.dest("build/css"));
  });
  ```

Let's make sure that we have some kind of CSS3 property that would require prefixes and then we can run `gulp` and check our compiled CSS to see if it worked. Did it? Of course it did! Boom!

##A little bit of practice for you
Generally, you will want to concatentate your JavaScript and CSS in production to save the browser from having to make multiple requests to the server to retrieve your assets. Your challenge is to add a few more JavaScript and/or SASS files and then use gulp to concatenate them into single files. Hint: you'll need to use another gulp plugin to do it. Research which one to use by visiting gulp's website or Googling to see which concatenation plugin is most popular.