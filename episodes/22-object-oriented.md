---
title: "Object Oriented Programming"
teaching: 60
exercises: 0
questions:
- "Key question (FIXME)"
objectives:
- "Describe the core concepts that define the Object Oriented Paradigm"
- "Use classes to encapsulate data within a more complex program"
- "Structure concepts within a program in terms of sets of behaviour"
- "Identify different types of relationship between concepts within a program"
- "Structure data within a program using these relationships"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

## Encapsulating Data

Structured data

One of the most common ways to store numerical data in Python is using a NumPy array.
How we did it in novice SWC.

~~~
data = np.array([1., 2., 3.],
                [4., 5., 6.])
~~~
{: .language-python}

Has advantage of being able to use NumPy operations to process the data and Matplotlib to plot it, but often we need to have more structure in our data than this.
For example, we may need to attach more information about the patients and store this alongside our measurements of inflammation.

We can do this using the Python data structures we're already familiar with, dictionaries and lists.
For instance, we could attach a name to each of our patients:

~~~
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
>
> ~~~
> data = np.array([1., 2., 3.],
>                 [4., 5., 6.])
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
{: .challenge}

### Classes in Python

Using nested dictionaries and lists should work for most cases where we need to handle structured data, but they get quite difficult to manage once the structure becomes a bit more complex.



### The `__init__` Method

Getting data in.

> ## Test Driven Development
>
> In yesterday's lesson we learnt how to create **unit tests** to make sure our code is behaving as we intended.
> **Test Driven Development** (TDD) is an extension of this.
> If we can define a set of tests for everything our code needs to do, then why not treat those tests as the specification.
>
> When doing Test Driven Development, we write our tests first and only write enough code to make the tests pass.
> We tend to do this at the level of individual features - define the feature, write the tests, write the code.
> The main advantages are:
>   - It forces us to think about how our code will be used before we write it
>   - It prevents us from doing work that we don't need to do, e.g. "I might need this later..."
>
> You may also see this process called **Red, Green, Refactor**: 'Red' for the failing tests, 'Green' for the code that makes them pass, then 'Refactor' (tidy up) the result.
>
> We'll be using Test Driven Development for most of the work from here.
>
{: .callout}


## Encapsulating Behaviour

### Dunder Methods

> ## Class and Static Methods
>
> Would quite like to have a `Patient.from_record` classmethod if time
>
{: .callout}

> ## Decorators
>
> Might come back to these later in Functional Programming - if time
>
{: .callout}


## Relationships Between Classes

### Composition

Doctor *has* Patients

### Inheritance

Patient *is* a Person

Doctor *is* a Person

> ## Multiple Inheritance
>
> Exists in Python, doesn't in some other languages.
> Useful, but dangerous.
>
{: .callout}

{% include links.md %}
