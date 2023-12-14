---
title: "Software Architecture and Programming Paradigms"
teaching: 30
exercises: 0
layout: episode
questions:
- "What should we consider when designing software?"
objectives:
- "Understand the use of common design patterns to improve the extensibility, reusability and overall quality of software."
- "Understand the components of multi-layer software architectures."
- "Describe some of the major software paradigms we can use to classify programming languages."
keypoints:
- "A software paradigm describes a way of structuring or reasoning about code."
- "Different programming languages are suited to different paradigms."
- "Different paradigms are suited to solving different classes of problems."
- "A single piece of software will often contain instances of multiple paradigms."
---

## Introduction

As a piece of software grows,
it will reach a point where there's too much code for us to keep in mind at once.
At this point, it becomes particularly important that the software be designed sensibly.
What should be the overall structure of our software,
how should all the pieces of functionality fit together,
and how should we work towards fulfilling this overall design throughout development?

It's not easy to come up with a complete definition for the term **software design**,
but some of the common aspects are:

- **Algorithm design** -
  what method are we going to use to solve the core business problem?
- **Software architecture** -
  what components will the software have and how will they cooperate?
- **System architecture** -
  what other things will this software have to interact with and how will it do this?
- **UI/UX** (User Interface / User Experience) -
  how will users interact with the software?

As usual, the sooner you adopt a practice in the lifecycle of your project, the easier it will be.
So we should think about the design of our software from the very beginning,
ideally even before we start writing code -
but if you didn't, it's never too late to start.

The answers to these questions will provide us with some **design constraints**
which any software we write must satisfy.
For example, a design constraint when writing a mobile app would be
that it needs to work with a touch screen interface -
we might have some software that works really well from the command line,
but on a typical mobile phone there isn't a command line interface that people can access.

## Software Architecture

At the beginning of this episode we defined **software architecture**
as an answer to the question
"what components will the software have and how will they cooperate?".
Software engineering borrowed this term, and a few other terms,
from architects (of buildings) as many of the processes and techniques have some similarities.
One of the other important terms we borrowed is 'pattern',
such as in **design patterns** and **architecture patterns**.
This term is often attributed to the book
['A Pattern Language' by Christopher Alexander *et al.*](https://en.wikipedia.org/wiki/A_Pattern_Language)
published in 1977
and refers to a template solution to a problem commonly encountered when building a system.

Design patterns are relatively small-scale templates
which we can use to solve problems which affect a small part of our software.
For example, the **[adapter pattern](https://en.wikipedia.org/wiki/Adapter_pattern)**
(which allows a class that does not have the "right interface" to be reused)
may be useful if part of our software needs to consume data
from a number of different external data sources.
Using this pattern,
we can create a component whose responsibility is
transforming the calls for data to the expected format,
so the rest of our program doesn't have to worry about it.

Architecture patterns are similar,
but larger scale templates which operate at the level of whole programs,
or collections or programs.
Model-View-Controller (which we chose for our project) is one of the best known architecture patterns.
Many patterns rely on concepts from Object Oriented Programming,
so we'll come back to the MVC pattern shortly
after we learn a bit more about Object Oriented Programming.

There are many online sources of information about design and architecture patterns,
often giving concrete examples of cases where they may be useful.
One particularly good source is [Refactoring Guru](https://refactoring.guru/design-patterns).

### Multilayer Architecture

One common architectural pattern for larger software projects is **Multilayer Architecture**.
Software designed using this architecture pattern is split into layers,
each of which is responsible for a different part of the process of manipulating data.

Often, the software is split into three layers:

- **Presentation Layer**
  - This layer is responsible for managing the interaction between
    our software and the people using it
  - May include the **View** components if also using the MVC pattern
- **Application Layer / Business Logic Layer**
  - This layer performs most of the data processing required by the presentation layer
  - Likely to include the **Controller** components if also using an MVC pattern
  - May also include the **Model** components
- **Persistence Layer / Data Access Layer**
  - This layer handles data storage and provides data to the rest of the system
  - May include the **Model** components of an MVC pattern
    if they're not in the application layer

Although we've drawn similarities here between the layers of a system and the components of MVC,
they're actually solutions to different scales of problem.
In a small application, a multilayer architecture is unlikely to be necessary,
whereas in a very large application,
the MVC pattern may be used just within the presentation layer,
to handle getting data to and from the people using the software.

## Programming Paradigms

In addition to architectural decisions on bigger components of your code, it is important
to understand the wider landscape of programming paradigms and languages,
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

### Procedural Programming

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

### Functional Programming

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

You can read more in an [Extras episode on Functional Programming](/functional-programming/index.html).

### Object Oriented Programming

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

You can read more in an [Extras episode on Object Oriented Programming](/object-oriented-programming/index.html).

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

We have mainly used Procedural Programming in this lesson, but you can
have a closer look at [Functional](/functional-programming/index.html) and 
[Object Oriented Programming](/object-oriented-programming/index.html) paradigms 
in Extras episodes and how they can affect our architectural design choices.

{% include links.md %}


{% include links.md %}
