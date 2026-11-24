---
title: "Extra Content: Programming Paradigms"
teaching: 20
exercises: 0
---


::: questions: 
- What should we consider when designing software?
:::

::: objectives: 
- Describe some of the major software paradigms we can use to classify programming languages.
:::


In addition to [architectural decisions](../learners/software-architecture-extra.md) on bigger components of your code, it is important
to understand the wider landscape of programming paradigms and languages,
with each supporting at least one way to approach a problem and structure your code.
In many cases, particularly with modern languages,
a single language can allow many different structural approaches within your code.

One way to categorise these structural approaches is into **paradigms**.
Each paradigm represents a slightly different way of thinking about and structuring our code
and each has certain strengths and weaknesses when used to solve particular types of problems.
Once your software begins to get more complex
it is common to use aspects of different paradigms to handle different subtasks.
Because of this, it is useful to know about the major paradigms,
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
so this classification of programming languages based on the paradigm they use is not as strict.

### Procedural Programming

Procedural Programming comes from a family of paradigms known as the Imperative Family.
With paradigms in this family, we can think of our code as the instructions for processing data.

Procedural Programming is probably the style you are most familiar with
and the one we used up to this point,
where we group code into
*procedures performing a single task, with exactly one entry and one exit point*.
In most modern languages we call these **functions**, instead of procedures -
so if you are grouping your code into functions, this might be the paradigm you are using.
By grouping code like this, we make it easier to reason about the overall structure,
since we should be able to tell roughly what a function does just by looking at its name.
These functions are also much easier to reuse than code outside of functions,
since we can call them from any part of our program.

So far we have been using this technique in our code -
it contains a list of instructions that execute one after the other starting from the top.
This is an appropriate choice for smaller scripts and software
that we are writing just for a single use.
Aside from smaller scripts, Procedural Programming is also commonly seen
in code focused on high performance, with relatively simple data structures,
such as in High Performance Computing (HPC).
These programs tend to be written in C (which does not support Object Oriented Programming)
or Fortran (which did not until recently).
HPC code is also often written in C++,
but C++ code would more commonly follow an Object Oriented style,
though it may have procedural sections.

Note that you may sometimes hear people refer to this paradigm as "functional programming"
to contrast it with Object Oriented Programming,
because it uses functions rather than objects,
but this is incorrect.
Functional Programming is a separate paradigm that
places much stronger constraints on the behaviour of a function
and structures the code differently as we will see soon.

You can read more in an [extra episode on Procedural Programming](../learners/procedural-programming.md).

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
With datasets like this, we cannot move the data around easily,
so we often want to send our code to where the data is instead.
By writing our code in a functional style,
we also gain the ability to run many operations in parallel
as it is guaranteed that each operation will not interact with any of the others -
this is essential if we want to process this much data in a reasonable amount of time.

You can read more in an [extra episode on Functional Programming](../learners/functional-programming.md).

### Object Oriented Programming

Object Oriented Programming focuses on the specific characteristics of each object
and what each object can do.
An object has two fundamental parts - properties (characteristics) and behaviours.
In Object Oriented Programming,
we first think about the data and the things that we are modelling - and represent these by objects.

For example, if we are writing a simulation for our chemistry research,
we are probably going to need to represent atoms and molecules.
Each of these has a set of properties which we need to know about
in order for our code to perform the tasks we want -
in this case, for example, we often need to know the mass and electric charge of each atom.
So with Object Oriented Programming,
we will have some **object** structure which represents an atom and all of its properties,
another structure to represent a molecule,
and a relationship between the two (a molecule contains atoms).
This structure also provides a way for us to associate code with an object,
representing any **behaviours** it may have.
In our chemistry example, this could be our code for calculating the force between a pair of atoms.

Most people would classify Object Oriented Programming as an
[extension of the Imperative family of languages](https://www.digitalocean.com/community/tutorials/functional-imperative-object-oriented-programming-comparison)
(with the extra feature being the objects), but
[others disagree](https://stackoverflow.com/questions/38527078/what-is-the-difference-between-imperative-and-object-oriented-programming).

You can read more in an [extra episode on Object Oriented Programming](../learners/object-oriented-programming.md).

## Other Paradigms

The three paradigms introduced here are some of the most common,
but there are many others which may be useful for addressing specific classes of problem -
for much more information see the Wikipedia's page on
[programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm).

We have mainly used Procedural Programming in this lesson, but you can
have a closer look at [Functional](../learners/functional-programming.md) and
[Object Oriented Programming](../learners/object-oriented-programming.md) paradigms
in extra episodes and how they can affect our architectural design choices.


::: keypoints
- A software paradigm describes a way of structuring or reasoning about code.
- Different programming languages are suited to different paradigms.
- Different paradigms are suited to solving different classes of problems.
- A single piece of software will often contain instances of multiple paradigms.
:::

