---
title: "Using classes to de-couple code."
teaching: 0
exercises: 0
questions:
- "What is de-coupled code?"
- "When is it useful to use classes to structure code?"
objectives:
- "Understand the object-oriented principle of polymorphism and interfaces."
- "Be able to introduce appropriate abstractions to simplify code."
- "Understand what decoupled code is, and why you would want it."
keypoints:
- "By using interfaces, code can become more decoupled."
- "Decoupled code is easier to test, and easier to maintain."
---

## Introduction

* What is coupled and decoupled code
* Why decoupled code is better

> ## Exercise: Decouple the file loading from the computation
> Currently the function is hard coded to load all the files in a directory
> Decouple this into a separate function that returns all the files to load
>> ## Solution
>> TODO: This is breaking this down into more steps that I originally though, but I think
>> this is a good idea as otherwise this exercise is very hard, here's what we're aiming for:
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/7ccda313fda3a0b10ef5add83f5be50fe1d250fd
>> At the end of this exercise, perhaps just have a version of load_data written and called directly
> {: .solution}
{: .challenge}

## Polymorphism

* Introduce what a class is
* Explain member methods
* Explain constructors

> ## Exercise: Use a class to configure loading
> Put your function as a member method of a class, separating out the configuration
> of where to load the files from in the constructor, from where it actually loads the  data
>> ## Solution
>> TODO: This is breaking this down into more steps that I originally though, but I think
>> this is a good idea as otherwise this exercise is very hard, here's what we're aiming for:
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/7ccda313fda3a0b10ef5add83f5be50fe1d250fd
>> At the end of this exercise, they would have implemented `CSVDataSource`.
> {: .solution}
{: .challenge}

* Introduce what an interface is
* Introduce what polymorphism is
* Explain how we can use polymorphism to introduce abstractions

> ## Exercise: Define an interface for your class
> Create an interface class that defines the methods that a data source should provide
>> ## Solution
>> TODO: This is breaking this down into more steps that I originally though, but I think
>> this is a good idea as otherwise this exercise is very hard, here's what we're aiming for:
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/7ccda313fda3a0b10ef5add83f5be50fe1d250fd
>> At the end of this exercise, they would have the complete solution.
> {: .solution}
{: .challenge}

## How polymorphism is useful

* Introduce the idea of using a different implementation
  without changing the code

> ## Exercise: Introduce an alternative implentation of DataSource
> Create another class that repeatedly asks the user for paths to CSVs to analyse.
> It should inherit from the interface and implement the load_data method.
> Finally, at run time provide an instance of the new implementation if the user hasn't
> put any files on the path.
>> ## Solution
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/045754a11221a269771de8648fc56a383136fdaf
>> TODO: this is kind of hard too
> {: .solution}
{: .challenge}

* Explain how to test code that uses an interface

> ## Exercise: Test using a mock or dummy implemenation
> It is now possible to test your original method by providing a dummy
> implementation of the `DataProvider`. Use this to test the method
>> ## Solution
>> TODO: I haven't done this - do we want it?
> {: .solution}
{: .challenge}

## Object Oriented Programming

* Polymorphism is a tool from object oriented programming
* Outline some other tools from OOP that might be useful
