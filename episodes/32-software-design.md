---
title: "Software Design"
teaching: 25
exercises: 20
questions:
- "Why should we invest time in software design?"
- "What should we consider when designing software?"
objectives:
- "Understand the goals and principles of designing 'good' software."
- "Understand what a code abstraction is, and when we should use it."
- "Understand what code refactoring is."
keypoints:
- "When writing software used for research, requirements will almost *always* change."
- "'Good' code is designed to be maintainable: readable by people who did not author the code, 
testable through a set of automated tests, adaptable to new requirements."
- "The sooner you adopt a practice of designing your software in the lifecycle of your project, 
the easier the development and maintenance process will."
---

## Introduction

Ideally, we should have at least a rough design sketched out for our software before we write a 
single line of code. 
This design should be based around the requirements and the structure of the problem we are trying 
to solve: what are the concepts we need to represent and what are the relationships between them. 
And importantly, who will be using our software and how will they interact with it.

As a piece of software grows,
it will reach a point where there's too much code for us to keep in mind at once.
At this point, it becomes particularly important to think of the overall design and
structure of our software, how should all the pieces of functionality fit together,
and how should we work towards fulfilling this overall design throughout development.
Even if you did not think about the design of your software from the very beginning - 
it is not too late to start now.

It's not easy to come up with a complete definition for the term **software design**,
but some of the common aspects are:

- **Algorithm design** -
  what method are we going to use to solve the core research/business problem?
- **Software architecture** -
  what components will the software have and how will they cooperate?
- **System architecture** -
  what other things will this software have to interact with and how will it do this?
- **UI/UX** (User Interface / User Experience) -
  how will users interact with the software?

There is literature on each of the above software design aspects - we will not go into details of
them all here. 
Instead, we will learn some techniques to structure our code better to satisfy some of the 
requirements of 'good' software and revisit 
our software's [MVC architecture](/11-software-project/index.html#software-architecture) 
in the context of software design.

## Good Software Design Goals
Aspirationally, what makes good code can be summarised in the following quote from the
[Intent HG blog](https://intenthq.com/blog/it-audience/what-is-good-code-a-scientific-definition/):

> *“Good code is written so that is readable, understandable,
> covered by automated tests, not over complicated
> and does well what is intended to do.”*

Software has become a crucial aspect of reproducible research, as well as an asset that
can be reused or repurposed. 
Thus, it is even more important to take time to design the software to be easily *modifiable* and 
*extensible*, to save ourselves and our team a lot of time later on when we have 
to fix a problem or the software's requirements change.

Satisfying the above properties will lead to an overall software design 
goal of having *maintainable* code, which is:

* *readable* (and understandable) by developers who did not write the code, e.g. by:
  * following a consistent coding style and naming conventions
  * using meaningful and descriptive names for variables, functions, and classes
  * documenting code to describe it does and how it may be used
  * using simple control flow to make it easier to follow the code execution
  * keeping functions and methods small and focused on a single task and avoiding large functions
  that do a little bit of everything (also important for testing)
* *testable* through a set of (preferably automated) tests, e.g. by:
  * writing unit, functional, regression tests to verify the code produces 
  the expected outputs from controlled inputs and exhibits the expected behavior over time 
  as the code changes
* *adaptable* (easily modifiable and extensible) to satisfy new requirements, e.g. by:
  * writing low-coupled/decoupled code where each part of the code has a separate concern and 
  the lowest possible dependency on other parts of the code making it 
  easier to test, update or replace - e.g. by separating the "business logic" and "presentation" 
  layers of the code on the architecture level (recall the [MVC architecture](/11-software-project/index.html#software-architecture)), 
  or separating "pure" (without side-effects) and "impure" (with side-effects) parts of the code on the 
  level of functions.

Now that we know what goals we should aspire to, let's take a critical look at the code in our 
software project and try to identify ways in which it can be improved. 

> ## Exercise: Identifying How Code Can be Improved?
> A team member has implemented a feature to our inflammation analysis software so that when a 
> `--full-data-analysis` command line parameter parameter is passed to software, 
> it scans the directory of one of the provided files, compares standard deviations across 
> the data by day and plots a graph. 
> The code is located in `compute_data.py` file within the `inflammation` project 
> in a function called `analyse_data()`. 
>
> Critically examine this new code. 
> In what ways does this code not live up to the ideal properties 
> of maintainable code?
> Think about ways in which you find it hard to understand.
> Think about the kinds of changes you might want to make to it, and what would
> make making those changes challenging.
>> ## Solution
>> You may have found others, but here are some of the things that make the code
>> hard to read, test and maintain:
>>
>> * **Hard to read:** everything is implemented in a single function. 
>> In order to understand it, you need to understand how file loading works at the same time as 
>> the analysis itself.
>> * **Hard to modify:** if you want to use the data without using the graph you would have to 
>> change the function.
>> * **Hard to modify or test:** it is always analysing a fixed set of data stored on the disk.
>> * **Hard to modify:** it does not have any tests meaning changes may break something and it 
>> would be hard to know what.
>> 
>> Make sure to keep the list you have created in the exercise above. 
>> For the remainder of this section, we will work on improving this code. 
>> At the end, we will revisit your list to check that you have learnt ways to address each of the 
>> problems you had found.
> {: .solution}
{: .challenge}

## Technical Debt

When faced with a problem that you need to solve by writing code - it may be tempted to 
skip the design phase and dive straight into coding. 
What happens if you do not follow the good software design and development best practices?
It can lead to accumulated 'technical debt',
which (according to [Wikipedia](https://en.wikipedia.org/wiki/Technical_debt)),
is the "cost of additional rework caused by choosing an easy (limited) solution now
instead of using a better approach that would take longer".
The pressure to achieve project goals can sometimes lead to quick and easy solutions,
which make the software become
more messy, more complex, and more difficult to understand and maintain.
The extra effort required to make changes in the future is the interest paid on the (technical) debt.
It is natural for software to accrue some technical debt,
but it is important to pay off that debt during a maintenance phase -
simplifying, clarifying the code, making it easier to understand -
to keep these interest payments on making changes manageable.

There is only so much time available in a project.
How much effort should we spend on designing our code properly
and using good development practices?
The following [XKCD comic](https://xkcd.com/844/) summarises this tension:

![Writing good code comic](../fig/xkcd-good-code-comic.png){: .image-with-shadow width="400px" }

At an intermediate level there are a wealth of practices that *could* be used,
and applying suitable design and coding practices is what separates
an *intermediate developer* from someone who has just started coding.
The key for an intermediate developer is to balance these concerns
for each software project appropriately,
and employ design and development practices *enough* so that progress can be made.
It is very easy to under-design software,
but remember it's also possible to over-design software too.

## Techniques for Improving Code

How code is structured is important for helping people who are developing and maintaining it 
to understand and update it.
By breaking down our software into components with a single responsibility, 
we avoid having to rewrite it all when requirements change. 
Such components can be as small as a single function, or be a software package in their own right.
These smaller components can be understood individually without having to understand 
the entire codebase at once.

### Code Refactoring

*Refactoring* is the process of changing the internal structure of code without changing its 
external behavior, with the goal of making the code more readable, maintainable, efficient or easier
to test.
This can include things such as renaming variables, reorganising 
functions to avoid code duplication and increase reuse, and simplifying conditional statements.

When faced with an existing piece of code that needs modifying a good refactoring 
process to follow is:

1. Make sure you have tests that verify the current behaviour
2. Refactor the code in such a way that the behaviour of the code is identical to that 
before refactoring

Another technique to use when improving code are *abstractions*. 

### Abstractions

*Abstraction* is the process of hiding the implementation details of a piece of
code behind an interface - i.e. the details of *how* something works are hidden away,
leaving us to deal only with *what* it does.
This allows developers to work with the code at a higher level
of abstraction, without needing to understand the underlying details.
Abstraction is used to simplify complex systems by breaking them down into smaller, 
more manageable parts.

Abstraction can be
achieved through techniques like *encapsulation*, *inheritance*, and *polymorphism*, which we will
cover in the next episodes.

## Improving Our Software Design

Both refactoring and abstraction are important for creating maintainable code.
Refactoring helps to keep the codebase clean and easy to understand, while abstraction allows
developers to work with the code in a more abstract and modular way.

Writing good code is hard and takes practise.
You may also be faced with an existing piece of code that breaks some (or all) of the
good code principles, and your job will be to improve it so that the code can evolve further.
In the rest of this section, we will use the refactoring and abstraction techniques to 
help us redesign our code to incrementally improve its quality.

{% include links.md %}
