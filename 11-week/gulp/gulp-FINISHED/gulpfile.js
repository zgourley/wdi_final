var gulp         = require("gulp");
var uglify       = require("gulp-uglify");
var sass         = require("gulp-sass");
var autoprefixer = require("gulp-autoprefixer");

gulp.task("scripts", function(){
  gulp.src("js/*.js") //allows us to target the file(s) we want to minify
    .pipe(uglify()) //performs the task
    .pipe(gulp.dest("build/js")); //save the output of the task
});

gulp.task("process-scss", function(){
  gulp.src("scss/*.scss")
    .pipe(sass().on("error", sass.logError))
    .pipe(autoprefixer({browsers: ["last 2 versions"]}))
    .pipe(gulp.dest("build/css"));
});

gulp.task("watch", function(){
  gulp.watch("js/*.js", ["scripts"]);
  gulp.watch("scss/*.scss", ["process-scss"]);
});

gulp.task("default", ["scripts", "watch"]);