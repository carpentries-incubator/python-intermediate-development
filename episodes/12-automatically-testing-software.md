---
title: "Automatically Testing your Software"
teaching: 45
exercises: 15
questions:
- "Key question (FIXME)"
objectives:
- "Explain the reasons why testing is important"
- "Describe the three main types of tests and what each are used for"
- "Implement and run unit tests to verify the correct behaviour of program functions"
- "Use parameterisation to automatically run tests over a set of inputs"
- "Use continuous integration to automatically run unit tests when changes are committed to a version control repository"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

FIXME: add lead-in from collaborative software development

In this episode we'll look into techniques of developing robust code and testing to improve the predictability of a software change, make development more productive, and help us produce code that works as expected and produces desired results.

Being able to demonstrate that a process generates the right results is important in any field of research, whether it's software generating those results or not. So when writing software we need to ask ourselves some key questions:

- Does the code we develop work the way it should do?
- Can we (and others) verify these assertions for themselves?
- And perhaps most importantly, to what extent are we confident of the accuracy of results that appear in publications?

If we are unable to demonstrate that our software fulfils these criteria, why would anyone use it?

## What is software testing?

For the sake of argument, if each line we write has a 99% chance of being right, then a 70-line program will be wrong more than half the time. We need to do better than that, which means we need to test our software to catch these mistakes.

We can test manually (FIXME: add something on manual testing, and its limitations: prone to error, time consuming, etc. Add something about test plans?). Another style of testing is automated testing. We can write code as `unit tests` that test the functions of our software. Since computers are very good and efficient at automating repetitive tasks, we should take advantage of this.

### How do we want from testing?

Most people don’t enjoy writing tests, so if we want them to actually do it, it must be easy to:

- Add or change tests,
- Understand the tests that have already been written,
- Run those tests, and
- Understand those tests’ results

Test results must also be reliable. If a testing tool says that code is working when it’s not, or reports problems when there actually aren’t any, people will lose faith in it and stop using it.

### Types of automated tests

There are three main types of automated tests:

- *Unit tests* are tests for fairly small and specific units of functionality, e.g. determining that a particular function returns output as expected given specific inputs.
- *Functional or integration tests* work at a higher level, and test entire functional paths through your code, e.g. given a specific set of initial parameters and input data, the software as a whole produces the correct results. These are particularly useful for exposing faults in how functional units interact.
- *Regression tests* make sure that your program's output hasn't changed, for example after making changes your code to add new functionality or fix a bug.

For the purposes of this course, we'll focus on unit tests. But the principles and practices we'll talk about can be built on and applied to the other types of tests too.

## An example dataset and application

FIXME: introduce these here?

## Create unit tests to verify correct behaviour

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

Which highlights an important point: as well as making sure our code is returning correct answers, we also need to ensure our tests also are correct. Otherwise, we may go on to fix our code only to return an incorrect result that *appears* to be correct. So a good rule is to make tests simple enough to understand so we can reason about both the correctness of our tests as well as our code. Otherwise, our tests hold little value.

Here's a different approach. Look at `tests/test_stats.py`:

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

Here, we have specified our zero and positive integer tests as separate functions. Aside from some minor changes to clarify the creation of a Numpy array to test against, they run the same assertions. FIXME: yapf comment?

FIXME: explain yapf directives, 

We can run these tests using `pytest` (FIXME: intro to PyTest):

~~~
$ python -m pytest tests/test_stats.py
~~~
{: .language-bash}

~~~
============================= test session starts ==============================
platform darwin -- Python 3.7.7, pytest-5.4.2, py-1.8.1, pluggy-0.13.1
rootdir: /Users/user/Projects/SSI/intermediate-swc/swc-intermediate-template
collected 2 items                                                              

tests/test_stats.py ..                                                   [100%]

============================== 2 passed in 0.08s ===============================
~~~
{: .output}

> ## Write some unit tests
>
> > ## Solution
> > 
> {: .solution}   
>
{: .challenge}    


## Parameterise tests to run over many test cases


## Automate running our tests using continuous integration


## Limits to testing


{% include links.md %}
