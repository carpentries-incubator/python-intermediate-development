---
title: "Automatically Testing Software"
teaching: 30
exercises: 20
questions:
- "Does the code we develop work the way it should do?"
- "Can we (and others) verify these assertions for themselves?"
- "To what extent are we confident of the accuracy of results that appear in publications?"
objectives:
- "Explain the reasons why testing is important"
- "Describe the three main types of tests and what each are used for"
- "Implement and run unit tests to verify the correct behaviour of program functions"
keypoints:
- "The three main types of automated tests are **unit tests**, **functional tests** and **regression tests**."
- "We can write unit tests to verify that functions generate expected output given a set of specific inputs."
- "It should be easy to add or change tests, understand and run them, and understand their results."
- "We can use a unit testing framework like Pytest to structure and simplify the writing of tests in Python."
- "We should test for expected errors in our code."
- "Testing program behaviour against both valid and invalid inputs is important and is known as **data validation**."
---

## Introduction

Being able to demonstrate that a process generates the right results
is important in any field of research,
whether it's software generating those results or not.
So when writing software we need to ask ourselves some key questions:

- Does the code we develop work the way it should do?
- Can we (and others) verify these assertions for themselves?
- Perhaps most importantly, to what extent are we confident of
  the accuracy of results that software produces?

If we are unable to demonstrate that our software fulfills these criteria,
why would anyone use it?
Having well-defined tests for our software is useful for this,
but manually testing software can prove an expensive process.

Automation can help, and automation where possible is a good thing -
it enables us to define a potentially complex process in a repeatable way
that is far less prone to error than manual approaches.
Once defined, automation can also save us a lot of effort, particularly in the long run.
In this episode we'll look into techniques of automated testing to
improve the predictability of a software change,
make development more productive,
and help us produce code that works as expected and produces desired results.


## What Is Software Testing?

For the sake of argument, if each line we write has a 99% chance of being right,
then a 70-line program will be wrong more than half the time.
We need to do better than that,
which means we need to test our software to catch these mistakes.

We can and should extensively test our software manually,
and manual testing is well-suited to testing aspects such as
graphical user interfaces and reconciling visual outputs against inputs.
However, even with a good test plan,
manual testing is very time consuming and prone to error.
Another style of testing is automated testing,
where we write code that tests the functions of our software.
Since computers are very good and efficient at automating repetitive tasks,
we should take advantage of this wherever possible.

There are three main types of automated tests:

- **Unit tests** are tests for fairly small and specific units of functionality,
  e.g. determining that a particular function returns output as expected given specific inputs.
- **Functional or integration tests** work at a higher level,
  and test functional paths through your code,
  e.g. given some specific inputs,
  a set of interconnected functions across a number of modules
  (or the entire code) produce the expected result.
  These are particularly useful for exposing faults in how functional units interact.
- **Regression tests** make sure that your program's output hasn't changed,
  for example after making changes your code to add new functionality or fix a bug.

For the purposes of this course, we'll focus on unit tests.
But the principles and practices we'll talk about can be built on
and applied to the other types of tests too.

## Set Up a New Feature Branch for Writing Tests

We're going to look at how to run some existing tests and also write some new ones,
so let's ensure we're initially on our `develop` branch we created earlier.
And then, we'll create a new feature branch called `test-suite` off the `develop` branch -
a common term we use to refer to sets of tests - that we'll use for our test writing work:

~~~
$ git switch develop
$ git branch -c test-suite
~~~
{: .language-bash}

Good practice is to write our tests around the same time we write our code on a feature branch.
But since the code already exists, we're creating a feature branch for just these extra tests.
Git branches are designed to be lightweight, and where necessary, transient,
and use of branches for even small bits of work is encouraged.

Later on, once we've finished writing these tests and are convinced they work properly,
we'll merge our `test-suite` branch back into `develop`.


## Catchment Data Analysis

Let's go back to our [river catchment software project](/11-software-project/index.html#national-river-catchment-research-project).
Recall that it is based on a measurement campaign 
to record and analyse meteorological and hydrological data. 
There are a number of datasets in the `data` directory
recording rainfall and hydrological data across three river catchment areas.
There is one file for rainfall for all three catchments,
and one file for hydrological data for each catchment.
Each dataset is stored in comma-separated values (CSV) format.
The first row contains the column headers,
and each subsequent row holds information for a given site at a given time,
as indicated by the values in the `Site` and `Date` columns.
The values are a mix of dates, strings, and numbers,
making the processing of the data difficult.

Let's take a quick look at the data now from within the Python command line console.
Change directory to the repository root
(which should be in your home directory `~/python-intermediate-rivercatchment`),
ensure you have your virtual environment activated in your command line terminal
(particularly if opening a new one),
and then start the Python console by invoking the Python interpreter without any parameters, e.g.:

~~~
$ cd ~/python-intermediate-rivercatchment
$ source venv/bin/activate
$ python3
~~~
{: .language-bash}

The last command will start the Python console within your shell,
which enables us to execute Python commands interactively.
Inside the console enter the following:

~~~
import pandas as pd
pd.read_csv('data/rain_data_2015-12.csv', usecols=['Site', 'Date', 'Rainfall (mm)'])
~~~
{: .language-python}

~~~
      Site              Date  Rainfall (mm)
0     FP35  01/12/2005 00:00            0.0
1     FP35  01/12/2005 00:15            0.0
2     FP35  01/12/2005 00:30            0.0
3     FP35  01/12/2005 00:45            0.0
4     FP35  01/12/2005 01:00            0.0
    ...               ...            ...
5761  PL16  31/12/2005 22:45            0.2
5762  PL16  31/12/2005 23:00            0.0
5763  PL16  31/12/2005 23:15            0.0
5764  PL16  31/12/2005 23:30            0.0
5765  PL16  31/12/2005 23:45            0.0
~~~
{: .output}

The data has been read in using the Panda's `read_csv()` function,
where the columns to be read have been specified in the list `['Site', 'Date', 'Rainfall (mm)']`.
As mentioned above,
the `Site` and `Date` columns indicate the location and time of each measurement.
The data itself is stored in the one-dimensional `Rainfall (mm)` column.
While this format is convenient for data storage,
it is not particularly useful for analysing the data,
and so we must do some preprocessing of the dataset.
Fortunately the code for this has already been prepared for you,
in the `read_variable_from_csv()` function,
available in the `catchment/models.py` library. 
To use this enter the following in the python console:
~~~
from catchment import models
dataset = models.read_variable_from_csv('data/rain_data_2015-12.csv')
dataset.shape
~~~
{: .language-python}
~~~
(2976, 2)
~~~
{: .output}
The data is now two-dimensional,
with 2 columns and 2976 rows of data.
We can simply view the data by entering the following in the python console:
~~~
dataset
~~~
{: .language-python}

~~~
                     FP35  PL16
2005-12-01 00:00:00   0.0   0.0
2005-12-01 00:15:00   0.0   0.0
2005-12-01 00:30:00   0.0   0.0
2005-12-01 00:45:00   0.0   0.0
2005-12-01 01:00:00   0.0   0.0
                   ...   ...
2005-12-31 22:45:00   0.2   0.2
2005-12-31 23:00:00   0.0   0.0
2005-12-31 23:15:00   0.2   0.0
2005-12-31 23:30:00   0.2   0.0
2005-12-31 23:45:00   0.0   0.0
~~~
{: .output}
Each measurement site, `FP35` and `PL16`, now has it's own column, and the index contains the timestamp for each measurement, stored as a Pandas `DatetimeIndex` object (enter `type(dataset.index)` into the python console to verify this for yourselves). 

Our catchment study application has a number of statistical functions, also held in `catchment/models.py`: `daily_mean()`, `daily_max()`, `daily_min()`, and `daily_total()`, for calculating the mean average, the maximum, the minimum, and the total values for each day in our data. For example, the `daily_total()` function looks like this:

~~~
def daily_total(data):
    """Calculate the daily total of a 2D data array.

    :param data: A 2D Pandas data frame with measurement data.
                 Index must be np.datetime64 compatible format. Columns are measurement sites.
    :returns: A 2D Pandas data frame with total values of the measurements for each day.
    """
    return data.groupby(data.index.date).sum()
~~~
{: .language-python}

Here, we use the Panda's dataset built-in `groupby()` function,
to group the data according to the date
(given by the built-in `date()` function, which returns only the dates for each index entry).
The total value of each group is calculated using the built-in `sum()` function,
and returned from the function. 

So that we can clearly show this working with our measurement data, we will use a small subsample of two hours of measurements from near the start of our dataset, across midnight of the 1st December 2005. This sample has been stored in a separate datafile, and can be loaded in the same manner as the main dataset:
~~~
sample_dataset = models.read_variable_from_csv('data/rain_data_small.csv')
sample_dataset
~~~
{: .language-python}
~~~
                     FP35  PL16
2005-12-01 23:00:00   0.0   0.4
2005-12-01 23:15:00   0.0   0.4
2005-12-01 23:30:00   0.0   0.4
2005-12-01 23:45:00   0.0   0.6
2005-12-02 00:00:00   0.2   0.2
2005-12-02 00:15:00   0.0   0.4
2005-12-02 00:30:00   0.0   0.8
2005-12-02 00:45:00   0.2   0.6
~~~
{: .output}

This data can be passed to the function by entering the following lines in the python console:
~~~
from catchment.models import daily_total

daily_total(sample_dataset)
~~~
{: .language-python}

Note we use a different form of `import` here -
only importing the `daily_total` function from our `models` module instead of everything.
This also has the effect that we can refer to the function using only its name,
without needing to include the module name too (i.e. `models.daily_total()`).

The above code will return the mean rainfall for each day across each hour
(labelled according to the day each is in), as another Pandas dataframe:
~~~
            FP35  PL16
2005-12-01   0.0   1.8
2005-12-02   0.4   2.0
~~~
{: .output}

The other statistical functions are similar.
Note that in real situations
functions we write are often likely to be more complicated than these,
but simplicity here allows us to reason about what's happening -
and what we need to test -
more easily.

Let's now look into how we can test each of our application's statistical functions
to ensure they are functioning correctly.


## Writing Tests to Verify Correct Behaviour

### Testing Basics

The principle method for testing our functions is to write a series of checks or tests,
each executing a function we want to test with known inputs against known valid results,
and throw an error if we encounter a result that is incorrect.
To help with this process both the NumPy and Pandas libraries provide testing functions,
which we will make use of here.

Working with only real data for testing is limiting though,
so we will instead create artificial inputs for our tests.
For example, we will test the `daily_mean()` function,
using `[[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]]` as an input to that function
and check whether the result equals `[3.0, 4.0]`:

~~~
import pandas as pd
import pandas.testing as pdt
from catchment.models import daily_mean
import datetime

test_input = pd.DataFrame(
                data=[[1.0, 2.0],
                      [3.0, 4.0],
                      [5.0, 6.0]],
                index=[pd.to_datetime('2000-01-01 01:00'),
                       pd.to_datetime('2000-01-01 02:00'),
                       pd.to_datetime('2000-01-01 03:00')],
                columns=['A', 'B']
)
test_result = pd.DataFrame(
                 data=[[3.0, 4.0]],
                 index=[datetime.date(2000, 1, 1)],
                 columns=['A', 'B']
)
pdt.assert_frame_equal(daily_mean(test_input), test_result)
~~~
{: .language-python}

So we use the `assert_frame_equal()` function -
part of Panda's testing library -
to test that our calculated result is the same as our expected result.
This function explicitly checks the frame's shape and elements are the same,
as well as the index and column values,
and throws an `AssertionError` if they are not
(and, it should be noted, returns nothing if they are).
In particular, note that we can't just use `==` or other Python equality methods,
since these won't work properly with NumPy-based arrays in all cases. 

We could then add to this with other tests that use and test against other values,
and end up with something like:

~~~
import pandas as pd
import pandas.testing as pdt
from catchment.models import daily_mean
import datetime

test_input = pd.DataFrame(
                data=[[2.0, 0.0],
                      [4.0, 0.0]],
                index=[pd.to_datetime('2000-01-01 01:00'),
                       pd.to_datetime('2000-01-01 02:00')],
                columns=['A', 'B']
)
test_result = pd.DataFrame(
                 data=[[2.0, 0.0]],
                 index=[datetime.date(2000, 1, 1)],
                 columns=['A', 'B']
)
pdt.assert_frame_equal(daily_mean(test_input), test_result)

test_input = pd.DataFrame(
                data=[[0.0, 0.0],
                      [0.0, 0.0]],
                index=[pd.to_datetime('2000-01-01 01:00'),
                       pd.to_datetime('2000-01-01 02:00')],
                columns=['A', 'B']
)
test_result = pd.DataFrame(
                 data=[[0.0, 0.0]],
                 index=[datetime.date(2000, 1, 1)],
                 columns=['A', 'B']
)
pdt.assert_frame_equal(daily_mean(test_input), test_result)

test_input = pd.DataFrame(
                data=[[1.0, 2.0],
                      [3.0, 4.0],
                      [5.0, 6.0]],
                index=[pd.to_datetime('2000-01-01 01:00'),
                       pd.to_datetime('2000-01-01 02:00'),
                       pd.to_datetime('2000-01-01 03:00')],
                columns=['A', 'B']
)
test_result = pd.DataFrame(
                 data=[[3.0, 4.0]],
                 index=[datetime.date(2000, 1, 1)],
                 columns=['A', 'B']
)
pdt.assert_frame_equal(daily_mean(test_input), test_result)
~~~
{: .language-python}

However, if we were to enter these in this order, we'll find we get the following after the first test:

~~~
...
AssertionError: DataFrame.iloc[:, 0] (column name="A") are different

DataFrame.iloc[:, 0] (column name="A") values are different (100.0 %)
[index]: [2000-01-01]
[left]:  [3.0]
[right]: [2.0]
~~~
{: .output}

This tells us that one element between our generated and expected arrays doesn't match,
and shows us the different values, and the indices to locate these.

We could put these tests in a separate script to automate the running of these tests.
But a Python script halts at the first failed assertion,
so the second and third tests aren't run at all.
It would be more helpful if we could get data from all of our tests every time they're run,
since the more information we have,
the faster we're likely to be able to track down bugs.
It would also be helpful to have some kind of summary report:
if our set of tests - known as a **test suite** - includes thirty or forty tests
(as it well might for a complex function or library that's widely used),
we'd like to know how many passed or failed.

Going back to our failed first test, what was the issue?
As it turns out, the test itself was incorrect, and should have read:

~~~
test_input = pd.DataFrame(
                data=[[2.0, 0.0],
                      [4.0, 0.0]],
                index=[pd.to_datetime('2000-01-01 01:00'),
                       pd.to_datetime('2000-01-01 02:00')],
                columns=['A', 'B']
)
test_result = pd.DataFrame(
                 data=[[3.0, 0.0]],
                 index=[datetime.date(2000, 1, 1)],
                 columns=['A', 'B']
)
pdt.assert_frame_equal(daily_mean(test_input), test_result)
~~~
{: .language-python}

Which highlights an important point:
as well as making sure our code is returning correct answers,
we also need to ensure the tests themselves are also correct.
Otherwise, we may go on to fix our code only to return
an incorrect result that *appears* to be correct.
So a good rule is to make tests simple enough to understand
so we can reason about both the correctness of our tests as well as our code.
Otherwise, our tests hold little value.

### Using a Testing Framework

Keeping these things in mind,
here's a different approach that builds on the ideas we've seen so far
but uses a **unit testing framework**.
In such a framework we define our tests we want to run as functions,
and the framework automatically runs each of these functions in turn,
summarising the outputs.
And unlike our previous approach,
it will run every test regardless of any encountered test failures.

Most people don't enjoy writing tests,
so if we want them to actually do it,
it must be easy to:

- Add or change tests,
- Understand the tests that have already been written,
- Run those tests, and
- Understand those tests' results

Test results must also be reliable.
If a testing tool says that code is working when it's not,
or reports problems when there actually aren't any,
people will lose faith in it and stop using it.

Look at `tests/test_models.py`:

~~~
"""Tests for statistics functions within the Model layer."""

import pandas as pd
import pandas.testing as pdt
import datetime

def test_daily_mean_zeros():
    """Test that mean function works for an array of zeros."""
    from catchment.models import daily_mean

    test_input = pd.DataFrame(
                     data=[[0.0, 0.0],
                           [0.0, 0.0],
                           [0.0, 0.0]],
                     index=[pd.to_datetime('2000-01-01 01:00'),
                            pd.to_datetime('2000-01-01 02:00'),
                            pd.to_datetime('2000-01-01 03:00')],
                     columns=['A', 'B']
    )
    test_result = pd.DataFrame(
                     data=[[0.0, 0.0]],
                     index=[datetime.date(2000, 1, 1)],
                     columns=['A', 'B']
    )

    # Need to use Pandas testing functions to compare arrays
    pdt.assert_frame_equal(daily_mean(test_input), test_result)


def test_daily_mean_integers():
    """Test that mean function works for an array of positive integers."""
    from catchment.models import daily_mean

    test_input = pd.DataFrame(
                     data=[[1.0, 2.0],
                           [3.0, 4.0],
                           [5.0, 6.0]],
                     index=[pd.to_datetime('2000-01-01 01:00'),
                            pd.to_datetime('2000-01-01 02:00'),
                            pd.to_datetime('2000-01-01 03:00')],
                     columns=['A', 'B']
    )
    test_result = pd.DataFrame(
                     data=[[3.0, 4.0]],
                     index=[datetime.date(2000, 1, 1)],
                     columns=['A', 'B']
    )

    # Need to use Pandas testing functions to compare arrays
    pdt.assert_frame_equal(daily_mean(test_input), test_result)
...
~~~
{: .language-python}

Here, although we have specified two of our previous manual tests as separate functions,
they run the same assertions.
Each of these test functions, in a general sense, are called **test cases** -
these are a specification of:

- Inputs, e.g. the `test_input` Pandas dataframe
- Execution conditions -
  what we need to do to set up the testing environment to run our test,
  e.g. importing the `daily_mean()` function so we can use it.
  Note that for clarity of testing environment,
  we only import the necessary library function we want to test within each test function
- Testing procedure, e.g. running `daily_mean()` with our `test_input` array
  and using `assert_frame_equal()` to test its validity
- Expected outputs, e.g. our `test_result` Pandas dataframe that we test against

Also, we're defining each of these things for a test case we can run independently
that requires no manual intervention.

Going back to our list of requirements, how easy is it to run these tests?
We can do this using a Python package called `pytest`.
Pytest is a testing framework that allows you to write test cases using Python.
You can use it to test things like Python functions,
database operations,
or even things like service APIs -
essentially anything that has inputs and expected outputs.
We'll be using Pytest to write unit tests,
but what you learn can scale to more complex functional testing for applications or libraries.

> ## What About Unit Testing in Other Languages?
>
> Other unit testing frameworks exist for Python,
> including Nose2 and Unittest,
> and the approach to unit testing can be translated to other languages as well,
> e.g. pFUnit for Fortran,
> JUnit for Java (the original unit testing framework),
> Catch or gtest for C++, etc.
{: .callout}

> ## Why Use pytest over unittest?
>
> We could alternatively use another Python unit test framework, [unittest](https://docs.python.org/3/library/unittest.html),
> which has the advantage of being installed by default as part of Python. This is certainly a solid and established 
> option, however [pytest has many distinct advantages](https://realpython.com/pytest-python-testing/#what-makes-pytest-so-useful), 
> particularly for learning, including:
> 
> - unittest requires additional knowledge of object-oriented frameworks (covered later in the course) 
> to write unit tests, whereas in pytest these are written in simpler functions so is easier to learn
> - Being written using simpler functions, pytest's scripts are more concise and contain less boilerplate, and thus are
> easier to read
> - pytest output, particularly in regard to test failure output, is generally considered more helpful and readable
> - pytest has a vast ecosystem of plugins available if ever you need additional testing functionality
> - unittest-style unit tests can be run from pytest out of the box!
>
> A common challenge, particularly at the intermediate level, is the selection of a suitable tool from many alternatives
> for a given task. Once you've become accustomed to object-oriented programming you may find unittest a better fit
> for a particular project or team, so you may want to revisit it at a later date.
{: .callout}


### Installing Pytest

If you have already installed `pytest` package in your virtual environment,
you can skip this step.
Otherwise, as we have seen, we have a couple of options for installing external libraries:
1. via PyCharm
   (see ["Adding an External Library"](../13-ides/index.html#adding-an-external-library) section
   in ["Integrated Software Development Environments"](../13-ides/index.html) episode),
   or
2. via the command line
   (see ["Installing External Libraries in an Environment With `pip`"](../12-virtual-environments/index.html#installing-packages-in-an-environment-with-pip) section
   in ["Virtual Environments For Software Development"](../12-virtual-environments/index.html) episode).

To do it via the command line -
exit the Python console first (either with `Ctrl-D` or by typing `exit()`),
then do:

~~~
$ python3 -m pip install pytest
~~~
{: .language-bash}

Whether we do this via PyCharm or the command line,
the results are exactly the same:
our virtual environment will now have the `pytest` package installed for use.


### Running Tests

Now we can run these tests using `pytest`:

~~~
$ python3 -m pytest tests/test_models.py
~~~
{: .language-bash}

Here, we use `-m` flag of the `python3` command to invoke the `pytest` module,
and specify the `tests/test_models.py` file to run the tests in that file explicitly.

> ## Why Run Pytest Using `python3 -m pytest` and Not `pytest`?
>
> `pytest` is another Python module that can be run via its own command but this is a good example 
> why invoking Python modules via `python3 -m` may be better (recall the [explanation of Python interpreter's `-m` flag](../12-virtual-environments/index.html#what-is--m-flag-in-python3-command)).
> Had we used `pytest tests/test_models.py` command directly,
> this would have led to a "ModuleNotFoundError: No module named 'catchment'" error. This is 
> because `pytest` command (unlike `python3 -m pytest`) does not add the current directory to its list of 
> directories to search for modules, hence the `catchment` subdirectory's contents are not being 
> 'seen' by `pytest` causing the `ModuleNotFoundError`. There are ways to work around this problem 
> but `python3 -m pytest` ensures it does not happen in the first place.
> 
> 
{: .callout}

~~~
============================================== test session starts =====================================================
platform darwin -- Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
rootdir: /Users/alex/python-intermediate-rivercatchment
plugins: anyio-3.3.4
collected 2 items

tests/test_models.py ..                                                                       [100%]

=============================================== 2 passed in 0.79s ==================================
~~~
{: .output}

Pytest looks for functions whose names also start with the letters 'test_' and runs each one.
Notice the `..` after our test script:

- If the function completes without an assertion being triggered,
  we count the test as a success (indicated as `.`).
- If an assertion fails, or we encounter an error,
  we count the test as a failure (indicated as `F`).
  The error is included in the output so we can see what went wrong.

So if we have many tests, we essentially get a report indicating which tests succeeded or failed.
Going back to our list of requirements (the bullet points under [Using a Testing
Framework](#using-a-testing-framework) section),
do we think these results are easy to understand?

> ## Exercise: Write Some Unit Tests
>
> We already have a couple of test cases in `test/test_models.py`
> that test the `daily_mean()` function.
> Looking at `catchment/models.py`,
> write at least two new test cases that test the `daily_max()` and `daily_min()` functions,
> adding them to `test/test_models.py`. Here are some hints:
>
> - You could choose to format your functions very similarly to `daily_mean()`,
>   defining test input and expected result arrays followed by the equality assertion.
> - Try to choose cases that are suitably different,
>   and remember that these functions take a 2D array and return a 1D array
>   with each element the result of analysing each *column* of the data.
>
> Once added, run all the tests again with `python -m pytest tests/test_models.py`,
> and you should also see your new tests pass.
>
> > ## Solution
> >
> > ~~~
> > ...
> > def test_daily_max():
> >     """Test that max function works for an array of positive integers."""
> >     from catchment.models import daily_max
> >
> >     test_input = pd.DataFrame(
> >                       data=[[4, 2, 5],
> >                             [1, 6, 2],
> >                             [4, 1, 9]],
> >                       index=[pd.to_datetime('2000-01-01 01:00'),
> >                              pd.to_datetime('2000-01-01 02:00'),
> >                              pd.to_datetime('2000-01-01 03:00')],
> >                       columns=['A', 'B', 'C']
> >     )
> >     test_result = pd.DataFrame(
> >                       data=[[4, 6, 9]],
> >                       index=[datetime.date(2000, 1, 1)],
> >                       columns=['A', 'B', 'C']
> >     )
> >
> >     pdt.assert_frame_equal(daily_max(test_input), test_result)
> >
> >
> > def test_daily_min():
> >     """Test that min function works for an array of positive and negative integers."""
> >     from catchment.models import daily_min
> >
> >     test_input = pd.DataFrame(
> >                       data=[[ 4, -2, 5],
> >                             [ 1, -6, 2],
> >                             [-4, -1, 9]],
> >                       index=[pd.to_datetime('2000-01-01 01:00'),
> >                              pd.to_datetime('2000-01-01 02:00'),
> >                              pd.to_datetime('2000-01-01 03:00')],
> >                       columns=['A', 'B', 'C']
> >     )
> >     test_result = pd.DataFrame(
> >                       data=[[-4, -6, 2]],
> >                       index=[datetime.date(2000, 1, 1)],
> >                       columns=['A', 'B', 'C']
> >     )
> >
> >     pdt.assert_frame_equal(daily_min(test_input), test_result)
> > ...
> > ~~~
> > {: .language-python}
> {: .solution}
>
{: .challenge}

The big advantage is that as our code develops we can update our test cases and commit them back,
ensuring that ourselves (and others) always have a set of tests
to verify our code at each step of development.
This way, when we implement a new feature, we can check
a) that the feature works using a test we write for it, and
b) that the development of the new feature doesn't break any existing functionality.

### What About Testing for Errors?

There are some cases where seeing an error is actually the correct behaviour,
and Python allows us to test for exceptions.
Add this test in `tests/test_models.py`:

~~~
import pytest
...
def test_daily_min_python_list():
    """Test for AttributeError when passing a python list"""
    from catchment.models import daily_min

    with pytest.raises(AttributeError):
        error_expected = daily_min([[3, 4, 7],[-3, 0, 5]])
~~~
{: .language-python}

Note that you need to import the `pytest` library at the top of our `test_models.py` file
with `import pytest` so that we can use `pytest`'s `raises()` function.

Run all your tests as before.

Since we've installed `pytest` to our environment,
we should also regenerate our `requirements.txt`:

~~~
$ python3 -m pip freeze > requirements.txt
~~~
{: .language-bash}

Finally, let's commit our new `test_models.py` file,
`requirements.txt` file,
and test cases to our `test-suite` branch,
and push this new branch and all its commits to GitHub:

~~~
$ git add requirements.txt tests/test_models.py
$ git commit -m "Add initial test cases for daily_max() and daily_min()"
$ git push -u origin test-suite
~~~
{: .language-bash}


> ## Why Should We Test Invalid Input Data?
>
> Testing the behaviour of inputs, both valid and invalid,
> is a really good idea and is known as *data validation*.
> Even if you are developing command line software
> that cannot be exploited by malicious data entry,
> testing behaviour against invalid inputs prevents generation of erroneous results
> that could lead to serious misinterpretation
> (as well as saving time and compute cycles
> which may be expensive for longer-running applications).
> It is generally best not to assume your user's inputs will always be rational.
>
{: .callout}

{% include links.md %}
