---
title: "Functional Programming"
teaching: 30
exercises: 0
questions:
- "Key question (FIXME)"
objectives:
- "Describe the core concepts that define the Functional Paradigm"
- "Decompose the flow of data within a program info a sequence of operations"
- "Decompose a problem into a set of similar sub-problems using recursion"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
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

### Pythonic MapReduce - Comprehensions

Often, when working with data you'll find that you need to apply a transformation to each datapoint, and/or filter the data, before performing some aggregation across the whole dataset.
This process is often referred to as MapReduce, particularly when working within the context of **Big Data** using tools such as Spark or Hadoop.

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
