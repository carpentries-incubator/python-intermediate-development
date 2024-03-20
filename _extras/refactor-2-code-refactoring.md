---
title: "Refactor 2: Code Refactoring"
teaching: 30
exercises: 20
questions:
- "How do you refactor code without breaking it?"
- "What is decoupled code?"
- "What are benefits of using pure functions in our code?"
objectives:
- "Understand the benefits of code decoupling."
- "Understand the use of regressions tests to avoid breaking existing code when refactoring."
- "Understand the use of pure functions in software design to make the code easier to test."
- "Refactor a piece of code to separate out 'pure' from 'impure' code."
keypoints:
- "Implementing regression tests before refactoring gives you confidence that your changes have not 
broken the code."
- "Decoupling code into pure functions that process data without side effects makes code easier 
to read, test and maintain."
---

## Introduction

*Code refactoring* is the process of improving the design of an existing code - for example 
to make it more decoupled. 
Recall that *code decoupling* means breaking the system into smaller components and reducing the 
interdependence between these components, so that they can be tested and maintained independently.
Two components of code can be considered **decoupled** if a change in one does not
necessitate a change in the other.
While two connected units cannot always be totally decoupled, **loose coupling**
is something we should aim for. Benefits of decoupled code include:

* easier to read as you do not need to understand the
  details of the other component.
* easier to test, as one of the components can be replaced
  by a test or a mock version of it.
* code tends to be easier to maintain, as changes can be isolated
  from other parts of the code.

When faced with an existing piece of code that needs modifying a good refactoring
process to follow is:

1. Make sure you have tests that verify the current behaviour
2. Refactor the code
3. Verify that that the behaviour of the code is identical to that before refactoring.

In this episode we will refactor the function `analyse_data()` in `compute_data.py` 
from our project in the following two ways:
* add more tests so we can be more confident that future changes will have the 
intended effect and will not break the existing code. 
* split the monolithic `analyse_data()` function into a number of smaller and more decoupled functions 
making the code easier to understand and test.

## Writing Tests Before Refactoring

When refactoring, first we need to make sure there are tests that verity 
the code behaviour as it is now (or write them if they are missing), 
then refactor the code and, finally, check that the original tests still pass. 
This is to make sure we do not break the existing behaviour through refactoring.

There is a bit of a "chicken and egg" problem here - if the refactoring is supposed to make it easier 
to write tests in the future, how can we write tests before doing the refactoring? 
The tricks to get around this trap are:

 * Test at a higher level, with coarser accuracy
 * Write tests that you intend to remove

The best tests are ones that test single bits of functionality rigorously.
However, with our current `analyse_data()` code that is not possible because it is a 
large function doing a little bit of everything. 
Instead we will make minimal changes to the code to make it a bit more testable. 

Firstly, 
we will modify the function to return the data instead of visualising it because graphs are harder 
to test automatically (i.e. they need to be viewed and inspected manually in order to determine 
their correctness). 
Next, we will make the assert statements verify what the outcome is 
currently, rather than checking whether that is correct or not. 
Such tests are meant to 
verify that the behaviour does not *change* rather than checking the current behaviour is correct
(there should be another set of tests checking the correctness). 
This kind of testing is called **regression testing** as we are testing for
regressions in existing behaviour.

Refactoring code is not meant to change its behaviour, but sometimes to make it possible to verify
you not changing the important behaviour you have to make small tweaks to the code to write
the tests at all.

> ## First Refactor Step - Preparing for Programmatic Work.
> Before we can progress with refactoring in a programmatic way,
> we need to ensure that the `analyse_data()` function is only analysing the data,
> not plotting it as well ('separating concerns' within our code).
> This first refactoring step will be tested manually:
> you will simply ensure the same graphs are produced both before and after this refactoring step.
>
> First remove the following lines of code from the `analyse_data()` function:
> ```python
>    graph_data = {
>        'daily standard deviation': daily_standard_deviation
>    }
>
>    views.visualize(graph_data)
> ```
> and add this `return` statement at the end of the `analyse_data()` function:
> ```python
>    return daily_standard_deviation
> ```
>
> Then replace this line in the `catchment-analysis.py` file:
> ```python
>        compute_data.analyse_data(os.path.dirname(InFiles[0]))
> ```
> with these lines of code:
> ```python
>        daily_standard_deviation = compute_data.analyse_data(os.path.dirname(InFiles[0]))
>        graph_data = {
>            'daily standard deviation': daily_standard_deviation
>        }
>
>        views.visualize(graph_data)
> ```
>
> Run the program to ensure that you get the same graph plotted as before. 
> Once you have confirmed that your code is functioning as before 
> you are ready to carry on the rest of the refactoring process. 
{: .callout}

> ## Exercise: Write Regression Tests
> Add a new test file called `test_compute_data.py` in the `tests` folder and 
> add a regression test to verify the current output of `analyse_data()`. We will use this test
> in the remainder of this section to verify the output `analyse_data()` is unchanged each time
> we refactor or change code in the future. 
> 
> Start from the skeleton test code below: 
> 
> ```python
> def test_analyse_data():
>     from catchment.compute_data import analyse_data
>     path = Path.cwd() / "data"
>     result = analyse_data(path)
>
>     # TODO: add an assert for the value of result
> ```
> Use `assert_array_almost_equal` from the `numpy.testing` library to
> compare arrays of floating point numbers.
>
> Remember to run the test using `python -m pytest` from the project base directory:
> ```bash
> python -m pytest tests/test_compute_data.py
> ```
>
>> ## Hint
>> When determining the correct return data result to use in tests, it may be helpful to assert the 
>> result equals some random made-up data, observe the test fail initially and then 
>> copy and paste the correct result into the test.
>>
>> Remember also that NaN values can be defined using the numpy library (`numpy.nan`).
> {: .solution}
>
>> ## Solution
>> One approach we can take is to:
>>  * comment out the visualize method on `analyse_data()` 
>> (as this will cause our test to hang waiting for the result data)
>>  * return the data instead, so we can write asserts on the data
>>  * See what the calculated value is, and assert that it is the same as the expected value
>> 
>> Putting this together, your test may look like:
>>
>> ```python
>> import numpy as np
>> import numpy.testing as npt
>> from pathlib import Path
>>
>> def test_analyse_data():
>>     from catchment.compute_data import analyse_data
>>     path = Path.cwd() / "data"
>>     result = analyse_data(path)
>>    expected_output = [ [0.        , 0.18801829],
>>                        [0.10978448, 0.43107373],
>>                        [0.06066156, 0.0699624 ],
>>                        [0.        , 0.02041241],
>>                        [0.        , 0.        ],
>>                        [0.        , 0.02871518],
>>                        [0.        , 0.17227833],
>>                        [0.        , 0.04866643],
>>                        [0.        , 0.02041241],
>>                        [0.88952727, 0.        ],
>>                        [0.        , 0.02041241],
>>                        [0.        , 0.        ],
>>                        [0.02041241, 0.        ],
>>                        [0.        , 0.        ],
>>                        [0.        , 0.        ],
>>                        [0.        , 0.        ],
>>                        [0.        , 0.        ],
>>                        [0.0349812 , 0.02041241],
>>                        [0.02871518, 0.02041241],
>>                        [0.02041241, 0.        ],
>>                        [0.02041241, 0.        ],
>>                        [0.        , 0.02041241],
>>                        [0.        , 0.        ],
>>                        [0.        ,     np.nan],
>>                        [0.02041241, 0.        ],
>>                        [0.        , 0.02041241],
>>                        [0.        , 0.02041241],
>>                        [0.02041241, 0.        ],
>>                        [0.13449059, 0.        ],
>>                        [0.18285024, 0.19707288],
>>                        [0.19176008, 0.13915472]]
>>     npt.assert_array_almost_equal(result, expected_output)
>> ```
>>
>> Note that while the above test will detect if we accidentally break the analysis code and 
>> change the output of the analysis, is not a good or complete test for the following reasons:
>> * It is not at all obvious why the `expected_output` is correct
>> * It does not test edge cases
>> * If the data files in the directory change - the test will fail
>> 
>> We would need additional tests to check the above.
> {: .solution}
{: .challenge}

## Separating Pure and Impure Code

Now that we have our regression test for `analyse_data()` in place, we are ready to refactor the 
function further. 
We would like to separate out as much of its code as possible as *pure functions*. 
Pure functions are very useful and much easier to test as they take input only from its input 
parameters and output only via their return values.

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
code as pure functions.


Some parts of a program are inevitably impure.
Programs need to read input from users, generate a graph, or write results to a file or a database.
Well designed programs separate complex logic from the necessary impure "glue" code that 
interacts with users and other systems.
This way, you have easy-to-read and easy-to-test pure code that contains the complex logic 
and simplified impure code that reads data from a file or gathers user input. Impure code may 
be harder to test but, when simplified like this, may only require a handful of tests anyway.

> ## Exercise: Refactoring To Use a Pure Function
> Refactor the `analyse_data()` function to delegate the data analysis to a new 
> pure function `compute_standard_deviation_by_day()` and separate it 
> from the impure code that handles the input and output.
> The pure function should take in the data, and return the analysis result, as follows:
> ```python
> def compute_standard_deviation_by_day(data):
>   # TODO
>   return daily_standard_deviation
> ```
>> ## Solution
>> The analysis code will be refactored into a separate function that may look something like:
>> ```python
>>def compute_standard_deviation_by_day(data):
>>    daily_std_list = []
>>    for dataset in data:
>>        daily_std = dataset.groupby(dataset.index.date).std()
>>        daily_std_list.append(daily_std)
>>
>>    daily_standard_deviation = pd.concat(daily_std_list)
>>    return daily_standard_deviation
>> ```
>> The `analyse_data()` function now calls the `compute_standard_deviation_by_day()` function, 
>> while keeping all the logic for reading the data, processing it and showing it in a graph:
>>```python
>>def analyse_data(data_dir):
>>    """Calculate the standard deviation by day between datasets.
>>
>>    Gets all the measurement data from the CSV files in the data directory,
>>    works out the mean for each day, and then graphs the standard deviation
>>    of these means.
>>    """
>>    data_file_paths = glob.glob(os.path.join(data_dir, 'rain_data_2015*.csv'))
>>    if len(data_file_paths) == 0:
>>        raise ValueError('No CSV files found in the data directory')
>>    data = map(models.read_variable_from_csv, data_file_paths)
>>    daily_standard_deviation = compute_standard_deviation_by_day(data)
>>
>>    graph_data = {
>>        'standard deviation by day': daily_standard_deviation,
>>    }
>>    # views.visualize(graph_data)
>>    return daily_standard_deviation
>>```
>> Make sure to re-run the regression test to check this refactoring has not
>> changed the output of `analyse_data()`.
> {: .solution}
{: .challenge}

> ## Mapping
> `map(f, C)` is a function that takes another function `f()`
> and a collection `C` of data items as inputs.
> Calling `map(f, C)` applies the function `f(x)` to every data item `x` in a collection `C`
> and returns the resulting values as a new collection of the same size.
>
> This is a simple mapping that takes a list of names and
> returns a list of the lengths of those names using the built-in function `len()`:
> ```python
> name_lengths = map(len, ["Mary", "Isla", "Sam"])
> print(list(name_lengths))
> ```
> ```output
> [4, 4, 3]
> ```
> For more information on mapping functions, and how they can be combined with reduce
> functions, see the [Functional Programming](/34-functional-programming/index.html) episode.
{: .callout}

> ## Exercise: Mapping
> Identify a line of code in the `analyse_data` function which uses the `map` function.
>> ## Solution
>> The `map` function is used with the `read_variables_from_csv` function in the `catchment/models.py` module.
>> It creates a collection of dataframes containing the data within files defined in the list `data_file_paths`:
>> ```python
>> data = map(models.read_variable_from_csv, data_file_paths)
>> ```
> {: .solution}
>
> Now create a pure function, `daily_std`, to calculate the standard deviation by day for any dataframe.
> This can take a similar form to the `daily_mean` and `daily_max` functions in the `catchment/models.py` file.
>
> Then replace the `for` loop below, that is in your `compute_standard_deviation_by_day` function,
> with a `map()` function that uses the `daily_std` function to calculate the daily standard
> deviation.
> ```python
> daily_std_list = []
> for dataset in data:
>     daily_std = dataset.groupby(dataset.index.date).std()
>     daily_std_list.append(daily_std)
> ```
>> ## Solution
>> The final functions could look like:
>> ```python
>> def daily_std(data):
>>     return data.groupby(data.index.date).std()
>>
>>
>> def compute_standard_deviation_by_day(data):
>>     daily_std_list = map(daily_std, data)
>>
>>     daily_standard_deviation = pd.concat(daily_std_list)
>>     return daily_standard_deviation
>> ```
>>
> {: .solution}
{: .challenge}

### Testing Pure Functions

Now we have our analysis implemented as a pure function, we can write tests that cover
all the things we would like to check without depending on CSVs files.
This is another advantage of pure functions - they are very well suited to automated testing, 
i.e. their tests are:
* **easier to write** - we construct input and assert the output
without having to think about making sure the global state is correct before or after
* **easier to read** - the reader will not have to open a CSV file to understand why 
the test is correct
* **easier to maintain** - if at some point the data format changes 
from CSV to JSON, the bulk of the tests need not be updated

> ## Exercise: Testing a Pure Function
> Add tests for `compute_standard_deviation_by_day()` that check for situations 
> when there is only one file with multiple sites, 
> multiple files with one site, and any other cases you can think of that should be tested.
>> ## Solution
>> You might have thought of more tests, but we can easily extend the test by parametrizing
>> with more inputs and expected outputs:
>> ```python
>>@pytest.mark.parametrize(
>>    "data, expected_output",
>>    [
>>        (
>>            [pd.DataFrame(data=[ [1.0, 0.0], [3.0, 4.0], [5.0, 8.0] ],
>>                        index=[ pd.to_datetime('2000-01-01 01:00'),
>>                                pd.to_datetime('2000-01-01 02:00'),
>>                                pd.to_datetime('2000-01-01 03:00') ],
>>                        columns=[ 'A', 'B' ])],
>>            [ [2.0,  4.0] ]
>>        ),
>>        (
>>            [pd.DataFrame(data=[ 1.0, 3.0, 5.0 ],
>>                        index=[ pd.to_datetime('2000-01-01 01:00'),
>>                                pd.to_datetime('2000-01-01 02:00'),
>>                                pd.to_datetime('2000-01-01 03:00') ],
>>                        columns=['A']),
>>            pd.DataFrame(data=[ 0.0, 4.0, 8.0 ],
>>                        index=[ pd.to_datetime('2000-01-01 01:00'),
>>                                pd.to_datetime('2000-01-01 02:00'),
>>                                pd.to_datetime('2000-01-01 03:00') ],
>>                        columns=['B']) ],                      
>>            [ [2.0,  4.0] ]
>>        )
>>    ], ids=["two datasets in same dataframe", "two datasets in two different dataframes"])
>>def test_compute_standard_deviation_by_day(data, expected_output):
>>    from catchment.compute_data import compute_standard_deviation_by_day
>>
>>    result = compute_standard_deviation_by_day(data)
>>    npt.assert_array_almost_equal(result, expected_output)
```
> {: .solution}
{: .challenge}

> ## Functional Programming
> **Functional programming** is a programming paradigm where programs are constructed by 
> applying and composing/chaining pure functions.
> Some programming languages, such as Haskell or Lisp, support writing pure functional code only.
> Other languages, such as Python, Java, C++, allow mixing **functional** and **procedural** 
> programming paradigms. 
> Read more in the [extra episode on functional programming](/34-functional-programming/index.html)
> and when it can be very useful to switch to this paradigm 
> (e.g. to employ MapReduce approach for data processing).
{: .callout}


There are no definite rules in software design but making your complex logic out of 
composed pure functions is a great place to start when trying to make your code readable, 
testable and maintainable. This is particularly useful for:

* Data processing and analysis 
(for example, using [Python Pandas library](https://pandas.pydata.org/) for data manipulation where most of functions appear pure)
* Doing simulations
* Translating data from one format to another

{% include links.md %}
