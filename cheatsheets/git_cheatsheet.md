Git CHEATSHEET



```$ git init``` 
Initializes a new local repository and begins version tracking. Creates a hidden file that tracks info about the repository including remote repositories. 

```$ git add -A```
Adds changes to the staging area

```$ git commit -m "awesome commit message"```
Puts the current state in memory and attaches it to this commit with a message.

```$ git remote add origin git@github.com:username/reponame.git```Initializes a new remote repository. 

```$ git push (-u) (origin master)``` Pushes commits to remote

```$ git status``` Status update on version tracking state

```$ git clone \<SSH or HTTPS>``` Clones a remote repository as a new local repository

```$ git branch ``` prints out a list of all available branches in Terminal

```$ git branch <branchname>``` creates a new branch called branchname

```$ git checkout <branchname>``` moves you to a different branch

```$ git checkout - b <branchname>``` creates a new branch and checks it out all in  one

```$ git merge <branchname>```merges the branch called \<branchname> into 

