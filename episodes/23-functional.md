---
title: "Functional Programming"
teaching: 30
exercises: 0
questions:
- "What is a function really?"
- "How can we be sure our code does the same thing every time?"
- "What is the difference between data and code?"
- "What do we need to do differently when working with Big Data?"
objectives:
- "Describe the core concepts that define the Functional Paradigm"
- "Decompose the flow of data within a program info a sequence of operations"
- "Decompose a problem into a set of similar sub-problems using recursion"
keypoints:
- "Pure Functions are functions with deterministic behaviour and no side effects."
- "By working towards pure functions, we can make our code more testable and composable."
- "There is very little difference between data and code in many languages - we can pass functions in and out of other functions without any extra work."
- "Comprehensions and generators are Python features for efficiently processing a collection of data."
---

## What is a Function?

### Pure Functions and Side Effects

We define a **pure function** as one which satisfies two criteria:
1. The data returned must be the same each time the same arguments are provided
2. Calling the function has no **side effects**

Side effects cover any action that a function performs which affects anything other than the value they return.
Examples include: printing text, modifying the value of an argument, or changing the value of a global variable.

> ## Pure Functions
>
> Which of these functions are pure?
> Explain your reasoning to a partner, do they agree?
>
> ~~~
> def add_one(x):
>     return x + 1
>
> def say_hello(name):
>     print('Hello', name)
>
> def append_item_1(a_list, item):
>     a_list.append(item)
>     return a_list
>
> def append_item_2(a_list, item):
>     result = a_list + [item]
>     return result
> ~~~
> {: .language-python}
>
> > ## Solution
> >
> > 1. `add_one` is pure - it has no effects other than to return a value
> > 2. `say_hello` is not pure - printing text counts as a side effect, even though it is the clear purpose of the function
> > 3. `append_item_1` is not pure - the argument `a_list` gets modified - try this yourself to prove it
> > 4. `append_item_2` is pure - the result is a new variable, so this time `a_list` doesn't get modified
> {: .solution}
>
{: .challenge}


### Why Does it Matter?

There's a few benefits we get when working with a pure function:

- Testability
- Composability
- Parallelisability

The first benefit is **Testability**.
It's much easier to test a function if we can be certain that a certain input will always produce the same output.
This has been the case with the examples we've seen so far.
If a function we're testing is non-pure, we need to come up with a new way to test it - how we do this will depend on how the function deviates from being pure.

**Composability** refers to the ability to combine multiple functions by piping the output of one function as the input to the next function.

Finally, **Parallelisability**.
If we know that a function is pure, we can split up the data and distribute the work across multiple processors.
The output of the function depends only on its input, so we'll get the right result regardless of where the code runs.

> ## Everything in Moderation
>
> > Turns out, every time a user does something, it could be different. Users are surprisingly non-mathematical, so they're gonna have to go.
> >
> > -- Douglas Crockford - The Post JavaScript Apocalypse
>
> Despite the benefits that pure functions can bring, we shouldn't be trying to use them everywhere.
> Any software we write needs to interact with the rest of the world somehow, which requires side effects.
>
{: .callout}


> ## Testing Impure Functions
>
> Try writing some unit tests for Python's `random.normalvariate` or NumPy's `numpy.random.normal` function.
> These functions both generate random numbers drawn from a normal distribution.
>
> What is the correct behaviour for these functions?
> How can we test that?
> How reliable are the tests you've created?
>
> ~~~
> # TODO write reference code and solution
> ~~~
> {: .language-python}
>
> ~~~
> ~~~
> {: .output}
>
> > ## Solution
> >
> > ~~~
> > ~~~
> > {: .language-python}
> >
> {: .solution}
{: .challenge}


### Pythonic MapReduce - Comprehensions

Often, when working with data you'll find that you need to apply a transformation to each datapoint, and/or filter the data, before performing some aggregation across the whole dataset.
This process is often referred to as **MapReduce**, particularly when working within the context of **Big Data** using tools such as Spark or Hadoop.
The MapReduce style of data processing relies heavily on the composability and parallelisability that we get when using functional programming.

In Python, we have the built-in functions `map`, `filter`, and `reduce`, but we'll skip over those and go straight to the recommended approach.
If you're interested in this form of data processing, it might be worth looking up the documentation for these older versions.

The new, more Pythonic way to perform MapReduce is using **comprehensions**.

~~~
integers = range(5)
double_ints = [2 * i for i in integers]

print(double_ints)
~~~
{: .language-python}

~~~
[0, 2, 4, 6, 8]
~~~
{: .output}

The above example uses a **list comprehension** to double each number in a sequence.
Notice the similarity between the syntax for a list comprehension and a for loop - in effect, this is a for loop compressed into a single line.

We can also use list comprehensions to filter data, by adding the filter condition to the end.

~~~
double_even_ints = [2 * i for i in integers if i % 2 == 0]

print(double_even_ints)
~~~
{: .language-python}

~~~
[0, 4, 8]
~~~
{: .output}

Similarly, we have **set and dictionary comprehensions**, which look similar to list comprehensions, but use the **set literal** or **dictionary literal** syntax.

~~~
double_int_set = {2 * i for i in integers}

print(double_int_set)
~~~
{: .language-python}

~~~
{0, 2, 4, 6, 8}
~~~
{: .output}

~~~
double_int_dict = {i: 2 * i for i in integers}

print(double_int_dict)
~~~
{: .language-python}

~~~
{0: 0, 1: 2, 2: 4, 3: 6, 4: 8}
~~~
{: .output}

> ## Why No Tuple Comprehensions
>
> Raymond Hettinger, one of the Python core developers, said in 2013:
>
> ~~~
> Generally, lists are for looping; tuples for structs. Lists are homogeneous; tuples heterogeneous. Lists for variable length.
> ~~~
{: .callout}

> ## Generator Comprehensions
>
> Mention as aside
>
{: .callout}

## Functions as First Class Objects

One of the important things that functional programming adds is the ability to pass functions around as if they were normal objects.
This is because in languages which support functional programming, functions are normal objects.

~~~
def add_one(num):
    return num + 1

def add_ones(in_list):
    return [add_one(x) for x in in_list]

result = add_ones([0, 1, 2])
print(result)
~~~
{: .language-python}

~~~
[1, 2, 3]
~~~
{: .output}

~~~
def add_one(num):
    return num + 1

def apply_fn(in_list, fn):
    return [fn(x) for x in in_list]

result = apply_fn([0, 1, 2], add_one)
print(result)
~~~
{: .language-python}

~~~
[1, 2, 3]
~~~
{: .output}

For small functions which we only need in a single place, we can use a **lambda function** instead.
These are functions which don't have a name, they exist as an un-named object.

~~~
def apply_fn(in_list, fn):
    return [fn(x) for x in in_list]

result = apply_fn([0, 1, 2], lambda x: x + 1)
print(result)
~~~
{: .language-python}

~~~
[1, 2, 3]
~~~
{: .output}


{% include links.md %}
