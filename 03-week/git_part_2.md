#Git Part 2 (of many more) 

###Prep for this lesson: 

1. refresh on "git er done" in class repo -> 01-week -> git basics 
2. navigate to your github page and make sure you are logged in
3. make a list of questions you have about git. 

----


1. Review
	* local v remote
	* git v github
	* ```$ git --help ```
	* ```$ git help -a -g```
	* ```$ git help glossary``` 
	* you may have to use 'q' to exit  
2. More Git
	* branch
	* checkout
	* merge
3. Cheatsheets


----


##1. Review

#####Lab 1
Get with your neighbour and talk "git" for 2 minutes. Everything you have learned so far. Likes, dislikes. Features you know how to use, features you want to learn.

Ideas:

* Local v Remote
* Git v Github
* Pull and Push
* Commits
* Adding files to the staging area. 

[2 minutes]

#####Discussion
Recap as a class

#####Tips
1. Work slowly
2. Understand what you are doing
3. If you stick to your workflow you will always be safe

#####You own this: 

```
git init
git add -A
git commit -m "first commit"
git remote add origin git@github.com:username/reponame.git
git push -u origin master
```

#####Recap

```
git --help

```

You know these:

```
add       
clone      
commit          
init       
log        
merge      
pull       
push       
reset    
status

there is one missing from this list, that we have been using a lot:
git add remote [string] [https or ssh]

```    


 
Similar to command line that we have already been using:

```
grep
mv 
rm  
```

Newbies for today:

```
branch    
checkout 
merge
 
```

Don't worry about these for now. 

```
tag
show 
rebase 
diff       
fetch  

```

##2. More Git

1. Branching

#####Lab 2 

```$ git help branch ```

Make notes and discuss with neighbour again 2 minutes

>What we got?

What happens if we run git branch with no args
What happens if we run git branch with args -> that exist and that don't


2. Checkout

#####Lab 3

```$ git help checkout ```

>What we got? 


-b <new_branch>

Create a new branch named <new_branch> and start it at <start_point>; see git-branch(1) for details.
           
           
--detach

Rather than checking out a branch to work on it, check out a commit for inspection and discardable experiments. This is the default behavior of "git
           checkout <commit>" when <commit> is not a branch name. See the "DETACHED HEAD" section below for details


#####Lab 4

```$ git merge```

>What we got?

```$ git merge <branchname>``` merges named branch into checkout branch


Summary of branching checkingout and merging 


#####Lab 5 -> your turn

1. Go to one of your exisitng projects. 
2. On master branch, make sure all changes are staged, commited and pushed
2. Take out a new branch
3. Make a few minor changes (add some comments)
4. Add them to the staging area
5. Commit them
6. Checkout back to master
7. Merge changes back to master


#####Lab 6 

Make yourself a **master** cheatsheet with all of your favorite git commands. 
You may use these for inspiration.
Take your thinking to the next level!!!

[cheatsheets.org](http://www.cheat-sheets.org/saved-copy/git-cheat-sheet.pdf)
[git-tower.com](http://www.git-tower.com/blog/git-cheat-sheet)
[hyperglot](http://hyperpolyglot.org/version-control)












