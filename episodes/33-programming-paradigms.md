---
title: "Programming Paradigms"
start: false
teaching: 10
exercises: 0
questions:
- "How does the structure of a problem affect the structure of our code?"
- "How can we use common software paradigms to improve the quality of our software?"
objectives:
- "Describe some of the major software paradigms we can use to classify programming languages."
keypoints:
- "A software paradigm describes a way of structuring or reasoning about code."
- "Different programming languages are suited to different paradigms."
- "Different paradigms are suited to solving different classes of problems."
- "A single piece of software will often contain instances of multiple paradigms."
---

## Introduction

As you become more experienced in software development it becomes increasingly important
to understand the wider landscape in which you operate,
particularly in terms of the software decisions the people around you made and why?
Today, there are a multitude of different programming languages,
with each supporting at least one way to approach a problem and structure your code.
In many cases, particularly with modern languages,
a single language can allow many different structural approaches within your code.

One way to categorise these structural approaches is into **paradigms**.
Each paradigm represents a slightly different way of thinking about and structuring our code
and each has certain strengths and weaknesses when used to solve particular types of problems.
Once your software begins to get more complex
it's common to use aspects of different paradigms to handle different subtasks.
Because of this, it's useful to know about the major paradigms,
so you can recognise where it might be useful to switch.

There are two major families that we can group the common programming paradigms into:
**Imperative** and **Declarative**.
An imperative program uses statements that change the program's state -
it consists of commands for the computer to perform
and focuses on describing **how** a program operates step by step.
A declarative program expresses the logic of a computation
to describe **what** should be accomplished
rather than describing its control flow as a sequence steps.

We will look into three major paradigms
from the imperative and declarative families that may be useful to you -
**Procedural Programming**, **Functional Programming** and **Object-Oriented Programming**.
Note, however, that most of the languages can be used with multiple paradigms,
and it is common to see multiple paradigms within a single program -
so this classification of programming languages based on the paradigm they use isn't as strict.

## Procedural Programming

Procedural Programming comes from a family of paradigms known as the Imperative Family.
With paradigms in this family, we can think of our code as the instructions for processing data.

Procedural Programming is probably the style you're most familiar with
and the one we used up to this point,
where we group code into
*procedures performing a single task, with exactly one entry and one exit point*.
In most modern languages we call these **functions**, instead of procedures -
so if you're grouping your code into functions, this might be the paradigm you're using.
By grouping code like this, we make it easier to reason about the overall structure,
since we should be able to tell roughly what a function does just by looking at its name.
These functions are also much easier to reuse than code outside of functions,
since we can call them from any part of our program.

So far we have been using this technique in our code -
it contains a list of instructions that execute one after the other starting from the top.
This is an appropriate choice for smaller scripts and software
that we're writing just for a single use.
Aside from smaller scripts, Procedural Programming is also commonly seen
in code focused on high performance, with relatively simple data structures,
such as in High Performance Computing (HPC).
These programs tend to be written in C (which doesn't support Object Oriented Programming)
or Fortran (which didn't until recently).
HPC code is also often written in C++,
but C++ code would more commonly follow an Object Oriented style,
though it may have procedural sections.

Note that you may sometimes hear people refer to this paradigm as "functional programming"
to contrast it with Object Oriented Programming,
because it uses functions rather than objects,
but this is incorrect.
Functional Programming is a separate paradigm that
places much stronger constraints on the behaviour of a function
and structures the code differently as we'll see soon.

## Functional Programming

Functional Programming comes from a different family of paradigms -
known as the Declarative Family.
The Declarative Family is a distinct set of paradigms
which have a different outlook on what a program is -
here code describes *what* data processing should happen.
What we really care about here is the outcome - how this is achieved is less important.

Functional Programming is built around
a more strict definition of the term **function** borrowed from mathematics.
A function in this context can be thought of as
a mapping that transforms its input data into output data.
Anything a function does other than produce an output is known as a **side effect**
and should be avoided wherever possible.

Being strict about this definition allows us to
break down the distinction between **code** and **data**,
for example by writing a function which accepts and transforms other functions -
in Functional Programming *code is data*.

The most common application of Functional Programming in research is in data processing,
especially when handling **Big Data**.
One popular definition of Big Data is
data which is too large to fit in the memory of a single computer,
with a single dataset sometimes being multiple terabytes or larger.
With datasets like this, we can't move the data around easily,
so we often want to send our code to where the data is instead.
By writing our code in a functional style,
we also gain the ability to run many operations in parallel
as it's guaranteed that each operation won't interact with any of the others -
this is essential if we want to process this much data in a reasonable amount of time.

## Object Oriented Programming

Object Oriented Programming focuses on the specific characteristics of each object
and what each object can do.
An object has two fundamental parts - properties (characteristics) and behaviours.
In Object Oriented Programming,
we first think about the data and the things that we're modelling - and represent these by objects.

For example, if we're writing a simulation for our chemistry research,
we're probably going to need to represent atoms and molecules.
Each of these has a set of properties which we need to know about
in order for our code to perform the tasks we want -
in this case, for example, we often need to know the mass and electric charge of each atom.
So with Object Oriented Programming,
we'll have some **object** structure which represents an atom and all of its properties,
another structure to represent a molecule,
and a relationship between the two (a molecule contains atoms).
This structure also provides a way for us to associate code with an object,
representing any **behaviours** it may have.
In our chemistry example, this could be our code for calculating the force between a pair of atoms.

Most people would classify Object Oriented Programming as an
[extension of the Imperative family of languages](https://www.digitalocean.com/community/tutorials/functional-imperative-object-oriented-programming-comparison)
(with the extra feature being the objects), but
[others disagree](https://stackoverflow.com/questions/38527078/what-is-the-difference-between-imperative-and-object-oriented-programming).

> ## So Which one is Python?
> Python is a multi-paradigm and multi-purpose programming language.
> You can use it as a procedural language and you can use it in a more object oriented way.
> It does tend to land more on the object oriented side as all its core data types
> (strings, integers, floats, booleans, lists,
> sets, arrays, tuples, dictionaries, files)
> as well as functions, modules and classes are objects.
>
> Since functions in Python are also objects that can be passed around like any other object,
> Python is also well suited to functional programming.
> One of the most popular Python libraries for data manipulation,
> [Pandas](https://pandas.pydata.org/) (built on top of NumPy),
> supports a functional programming style
> as most of its functions on data are not changing the data (no side effects)
> but producing a new data to reflect the result of the function.
{: .callout}

## Other Paradigms

The three paradigms introduced here are some of the most common,
but there are many others which may be useful for addressing specific classes of problem -
for much more information see the Wikipedia's page on
[programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm).
Having mainly used Procedural Programming so far,
we will now have a closer look at Functional and Object Oriented Programming paradigms
and how they can affect our architectural design choices.

{% include links.md %}
