---
title: "Refactoring Functions to Do Just One Thing"
teaching: 30
exercises: 20
questions:
- "How do you refactor code without breaking it?"
- "How do you write code that is easy to test?"
- "What is functional programming?"
- "Which situations/problems is functional programming well suited for?"
objectives:
- "Understand how to refactor functions to be easier to test"
- "Be able to write regressions tests to avoid breaking existing code"
- "Understand what a pure function is."
keypoints:
- "By refactoring code into pure functions that act on data makes code easier to test."
- "Making tests before you refactor gives you confidence that your refactoring hasn't broken anything"
- "Functional programming is a programming paradigm where programs are constructed by applying and composing smaller and simple functions into more complex ones (which describe the flow of data within a program as a sequence of data transformations)."
---

## Introduction

In this episode we will take some code and refactor it in a way which is going to make it
easier to test.
By having more tests, we can more confident of future changes having their intended effect.
The change we will make will also end up making the code easier to understand.

## Writing tests before refactoring

The process we are going to be following is:

1. Write some tests that test the behaviour as it is now
2. Refactor the code to be more testable
3. Ensure that the original tests still pass

By writing the tests *before* we refactor, we can be confident we haven't broken
existing behaviour through the refactoring.

There is a bit of a chicken-and-the-egg problem here however.
If the refactoring is to make it easier to write tests, how can we write tests
before doing the refactoring?

The tricks to get around this trap are:

 * Test at a higher level, with coarser accuracy
 * Write tests that you intend to remove

The best tests are ones that test single bits of code rigorously.
However, with this code it isn't possible to do that.

Instead we will make minimal changes to the code to make it a bit testable,
for example returning the data instead of visualising it.

We will make the asserts verify whatever the outcome is currently,
rather than worrying whether that is correct.
These tests are to verify the behaviour doesn't *change* rather than to check the current behaviour is correct.
This kind of testing is called **regression testing** as we are testing for
regressions in existing behaviour.

As with everything in this episode, there isn't a hard and fast rule.
Refactoring doesn't change behaviour, but sometimes to make it possible to verify
you're not changing the important behaviour you have to make some small tweaks to write
the tests at all.

> ## Exercise: Write regression tests before refactoring
> Add a new test file called `test_compute_data.py` in the tests folder.
> Add and complete this regression test to verify the current output of `analyse_data`
> is unchanged by the refactorings we are going to do:
> ```python
> def test_analyse_data():
>     from inflammation.compute_data import analyse_data
>     path = Path.cwd() / "../data"
>     result = analyse_data(path)
>
>     # TODO: add an assert for the value of result
> ```
> Use `assert_array_almost_equal` from the `numpy.testing` library to
> compare arrays of floating point numbers.
>
> You will need to modify `analyse_data` to not create a graph and instead
> return the data.
>
>> ## Hint
>> You might find it helpful to assert the results equal some made up array, observe the test failing
>> and copy and paste the correct result into the test.
> {: .solution}
>
>> ## Solution
>> One approach we can take is to:
>>  * comment out the visualize (as this will cause our test to hang)
>>  * return the data instead, so we can write asserts on the data
>>  * See what the calculated value is, and assert that it is the same
>> Putting this together, you can write a test that looks something like:
>>
>> ```python
>> import numpy.testing as npt
>> from pathlib import Path
>>
>> def test_analyse_data():
>>     from inflammation.compute_data import analyse_data
>>     path = Path.cwd() / "../data"
>>     result = analyse_data(path)
>>     expected_output = [0.,0.22510286,0.18157299,0.1264423,0.9495481,0.27118211,
>>                        0.25104719,0.22330897,0.89680503,0.21573875,1.24235548,0.63042094,
>>                        1.57511696,2.18850242,0.3729574,0.69395538,2.52365162,0.3179312,
>>                        1.22850657,1.63149639,2.45861227,1.55556052,2.8214853,0.92117578,
>>                        0.76176979,2.18346188,0.55368435,1.78441632,0.26549221,1.43938417,
>>                        0.78959769,0.64913879,1.16078544,0.42417995,0.36019114,0.80801707,
>>                        0.50323031,0.47574665,0.45197398,0.22070227]
>>     npt.assert_array_almost_equal(result, expected_output)
>> ```
>>
>> Note - this isn't a good test:
>> * It isn't at all obvious why these numbers are correct.
>> * It doesn't test edge cases.
>> * If the files change, the test will start failing.
>>
>> However, it allows us to guarantee we don't accidentally change the analysis output.
> {: .solution}
{: .challenge}

## Pure functions

A **pure function** is a function that works like a mathematical function.
That is, it takes in some inputs as parameters, and it produces an output.
That output should always be the same for the same input.
That is, it does not depend on any information not present in the inputs (such as global variables, databases, the time of day etc.)
Further, it should not cause any **side effects**, such as writing to a file or changing a global variable.

You should try and have as much of the complex, analytical and mathematical code in pure functions.

By eliminating dependency on external things such as global state, we
reduce the cognitive load to understand the function.
The reader only needs to concern themselves with the input
parameters of the function and the code itself, rather than
the overall context the function is operating in.

Similarly, a function that *calls* a pure function is also easier
to understand.
Since the function won't have any side effects, the reader needs to
only understand what the function returns, which will probably
be clear from the context in which the function is called.

This property also makes them easier to re-use as the caller
only needs to understand what parameters to provide, rather
than anything else that might need to be configured
or side effects for calling it at a time that is different
to when the original author intended.

Some parts of a program are inevitably impure.
Programs need to read input from the user, or write to a database.
Well designed programs separate complex logic from the necessary impure "glue" code that interacts with users and systems.
This way, you have easy-to-test, easy-to-read code that contains the complex logic.
And you have really simple code that just reads data from a file, or gathers user input etc,
that is maybe harder to test, but is so simple that it only needs a handful of tests anyway.

> ## Exercise: Refactor the function into a pure function
> Refactor the `analyse_data` function into a pure function with the logic, and an impure function that handles the input and output.
> The pure function should take in the data, and return the analysis results:
> ```python
> def compute_standard_deviation_by_day(data):
>   # TODO
>   return daily_standard_deviation
> ```
> The "glue" function should maintain the behaviour of the original `analyse_data`
> but delegate all the calculations to the new pure function.
>> ## Solution
>> You can move all of the code that does the analysis into a separate function that
>> might look something like this:
>> ```python
>> def compute_standard_deviation_by_day(data):
>>     means_by_day = map(models.daily_mean, data)
>>     means_by_day_matrix = np.stack(list(means_by_day))
>>
>>     daily_standard_deviation = np.std(means_by_day_matrix, axis=0)
>>     return daily_standard_deviation
>> ```
>> Then the glue function can use this function, whilst keeping all the logic
>> for reading the file and processing the data for showing in a graph:
>>```python
>>def analyse_data(data_dir):
>>    """Calculate the standard deviation by day between datasets
>>    Gets all the inflammation csvs within a directory, works out the mean
>>    inflammation value for each day across all datasets, then graphs the
>>    standard deviation of these means."""
>>    data_file_paths = glob.glob(os.path.join(data_dir, 'inflammation*.csv'))
>>    if len(data_file_paths) == 0:
>>        raise ValueError(f"No inflammation csv's found in path {data_dir}")
>>    data = map(models.load_csv, data_file_paths)
>>    daily_standard_deviation = compute_standard_deviation_by_day(data)
>>
>>    graph_data = {
>>        'standard deviation by day': daily_standard_deviation,
>>    }
>>    # views.visualize(graph_data)
>>    return daily_standard_deviation
>>```
>> Ensure you re-run our regression test to check this refactoring has not
>> changed the output of `analyse_data`.
> {: .solution}
{: .challenge}

### Testing Pure Functions

Now we have a pure function for the analysis, we can write tests that cover
all the things we would like tests to cover without depending on the data
existing in CSVs.

This is another advantage of pure functions - they are very well suited to automated testing.

They are **easier to write** -
we construct input and assert the output
without having to think about making sure the global state is correct before or after.

Perhaps more important, they are **easier to read** -
the reader will not have to open up a CSV file to understand why the test is correct.

It will also make the tests **easier to maintain**.
If at some point the data format is changed from CSV to JSON, the bulk of the tests
won't need to be updated.

> ## Exercise: Write some tests for the pure function
> Now we have refactored our a pure function, we can more easily write comprehensive tests.
> Add tests that check for when there is only one file with multiple rows, multiple files with one row
> and any other cases you can think of that should be tested.
>> ## Solution
>> You might have thought of more tests, but we can easily extend the test by parametrizing
>> with more inputs and expected outputs:
>> ```python
>>@pytest.mark.parametrize('data,expected_output', [
>>    ([[[0, 1, 0], [0, 2, 0]]], [0, 0, 0]),
>>    ([[[0, 2, 0]], [[0, 1, 0]]], [0, math.sqrt(0.25), 0]),
>>    ([[[0, 1, 0], [0, 2, 0]], [[0, 1, 0], [0, 2, 0]]], [0, 0, 0])
>>],
>>ids=['Two patients in same file', 'Two patients in different files', 'Two identical patients in two different files'])
>>def test_compute_standard_deviation_by_day(data, expected_output):
>>    from inflammation.compute_data import compute_standard_deviation_by_data
>>
>>    result = compute_standard_deviation_by_data(data)
>>    npt.assert_array_almost_equal(result, expected_output)
```
> {: .solution}
{: .challenge}

## Functional Programming

**Pure Functions** are a concept that is part of the idea of **Functional Programming**.
Functional programming is a style of programming that encourages using pure functions,
chained together.
Some programming languages, such as Haskell or Lisp just support writing functional code,
but it is more common for languages to allow using functional and **imperative** (the style
of code you have probably been writing thus far where you instruct the computer directly what to do).
Python, Java, C++ and many other languages allow for mixing these two styles.

In Python, you can use the built-in functions `map`, `filter` and `reduce` to chain
pure functions together into pipelines.

In the original code, we used `map` to "map" the file paths into the loaded data.
Extending this idea, you could then "map" the results of that through another process.

You can read more about using these language features [here](https://www.learnpython.org/en/Map%2C_Filter%2C_Reduce).
Other programming languages will have similar features, and searching "functional style" + your programming language of choice
will help you find the features available.

There are no hard and fast rules in software design but making your complex logic out of composed pure functions is a great place to start
when trying to make code readable, testable and maintainable.
This tends to be possible when:

* Doing any kind of data analysis
* Simulations
* Translating data from one format to another

{% include links.md %}
