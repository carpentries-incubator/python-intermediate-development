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

In C, using the procedural paradigm:

~~~
#include<stdio.h>

int main (void)
{
    int i;
    for (i = 1; i <= 100; i++)
    {
        if (!(i % 15))
            printf ("FizzBuzz");
        else if (!(i % 3))
            printf ("Fizz");
        else if (!(i % 5))
            printf ("Buzz");
        else
            printf ("%d", i);

        printf("\n");
    }
    return 0;
}
~~~
{: .language-c}

In JavaScript, using the functional paradigm:

~~~
const factors = [[3, 'Fizz'], [5, 'Buzz']]
const fizzBuzz = num => factors.map(([factor,text]) => (num % factor)?'':text).join('') || num
const range1 = x => [...Array(x+1).keys()].slice(1)
const outputs = range1(100).map(fizzBuzz)

console.log(outputs.join('\n'))
~~~
{: .language-javascript}

Many of the most popular languages allow you to use multiple paradigms, so you can choose the one that best fits the problem you're trying to solve.
Python is no exception here, and it's very common to see a Python program containing elements of the Procedural, Object Oriented, and Functional Paradigms.

> ## FizzBuzz in Python
>
> Write your own implementation of FizzBuzz in Python.
> Which paradigm(s) have you used?
>
{: .challenge}


{% include links.md %}
