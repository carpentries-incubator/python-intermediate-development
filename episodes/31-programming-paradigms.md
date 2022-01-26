---
title: "Programming Paradigms"
start: false
teaching: 10
exercises: 5
questions:
- "How does the structure of a problem affect the structure of our code?"
objectives:
- "Briefly describe the major paradigms we can use to classify programming languages."
keypoints:
- "A Paradigm describes a way of structuring reasoning about code."
- "Different programming languages are suited to different paradigms."
- "Different paradigms are suited to solving different classes of problems."
---

## Introduction

This section is a bit of a tone change as we introduce some theoretical concepts and a bit of historical context - please bear with us, we'll be back to practical applications soon!
As you become more experienced in software development, it becomes increasingly important to understand the wider landscape in which you operate - i.e. what software decisions have the people around you made and why?
A good understanding of their landscape is one of the key things that makes someone an expert.
By giving a small amount of background in theory and historical context here, we hope that this will help you to examine and understand your landscape.

There are hundreds (probably thousands) of different programming languages, each with different expectations of how a programmer will use them to solve a problem.
To help us choose the language we will use and to help us describe how we want to use them, we can group the languages into **paradigms**.

Each paradigm represents a slightly different way of thinking about and structuring our code and each has certain strengths and weaknesses when used to solve particular types of problems.
Once your software begins to get more complex it's common to use aspects of different paradigms to handle different subtasks.
Because of this, it's useful to know about the major paradigms, so you can recognise where it might be useful to switch.

> In science and philosophy, a paradigm ... is a distinct set of concepts or thought patterns ...
>
> -- Wikipedia - Paradigm

There are two major families that we can group the common major paradigms into: **Imperative** and **Declarative**.
For each of these families, some of the major paradigms are listed, with examples of the languages which introduced them and some languages you might encounter in your own work which predominantly use each paradigm.
However, most of the languages listed can be used with multiple paradigms, and it's common to see multiple paradigms within a single program - so this isn't a strict list.

### The Imperative Family

In the paradigms of the Imperative Family, code describes *how* data processing should happen.

#### Structured Programming

- Early example: Algol (1958)

The core of Structured Programming is the realisation that code should be grouped into *logical blocks* - before this, code was just a sequence of instructions, with a little bit of flow control.
This sounds an obvious thing now, but has implications further than just grouping code into blocks using constructs like `for` and `if`.
If we can be sure that a block has exactly one **entry point** at the top, and exactly one **exit point** at the bottom, then when we reason about the overall flow of the program, we can treat that block as if it's a straight line, regardless of the structure inside it.

This paradigm has largely been replaced now and only really exists as a subset of the other paradigms.
Nonetheless, we can use this model of entry and exit points to simplify the structure of code we write, whichever paradigm we're using.

~~~ python
# This code has one entry point at the top and one exit point at the bottom.
# The overall flow through this code is linear, even though it contains a loop.

total = 0
for value in my_collection:
    total += value

print(total)

# This code has one entry point at the top, but multiple exit points.
# With this code inside a function (for `return` to work), we could either leave
# at the bottom, past the `print`, or by returning `total` within the loop.
# When we reason about this code, we have to consider the internal structure of the loop
# and the collection of values we're using.

total = 0
for value in my_collection:
    total += value
    if total > 10:
        return total

print(total)
~~~
{: .language-python}

#### Procedural Programming

- Early examples: FORTRAN II (1958), COBOL (1959)
- Common examples in research: C, Fortran

Procedural Programming is probably the style you're most familiar with up to this point, where we group code into *procedures performing a single task*.
In most modern languages we call these **functions**, instead of procedures - so if you're grouping your code into functions, this might be the paradigm you're using.

By grouping code like this, we make it even easier to reason about the overall structure, since we should be able to tell roughly what a function does just by looking at its name.
These functions are also much easier to reuse code outside of functions, since we can call them from any part of our program.
The ideas of Structured Programming still apply here, since we can design our functions with exactly one entry and one exit point.

As the structure of code here is simpler than the following paradigms, this is an appropriate choice for smaller scripts and software that we're writing just for a single use.
Aside from smaller scripts, Procedural Programming is also commonly seen in code focused on high performance, with relatively simple data structures, such as in High Performance Computing (HPC).
These programs tend to be written in C (which doesn't support Object Oriented Programming) or Fortran (which didn't until recently).
HPC code is also often written in C++, but C++ code would more commonly follow an Object Oriented style, though it may have procedural sections.

Note that you may sometimes hear people refer to this paradigm as "Functional Programming" to contrast it with Object Oriented Programming, because it uses functions rather than objects, but this is incorrect.
Functional Programming (see below) places much stronger constraints on the behaviour of a function.

#### Object Oriented Programming

- Early examples: Simula (1967), Smalltalk (1972)
- Common examples in research: Python, C++, Java, C#

In Object Oriented Programming, we first think about the structure of the data and the things that we're modelling.
For example, if we're writing a simulation for our chemistry research, we're probably going to need to represent atoms and molecules.
Each of these has a set of properties which we need to know about in order for our code to perform the tasks we want - in this case, for example, we often need to know the mass and electric charge of each atom.
So with Object Oriented Programming, we'll have some **object** structure which represents an atom and all of its properties, another structure to represent a molecule, and a relationship between the two (a molecule contains atoms).
This structure also provides a way for us to associate code with an object, representing any **behaviours** it may have.

### The Declarative Family

The Declarative Family is a distinct set of paradigms which have a different outlook on what a program is - here code describes *what* data processing should happen.
What we really care about here is the outcome - how this is achieved is less important.

#### Functional Programming

- Early example: Lisp (1958)
- Common examples in research: R, JavaScript, Hadoop, Spark

Functional Programming is built around a more strict definition of the term **function** borrowed from mathematics.
A function in this context can be thought of as a mapping that transforms its input data into output data.
Anything a function does other than produce an output is known as a **side effect** and should be avoided wherever possible.

Being strict about this definition allows us to break down the distinction between **code** and **data**, for example by writing a function which accepts and transforms other functions - in Functional Programming *code is data*.

The most common application of Functional Programming in research is in data processing, especially when handling **Big Data**.
One popular definition of Big Data is data which is too large to fit in the memory of a single computer, with a single dataset sometimes being multiple terabytes or larger.
With datasets like this, we can't move the data around easily, so we often want to send our code to where the data is instead.
By writing our code in a functional style, we also gain the ability to run many operations in parallel as it's guaranteed that each operation won't interact with any of the others - this is essential if we want to process this much data in a reasonable amount of time.

#### Query Languages

- Common examples in research: SQL, many domain specific examples

Query Languages are, as you might expect, languages designed for making queries from a set of data.
In general, queries express the subset of the data to be returned and any operations which should be performed on it before it is returned.
We aren't particularly concerned with how exactly these operations happen, only that we get the right data back.

SQL (or variants of SQL) is a very commonly used database query language, so many researchers find it useful to learn SQL at some point, regardless of the language they use for the rest of their work.
It's common to see short sections of SQL within programs written with another language.

#### Logic Programming

- Early and common example: Prolog (1972)

Logic Programming is even closer to mathematics than Functional Programming, being based on formal logic.
In this paradigm, our program is written as a *set of facts and rules* which form a system of logic.
We can then execute queries against this set, which the computer tries to prove.

This paradigm is most useful for handling relatively small datasets with very complex relationships between entities, particularly where we need to be able to prove the existence or non-existence of particular relationships.
You're unlikely to encounter this paradigm unless you're working on problems around systems of reasoning, but it's included here for balance, to show that the Declarative Family isn't just Functional Programming.

## 1, 2, Fizz, 4, Buzz ... FizzBuzz

FizzBuzz is a common example of a simple program used to compare different languages or paradigms.
The idea is to generate the sequence of integers, but replace multiples of three with "Fizz", multiples of five with "Buzz", and multiples of both with "FizzBuzz".

> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz

> ## FizzBuzz in Python
>
> Write your own implementation of FizzBuzz in Python.
> Which paradigm(s) have you used?
>
> You will probably find the **modulo** operator `%` useful, which calculates the remainder after division.
> It is used like `5 % 2` - which has the value `1`.
>
{: .challenge}

The examples below are illustrative of some of the major paradigms - we don't expect you to fully understand what's happening in each example.

This first FizzBuzz implementation is characteristic of the procedural or structured paradigms.
The code shows a sequence of instructions which should be run to obtain the desired result.

~~~
for i in range(1, 101):
    if i % 15 == 0:
        print('FizzBuzz')
    elif i % 3 == 0:
        print('Fizz')
    elif i % 5 == 0:
        print('Buzz')
    else:
        print(i)
~~~
{: .language-python}

The fundamental structure here is a `for` loop, containing some `if` statements to make decisions - this is probably a structure you're quite familiar with and is probably similar to the fizbuzz solution you wrote yourself.

In contrast, this second implementation of FizzBuzz is characteristic of the functional paradigm and may look much less familiar.
Each line describes either a piece of data or a data transformation, which are combined to obtain the desired result.

~~~
factors = [[3, 'Fizz'], [5, 'Buzz']]
fizzbuzz = lambda val: ''.join(text for factor, text in factors if val % factor == 0) or str(val)
outputs = map(fizzbuzz, range(1, 101))
print('\n'.join(outputs))
~~~
{: .language-python}

In this example, there's three main things to notice:

- Once we've created a variable, we never change its value
- One of the variables (`fizzbuzz`) is actually a function, which we then pass into another function (`map`)
- To add an extra factor (e.g. 7 = 'Foo') we only need to update the factor mapping, none of the code which actually performs the work needs to be changed.

These are all common features in functional programming - we treat functions exactly the same as data, and usually do not modify existing data, but apply transformations to create new data.

It's quite difficult to come up with a sensible implementation of FizzBuzz which demonstrates the Object Oriented Paradigm.
This is because the problem doesn't really involve structured data.
Just because you *can* use a particular paradigm to solve a problem doesn't mean you *should*.

The Object Oriented implementation of FizzBuzz in Python below has similarities with both the procedural and functional implementations above, but is worse than both.
Again, we do not expect you to fully understand this example yet, but it should make more sense after we've covered the necessary Python lessons.

~~~
class FizzBuzzer:
    def __init__(self, value, factor_mapping=None):
        self.value = value
        self.factor_mapping = factor_mapping

    def __mod__(self, div):
        return self.value % div

    def __str__(self):
        result = ''
        for factor, text in self.factor_mapping.items():
            if self % factor == 0:
                result += text

        if not result:
            result += str(self.value)

        return result


def fizzbuzz(factor_mapping, start, stop):
        return [FizzBuzzer(i, factor_mapping) for i in range(start, stop)]


fizzbuzz_factors = {
    3: 'Fizz',
    5: 'Buzz',
}

for val in fizzbuzz(fizzbuzz_factors, 1, 101):
    print(val)
~~~
{: .language-python}

In this example we make a `FizzBuzzer` structure (a **class**) which holds a numeric value and a mapping from factors to phrases.
It also implements some **behaviours** - we can find the modulo of the object with respect to a factor and we can convert it to a string.

> ## Rosetta Code
>
> [Rosetta Code](https://rosettacode.org/) is a useful resource for comparing a wide range of programming languages.
> It contains user-contributed examples of code which solves the same problems in many different languages.
> For example, the [FizzBuzz page](https://rosettacode.org/wiki/FizzBuzz) contained examples in just over 300 different languages when this was written.
>
{: .callout}


{% include links.md %}
