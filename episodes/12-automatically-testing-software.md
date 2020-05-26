---
title: "Automatically Testing your Software"
teaching: 30
exercises: 10
questions:
- "Key question (FIXME)"
objectives:
- "Explain the reasons why testing is important"
- "Describe the three main types of tests and what each are used for"
- "Implement and run unit tests to verify the correct behaviour of program functions"
- "Use parameterisation to automatically run tests over a set of inputs"
- "Use code coverage to understand how much of our code is being tested using unit tests"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

FIXME: add setup.py directly to repo?

So far we've seen how to use version control to manage the development of code with tools that help automate the process. Automation, where possible is a good thing - it enables us to define a potentially complex process in a repeatable way that is far less prone to error than manual approaches. Once defined, automation can also save us a lot of effort, particularly in the long run. In this episode we'll look into techniques of automated testing to improve the predictability of a software change, make development more productive, and help us produce code that works as expected and produces desired results.

Being able to demonstrate that a process generates the right results is important in any field of research, whether it's software generating those results or not. So when writing software we need to ask ourselves some key questions:

- Does the code we develop work the way it should do?
- Can we (and others) verify these assertions for themselves?
- And perhaps most importantly, to what extent are we confident of the accuracy of results that appear in publications?

If we are unable to demonstrate that our software fulfils these criteria, why would anyone use it?


## What is software testing?

For the sake of argument, if each line we write has a 99% chance of being right, then a 70-line program will be wrong more than half the time. We need to do better than that, which means we need to test our software to catch these mistakes.

We can test manually (FIXME: add something on manual testing, and its limitations: prone to error, time consuming, etc. Add something about test plans?). Another style of testing is automated testing. We can write code as `unit tests` that test the functions of our software. Since computers are very good and efficient at automating repetitive tasks, we should take advantage of this.

There are three main types of automated tests:

- *Unit tests* are tests for fairly small and specific units of functionality, e.g. determining that a particular function returns output as expected given specific inputs.
- *Functional or integration tests* work at a higher level, and test functional paths through your code, e.g. given some specific inputs a set of interconnected functions across a number of modules produce the expected result. These are particularly useful for exposing faults in how functional units interact.
- *Regression tests* make sure that your program's output hasn't changed, for example after making changes your code to add new functionality or fix a bug.

For the purposes of this course, we'll focus on unit tests. But the principles and practices we'll talk about can be built on and applied to the other types of tests too.


## An example dataset and application

FIXME: introduce these here?


## Writing tests to verify correct behaviour

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

This result is useful, in the sense that we know something’s wrong, but look closely at what happens if we run the tests in a different order:

~~~
from inflammation.models import daily_mean
import numpy as np

assert np.array_equal(np.array([2, 0]), daily_mean(np.array([[2, 0], [4, 0]])))
assert np.array_equal(np.array([3, 4]), daily_mean(np.array([[1, 2], [3, 4], [5, 6]])))
assert np.array_equal(np.array([0, 0]), daily_mean(np.array([[0, 0], [0, 0]])))
~~~
{: .language-python}

~~~
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError
~~~
{: .output}

We could put these in a separate script to automate the running of these tests. But Python halts at the first failed assertion, so the second and third tests aren’t run at all. It would be more helpful if we could get data from all of our tests every time they’re run, since the more information we have, the faster we’re likely to be able to track down bugs. It would also be helpful to have some kind of summary report: if our test suite includes thirty or forty tests (as it well might for a complex function or library that’s widely used), we’d like to know how many passed or failed.

So what has failed? As it turns out, the first test we just ran was incorrect, and should have read:

~~~
assert np.array_equal(np.array([3, 0]), daily_mean(np.array([[2, 0], [4, 0]])))
~~~
{: .language-python}

Which highlights an important point: as well as making sure our code is returning correct answers, we also need to ensure our tests are also correct. Otherwise, we may go on to fix our code only to return an incorrect result that *appears* to be correct. So a good rule is to make tests simple enough to understand so we can reason about both the correctness of our tests as well as our code. Otherwise, our tests hold little value.

Most people don’t enjoy writing tests, so if we want them to actually do it, it must be easy to:

- Add or change tests,
- Understand the tests that have already been written,
- Run those tests, and
- Understand those tests’ results

Test results must also be reliable. If a testing tool says that code is working when it’s not, or reports problems when there actually aren’t any, people will lose faith in it and stop using it.

Keeping these things in mind, here's a different approach. Look at `tests/test_stats.py`:

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

Here, we have specified our zero and positive integer tests as separate functions. Aside from some minor changes to clarify the creation of a Numpy array to test against, they run the same assertions. So, reasonably easy to understand, and it appears easy to add new ones.

> ## What about the comments that refer to Yapf?
>
> You'll also notice the peculiar `# yapf: disable` comments. You may remember we looked into coding style in the last lesson, and Yapf is a command-line tool that reformats your code according to a given coding style. These *directives* inform Yapf that we don't wish to have this line reformatted, just to maintain clarity. We'll be looking into using Yapf later.
>
{: .callout}

Each of these test functions are called *test cases*.

Going back to our list of requirements, how easy is it to run them? We can do this using a Python package called `pytest`.

FIXME: add intro to PyTest

FIXME: write a basic setup.py

~~~
from setuptools import setup, find_packages

setup(name="swc-intermediate-test", version='1.0', packages=find_packages())
~~~
{: .language-python}

~~~
$ pytest tests/test_stats.py
~~~
{: .language-bash}

Here, we can use the `-m` argument to Python to tell it to run a Python module, in this case `pytest`, on the specified `test_stats.py` file.

~~~
============================= test session starts ==============================
platform darwin -- Python 3.7.7, pytest-5.4.2, py-1.8.1, pluggy-0.13.1
rootdir: /Users/user/Projects/SSI/intermediate-swc/swc-intermediate-template
collected 2 items                                                              

tests/test_stats.py ..                                                   [100%]

============================== 2 passed in 0.08s ===============================
~~~
{: .output}

PyTest looks for functions whose names also start with the letters 'test_' and runs each one. Notice the `..` after our test script:

- If the function completes without an assertion being triggered, we count the test as a success (indicated as `.`).
- If an assertion fails, or we encounter an error, we count the test as a failure (indicated as `F`). The error is included in the output so we can see what went wrong.

So if we have many tests, we essentially get a report indicating which tests succeeded or failed. Going back to our list of requirements, are these results easy to understand?

### Preparing to write unit tests

Let's write some of our own tests. A common term we use to refer to sets of tests is a `test suite`.

Before we do, however, let's create a new feature branch called `test-suite` that we'll use for our initial test writing work:

~~~
$ git branch test-suite
$ git checkout test-suite
~~~
{: .language-bash}

Good practice is to write our tests around the same time we write our code on a feature branch. But since the code already exists, we're creating a feature branch for just these extra tests. Git branches are designed to be lightweight, and where necessary, transient, and use of branches for even small bits of work is encouraged.

Once we've finished writing these tests and are convinced they work properly, we'll merge our `test-suite` branch back into `dev`.

> ## Write some unit tests
>
> We already have a couple of test cases in our script that test the `daily_mean()` function. Looking at `inflammation/models.py`, write at least two new test cases that test the `daily_max()` and `daily_min()` functions. Try to choose cases that are suitably different.
>
> > ## Solution
> > 
> > ~~~
> > function test_daily_max():
> >     """Test that max function works for an array of positive integers."""
> >     from inflammation.models import daily_mean
> > 
> >     test_array = np.array([[4, 2, 5],
> >                            [1, 6, 2],
> >                            [4, 1, 9]])  # yapf: disable
> > 
> >     # Need to use Numpy testing functions to compare arrays
> >     npt.assert_array_equal(np.array([4, 6, 9]), daily_max(test_array))
> > 
> > function test_daily_min():
> >     """Test that min function works for an array of positive and negative integers."""
> >     from inflammation.models import daily_mean
> > 
> >     test_array = np.array([[ 4, -2, 5],
> >                            [ 1, -6, 2],
> >                            [-4, -1, 9]])  # yapf: disable
> > 
> >     # Need to use Numpy testing functions to compare arrays
> >     npt.assert_array_equal(np.array([-4, -6, 2]), daily_min(test_array))
> > ~~~
> {: .solution}   
>
{: .challenge}    

The big advantage is that as our code develops, we can update our test cases and commit them back, ensuring that ourselves (and others) always have a set of tests to verify our code at each step of development. This way, when we implement a new feature, we can check a) that the feature works using a test we write for it, and b) that the development of the new feature doesn’t break any existing functionality.

FIXME: add testing exceptions


## Parameterise tests to run over many test cases

We're starting to build up a number of tests that test the same function, but just with different parameters. Instead of writing a separate function for each different test, we can *parameterize* the tests with multiple test inputs. For example, we could rewrite the `test_daily_mean_zeros()` and `test_daily_mean_integers()` into a single test function:

~~~
@pytest.mark.parameterize(
    "test, expected", 
    [[[0, 0], [0, 0], [0, 0]], [0, 0]],
     [[1, 2], [3, 4], [5, 6]], [3, 4]]])
def test_daily_mean(test, expected):
    """Test mean function works for array of zeroes and positive integers."""
    from inflammation.models import daily_mean
    npt.assert_array_equal(np.array(expected), daily_mean(np.array(test)))
~~~
{: .language-python}

> ## Write parameterised unit tests
>
> Rewrite your test functions for `daily_max()` and `daily_min()` to be parameterised, adding in some more test cases.
>
> > ## Solution
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
> > ~~~
> > function test_daily_max()
> {: .solution}   
>
{: .challenge}    


FIXME: introduce fixtures and marking expected failures (@pytest.mark.xfail(msg)) if space allows?

FIXME: add custom attributes to group tests (@pytest.mark.slow, e.g. into slow)

Let's commit our new test cases to our `test-suite` branch (but don't push it yet!):

~~~
$ git add tests/test_stats.py
$ git commit -m "Add initial test cases for daily_max() and daily_min()" tests/test_stats.py
~~~
{: .language-bash}


## Using code coverage to understand how much of our code is tested

Pytest can’t think of test cases for us. We still have to decide what to test and how many tests to run. Our best guide here is economics: we want the tests that are most likely to give us useful information that we don’t already have. For example, if `daily_mean(np.array([[2, 0], [4, 0]])))` works, there’s probably not much point testing `daily_mean(np.array([[3, 0], [4, 0]])))`, since it’s hard to think of a bug that would show up in one case but not in the other.

Now, we should try to choose tests that are as different from each other as possible, so that we force the code we’re testing to execute in all the different ways it can - to ensure our tests have a high degree of *code coverage*.

A simple way to check the code coverage for a set of tests is to use nose to tell us how many statements in our code are being tested. By installing a Python package to our virtual environment called `pytest-cov` that is used by PyTest and using that, we can find this out:

~~~
$ pip install pytest-cov
$ pytest --cov=inflammation.models tests/test_stats.py
~~~
{: .language-bash}

So here, we specify the additional named argument `--cov` to PyTest specifying the code to analyse for test coverage.

~~~
============================= test session starts ==============================
platform darwin -- Python 3.8.3, pytest-5.4.2, py-1.8.1, pluggy-0.13.1
rootdir: /Users/user/Projects/SSI/intermediate-swc/swc-intermediate-test2
plugins: cov-2.9.0
collected 8 items                                                              

tests/test_stats.py ........                                             [100%]

---------- coverage: platform darwin, python 3.8.3-final-0 -----------
Name                     Stmts   Miss  Cover
--------------------------------------------
inflammation/models.py       9      1    89%


============================== 8 passed in 0.17s ===============================

~~~
{: .output}

Here we can see that our tests are doing very well - 89% of statements in `inflammation/models.py` have been executed. But there's still one not being tested in `load_csv()`. So, here we should consider whether or not to write a test for this function, and indeed any others that may not be tested. Of course, if there are hundreds or thousands of lines that are not covered, it may not be feasible to write tests for them all. But we should prioritise the ones for which we write tests, considering how often they're used, how complex they are, and importantly, the extent to which they affect our program's results.

~~~
~~~
{: .language-python}

We should also update our `requirements.txt` file with our latest package environment, which now includes `pytest-cov`, and commit it:

~~~
$ pip freeze > requirements.txt
$ git add requirements.txt
$ git commit -m "Update with py-cov" requirements.txt
$ git push
~~~
{: .language-bash}


## Limits to testing

Like any other piece of experimental apparatus, a complex program requires a much higher investment in testing than a simple one. Putting it another way, a small script that is only going to be used once, to produce one figure, probably doesn’t need separate testing: its output is either correct or not. A linear algebra library that will be used by thousands of people in twice that number of applications over the course of a decade, on the other hand, definitely does.

FIXME: more on limitations/cons: concerns about diverting effort away from new features, and the need to supplement automated testing with manual testing. Pros: potential economic savings as code becomes more complex to understand. Increased confidence in results, for yourselves and others.

{% include links.md %}
