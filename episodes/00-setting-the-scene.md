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
you have some basic Python, shell and `git` skills."
---
## Setting the Scene
This lesson teaches intermediate-level software development skills in a way that mimics a typical collaborative 
software development. We will teach you to use a number of different software development tools and techniques 
simultaneously and interchangeably as you would in a real life, rather than teaching them separately. 
The workshop is configured to get you working as part 
of a team (that you have perhaps just joined, inheriting some code). After attending this workshop, you will be 
equipped with some intermediate Python development 
skills, as well as general skills on writing robust software collaboratively making it easier to use, develop, 
and sustain it in the future for yourself and others.
           
## Prerequisite Knowledge
This is an intermediate-level software development course so it is expected for you to have some prerequisite knowledge
on the topics covered, as outlined at the [beginning of the lesson](/index.html).

> ## Quiz 
> Here is a little quiz that can be done in a shared document to test the participants' prior knowledge and 
> determine where they fit on the must have/desirable skill spectrum.
>
> #### Git       
> 1. Which command should you use to initialise a new `git` repository?
>> a. `git bash`  
>> b. `git install`  
>> c. `git init`  
>> d. `git start`       
> 2. After you initialize a new `git` repository and create a file named `LICENCE.md` in the root of the repository, 
> which of the following commands will not work? 
>> a. `git add LICENCE.md`  
>> b. `git status`  
>> c. `git add .`  
>> d. `git commit -m "Licence file added"`  
> 3. What's the opposite of `git clone` command that, instead of downloading your code from a remote repository, 
> uploads your changes and code back to it?
>> a. `git push`  
>> b. `git add`  
>> c. `git upload`  
>> d. `git commit`  
>
> #### Shell  
>
> 1. With what command you can see what folder you are in?  
>> a. `whereami`  
>> b. `locate`  
>> c. `map`  
>> d. `pwd`  
> 2. What command do you use to go to the parent directory?  
>> a. `cd -`  
>> b. `cd ~`  
>> c. `cd /up`  
>> d. `cd..`  
> 3. How can you append the output of a command to a file?  
>> a. `command > file`  
>> b. `command >> file`  
>> c. `command file`  
>> d. `command < file` 
> 
> ### Python
>
> 1. Which of these collections defines a list in Python?
>> a. `{"apple", "banana", "cherry"}`  
>> b. `{name: "apple", type: "fruit"}`  
>> c. `["apple", "banana", "cherry"]`  
>> d. `("apple", "banana", "cherry")`   
> 2. What is the correct syntax for *if* statement in Python?
  >> a. `if (x > 3):`  
  >> b. `if (x > 3) then:`  
  >> c. `if (x > 3)`  
  >> d. `if (x > 3);`
> 3. What is the result at the end of the following 3 assignment statements in Python?   
>> `n = 300`  
>>    `m = n`  
>>   `n = -100 `  
>>   
>> a. `n = 300 and m = 300`  
>> b. `n = -100 and m = 300`   
>> c. `n = -100 and m = -100`   
>> d. `n = 300 and m = -100` 
{: .callout} 

## Required Software
Please make sure that you have all the necessary software installed as described in the [Setup](/setup.html) section.

{% include links.md %}
