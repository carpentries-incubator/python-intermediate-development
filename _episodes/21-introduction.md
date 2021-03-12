---
title: "Introduction - Day 2"
start: true
teaching: 5
exercises: 10
questions:
- "How does the structure of a problem affect the structure of our code?"
objectives:
- "Briefly describe the major paradigms we can use to classify programming languages"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

## A Brief History of Paradigms

There are hundreds (probably thousands) of different programming languages, each with different expectations of how a programmer will use them to solve a problem.
To help us to choose the language we will use and to help us describe how we want to use them, we can group the languages into **paradigms**.

Each paradigm represents a slightly different way of thinking about and structuring our code and each has certain strengths and weaknesses when used to solve particular types of problems.
Once your software begins to get more complex it's common to use aspects of different paradigms to handle different subtasks.
Because of this, it's useful to know about the major paradigms, so you can recognise where it might be useful to switch.

> In science and philosophy, a paradigm ... is a distinct set of concepts or thought patterns ...
>
> -- Wikipedia - Paradigm

### The Imperative Family

Code describes *how* data processing should happen.

Structured Programming
: Code is grouped into *logical blocks*.
: Early example: Algol (1958)
: You're unlikely to encounter this paradigm other than as a subset of the Procedural Paradigm

Procedural Programming
: Code is grouped into *procedures performing a single task*. (Does this sound familiar?)
: Early examples: FORTRAN II (1958), COBOL (1959)
: Common examples: C, Fortran

Object Oriented Programming
: Data is structured. Code *belongs with the data* it manipulates.
: Early examples: Simula (1967), Smalltalk (1972)
: Common examples: Python, C++, Java, C#

### The Declarative Family

Code describes *what* data processing should happen.

Functional Programming
: Functions are mathematical operations. *Code is data*.
: Early example: Lisp (1958)
: Common examples: R, JavaScript, Hadoop, Spark

Logic Programming
: Code is a *set of facts and rules*. Programs are executed by making a query.
: Early and common example: Prolog (1972)
: You're unlikely to encounter this paradigm unless you're a computer scientist or mathematician working in the field of logic reasoning - it's included here for balance

For each of the paradigms above, we've listed a couple of programming languages / tools commonly used in research for which this is the major paradigm.
Many of these languages (and many languages in general) can actually be used with a range of paradigms - so don't take this as a strict list.

## 1, 2, Fizz, 4, Buzz ... FizzBuzz

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

It's quite difficult to come up with a sensible implementation of FizzBuzz which demonstrates the Object Oriented Paradigm.
This is because the problem doesn't really involve structured data.
Just because you *can* use a particular paradigm to solve a problem doesn't mean you *should*.

The Object Oriented implementation of FizzBuzz below has similarities with both the procedural and functional implementations above, but is worse than both.

~~~
class FizzBuzzFactory:
    def __init__(self, factor_mapping):
        self.factor_mapping = factor_mapping

    def generate(self, count):
        return [FizzBuzzer(i, self.factor_mapping) for i in range(1, count + 1)]


class FizzBuzzer:
    def __init__(self, value, factor_mapping=None):
        self.value = value
        self.factor_mapping = factor_mapping

    def __mod__(self, div):
        return self.value % div

    def __str__(self):
        result = ''
        for factor, text in self.factor_mapping.items():
            if not self % factor:
                result += text

        if not result:
            result += str(self.value)

        return result


fizzbuzz_factors = {
    3: 'Fizz',
    5: 'Buzz',
}

factory = FizzBuzzFactory(fizzbuzz_factors)
print(', '.join(map(str, factory.generate(100))))
~~~
{: .language-python}

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
