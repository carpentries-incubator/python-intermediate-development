---
title: "Setting the Scene"
start: true
teaching: 30
exercises: 0
questions:
- "What are we going to teach in this workshop?"
- "Have you got all the necessary software installed?"
objectives:
- "Setting the scene and expectations"
- "Making sure everyone has all the necessary software is installed"
keypoints:
- "This lesson focuses on core, intermediate skills covering the whole software development life-cycle 
that will be of most use to anyone working collaboratively on code."
- "The lesson follows on from the novice Software Carpentry lesson, but it not a prerequisite for attending as long as
you have some basic Python, shell and Git skills."
---

## Introduction
This lesson teaches intermediate-level software development skills in a way that mimics a typical collaborative 
software development process. It will teach you to use a number of different software development tools and techniques 
simultaneously and interchangeably as you would in a real life, rather than teaching them separately. The material is 
organised into 4 half-day blocks, with the following learning objectives:

1. setting up an own virtual environment using a variety of tools to develop software collaboratively in a team
2. implementing a test framework to verify the correct behaviour of code and automate testing
3. software design paradigms and writing robust software
4. publishing and releasing software for reuse by others

After attending this workshop, you will be 
equipped with some intermediate Python development 
skills, as well as general skills on writing robust software collaboratively making it easier to use, develop, 
and sustain it in the future for yourself and others.
           
## Prerequisite Knowledge
This is an intermediate-level software development course so it is expected for you to have some prerequisite knowledge
on the topics covered, as outlined at the [beginning of the lesson](/index.html#prerequisites).
Here is a little quiz that you can do to test your prior knowledge to determine 
where you fit on the skills spectrum and if this course is for you.  
> ## Quiz 
> #### Git       
> 1. Which command should you use to initialise a new Git repository?
>> a. `git bash`  
>> b. `git install`  
>> c. `git init`  
>> d. `git start`    
>
> > ## Solution 
> > `git init` is the command to initialise a Git repository and tell Git to start tracking files in it.
> > `git bash`, `git start` and `git install` are not Git commands and will return an error.   
> {: .solution}   
> 2. After you initialise a new Git repository and create a file named `LICENCE.md` in the root of the repository, 
> which of the following commands will not work? 
>> a. `git add LICENCE.md`  
>> b. `git status`  
>> c. `git add .`  
>> d. `git commit -m "Licence file added"`       
>
>> ## Solution 
>> `git commit -m "Licence file added"` won't work because you need to add the file to Git's staging area first before you can commit.       
> {: .solution}
> 3. `git clone` command downloads and creates a local repository from a remote repository. 
> Which command can then be used to upload your local changes back to the remote repository? 
>> a. `git push`  
>> b. `git add`  
>> c. `git upload`  
>> d. `git commit`  
>
> > ## Solution 
> > `git push` is the correct command. `git add` adds a file to the local staging area, `git commit` commits the 
> > staged changes to the local repository and `git push` will push those committed changes to the remote repository. 
> > `git upload` is not a Git command and will return an error. 
> {: .solution}  
> #### Shell  
>
> 1. In the command line shell, which command can you use to see the directory you are currently in?  
>> a. `whereami`  
>> b. `locate`  
>> c. `map`  
>> d. `pwd`  
>
> > ## Solution 
 > > `pwd` (which stands for 'print working directory') is the correct command. 
 > {: .solution} 
> 2. Which command do you use to go to the parent directory of the directory you are currently in?  
>> a. `cd -`  
>> b. `cd ~`  
>> c. `cd /up`  
>> d. `cd ..`  
>
> > ## Solution 
 > > `cd ..` is the correct command. 
 > {: .solution} 
> 3. How can you append the output of a command to a file?  
>> a. `command > file`  
>> b. `command >> file`  
>> c. `command file`  
>> d. `command < file` 
>
> > ## Solution 
 > > `command >> file` is the correct command. `command > file` will redirect the output of a command to a file and 
>overwrite its content, `command file` will pass the file as an argument to the command and `command < file` redirects
> input rather than output.
 > {: .solution}  
> ### Python
>
> 1. Which of these collections defines a list in Python?
>> a. `{"apple", "banana", "cherry"}`  
>> b. `{"name": "apple", "type": "fruit"}`  
>> c. `["apple", "banana", "cherry"]`  
>> d. `("apple", "banana", "cherry")`   
>
> > ## Solution 
 > > While all of the answers define a collection in Python, `["apple", "banana", "cherry"]` defines a list and 
> is the correct answer. `{"apple", "banana", "cherry"}` defines a set; `{"name": "apple", "type": "fruit"}` defines a dictionary 
> (a hash map),`("apple", "banana", "cherry")` defines a tuple (an ordered and unchangeable collection). 
 > {: .solution} 
> 2. What is the correct syntax for *if* statement in Python?
  >> a. `if (x > 3):`  
  >> b. `if (x > 3) then:`  
  >> c. `if (x > 3)`  
  >> d. `if (x > 3);`  
 >
 > > ## Solution 
  > > `if (x > 3):` is the correct answer. 
  > {: .solution} 
> 3. What is the result at the end of the following 3 assignment statements in Python?   
>> `n = 300`  
>>    `m = n`  
>>   `n = -100 `  
>>   
>> a. `n = 300 and m = 300`  
>> b. `n = -100 and m = 300`   
>> c. `n = -100 and m = -100`   
>> d. `n = 300 and m = -100`   
>
> > ## Solution 
 > > `n = -100 and m = 300` is the correct answer. 
 > {: .solution} 
{: .callout} 

## Required Software
Please make sure that you have all the necessary software installed as described in the [Setup](/setup.html) section. 
This section also contains instructions on how to test your setup. 

{% include links.md %}
