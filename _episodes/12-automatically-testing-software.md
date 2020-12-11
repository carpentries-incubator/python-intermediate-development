---
title: "Automatically Testing your Software"
teaching: 35
exercises: 10
questions:
- "Does the code we develop work the way it should do?"
- "Can we (and others) verify these assertions for themselves?"
- "To what extent are we confident of the accuracy of results that appear in publications?"
objectives:
- "Explain the reasons why testing is important"
- "Describe the three main types of tests and what each are used for"
- "Implement and run unit tests to verify the correct behaviour of program functions"
- "Use parameterisation to automatically run tests over a set of inputs"
- "Use code coverage to understand how much of our code is being tested using unit tests"
keypoints:
- "The three main types of automated tests are **unit tests**, **functional tests**, and **regression tests**."
- "We can write unit tests to verify that functions generate expected output given a set of specific inputs."
- "It should be easy to add or change tests, understand and run them, and understand their results."
- "We can use a unit testing framework like PyTest to structure and simplify the writing of tests."
- "We should test for expected errors in our code."
- "Testing program behaviour against both valid and invalid inputs is important and is known as **data validation**."
- "We can assign multiple inputs to tests using parametrization."
- "It's important to understand the **coverage** of our tests across our code."
---

So far we've seen how to use version control to manage the development of code with tools that help automate the process. Automation, where possible is a good thing - it enables us to define a potentially complex process in a repeatable way that is far less prone to error than manual approaches. Once defined, automation can also save us a lot of effort, particularly in the long run. In this episode we'll look into techniques of automated testing to improve the predictability of a software change, make development more productive, and help us produce code that works as expected and produces desired results.

Being able to demonstrate that a process generates the right results is important in any field of research, whether it's software generating those results or not. So when writing software we need to ask ourselves some key questions:

- Does the code we develop work the way it should do?
- Can we (and others) verify these assertions for themselves?
- And perhaps most importantly, to what extent are we confident of the accuracy of results that appear in publications?

If we are unable to demonstrate that our software fulfils these criteria, why would anyone use it?


## What is software testing?

For the sake of argument, if each line we write has a 99% chance of being right, then a 70-line program will be wrong more than half the time. We need to do better than that, which means we need to test our software to catch these mistakes.

We can and should extensively test our software manually, and manual testing is well suited to testing aspects such as graphical user interfaces and reconciling visual outputs against inputs. However, even with a good test plan, manual testing is very time consuming and prone to error. Another style of testing is automated testing. We can write code as **unit tests** that test the functions of our software. Since computers are very good and efficient at automating repetitive tasks, we should take advantage of this wherever possible.

There are three main types of automated tests:

- *Unit tests* are tests for fairly small and specific units of functionality, e.g. determining that a particular function returns output as expected given specific inputs.
- *Functional or integration tests* work at a higher level, and test functional paths through your code, e.g. given some specific inputs, a set of interconnected functions across a number of modules (or the entire code) produce the expected result. These are particularly useful for exposing faults in how functional units interact.
- *Regression tests* make sure that your program's output hasn't changed, for example after making changes your code to add new functionality or fix a bug.

For the purposes of this course, we'll focus on unit tests. But the principles and practices we'll talk about can be built on and applied to the other types of tests too.


## An example dataset and application

We going to use an example dataset that was actually used in the novice Software Carpentry materials. It's based on a clinical trial of inflammation in patients who have been given a new treatment for arthritis. There are a number of these data sets in the `data` directory, and are each stored in comma-separated values (CSV) format: each row holds information for a single patient, and the columns represent successive days.

Let's take a quick look now. Start the Python interpreter on the command line, in the 
repository root `swc-intermediate-template` directory:

~~~
$ python
~~~
{: .language-bash}

And then enter the following:

~~~
import numpy
data = numpy.loadtxt(fname='data/inflammation-01.csv', delimiter=',')
data.shape
~~~
{: .language-python}

~~~
(60, 40)
~~~
{: .language-output}

The data in this case has 60 rows (one for each patient) and 40 columns (one for each day). Each cell in the data represents an inflammation reading on a given day for a patient. So this shows the results of measuring the inflammation of 60 patients over a 40 day period. Let's look into how we can test our application's statistical functions (held in `inflammation/models.py`) against this data.

## Writing tests to verify correct behaviour

### How about using Python assertions?
As an example, we'll start by testing our code directly using `assert`. Here, we call the function three times with different arguments, checking that a certain value is returned each time:

~~~
from inflammation.models import daily_mean
import numpy as np

assert np.array_equal(np.array([0, 0]), daily_mean(np.array([[0, 0], [0, 0]])))
assert np.array_equal(np.array([3, 4]), daily_mean(np.array([[1, 2], [3, 4], [5, 6]])))
assert np.array_equal(np.array([2, 0]), daily_mean(np.array([[2, 0], [4, 0]])))
~~~
{: .language-python}

So here, our first test is testing that the average mean of a dataset that has values of zero for each day for two patients is, overall, zero for each day. Our second test is testing that some positive integer data for three patients returns some particular average values. Similarly, for the third test.

~~~
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError
~~~
{: .output}

This result is useful, in the sense that we know something's wrong, but look closely at what happens if we run the tests in a different order:

~~~
from inflammation.models import daily_mean
import numpy as np

assert np.array_equal(np.array([2, 0]), daily_mean(np.array([[2, 0], [4, 0]])))
assert np.array_equal(np.array([3, 4]), daily_mean(np.array([[1, 2], [3, 4], [5, 6]])))
assert np.array_equal(np.array([0, 0]), daily_mean(np.array([[0, 0], [0, 0]])))
~~~
{: .language-python}

If we were to enter these in this order, we'd now get the following after the first test:

~~~
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError
~~~
{: .output}

We could put these in a separate script to automate the running of these tests. But Python halts at the first failed assertion, so the second and third tests aren’t run at all. It would be more helpful if we could get data from all of our tests every time they’re run, since the more information we have, the faster we’re likely to be able to track down bugs. It would also be helpful to have some kind of summary report: if our set of test - known as a **test suite** - includes thirty or forty tests (as it well might for a complex function or library that’s widely used), we’d like to know how many passed or failed.

So what has failed? As it turns out, the first test we just ran was incorrect, and should have read:

~~~
assert np.array_equal(np.array([3, 0]), daily_mean(np.array([[2, 0], [4, 0]])))
~~~
{: .language-python}

Which highlights an important point: as well as making sure our code is returning correct answers, we also need to ensure our tests are also correct. Otherwise, we may go on to fix our code only to return an incorrect result that *appears* to be correct. So a good rule is to make tests simple enough to understand so we can reason about both the correctness of our tests as well as our code. Otherwise, our tests hold little value.

### Using a testing framework

Most people don't enjoy writing tests, so if we want them to actually do it, it must be easy to:

- Add or change tests,
- Understand the tests that have already been written,
- Run those tests, and
- Understand those tests' results

Test results must also be reliable. If a testing tool says that code is working when it's not, or reports problems when there actually aren't any, people will lose faith in it and stop using it.

Keeping these things in mind, here's a different approach. Look at 
`tests/test_models.py`:

~~~
"""Tests for statistics functions within the Model layer."""

import numpy as np
import numpy.testing as npt


def test_daily_mean_zeros():
    """Test that mean function works for an array of zeros."""
    from inflammation.models import daily_mean

    # NB: the comment 'yapf: disable' disables automatic formatting using
    # a tool called 'yapf' which we have used when creating this project
    test_array = np.array([[0, 0],
                           [0, 0],
                           [0, 0]])  # yapf: disable

    # Need to use Numpy testing functions to compare arrays
    npt.assert_array_equal(np.array([0, 0]), daily_mean(test_array))


def test_daily_mean_integers():
    """Test that mean function works for an array of positive integers."""
    from inflammation.models import daily_mean

    test_array = np.array([[1, 2],
                           [3, 4],
                           [5, 6]])  # yapf: disable

    # Need to use Numpy testing functions to compare arrays
    npt.assert_array_equal(np.array([3, 4]), daily_mean(test_array))
...
~~~
{: .language-python}

Here, we have specified our zero and positive integer tests as separate functions. Aside from some minor changes to clarify the creation of a Numpy array to test against, they run the same assertions. Note that for clarity, only within the scope of each test function do we import the necessary function we want to test. So, reasonably easy to understand, and it appears easy to add new ones.

Each of these test functions, in a general sense, are called **test cases** - these are a specification of inputs, execution conditions, testing procedure and expected outputs. And here, we're defining these things for a test case we can run independently that requires no manual intervention.

> ## What about the comments that refer to Yapf?
>
> You'll also notice the peculiar `# yapf: disable` comments. You may remember we looked into coding style in the last lesson, and Yapf is a command-line tool that reformats your code according to a given coding style. These *directives* inform Yapf that we don't wish to have this line reformatted, just to maintain clarity. We'll be looking into using Yapf later.
{: .callout}

Going back to our list of requirements, how easy is it to run these tests? We can do this using a Python package called `pytest`. PyTest is a testing framework that allows you to write test cases using Python. You can use it to test things like Python functions, database operations, or even things like service APIs - essentially anything that has inputs and expected outputs. We'll be using PyTest to write unit tests, but what you learn can scale to more complex functional testing for applications or libraries.

> ## What about unit testing in other languages?
>
> Other unit testing frameworks exist for Python, including Nose2 and Unittest, and the approach to unit testing can be translated to other languages as well, e.g. FRUIT for Fortran, JUnit for Java (the original unit testing framework), Catch for C++, etc.
>
{: .callout}

### Preparing to write unit tests

#### Install pytest

One of the first things we need to do is install the pytest package in our virtual environment. Instead of using PyCharm to configure the Conda environment, let's use the `pip` command from the command line instead:

~~~
$ pip install pytest
~~~
{: .language-bash}

You should see something like:

~~~
Collecting pytest
  Downloading pytest-6.0.2-py3-none-any.whl (270 kB)
     |████████████████████████████████| 270 kB 1.0 MB/s 
...

Installing collected packages: pytest
Successfully installed pytest-6.0.2
~~~
{: .output}

So pytest gets installed along with any additional dependencies it requires.

#### Set up a new feature branch for writing tests

Since we're going to write some new tests, let's ensure we're initially on our `develop` branch we created earlier. And then, we'll create a new feature branch called `test-suite` - a common term we use to refer to sets of tests - that we'll use for our initial test writing work:	Since we're going to write some new tests, let's ensure we're initially on our 
`test-suite` branch we created earlier:

~~~
$ git checkout develop	git checkout test-suite
$ git branch test-suite	
$ git checkout test-suite	
~~~
{: .language-bash}

Good practice is to write our tests around the same time we write our code on a feature branch. But since the code already exists, we're creating a feature branch for just these extra tests. Git branches are designed to be lightweight, and where necessary, transient, and use of branches for even small bits of work is encouraged.

Once we've finished writing these tests and are convinced they work properly, we'll merge our `test-suite` branch back into `develop`.

#### Write a metadata package description

Another thing we need to do is create a `setup.py` in the root of our project repository. A `setup.py` file defines metadata about our software, such as its name and current version, and is typically used when writing and distributing Python code as packages. Create a new file `setup.py` in the root directory of the `swc-intermediate-template` repository, with the following content:

~~~
from setuptools import setup, find_packages

setup(name="patient-analysis", version='1.0', packages=find_packages())
~~~
{: .language-python}

This is a typical short `setup.py` that will enable pytest to locate the Python source files to test, that we have in the `inflammation` directory. But first, we need to install our code as a local package:

~~~
$ pip install -e .
$ pip list
~~~
{: .language-bash}

We should see included with the other installed packages:

~~~
...
patient-analysis 1.0    /Users/user/swc-intermediate-template
...
~~~
{: .output}

This will install our code, as a package, within our virtual environment. The `-e` flag indicates that it's an *editable* package, i.e. its contents may change. So as we develop our code we don't need to install it each time.

### Running the tests

Now we can run these tests using pytest:

~~~
$ pytest tests/test_models.py
~~~
{: .language-bash}

So here, we specify the `tests/test_models.py` file to run the tests in that file 
specifically.

~~~
============================= test session starts ==============================
platform darwin -- Python 3.7.9, pytest-6.0.2, py-1.9.0, pluggy-0.13.1
rootdir: /Users/user/Projects/SSI/intermediate-swc/swc-intermediate-template
collected 2 items                                                              

tests/test_models.py ..                                                   [100%]

============================== 2 passed in 0.08s ===============================
~~~
{: .output}

Pytest looks for functions whose names also start with the letters 'test_' and runs each one. Notice the `..` after our test script:

- If the function completes without an assertion being triggered, we count the test as a success (indicated as `.`).
- If an assertion fails, or we encounter an error, we count the test as a failure (indicated as `F`). The error is included in the output so we can see what went wrong.

So if we have many tests, we essentially get a report indicating which tests succeeded or failed. Going back to our list of requirements, do we think these results are easy to understand?

> ## Write some unit tests
>
> We already have a couple of test cases in our script that test the `daily_mean()` function. Looking at `inflammation/models.py`, write at least two new test cases that test the `daily_max()` and `daily_min()` functions. Try to choose cases that are suitably different.
>
> > ## Solution
> > 
> > ~~~
> > ...
> > def test_daily_max():
> >     """Test that max function works for an array of positive integers."""
> >     from inflammation.models import daily_max
> > 
> >     test_array = np.array([[4, 2, 5],
> >                            [1, 6, 2],
> >                            [4, 1, 9]])  # yapf: disable
> > 
> >     # Need to use Numpy testing functions to compare arrays
> >     npt.assert_array_equal(np.array([4, 6, 9]), daily_max(test_array))
> > 
> > 
> > def test_daily_min():
> >     """Test that min function works for an array of positive and negative integers."""
> >     from inflammation.models import daily_min
> > 
> >     test_array = np.array([[ 4, -2, 5],
> >                            [ 1, -6, 2],
> >                            [-4, -1, 9]])  # yapf: disable
> > 
> >     # Need to use Numpy testing functions to compare arrays
> >     npt.assert_array_equal(np.array([-4, -6, 2]), daily_min(test_array))
> > ...
> > ~~~
> > {: .language-python}
> {: .solution}
>
{: .challenge}

The big advantage is that as our code develops, we can update our test cases and commit them back, ensuring that ourselves (and others) always have a set of tests to verify our code at each step of development. This way, when we implement a new feature, we can check a) that the feature works using a test we write for it, and b) that the development of the new feature doesn't break any existing functionality.

### What about testing for errors?

There are some cases where seeing an error is the correct behaviour, and we can test for Python exceptions using, e.g.:

~~~
def test_daily_min_string():
    """Test for TypeError when passing strings"""
    from inflammation.models import daily_min

    with pytest.raises(TypeError):
        error_expected = daily_min([['Hello', 'there'], ['General', 'Kenobi']])
~~~
{: .language-python}

Although note that we need to import the pytest library at the top of our `test_models.py` file with `import pytest` so that we can use pytest's `raises()` function.

> ## Why should we test invalid input data?
>
> Testing the behaviour of inputs, both valid and invalid, is a really good idea and is known as *data validation*. Even if you are developing command-line software that cannot be exploited by malicious data entry, testing behaviour against invalid inputs prevents generation of erroneous results that could lead to serious misinterpretation (as well as saving time and compute cycles which may be expensive for longer-running applications). It's generally best not to assume your user's inputs will always be rational.
>
{: .callout}

## Parameterise tests to run over many test cases

We're starting to build up a number of tests that test the same function, but just with different parameters. Instead of writing a separate function for each different test, we can **parameterize** the tests with multiple test inputs. For example, we could rewrite the `test_daily_mean_zeros()` and `test_daily_mean_integers()` into a single test function:

~~~
@pytest.mark.parametrize(
    "test, expected",
    [
        ([[0, 0], [0, 0], [0, 0]], [0, 0]),
        ([[1, 2], [3, 4], [5, 6]], [3, 4]),
    ])
def test_daily_mean(test, expected):
    """Test mean function works for array of zeroes and positive integers."""
    from inflammation.models import daily_mean
    npt.assert_array_equal(np.array(expected), daily_mean(np.array(test)))
~~~
{: .language-python}

Here, we use pytest's **mark** capability to add metadata to this specific test - in this case, marking that it's a parameterised test. `parameterize()` is actually a Python **decorator**. The arguments we pass to `parameterize()` indicate that we wish to pass additional arguments to the function as it is executed a number of times, and what we'll call these arguments.  We also pass the arguments we want to test with the expected result, which are picked up by the function. In this case, we are passing in two tests which will be run sequentially.
 
The big pluses here are that we don't need to write separate functions for each of them, which can mean writing our tests scales better as our code becomes more complex and we need to write more tests.

> ## Write parameterised unit tests
>
> Rewrite your test functions for `daily_max()` and `daily_min()` to be parameterised, adding in new test cases for each of them.
>
> > ## Solution
> > ~~~
> > ...
> > @pytest.mark.parametrize(
> >     "test, expected",
> >     [
> >         ([[0, 0, 0], [0, 0, 0], [0, 0, 0]], [0, 0, 0]),
> >         ([[4, 2, 5], [1, 6, 2], [4, 1, 9]], [4, 6, 9]),
> >         ([[4, -2, 5], [1, -6, 2], [-4, -1, 9]], [4, -1, 9]),
> >     ])
> > def test_daily_max(test, expected):
> >     """Test max function works for zeroes, positive integers, mix of positive/negative integers."""
> >     from inflammation.models import daily_max
> >     npt.assert_array_equal(np.array(expected), daily_max(np.array(test)))
> > 
> > 
> > @pytest.mark.parametrize(
> >     "test, expected",
> >     [
> >         ([[0, 0, 0], [0, 0, 0], [0, 0, 0]], [0, 0, 0]),
> >         ([[4, 2, 5], [1, 6, 2], [4, 1, 9]], [1, 1, 2]),
> >         ([[4, -2, 5], [1, -6, 2], [-4, -1, 9]], [-4, -6, 2]),
> >     ])
> > def test_daily_min(test, expected):
> >     """Test min function works for zeroes, positive integers, mix of positive/negative integers."""
> >     from inflammation.models import daily_min
> >     npt.assert_array_equal(np.array(expected), daily_min(np.array(test)))
> > ...
> > ~~~
> > {: .language-python}
> {: .solution}   
>
{: .challenge}

Try them out!

Let's commit our new `test_models.py` file and test cases to our `test-suite` branch (but don't push it yet!):

~~~
$ git add setup.py tests/test_models.py
$ git commit -m "Add initial test cases for daily_max() and daily_min()"
~~~
{: .language-bash}


## Using code coverage to understand how much of our code is tested

Pytest can't think of test cases for us. We still have to decide what to test and how many tests to run. Our best guide here is economics: we want the tests that are most likely to give us useful information that we don't already have. For example, if `daily_mean(np.array([[2, 0], [4, 0]])))` works, there's probably not much point testing `daily_mean(np.array([[3, 0], [4, 0]])))`, since it's hard to think of a bug that would show up in one case but not in the other.

Now, we should try to choose tests that are as different from each other as possible, so that we force the code we're testing to execute in all the different ways it can - to ensure our tests have a high degree of **code coverage**.

A simple way to check the code coverage for a set of tests is to use `pytest` to tell us how many statements in our code are being tested. By installing a Python package to our virtual environment called `pytest-cov` that is used by pytest and using that, we can find this out:

~~~
$ pip install pytest-cov
$ pytest --cov=inflammation.models tests/test_models.py
~~~
{: .language-bash}

So here, we specify the additional named argument `--cov` to PyTest specifying the code to analyse for test coverage.

~~~
============================= test session starts ==============================
platform darwin -- Python 3.7.9, pytest-6.0.2, py-1.9.0, pluggy-0.13.1
rootdir: /Users/user/swc-intermediate-template
plugins: cov-2.10.1
collected 9 items                                                              

tests/test_models.py .....                                                [100%]

---------- coverage: platform darwin, python 3.7.9-final-0 -----------
Name                     Stmts   Miss  Cover
--------------------------------------------
inflammation/models.py       9      1    89%


============================== 5 passed in 0.17s ===============================

~~~
{: .output}

Here we can see that our tests are doing very well - 89% of statements in `inflammation/models.py` have been executed. But there's still one not being tested in `load_csv()`. So, here we should consider whether or not to write a test for this function, and indeed any others that may not be tested. Of course, if there are hundreds or thousands of lines that are not covered, it may not be feasible to write tests for them all. But we should prioritise the ones for which we write tests, considering how often they're used, how complex they are, and importantly, the extent to which they affect our program's results.

We should also update our `requirements.txt` file with our latest package environment, which now includes `pytest-cov`, and commit it:

~~~
$ pip freeze > requirements.txt
$ cat requirements.txt
~~~
{: .language-bash}

Now if you look at `requirement.txt` you'll see `pytest-cov`, you'll notice it has a 
line indicating our `swc-intermediate-template` package is installed in edit mode, along with a 
GitHub repository URL to locate it. Before committing it to GitHub, we should remove 
this line, since we only need it for development. Do that now, and once done:

~~~
$ git add requirements.txt
$ git commit -m "Add coverage support"
$ git push -u origin test-suite
~~~
{: .language-bash}


## Limits to testing

Like any other piece of experimental apparatus, a complex program requires a much higher investment in testing than a simple one. Putting it another way, a small script that is only going to be used once, to produce one figure, probably doesn't need separate testing: its output is either correct or not. A linear algebra library that will be used by thousands of people in twice that number of applications over the course of a decade, on the other hand, definitely does. The key is identify and prioritise against what will most affect the code's ability to generate accurate results.

It's also important to remember that unit testing cannot catch every bug in an application, no matter how many tests you write. To mitigate this manual testing is also important. Also remember to test using as much input data as you can, since very often code is developed and tested against the same small sets of data. Increasing the amount of data you test against - from numerous sources - gives you greater confidence that the results are correct.

Our software will inevitably increase in complexity as it develops. Using automated testing where appropriate can save us considerable time, especially in the long term, and allows others to verify against correct behaviour.

{% include links.md %}
