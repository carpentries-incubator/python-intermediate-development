---
title: "Functional Programming"
teaching: 30
exercises: 30
questions:
- "What is a function really?"
- "How can we be sure our code does the same thing every time?"
- "What is the difference between data and code?"
- "What do we need to do differently when working with Big Data?"
objectives:
- "Describe the core concepts that define the Functional Paradigm"
- "Decompose the flow of data within a program into a sequence of data transformations"
keypoints:
- "*Pure functions* are functions with deterministic behaviour and no side effects."
- "By working towards pure functions, we can make our code more testable and composable."
- "There is very little difference between data and code in many languages - we can pass functions in and out of other functions without any extra work."
- "Comprehensions and generators are Python features for efficiently processing a collection of data."
---

## What is a Function?

Often when we use the term **function** we're referring to a construct for containing a block of code which performs a particular task.
But we borrowed the term from mathematics, so what does it mean there?

> In mathematics, a function is a relation between sets that associates to every element of a first set exactly one element of the second set.
>
> -- Wikipedia - [Function (mathematics)](https://en.wikipedia.org/wiki/Function_(mathematics))

This definition is all about applying a transformation to some data - which gives us some other data as a result.
The Functional Programming paradigm is based on the mathematical definition of functions.
A program written in a functional style describes a series of operations which are performed on data to produce a desired output, the focus being on **what** rather than **how**.

You will likely encounter functional programming in the future in data analysis code, or if you use frameworks such as Hadoop, or languages like R.
In fact, there's a good [section on functional programming](https://adv-r.hadley.nz/fp.html) in Hadley Wickham's Advanced R book.
In this book, Hadley gives a good summary of the style:

> It’s hard to describe exactly what a functional style is, but generally I think it means decomposing a big problem into smaller pieces, then solving each piece with a function or combination of functions.
> When using a functional style, you strive to decompose components of the problem into isolated functions that operate independently.
> Each function taken by itself is simple and straightforward to understand; complexity is handled by composing functions in various ways.
>
> -- Hadley Wickham - [Functional Style](https://adv-r.hadley.nz/fp.html)

### Pure Functions and Side Effects

We define a **pure function** as one which satisfies two criteria:

1. The data returned must be the same each time the same arguments are provided
2. Calling the function has no **side effects**

Side effects cover any action that a function performs which affects anything other than the value they return.
Examples include: printing text, modifying the value of an argument, or changing the value of a global variable.

> ## Pure Functions
>
> Which of these functions are pure?
> If you're not sure, explain your reasoning to someone else, do they agree?
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
> > 1. `add_one` is pure - it has no effects other than to return a value and this value will always be the same when given the same inputs
> > 2. `say_hello` is not pure - printing text counts as a side effect, even though it is the clear purpose of the function
> > 3. `append_item_1` is not pure - the argument `a_list` gets modified as a side effect - try this yourself to prove it
> > 4. `append_item_2` is pure - the result is a new variable, so this time `a_list` doesn't get modified - again, try this yourself
>{: .solution}
>
{: .challenge}

There are a few benefits we get when working with a pure function:

- Testability
- Composability
- Parallelisability

**Testability**, as you might expect, means how easy it is to test the function - usually meaning unit tests.
It's much easier to test a function if we can be certain that a particular input will always produce the same output.
This has been the case with the examples we've seen so far.
If a function we're testing might have different results each time it runs, we need to come up with a new way to test it.
Similarly, it can be more difficult to test a function with side effects as it's not always obvious what the side effects will be, or how to measure them.

**Composability** refers to the ability to make a new function from a chain of other functions by piping the output of one as the input to the next.
If a function doesn't have side effects or non-deterministic behaviour, then all of its behaviour is reflected in the value it returns.
As a consequence of this, any chain of combined pure functions is itself pure, so we keep all these benefits when we're combining functions into a larger program.
As an example of this, we could make a function called `add_two`, using the `add_one` function we already have.

~~~
def add_two(x):
    return add_one(add_one(x))
~~~
{: .language-python}

Finally, **Parallelisability** - the ability for operations to be performed at the same time independently.
If we know that a function is fully pure and we've got a lot of data, we can often improve performance by distributing the computation across multiple processors.
The output of a pure function depends only on its input, so we'll get the right result regardless of when or where the code runs.


> ## Everything in Moderation
>
> > Turns out, every time a user does something, it could be different. Users are surprisingly non-mathematical, so they're gonna have to go.
> >
> > -- Douglas Crockford - [The Post JavaScript Apocalypse](https://youtu.be/99Zacm7SsWQ)
>
> Despite the benefits that pure functions can bring, we shouldn't be trying to use them everywhere.
> Any software we write needs to interact with the rest of the world somehow, which requires side effects.
> With pure functions you can't read any input, write any output, or interact with the rest of the world in any way, so we can't usually write useful software using just pure functions.
{: .callout}


> ## Testing Impure Functions
>
> Try writing some unit tests for Python's [`random.normalvariate` [docs]](https://docs.python.org/3/library/random.html#random.normalvariate) or NumPy's [`numpy.random.normal` [docs]](https://numpy.org/doc/stable/reference/random/generated/numpy.random.normal.html) function.
> These functions both generate random numbers drawn from a normal distribution.
> Because they return a different result each time we call them, these functions are not pure.
>
> What is the correct behaviour for these functions?
> How can we test that?
> How reliable are the tests you've created?
>
> One possible approach you may have seen before when dealing with randomness is to set a known **seed** (a number which is used to kick off a random sequence) for the random number generator.
> This effectively makes the random number generator non-random, which allows us to test it more easily.
> By doing this we're almost turning it back into a pure function!
> Instead of using this approach here, try to come up with a method which tests the statistical properties of the generator.
> A seed-based approach will tell you if the generator is giving the correct result for that particular seed, but not whether it's behaving correctly in general terms.
>
> > ## Solution
> >
> > The correct behaviour of these functions is to generate random numbers from a normal distribution with a given mean and standard deviation.
> > So to test these functions, that's what we need to check.
> >
> > However, because we're dealing with randomness, we need to make sure we've got a sufficiently large sample for the tests to be reliable and pick a threshold that we're going to use to say that the sample is correct.
> > In this example solution, we've picked a sample size of one million, and testing that the expected measurements are correct to within two decimal places.
> > This does seem a little loose, but the stricter we make these criteria the more likely the test will randomly fail.
> > Even with these values, the test will occasionally fail if you run it enough times.
> > ~~~
> >import numpy as np
> >import numpy.testing as npt
> >
> >def test_random_numpy():
> >   mean = 5
> >   sdev = 3
> >   sample_size = 1000000                    
> > 
> >   sample = np.random.normal(mean, sdev, sample_size)
> >   npt.assert_almost_equal(mean, np.mean(sample), decimal=2)
> >   npt.assert_almost_equal(sdev, np.std(sample), decimal=2)
> > ~~~
> > {: .language-python}
> {: .solution}
{: .challenge}


### MapReduce in Python Using Comprehensions

Often, when working with data you'll find that you need to apply a transformation to each datapoint, and/or filter the data, before performing some aggregation across the whole dataset.
This process is often referred to as **MapReduce**, particularly when working within the context of **Big Data** using tools such as Spark or Hadoop.
The MapReduce style of data processing relies heavily on the composability and parallelisability that we get when using functional programming.
This name comes from applying or **mapping** an operation to each value, then performing a **reduction** operation which collects the data together to produce a single result.

In Python, we do have the built-in functions `map()`, `filter()`, and `reduce()` - but here we will 
use Python **comprehensions** instead to achieve the same effect (which is a commonly used and recommended 
approach). If you're particularly interested in this form of data processing, it might be worth looking up the documentation for these functions.

**Comprehensions** are an elegant way of creating collections with less code using *for loops*. 

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
Notice the similarity between the syntax for a list comprehension and a for loop - in effect, 
this is a for loop compressed into a single line.
In this simple case, the code above is equivalent to using a map operation on a sequence.

We can also use list comprehensions to filter data, by adding the filter condition to the end:

~~~
double_even_ints = [2 * i for i in integers if i % 2 == 0]

print(double_even_ints)
~~~
{: .language-python}

~~~
[0, 4, 8]
~~~
{: .output}

Similarly, we have **set** and **dictionary comprehensions**, which look similar to list comprehensions, but use the **set literal** or **dictionary literal** syntax.

~~~
double_even_int_set = {2 * i for i in integers if i % 2 == 0}

print(double_even_int_set)
~~~
{: .language-python}

~~~
{0, 4, 8}
~~~
{: .output}

~~~
double_even_int_dict = {i: 2 * i for i in integers if i % 2 == 0}

print(double_even_int_dict)
~~~
{: .language-python}

~~~
{0: 0, 2: 4, 4: 8}
~~~
{: .output}

These comprehensions cover the map and filter components of MapReduce, but not the reduce 
(accumulate/aggregate) component.
For that we either need to rely on a built in reduction operator, 
or use the `reduce` function with a custom reduction operator.

In many cases, what we want to do in the reduction component is to sum all 
the values in a collection - for this we have the built in `sum` function:

~~~
l = [1, 2, 3]

print(sum(l))
~~~
{: .language-python}

~~~
6
~~~
{: .output}

Otherwise, we'll probably need to write the reduction operator ourselves - but before we look into this 
we need to cover another topic first.


### Generator Expressions

There's one 'comprehension' left that we've not discussed - **generator expressions**.
In Python, a **generator** is a type of **iterable** which we can take values from and loop over, but doesn't actually compute any of the values until we need them.
Iterable is the generic term for anything we can loop or iterate over - lists, sets and dictionaries are all iterables.

The `range` function is an example of a generator - if we created a `range(1000000000)`, but didn't iterate over it, we'd find that it takes almost no time to do.
Creating a list containing a similar number of values would take much longer, and could be at risk of running out of memory and failing entirely.

We can build our own generators using a generator expression.
These look much like the comprehensions above, but act like a generator when we use them. Note the 
syntax difference for generator expressions - parenthesis are used in place of square or curly brackets.

~~~
squares_generator = (i * i for i in range(10))

for x in squares_generator:
    print(x)
~~~
{: .language-python}

~~~
0
1
4
9
16
25
36
49
64
81
~~~
{: .output}

The key difference between generator expressions and comprehensions is that the generator 
yields one item at a time and generates the item only on demand. On the other hand, for list, set or dictionary comprehensions, Python reserves memory for the whole list, set or dictionary in advance. 
So, generator expressions are more memory efficient than the comprehensions.


> ## Comprehensions Applied
>
> Within the `read_variable_from_csv` function in the `catchment/models.py` file contains
> a list comprehension. Can you identify which line of code this is, and work out what it does?
> > ## Solution
> >
> > The list comprehension is this line of code:
> > ~~~
> > # catchment/models.py
> > import pandas as pd
> > ...
> > dataset['Date'] = [pd.to_datetime(x,dayfirst=True) for x in dataset['OldDate']]
> > ...
> > ~~~
> > {: .language-python}
> > It iterates over the date strings in the `OldDate` column within the dataframe, 
> > converts each string to a `pandas` datetime object, and adds these to the dataframe
> > as the `Date` column.
> > 
> {: .solution}
{: .challenge}


> ## Separating out Time
>
> The `read_variable_from_csv` function is a pure function, it is given a filename, 
> and returns a `pandas` dataframe. However it carries out several operations on the data
> before returning it, and this reduces the testability of the code within this 
> function. To improve the testability of this code it would be helpful to separate out 
> complex transformations in the function to their own, pure, function.
>
> To this end, create a function, called `format_date`, which will read the fresh dataset
> and return a dataset in which the contents of the `Date` column has been converted to 
> `pandas` datetime objects. Then replace the equivalent code in the `read_variable_from_csv`
> function with a call to this new function. 
> 
> ~~~
> # catchment/models.py
>
> import pandas as pd
> ...
> def read_variable_from_csv(filename):
>     """Reads a named variable from a CSV file, and returns a
>     pandas dataframe containing that variable. The CSV file must contain
>     a column of dates, a column of site ID's, and (one or more) columns
>     of data - only one of which will be read.
>     :param filename: Filename of CSV to load
>     :return: 2D array of given variable. Index will be dates,
>              Columns will be the individual sites
>     """
>     with open(filename) as f:
>         dataset = pd.read_csv(f, usecols=['Date', 'Site', 'Rainfall (mm)'])
> 
>     dataset = dataset.rename({'Date':'OldDate'}, axis='columns')
>     dataset['Date'] = [pd.to_datetime(x,dayfirst=True) for x in dataset['OldDate']]
>     dataset = dataset.drop('OldDate', axis='columns')
> 
>     newdataset = pd.DataFrame(index=dataset['Date'].unique())
> 
>     for site in dataset['Site'].unique():
>         newdataset[site] = dataset[dataset['Site'] == site].set_index('Date')["Rainfall (mm)"]
> 
>     newdataset = newdataset.sort_index()
> 
>     return newdataset
> ~~~
> {: .language-python}
> > ## Solution
> > A solution is given below. Note that we have renamed `dataset` to `ds_internal` within
> > the function, which is not strictly necessary, but helps to ensure that the function is pure.
> > ~~~
> > # catchment/models.py
> >
> > import pandas as pd
> > ...
> > def format_date(dataset):
> >     """Converts the Date column in the dataset to pandas datetime objects"""
> >     ds_internal = dataset.rename({'Date':'OldDate'}, axis='columns')
> >     ds_internal['Date'] = [pd.to_datetime(x,dayfirst=True) for x in ds_internal['OldDate']]
> >     ds_internal = ds_internal.drop('OldDate', axis='columns')
> >     return ds_internal
> > 
> > def read_variable_from_csv(filename):
> >     """Reads a named variable from a CSV file, and returns a
> >     pandas dataframe containing that variable. The CSV file must contain
> >     a column of dates, a column of site ID's, and (one or more) columns
> >     of data - only one of which will be read.
> >     :param filename: Filename of CSV to load
> >     :return: 2D array of given variable. Index will be dates,
> >              Columns will be the individual sites
> >     """
> >     with open(filename) as f:
> >         dataset = pd.read_csv(f, usecols=['Date', 'Site', 'Rainfall (mm)'])
> > 
> >     dataset = format_date(dataset)
> > 
> >     newdataset = pd.DataFrame(index=dataset['Date'].unique())
> > 
> >     for site in dataset['Site'].unique():
> >         newdataset[site] = dataset[dataset['Site'] == site].set_index('Date')["Rainfall (mm)"]
> > 
> >     newdataset = newdataset.sort_index()
> > 
> >     return newdataset
> > ~~~
> > {: .language-python}
> > Does this make the function more readable to you? And are there any other operations 
> > within the `read_variable_from_csv` function that you think could be moved to a 
> > separate pure function, to help with readability and/or testing? 
> {: .solution}
{: .challenge}


## Functions as First-Class Objects

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

def apply_fn(fn, in_list):
    return [fn(x) for x in in_list]

result = apply_fn(add_one, [0, 1, 2])
print(result)
~~~
{: .language-python}

~~~
[1, 2, 3]
~~~
{: .output}

In these examples above, we've used a list comprehension to effectively build the `map()` function ourselves.
In Python 2, this is exactly how `map` worked - it returned a list of items. In Python 3, it is a little different as the `map()` and `filter()` functions are now generators - they do not return lists 
but map and filter objects, respectively, which are iterators. These objects can then 
be passed to functions like `list()` (to create a list), `set()` (to create a set), etc. - but cannot be used 
as lists or sets directly (e.g. you cannot pass them directly to, say, `print` function) if this is what you are used to in Python 2.
         
### Lambda Function

For small functions which we only need in a single place, we can use a **lambda function** or **anonymous function** (so called because we don't give them names) instead.
These functions use the `lambda` keyword, take a number of arguments and contain a single expression as their body.
The value of this expression is then the return value of the lambda function.

~~~
def apply_fn(fn, in_list):
    return [fn(x) for x in in_list]

result = apply_fn(lambda x: x + 1, [0, 1, 2])
print(result)
~~~
{: .language-python}

~~~
[1, 2, 3]
~~~
{: .output}

The major distinction between lambda functions and 'normal' functions is that lambdas don't have a name.
We could give a name to a lambda function if we really wanted to - but at that point we should be using a 'normal' Python function instead.

~~~
# Don't do this
add_one = lambda x: x + 1

# Do this instead
def add_one(x):
    return x + 1
~~~
{: .language-python}

These are the fundamental components of the MapReduce programming model, and can be combined to perform much more complex data processing operations.

## Reducing MapReduce

Now we've got all the components we need to use MapReduce with reductions that aren't just `sum`.
Time to make our own reduction operators.

A reduction operator is a function which accepts two values to accumulate (aggregate) the values in the iterable.
One example would be to calculate the product of a sequence.

When we give this function to `reduce`, it first applies the function to the first two values in the iterable.
Then for each remaining value, we take the previous result and the new value as the new arguments to the reduction operator until we've processed all of the data.

~~~
from functools import reduce

l = [1, 2, 3]

def product(a, b):
    return a * b

print(reduce(product, l))

# The same reduction using a lambda function
print(reduce((lambda a, b: a * b), l))
~~~
{: .language-python}

~~~
6
6
~~~
{: .output}

> ## Sum of Squares
>
> Using the MapReduce model, write a function that calculates the sum of the squares of the values in a list.
> Although in practice we'd use the built in `sum` function for part of this - try doing it without using `sum`.
> Your function should behave as below:
>
> ~~~
> def sum_of_squares(l):
>     # Your code here
>
> print(sum_of_squares([0]))
> print(sum_of_squares([1]))
> print(sum_of_squares([1, 2, 3]))
> print(sum_of_squares([-1]))
> print(sum_of_squares([-1, -2, -3]))
> ~~~
> {: .language-python}
>
> ~~~
> 0
> 1
> 14
> 1
> 14
> ~~~
> {: .output}
>
> > ## Solution
> >
> > ~~~
> > from functools import reduce
> >
> > def sum_of_squares(l):
> >     squares = [x * x for x in l]
> >     return reduce(lambda a, b: a + b, squares)
> > ~~~
> > {: .language-python}
> >
> {: .solution}
>
> Now let's assume we're reading in these numbers from an input file, so they arrive as a list of strings.
> Modify your function so that it passes the following tests:
>
> ~~~
> print(sum_of_squares(['1', '2', '3']))
> print(sum_of_squares(['-1', '-2', '-3']))
> ~~~
> {: .language-python}
>
> ~~~
> 14
> 14
> ~~~
> {: .output}
>
> > ## Solution
> >
> > ~~~
> > from functools import reduce
> >
> > def sum_of_squares(l):
> >     integers = [int(x) for x in l]
> >     squares = [x * x for x in integers]
> >     return reduce(lambda a, b: a + b, squares)
> > ~~~
> > {: .language-python}
> >
> {: .solution}
>
> Finally, like comments in Python, we'd like it to be possible for users to comment out numbers in the input file they give to our program.
> Extend your function so that the following tests pass (don't worry about passing the first set of tests with lists of integers):
>
> ~~~
> print(sum_of_squares(['1', '2', '3']))
> print(sum_of_squares(['-1', '-2', '-3']))
> print(sum_of_squares(['1', '2', '#100', '3']))
> ~~~
> {: .language-python}
>
> ~~~
> 14
> 14
> 14
> ~~~
> {: .output}
>
> > ## Solution
> >
> > ~~~
> > from functools import reduce
> >
> > def sum_of_squares(l):
> >     integers = [int(x) for x in l if x[0] != '#']
> >     squares = [x * x for x in integers]
> >     return reduce(lambda a, b: a + b, squares)
> > ~~~
> > {: .language-python}
> {: .solution}
>
> If you've got this far and have time left, try converting these solutions to use generator expressions.
> Which do you prefer?
> Are there situations when one would be much better than the other?
>
> > ## Solution
> >
> > ~~~
> > from functools import reduce
> >
> > def sum_of_squares(l):
> >     integers_generator = (int(x) for x in l if x[0] != '#')
> >     squares_generator = (x * x for x in integers_generator)
> >     return reduce(lambda a, b: a + b, squares_generator)
> > ~~~
> > {: .language-python}
> Generators would be better for bigger lists as they would not allocate the memory for the
> whole list at once and in advance.
> {: .solution}
{: .challenge}

## Decorators

In the [episode on parametrising our unit tests](../22-scaling-up-unit-testing/index.html#parameterising-our-unit-tests), we have used a **decorator** to modify the behaviour of a function.
Here, we'll discuss decorators in more detail and learn how to write our own.

The important feature of a decorator is that it can take a function, modify it, then return the resulting function.
When using Functional Programming, we can use the idea that functions are first-class objects to implement a decorator.

~~~ python
def with_logging(func):
    """A decorator which adds logging to a function."""
    def inner(*args, **kwargs):
        print("Before function call")
        result = func(*args, **kwargs)
        print("After function call")

        return result

    return inner


def add_one(n):
    print("Adding one")
    return n + 1


add_one = with_logging(add_one)    


@with_logging
def add_two(n):
    print("Adding two")
    return n + 2

print(add_one(1))
print(add_two(1))
~~~
{: .language-python}

~~~
Before function call
Adding one
After function call
2
Before function call
Adding two
After function call
3
~~~
{: .output}

In this example, we see a decorator (`with_logging`) and two different syntaxes for applying the decorator to a function.
The decorator is implemented here as a function which encloses another function.
Because the inner function (`inner`) calls the function being decorated (`func`) and returns its result, it still behaves like this original function.
Part of this is the use of `*args` and `**kwargs` - these allow our decorated function to accept any arguments or keyword arguments and pass them directly to the function being decorated.
Our decorator in this case doesn't need to modify any of the arguments, so we don't need to know what they are.
Any additional behaviour we want to add as part of our decorated function, we can put before or after the call to the original function.
Here we print some text both before and after the decorated function, to show the order in which events happen.

We also see in this example the two different ways in which a decorator can be applied.
The first of these is to use a normal function call (`with_logging(add_one)`), where we then assign the resulting function back to a variable - often using the original name of the function, so replacing it with the decorated version.
The second syntax, is the one we have seen previously (`@with_logging`).
This syntax is equivalent to the previous one - the result is that we have a decorated version of the function, here with the name `add_two`.
Both of these syntaxes can be useful in different situations: the `@` syntax is more concise if we never need to use the un-decorated version, while the function-call syntax gives us more flexibility - we can continue to use the un-decorated function if we make sure to give the decorated one a different name, and can even make multiple decorated versions using different decorators.

> ## Decorators: Measuring Performance
> 
> One small task you might find a useful case for a decorator is in measuring the time taken to execute a particular function.
> This is an important part of performance profiling.
> 
> Write a decorator which you can use to measure the execution time of the decorated function using the [`time.process_time_ns()` [docs]](https://docs.python.org/3/library/time.html#time.process_time_ns) function.
> There are several different timing functions each with slightly different use-cases, but we won't worry about that here.
> 
> For the function to measure, you may wish to use this as an example:
> 
> ~~~ python
> def measure_me(n):
>     total = 0
>     for i in range(n):
>         total += i * i
> 
>     return total
> ~~~
> {: .language-python}
> 
> > ## Solution
> > 
> > ~~~ python
> > import time
> > 
> > def profile(func):
> >     def inner(*args, **kwargs):
> >         start = time.process_time_ns()
> >         result = func(*args, **kwargs)
> >         stop = time.process_time_ns()
> > 
> >         print("Took {0} seconds".format((stop - start) / 1e9))
> >         return result
> >     
> >     return inner
> >         
> > 
> > @profile
> > def measure_me(n):
> >     total = 0
> >     for i in range(n):
> >         total += i * i
> > 
> >     return total
> > 
> > print(measure_me(1000000))
> > ~~~
> > {: .language-python}
> > 
> > ~~~
> > Took 0.124199753 seconds
> > 333332833333500000
> > ~~~
> > {: .output}
> {: .solution}
> 
{: .challenge}

> ## Optional Advanced Exercise: Multiprocessing 
>
> **Advanced optional exercise to come back to if you finish this section early.**
>
> One of the benefits of functional programming is that, if we have pure functions, when applying / mapping a function to many values in a collection, each application is completely independent of the others.
> This means that we can take advantage of multiprocessing, without many of the normal problems in synchronisation that this brings.
>
> Read through the Python documentation for the [multiprocessing module](https://docs.python.org/3/library/multiprocessing.html), particularly the `Pool.map` method.
> This function is similar to the `map()` function we mentioned in MapReduce model, but distributes the operations across a number of processes.
>
> Update one of our examples to make use of multiprocessing.
> How much of a performance improvement do you get?
> Is this as much as you would expect for the number of cores your CPU has?
>
> **Hint:** To time the execution of a Python script we can use the shell command `time`, or make careful use of the timing decorator we wrote for the exercise above:
> ~~~
> time python3 my_script.py
> ~~~
> {: .language-bash}
>
> **Hint:** There is a computational cost associated with creating the process pool and sharing the work - if the computational task being performed is too small, you will may not see a performance improvement.
>
> **Warning:** Multiprocessing can easily have unexpected results when any non-pure functions are used.
> One common example is that when trying to generate random numbers using some random number generators, we may see the same sequence of numbers generated in each process.
>
> Would we get the same benefits from parallel equivalents of the `filter()` and `reduce()` functions?
> Why, or why not?
>
> {: .language-bash}
{: .challenge}

{% include links.md %}
