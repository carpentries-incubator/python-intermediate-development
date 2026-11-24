---
title: Quiz
---

This is an intermediate-level software development course
so it is expected for you to have some prerequisite knowledge on the topics covered,
as outlined at the [beginning of the lesson](../index.md#prerequisites).
Here is a little quiz that you can do to test your prior knowledge
to determine where you fit on the skills spectrum and if this course is for you.

## Git

1. Which command should you use to initialise a new Git repository?
  
  ```
  a. git bash
  b. git install
  c. git init
  d. git start
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `git init` is the command to initialise a Git repository
  > and tell Git to start tracking files in it.
  > `git bash`, `git start` and `git install` are not Git commands and will return an error.
  > 
  > 
  > :::::::::::::::::::::::::

2. After you initialise a new Git repository
  and create a file named `LICENCE.md` in the root of the repository,
  which of the following commands will not work?
  
  ```
  a. git add LICENCE.md
  b. git status
  c. git add .
  d. git commit -m "Licence file added"
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `git commit -m "Licence file added"` won't work
  > because you need to add the file to Git's staging area first
  > before you can commit.
  > 
  > 
  > :::::::::::::::::::::::::

3. `git clone` command downloads and creates a local repository from a remote repository.
  Which command can then be used to upload your local changes back to the remote repository?
  
  ```
  a. git push
  b. git add
  c. git upload
  d. git commit
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `git push` is the correct command.
  > `git add` adds a file to the local staging area,
  > `git commit` commits the staged changes to the local repository
  > and `git push` will push those committed changes to the remote repository.
  > `git upload` is not a Git command and will return an error.
  > 
  > 
  > :::::::::::::::::::::::::

## Shell

1. In the command line shell,
  which command can you use to see the directory you are currently in?
  
  ```
  a. whereami
  b. locate
  c. map
  d. pwd
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `pwd` (which stands for 'print working directory') is the correct command.
  > 
  > 
  > :::::::::::::::::::::::::

2. Which command do you use to go to the parent directory of the directory you are currently in?
  
  ```
  a. cd -
  b. cd ~
  c. cd /up
  d. cd ..
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `cd ..` is the correct command.
  > `cd -` goes to the previous location in history (not parent).
  > `cd ~` goes to the home folder.
  > `cd /up` goes to a folder `up` in the root (`/`) of the file system.
  > 
  > 
  > :::::::::::::::::::::::::

3. How can you append the output of a command to a file?
  
  ```
  a. command > file
  b. command >> file
  c. command file
  d. command < file
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `command >> file` is the correct command.
  > `command > file` will redirect the output of a command to a file
  > and overwrite its content,
  > `command file` will pass the file as an argument to the command
  > and `command < file` redirects input rather than output.
  > 
  > 
  > :::::::::::::::::::::::::

## Python

1. Which of these collections defines a list in Python?
  
  ```
  a. {"apple", "banana", "cherry"}
  b. {"name": "apple", "type": "fruit"}
  c. ["apple", "banana", "cherry"]
  d. ("apple", "banana", "cherry")
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > While all of the answers define a collection in Python,
  > `["apple", "banana", "cherry"]` defines a list and is the correct answer.
  > `{"apple", "banana", "cherry"}` defines a set;
  > `{"name": "apple", "type": "fruit"}` defines a dictionary (a hash map);
  > `("apple", "banana", "cherry")` defines a tuple (an ordered and unchangeable collection).
  > 
  > 
  > :::::::::::::::::::::::::

2. What is the correct syntax for *if* statement in Python?
  
  ```
  a. if (x > 3):
  b. if (x > 3) then:
  c. if (x > 3)
  d. if (x > 3);
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `if (x > 3):` is the correct answer.
  > 
  > 
  > :::::::::::::::::::::::::

3. Look at the following 3 assignment statements in Python.
  
  ```
  n = 300
  m = n
  n = -100
  ```
  
  What is the result at the end of the above assignments?
  
  ```
  a. n = 300 and m = 300
  b. n = -100 and m = 300
  c. n = -100 and m = -100
  d. n = 300 and m = -100
  ```
  
  > :::::::::::::::  solution
  > 
  > ## Solution
  > 
  > `n = -100 and m = 300` is the correct answer.
  > 
  > 
  > :::::::::::::::::::::::::


