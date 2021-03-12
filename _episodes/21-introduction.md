---
title: "Introduction - Day 2"
start: true
teaching: 0
exercises: 0
questions:
- "Key question (FIXME)"
objectives:
- "First learning objective. (FIXME)"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

## A Brief History of Paradigms

There are hundreds (probably thousands) of different programming languages, each with different expectations of how a programmer will use them to solve a problem.
To help us to choose the language we will use and to help us describe how we want to use them, we can group the languages into **paradigms**.

> ## Paradigms
>
> > In science and philosophy, a paradigm ... is a distinct set of concepts or thought patterns ...
> >
> > -- Wikipedia - Paradigm
{: .callout}

## The Imperative Family

Code describes *how* data processing should happen.

### Structured Programming

Code should be grouped into *logical blocks*.
Early example: Algol (1958)

### Procedural Programming

Code should be grouped into *procedures performing a single task*.
(Does this sound familiar?)
Early examples: FORTRAN II (1958), COBOL (1959)

### Object Oriented Programming

Data should be structured.
*Code belongs with data*.
Early examples: Simula (1967), Smalltalk (1972)

## The Declarative Family

Code describes *what* data processing should happen.

### Functional Programming

Functions are mathematical operations.
*Code is data*.
Early example: Lisp (1958)

## 1, 2, Fizz, 4, Buzz

FizzBuzz is a common example of a simple program used to compare different languages.
The idea is to generate the sequence of integers, but replace multiples of three with "Fizz", multiples of five with "Buzz", and multiples of both with "FizzBuzz".

> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz

The FizzBuzz implementation below, written in C, is characteristic of the procedural paradigm.
The code shows a sequence of instructions which should be run to obtain the desired result.

~~~
#include<stdio.h>

int main (void)
{
    int i;
    for (i = 1; i <= 100; i++)
    {
        if (!(i % 15))
            printf("FizzBuzz");
        else if (!(i % 3))
            printf("Fizz");
        else if (!(i % 5))
            printf("Buzz");
        else
            printf("%d", i);

        printf("\n");
    }
    return 0;
}
~~~
{: .source}

In contrast, this implementation of FizzBuzz in Javascript is characteristic of the functional paradigm.
The code is structured as a sequence of transformations which are applied to data to obtain the desired result.

~~~
const factors = [[3, 'Fizz'], [5, 'Buzz']]
const fizzBuzz = num => factors.map(([factor,text]) => (num % factor)?'':text).join('') || num
const range1 = x => [...Array(x+1).keys()].slice(1)
const outputs = range1(100).map(fizzBuzz)

console.log(outputs.join('\n'))
~~~
{: .source}


Note how in the functional JavaScript example, every variable is declared as `const` - meaning that the value cannot be changed (perhaps 'variable' isn't the best word here, but it's still used).
You may also notice that two of the variables (`fizzBuzz` and `range1`) are actually functions.
Both of these are common in functional programming - we treat functions exactly the same as data, and usually do not modify existing data, but apply transformations to create new data.

Many of the most popular languages allow you to use multiple paradigms, so you can choose the one that best fits the problem you're trying to solve.
Python is no exception here, and it's quite common to see a Python program containing elements of the Procedural, Object Oriented, and Functional Paradigms.

> ## FizzBuzz in Python
>
> Write your own implementation of FizzBuzz in Python.
> Which paradigm(s) have you used?
>
{: .challenge}

> ## Rosetta Code
>
> [Rosetta Code](https://rosettacode.org/) is a useful resource for comparing a wide range of programming languages.
> It contains user-contributed examples of code which solves the same problems in many different languages.
> For example, the [FizzBuzz page](https://rosettacode.org/wiki/FizzBuzz) contained examples in just over 300 different languages when this was written.
>
{: .callout}


{% include links.md %}
