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
>
{: .challenge}



### Functions as First Class Objects


## Algorithms

### Pythonic MapReduce - Comprehensions

List, dictionary, set comprehensions.
Cut down from previous, too much repetition.
Don't bother with `map`, `filter`, `reduce`.

> ## Generator Comprehensions
>
> Mention as aside
>
{: .callout}

{% include links.md %}
