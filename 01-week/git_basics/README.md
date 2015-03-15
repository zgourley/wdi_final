#Git 'Er Done! (The Basics of Git)
###More Git Puns:
* "Git With The Program"
* "Gitting Down With Git"
* "Let's Git Going"

##Learning Objectives
By the end of today's lesson, you will be able to:

* explain the basics of version control and Git
* explain the differences between Git and Github
* initialize a new local repository
* stage and commit files to this local repository
* write good commit messages using best practices
* push changes up to a remote repository on Github
* clone the class repository

##Roadmap
1. We'll start by talking about version control, Git, and Github.
2. We'll walk through the steps of a sample Git workflow and talk about the basic Git commands and some important Git vocabulary.
3. We'll do three short labs where you can get some practice using Git and Github.

##Essential Questions
###What is version control?
Version control is like a time capsule for your project.  It is a system that tracks the changes you make to all the files in your project so that you can recall previous versions later if needed.

Think about the typical life cycle of a file:

* create a new file
* save the file
* edit the file
* save the file again <= this is where version control comes in!

Version control is useful for all kinds of projects, not just software development.  Photographers, graphic designers, musicians, and writers are just some of the people who can benefit from using a version control system to track changes to their work as it evolves and grows.

###What is Git?
Git is a distributed version control system (DVCS) that allows you to version control your projects and collaborate on them easily with others.  

We'll talk more about the "distributed" part of Git later in the course when we go over using Git and Github to collaborate with others.  For now, you need to know that Git is a program that will help you track changes you make to your project over time.

###What is the difference between Git and Github?
* Git is a version control system that lives locally on your system and is used to track changes to files and projects over time.  
* Github, on the other hand, is a hosting service for Git repositories.  Github makes it easy to collaborate on projects and share code with other developers.
* You can think of it like this:  Git is a tool, Github is a service.
 
##A Sample Git Workflow
1. Create a new project directory.
2. cd into this directory.
3. Run the command `git init` inside your project directory to initialize a new repository.
4. Create and save a new file, which starts as "untracked".
5. Run the command `git status` to see that you have an untracked file in your repo.
6. Run the command `git add -A` to add this file to the staging area for a commit.
7. Run the command `git status` again to see that we have a file that has been added to the staging area and is ready to be committed.
7. Run the command `git commit -m "<YOUR COMMIT MESSAGE GOES HERE>"` to record these changes and take a snapshot of your project in its current state.
8. Run `git status` one more time to see that everything is up to date and there are no new changes to commit.
9. Run `git log` to take a look at the details of our commit.

##Lab Time!
###Pre-Lab Exercise
Let's set up our WDI folder structure (more command line practice...yay!).

###Lab #1
Make a new directory in your WDI/01_week folder and create a new HTML file inside this directory.

```	
$ mkdir git_intro_lab
$ cd git_intro_lab
$ touch test.txt 
```

Next, we'll initialize a new Git repo in this directory, add our file to the staging area, and make an initial commit.

```
$ git init
$ git add -A
$ git commit -m "initial commit"
```

Okay, now go to Github and create a new empty repository.  Read the instructions that Github gives you and then go back into your terminal. 

	$ git remote add origin <YOUR REMOTE REPO URL GOES HERE>
	$ git push -u origin master

Let's pop back over to Github now to see our handy work.

Back to the terminal!  Type `subl .` inside your `git_intro_lab` directory to open this folder in Sublime Text.  Open up `test.txt` and make a few changes.

After you make these changes, go back to your terminal and run the command `git status`.  What do you see?  You should see that changes have been made to your `test.txt` file. 

Now, it's time to add these changes to the staging area, commit them locally, and then push those changes up to your Github repo.

	$ git add -A
	$ commit -m "<INSERT GREAT COMMIT MESSAGE HERE>"
	$ git push origin master
	$ git log

Repeat these steps THREE MORE TIMES to help these commands stick in your brain!  Try adding new files, modifying existing files, and deleting a file.

###Lab #2
1. Clone the class repo to your local machine.
2. Let's take a look at the repo README and discuss how we will work with these files throughout WDI.

##Important Git Commands
```
git init
git status
git add -A
git commit -m "<INSERT YOUR COMMIT MESSAGE HERE>"
git log
git push origin master
git pull
git clone <URL GOES HERE>
```
