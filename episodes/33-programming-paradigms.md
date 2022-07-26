---
title: "Programming Paradigms"
start: false
teaching: 15
exercises: 30
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

As you become more experienced in software development, it becomes increasingly important to understand the wider 
landscape in which you operate - i.e. what software decisions have the people around you made and why?
There are hundreds (probably thousands) of different programming languages, each with different approaches of how a 
programmer will use them to solve a problem. These approaches group the programming languages into **paradigms**.
Each paradigm represents a slightly different way of thinking about and structuring our code and each has certain 
strengths and weaknesses when used to solve particular types of problems. Once your software begins to get more 
complex it's common to use aspects of different paradigms to handle different subtasks. Because of this, it's useful to 
know about the major paradigms, so you can recognise where it might be useful to switch. We will look into two major 
paradigms that may be useful to you - **Procedural Programming** and **Object-Oriented Programming**.

## Procedural Programming
Procedural Programming is probably the style you're most familiar with and the one we used 
up to this point, where we group code into *procedures performing a single task, with exactly one entry and one exit point*.
In most modern languages we call these **functions**, instead of procedures - so if you're grouping your code into functions, this might be the paradigm you're using. By grouping code like this, we make it even easier to reason about the overall structure, since we should be able to tell roughly what a function does just by looking at its name.
These functions are also much easier to reuse outside of functions, since we can call them from any part of our program.

So far we have been using this technique in our code - it contains a
list of instructions that execute one after the other starting from the top. This is an appropriate choice for smaller scripts and software that we're writing just for a single use.
Aside from smaller scripts, Procedural Programming is also commonly seen in code focused on high performance, with relatively simple data structures, such as in High Performance Computing (HPC).
These programs tend to be written in C (which doesn't support Object Oriented Programming) or Fortran (which didn't until recently).
HPC code is also often written in C++, but C++ code would more commonly follow an Object Oriented style, though it may have procedural sections.

Note that you may sometimes hear people refer to this paradigm as "Functional Programming" to contrast it with 
Object Oriented Programming, because it uses functions rather than objects, but this is incorrect.
[Functional Programming][functional-programming] is a separate paradigm that places much stronger constraints 
on the behaviour of a function - there is an [extra episode on Functional Programming](../functional-programming) 
for some additional reading.

## Object Oriented Programming

Object Oriented Programming focuses on the specific characteristics of each object and what each object can do.
An object has two fundamental parts - properties (characteristics) and actions. In Object Oriented Programming, we 
first think about the data and the things that we're modelling - and represent these by objects. 

For example, if we're writing a simulation for our chemistry research, we're probably going to need to represent atoms and molecules.
Each of these has a set of properties which we need to know about in order for our code to perform the tasks we want - 
in this case, for example, we often need to know the mass and electric charge of each atom.
So with Object Oriented Programming, we'll have some **object** structure which represents an atom and all of its properties, another structure to represent a molecule, and a relationship between the two (a molecule contains atoms).
This structure also provides a way for us to associate code with an object, representing any **behaviours** it may have.

> ## Is Python Procedural or Object Oriented Language?
> Python is a multi-paradigm and multi-purpose programming language. You can use it as a procedural language and 
> you can use it in a more object oriented way. It tends to land more on the object oriented side as all its core data 
> types (strings, integers, floats, booleans, lists, sets, arrays, tuples, dictionaries, files) as well as functions, 
> modules and classes are objects. Many built-in functions and external Python packages 
> like [NumPy][numpy], [pandas][pandas] and [Scikit-learn][scikit-learn] are also built using object oriented programming.
{: .callout}

Let's continue to develop our software project, using Object Oriented Programming to design a more complete model 
of our patients and to get a bit more experience with object oriented programming paradigm.

### Encapsulating Data

One of the main difficulties we encounter when building more complex software is how to structure our data.
So far, we've been processing data from a single source and with a simple tabular structure, but it would be useful to be able to combine data from a range of different sources and with more data than just an array of numbers.

~~~ python
data = np.array([[1., 2., 3.],
                 [4., 5., 6.]])
~~~
{: .language-python}

Using this data structure has the advantage of being able to use NumPy operations to process the data and Matplotlib to plot it, but often we need to have more structure than this.
For example, we may need to attach more information about the patients and store this alongside our measurements of inflammation.

We can do this using the Python data structures we're already familiar with, dictionaries and lists.
For instance, we could attach a name to each of our patients:

~~~ python
patients = [
    {
        'name': 'Alice',
        'data': [1., 2., 3.],
    },
    {
        'name': 'Bob',
        'data': [4., 5., 6.],
    },
]
~~~
{: .language-python}

> ## Structuring Data
>
> Write a function, called `attach_names`, which can be used to attach names to our patient dataset.
> When used as below, it should produce the expected output.
>
> If you're not sure where to begin, think about ways you might be able to effectively loop over two collections at once.
> Also, don't worry too much about the data type of the `data` value, it can be a Python list, or a NumPy array - either is fine.
>
> ~~~ python
> data = np.array([[1., 2., 3.],
>                  [4., 5., 6.]])
>
> output = attach_names(data, ['Alice', 'Bob'])
> print(output)
> ~~~
> {: .language-python}
>
> ~~~
> [
>     {
>         'name': 'Alice',
>         'data': [1., 2., 3.],
>     },
>     {
>         'name': 'Bob',
>         'data': [4., 5., 6.],
>     },
> ]
> ~~~
> {: .output}
>
> > ## Solution
> >
> > One possible solution, perhaps the most obvious, is to use the `range` function to index into both lists at the same location:
> >
> > ~~~ python
> > def attach_names(data, names):
> >     """Create datastructure containing patient records."""
> >     output = []
> >
> >     for i in range(len(data)):
> >         output.append({'name': names[i],
> >                        'data': data[i]})
> >
> >     return output
> > ~~~
> > {: .language-python}
> >
> > However, this solution has a potential problem that can occur sometimes, depending on the input.
> > What might go wrong with this solution?  How could we fix it?
> >
> > > ## A Better Solution
> > >
> > > What would happen if the `data` and `names` inputs were different lengths?
> > >
> > > If `names` is longer, we'll loop through, until we run out of rows in the `data` input, at which point we'll stop processing the last few names.
> > > If `data` is longer, we'll loop through, but at some point we'll run out of names - but this time we try to access part of the list that doesn't exist, so we'll get an exception.
> > >
> > > A better solution would be to use the `zip` function, which allows us to iterate over multiple iterables without needing an index variable.
> > > The `zip` function also limits the iteration to whichever of the iterables is smaller, so we won't raise an exception here, but this might not quite be the behaviour we want, so we'll also explicitly `assert` that the inputs should be the same length.
> > > Checking that our inputs are valid in this way is known as a **precondition**.
> > >
> > > If you've not previously come across this function, read [this section](https://docs.python.org/3/library/functions.html#zip) of the Python documentation.
> > >
> > > ~~~ python
> > > def attach_names(data, names):
> > >     """Create datastructure containing patient records."""
> > >     assert len(data) == len(names)
> > >     output = []
> > >
> > >     for data_row, name in zip(data, names):
> > >         output.append({'name': name,
> > >                        'data': data_row})
> > >
> > >     return output
> > > ~~~
> > > {: .language-python}
> > {: .solution}
> {: .solution}
{: .challenge}

{% include links.md %}
