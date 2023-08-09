---
title: "Software Architecture and Design"
teaching: 0
exercises: 0
questions:
- "What should we consider when designing software?"
- "What goals should we have when structuring our code"
objectives:
- "Understand what an abstraction is, and when you should use one"
- "Understand what refactoring is"
keypoints:
- "How code is structured is important for helping future people understand and update it"
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change.
Such components can be as small as a single function, or be a software package in their own right."
- "These smaller components can be understood individually without having to understand the entire codebase at once."
- "When writing software used for research, requirements will almost *always* change."
- "*'Good code is written so that is readable, understandable, covered by automated tests, not over complicated and does well what is intended to do.'*"
---

## Introduction

* Thoughts on software design

## Abstractions

* Introduce the idea of an abstraction

> ## Group Exercise: Think about examples of good and bad code
> Try to come up with examples of code that has been hard to understand - why?
>
> Try to come up with examples of code that was easy to understand and modify - why?
{: .challenge}

## Refactoring

* Define refactoring
* Discuss the advantages of refactoring before making changes

## The code for this episode

* Introduce the code that will be used for this episode

> ## Group Exercise: What is bad about this code?
> What about this code makes it hard to understand?
> What makes this code hard to change?
>> ## Solution
>> * Everything is in a single function
>> * If I want to use the data without using the graph I'd have to change it
>> * It is always analysing a fixed set of data
>> * It seems hard to write tests for it
>> * It doesn't have any tests
> {: .solution}
{: .challenge}

{% include links.md %}
