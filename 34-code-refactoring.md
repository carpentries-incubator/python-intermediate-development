---
title: 3.4 Code Refactoring
teaching: 30
exercises: 20
---

::::::::::::::::::::::::::::::::::::::: objectives

- Employ code refactoring to improve the structure of existing code.
- Understand the use of regressions tests to avoid breaking existing code when refactoring.
- Understand the use of pure functions in software design to make the code easier to read, test amd maintain.
- Refactor a piece of code to separate out 'pure' from 'impure' code.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How do you refactor existing code without breaking it?
- What are benefits of using pure functions in code?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

Code refactoring is the process of improving the design of an existing codebase - changing the
internal structure of code without changing its external behavior, with the goal of making the code
more readable, maintainable, efficient or easier to test. This can include introducing things such
as code decoupling and abstractions, but also renaming variables, reorganising functions to avoid
code duplication and increase reuse, and simplifying conditional statements.

In the previous episode, we have already changed the structure of our code (i.e. refactored it
to a certain extent)
when we separated out data loading from data analysis but we have not tested that the new code
works as intended. This is particularly important with bigger code changes but even a small change
can easily break the codebase and introduce bugs.

When faced with an existing piece of code that needs modifying a good refactoring
process to follow is:

1. Make sure you have tests that verify the current behaviour
2. Refactor the code
3. Verify that that the behaviour of the code is identical to that before refactoring.

In this episode we will further improve the code from our project in the following two ways:

- add more tests so we can be more confident that future changes will have the
  intended effect and will not break the existing code.
- further split `analyse_data()` function into a number of smaller and more
  decoupled functions (continuing the work from the previous episode).

## Writing Tests Before Refactoring

When refactoring, first we need to make sure there are tests in place that can verify
the code behaviour as it is now (or write them if they are missing),
then refactor the code and, finally, check that the original tests still pass.

There is a bit of a "chicken and egg" problem here - if the refactoring is supposed to make it easier
to write tests in the future, how can we write tests before doing the refactoring?
The tricks to get around this trap are:

- test at a higher level, with coarser accuracy, and
- write tests that you intend to replace or remove.

The best tests are the ones that test a single bit of functionality rigorously.
However, with our current `analyse_data()` code that is not possible because it is a
large function doing a little bit of everything.
Instead we will make minimal changes to the code to make it a bit more testable.

Firstly,
we will modify the function to return the data instead of visualising it because graphs are harder
to test automatically (i.e. they need to be viewed and inspected manually in order to determine
their correctness).
Next, we will make the assert statements verify what the current outcome is, rather than check
whether that is correct or not.
Such tests are meant to
verify that the behaviour does not *change* rather than checking the current behaviour is correct
(there should be another set of tests checking the correctness).
This kind of testing is called **regression testing** as we are testing for
regressions in existing behaviour.

Refactoring code is not meant to change its behaviour, but sometimes to make it possible to verify
you are not changing the important behaviour you have to make small tweaks to the code to write
the tests at all.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Write Regression Tests

Modify the `analyse_data()` function not to plot a graph and return the data instead.
Then, add a new test file called `test_compute_data.py` in the `tests` folder and
add a regression test to verify the current output of `analyse_data()`. We will use this test
in the remainder of this section to verify the output `analyse_data()` is unchanged each time
we refactor or change code in the future.

Start from the skeleton test code below:

```python
def test_analyse_data():
    from inflammation.compute_data import analyse_data
    path = Path.cwd() / "../data"
    data_source = CSVDataSource(path)
    result = analyse_data(data_source)

    # TODO: add assert statement(s) to test the result value is as expected
```

Use `assert_array_almost_equal` from the `numpy.testing` library to
compare arrays of floating point numbers.

:::::::::::::::  solution

## Hint

When determining the correct return data result to use in tests, it may be helpful to assert the
result equals some random made-up data, observe the test fail initially and then
copy and paste the correct result into the test.


:::::::::::::::::::::::::

:::::::::::::::  solution

## Solution

One approach we can take is to:

- comment out the visualise method on `analyse_data()`
  (this will cause our test to hang waiting for the result data)
- return the data (instead of plotting it on a graph), so we can write assert statements
  on the data
- see what the calculated result value is, and assert that it is the same as the expected value

Putting this together, our test may look like:

```python
import numpy.testing as npt
from pathlib import Path

def test_analyse_data():
    from inflammation.compute_data import analyse_data
    path = Path.cwd() / "../data"
    data_source = CSVDataSource(path)
    result = analyse_data(data_source)
    expected_output = [0.,0.22510286,0.18157299,0.1264423,0.9495481,0.27118211,
                       0.25104719,0.22330897,0.89680503,0.21573875,1.24235548,0.63042094,
                       1.57511696,2.18850242,0.3729574,0.69395538,2.52365162,0.3179312,
                       1.22850657,1.63149639,2.45861227,1.55556052,2.8214853,0.92117578,
                       0.76176979,2.18346188,0.55368435,1.78441632,0.26549221,1.43938417,
                       0.78959769,0.64913879,1.16078544,0.42417995,0.36019114,0.80801707,
                       0.50323031,0.47574665,0.45197398,0.22070227]
    npt.assert_array_almost_equal(result, expected_output)
```

Note that while the above test will detect if we accidentally break the analysis code and
change the output of the analysis, it is still not a complete test for the following reasons:

- It is not obvious why the `expected_output` is correct
- It does not test edge cases
- If the data files in the directory change - the test will fail

We would need to add additional tests to check the above.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Separating Pure and Impure Code

Now that we have our regression test for `analyse_data()` in place, we are ready to refactor the
function further.
We would like to separate out as much of its code as possible as *pure functions*.

### Pure Functions

A pure function in programming works like a mathematical function -
it takes in some input and produces an output and that output is
always the same for the same input.
That is, the output of a pure function does not depend on any information
which is not present in the input (such as global variables).
Furthermore, pure functions do not cause any *side effects* - they do not modify the input data
or data that exist outside the function (such as printing text, writing to a file or
changing a global variable). They perform actions that affect nothing but the value they return.

### Benefits of Pure Functions

Pure functions are easier to understand because they eliminate side effects.
The reader only needs to concern themselves with the input
parameters of the function and the function code itself, rather than
the overall context the function is operating in.
Similarly, a function that calls a pure function is also easier
to understand - we only need to understand what the function returns, which will probably
be clear from the context in which the function is called.
Finally, pure functions are easier to reuse as the caller
only needs to understand what parameters to provide, rather
than anything else that might need to be configured prior to the call.
For these reasons, you should try and have as much of the complex, analytical and mathematical
code are pure functions.

Some parts of a program are inevitably impure.
Programs need to read input from users, generate a graph, or write results to a file or a database.
Well designed programs separate complex logic from the necessary impure "glue" code that
interacts with users and other systems.
This way, you have easy-to-read and easy-to-test pure code that contains the complex logic
and simplified impure code that reads data from a file or gathers user input. Impure code may
be harder to test but, when simplified like this, may only require a handful of tests anyway.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Refactoring To Use a Pure Function

Refactor the `analyse_data()` function to delegate the data analysis to a new
pure function `compute_standard_deviation_by_day()` and separate it
from the impure code that handles the input and output.
The pure function should take in the data, and return the analysis result, as follows:

```python
def compute_standard_deviation_by_day(data):
    # TODO
    return daily_standard_deviation
```

:::::::::::::::  solution

## Solution

The analysis code will be refactored into a separate function that may look something like:

```python
def compute_standard_deviation_by_day(data):
    means_by_day = map(models.daily_mean, data)
    means_by_day_matrix = np.stack(list(means_by_day))

    daily_standard_deviation = np.std(means_by_day_matrix, axis=0)
    return daily_standard_deviation
```

The `analyse_data()` function now calls the `compute_standard_deviation_by_day()` function,
while keeping all the logic for reading the data, processing it and showing it in a graph:

```python
def analyse_data(data_dir):
    """Calculates the standard deviation by day between datasets.
    Gets all the inflammation data from CSV files within a directory, works out the mean
    inflammation value for each day across all datasets, then visualises the
    standard deviation of these means on a graph."""
    data_file_paths = glob.glob(os.path.join(data_dir, 'inflammation*.csv'))
    if len(data_file_paths) == 0:
        raise ValueError(f"No inflammation csv's found in path {data_dir}")
    data = map(models.load_csv, data_file_paths)
    daily_standard_deviation = compute_standard_deviation_by_day(data)

    graph_data = {
        'standard deviation by day': daily_standard_deviation,
    }
    # views.visualize(graph_data)
    return daily_standard_deviation
```

Make sure to re-run the regression test to check this refactoring has not
changed the output of `analyse_data()`.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

### Testing Pure Functions

Now we have our analysis implemented as a pure function, we can write tests that cover
all the things we would like to check without depending on CSVs files.
This is another advantage of pure functions - they are very well suited to automated testing,
i.e. their tests are:

- **easier to write** - we construct input and assert the output
  without having to think about making sure the global state is correct before or after
- **easier to read** - the reader will not have to open a CSV file to understand why
  the test is correct
- **easier to maintain** - if at some point the data format changes
  from CSV to JSON, the bulk of the tests need not be updated

::: challenge
## Exercise: Testing a Pure Function

Add tests for `compute_standard_deviation_by_data()` that check for situations
when there is only one file with multiple rows,
multiple files with one row, and any other cases you can think of that should be tested.

:::: solution

You might have thought of more tests, but we can easily extend the test by parametrizing
with more inputs and expected outputs:

```python
@pytest.mark.parametrize('data,expected_output', [
    ([[[0, 1, 0], [0, 2, 0]]], [0, 0, 0]),
    ([[[0, 2, 0]], [[0, 1, 0]]], [0, math.sqrt(0.25), 0]),
    ([[[0, 1, 0], [0, 2, 0]], [[0, 1, 0], [0, 2, 0]]], [0, 0, 0])
],
ids=['Two patients in same file', 'Two patients in different files', 'Two identical patients in two different files'])
def test_compute_standard_deviation_by_day(data, expected_output):
    from inflammation.compute_data import compute_standard_deviation_by_data

    result = compute_standard_deviation_by_data(data)
    npt.assert_array_almost_equal(result, expected_output)
```

::::
:::

::: callout

## Functional Programming

**Functional programming** is a programming paradigm where programs are constructed by
applying and composing/chaining pure functions.
Some programming languages, such as Haskell or Lisp, support writing pure functional code only.
Other languages, such as Python, Java, C++, allow mixing **functional** and **procedural**
programming paradigms.
Read more in the [extra episode on functional programming](../learners/functional-programming.md)
and when it can be very useful to switch to this paradigm
(e.g. to employ MapReduce approach for data processing).

:::

There are no definite rules in software design but making your complex logic out of
composed pure functions is a great place to start when trying to make your code readable,
testable and maintainable. This is particularly useful for:

* Data processing and analysis 
(for example, using [Python Pandas library](https://pandas.pydata.org/) for data manipulation where most of functions appear pure)
* Doing simulations (? needs more explanation)
* Translating data from one format to another (? an example would be good)

## Programming Paradigms

Until this section, we have mainly been writing procedural code. 
In the previous episode, we have touched a bit upon classes, encapsulation and polymorphism, 
which are characteristics of (but not limited to) the object-oriented programming (OOP).
In this episode, we mentioned [pure functions](./index.html#pure-functions) 
and Functional Programming.

These are examples of different [programming paradigms](../learners/programming-paradigms.md) 
and provide varied approaches to structuring your code - 
each with certain strengths and weaknesses when used to solve particular types of problems. 
In many cases, particularly with modern languages, a single language can allow many different 
structural approaches and mixing programming paradigms within your code.
Once your software begins to get more complex - it is common to use aspects of [different paradigm](../learners/programming-paradigms.md) 
to handle different subtasks. 
Because of this, it is useful to know about the [major paradigms](../learners/programming-paradigms.md), 
so you can recognise where it might be useful to switch. 
This is outside of scope of this course - we have some extra episodes on the topics of 
[procedural programming](../learners/procedural-programming.md), 
[functional programming](../learners/functional-programming.md) and 
[object-oriented programming](../learners/object-oriented-programming.md) if you want to know more.

::: callout

## So Which One is Python?

Python is a multi-paradigm and multi-purpose programming language.
You can use it as a procedural language and you can use it in a more object oriented way.
It does tend to land more on the object oriented side as all its core data types
(strings, integers, floats, booleans, lists,
sets, arrays, tuples, dictionaries, files)
as well as functions, modules and classes are objects.

Since functions in Python are also objects that can be passed around like any other object,
Python is also well suited to functional programming.
One of the most popular Python libraries for data manipulation,
[Pandas](https://pandas.pydata.org/) (built on top of NumPy),
supports a functional programming style
as most of its functions on data are not changing the data (no side effects)
but producing a new data to reflect the result of the function.
:::

## Software Design and Architecture

In this section so far we have been talking about **software design** - the individual modules and
components of the software. We are now going to have a brief look into **software architecture** -
which is about the overall structure that these software components fit into, a *design pattern*
with a common successful use of software components.

:::::::::::::::::::::::::::::::::::::::: keypoints

- Code refactoring is a technique for improving the structure of existing code.
- Implementing regression tests before refactoring gives you confidence that your changes have not broken the code.
- Using pure functions that process data without side effects whenever possible makes the code easier to understand, test and maintain.

::::::::::::::::::::::::::::::::::::::::::::::::::
