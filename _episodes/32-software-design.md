---
title: "Software Architecture and Design"
teaching: 25
exercises: 20
questions:
- "What should we consider when designing software?"
- "What goals should we have when structuring our code?"
- "What is refactoring?"
objectives:
- "Know what goals we have when architecting and designing software."
- "Understand what an abstraction is, and when you should use one."
- "Understand what refactoring is."
keypoints:
- "How code is structured is important for helping future people understand and update it"
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change.
Such components can be as small as a single function, or be a software package in their own right."
- "These smaller components can be understood individually without having to understand the entire codebase at once."
- "When writing software used for research, requirements will almost *always* change."
- "*'Good code is written so that is readable, understandable, covered by automated tests, not over complicated and does well what is intended to do.'*"
---

## Introduction

Typically when we start writing code, we write small scripts that
we intend to use.
We probably don't imagine we will need to change the code in the future.
We almost certainly don't expect other people will need to understand
and modify the code in the future.
However, as projects grow in complexity and the number of people involved grows,
it becomes important to think about how to structure code.
Software Architecture and Design is all about thinking about ways to make the
code be **maintainable** as projects grow.

Maintainable code is:

 * Readable to people who didn't write the code.
 * Testable through automated tests (like those from [episode 2](../21-automatically-testing-software/index.html)).
 * Adaptable to new requirements.

Writing code that meets these requirements is hard and takes practise.
Further, in most contexts you will already have a piece of code that breaks
some (or maybe all!) of these principles.

> ## Group Exercise: Think about examples of good and bad code
> Try to come up with examples of code that has been hard to understand - why?
>
> Try to come up with examples of code that was easy to understand and modify - why?
{: .challenge}

In this episode we will explore techniques and processes that can help you
continuously improve the quality of code so, over time, it tends towards more
maintainable code.

We will look at:

 * What abstractions are, and how to pick appropriate ones.
 * How to take code that is in a bad shape and improve it.
 * Best practises to write code in ways that facilitate achieving these goals.

### Cognitive Load

When we are trying to understand a piece of code, in our heads we are storing
what the different variables mean and what the lines of code will do.
**Cognitive load** is a way of thinking about how much information we have to store in our
heads to understand a piece of code.

The higher the cognitive load, the harder it is to understand the code.
If it is too high, we might have to create diagrams to help us hold it all in our head
or we might just decide we can't understand it.

There are lots of ways to keep cognitive load down:

* Good variable and function names
* Simple control flow
* Having each function do just one thing

## Abstractions

An **abstraction**, at its most basic level, is a technique to hide the details
of one part of a system from another part of the system.
We deal with abstractions all the time - when you press the break pedal on the
car, you do not know how this manages both slowing down the engine and applying
pressure on the breaks.
The advantage of using this abstraction is, when something changes, for example
the introduction of anti-lock breaking or an electric engine, the driver does
not need to do anything differently -
the detail of how the car breaks is *abstracted* away from them.

Abstractions are a fundamental part of software.
For example, when you write Python code, you are dealing with an
abstraction of the computer.
You don't need to understand how RAM functions.
Instead, you just need to understand how variables work in Python.

In large projects it is vital to come up with good abstractions.
A good abstraction makes code easier to read, as the reader doesn't need to understand
all the details of the project to understand one part.
An abstraction lowers the cognitive load of a bit of code,
as there is less to understand at once.

A good abstraction makes code easier to test, as it can be tested in isolation
from everything else.

Finally, a good abstraction makes code easier to adapt, as the details of
how a subsystem *used* to work are hidden from the user, so when they change,
the user doesn't need to know.

In this episode we are going to look at some code and introduce various
different kinds of abstraction.
However, fundamentally any abstraction should be serving these goals.

## Refactoring

Often we are not working on brand new projects, but instead maintaining an existing
piece of software.
Often, this piece of software will be hard to maintain, perhaps because it has hard to understand, or doesn't have any tests.
In this situation, we want to adapt the code to make it more maintainable.
This will allow greater confidence of the code, as well as making future development easier.

**Refactoring** is a process where some code is modified, such that its external behaviour remains
unchanged, but the code itself is easier to read, test and extend.

When faced with a old piece of code that is hard to work with, that you need to modify, a good process to follow is:

1. Refactor the code in such a way that the new change will slot in cleanly.
2. Make the desired change, which now fits in easily.

Notice, after step 1, the *behaviour* of the code should be totally identical.
This allows you to test rigorously that the refactoring hasn't changed/broken anything
*before* making the intended change.

In this episode, we will be making some changes to an existing bit of code that
is in need of refactoring.

## The code for this episode

The code itself is a feature to the inflammation tool we've been working on.

In it, if the user adds `--full-data-analysis` then the program will scan the directory
of one of the provided files, compare standard deviations across the data by day and
plot a graph.

The main body of it exists in `inflammation/compute_data.py` in a function called `analyse_data`.

We are going to be refactoring and extending this over the remainder of this episode.

> ## Group Exercise: What is bad about this code?
> In what ways does this code not live up to the ideal properties of maintainable code?
> Think about ways in which you find it hard to understand.
> Think about the kinds of changes you might want to make to it, and what would
> make making those changes challenging.
>> ## Solution
>> You may have found others, but here are some of the things that make the code
>> hard to read, test and maintain:
>>
>> * Everything is in a single function - reading it you have to understand how the file loading
works at the same time as the analysis itself.
>> * If you want to use the data without using the graph you'd have to change it
>> * It is always analysing a fixed set of data
>> * It seems hard to write tests for it as it always analyses a fixed set of files
>> * It doesn't have any tests
>>
>> Keep the list you created - at the end of this section we will revisit this
>> and check that we have learnt ways to address the problems we found.
> {: .solution}
{: .challenge}

{% include links.md %}
