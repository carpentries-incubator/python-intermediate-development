---
title: "Scaling Up Unit Testing"
teaching: 10
exercises: 5
questions:
- "How do we scale up the number of tests we want to run?"
- "How can we know how much of our code is being tested?"
objectives:
- "Use parameterisation to automatically run tests over a set of inputs"
- "Use code coverage to understand how much of our code is being tested using unit tests"
keypoints:
- "We can assign multiple inputs to tests using parametrization."
- "It's important to understand the **coverage** of our tests across our code."
- "Writing unit tests takes time, so apply them where it makes the most sense."
---

## Introduction 
We're starting to build up a number of tests that test the same function, but just with different parameters. However, continuing to write a new function for every single test case isn't likely to scale well as our development progresses. How can we make our job of writing tests more efficient? And importantly, as the number of tests increases, how can we determine how much of our code base is actually being tested?

## Parameterising Our Unit Tests

So far, we've been writing a single function for every new test we need. But instead of writing a separate function for each different test, we can **parameterize** the tests with multiple test inputs. For example, in `tests/test_models.py` let us rewrite the `test_daily_mean_zeros()` and `test_daily_mean_integers()` into a single test function:

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

Here, we use pytest's **mark** capability to add metadata to this specific test - in this case, marking that it's a parameterised test. `parameterize()` is actually a Python **decorator**. A decorator, when applied to a function, adds some functionality to it when it is called, and here, what we want to do is specify multiple input and expected output test cases so the function is called over each of them automatically when this test is called.

We specify these as arguments to the `parameterize()` decorator, firstly indicating the names of these arguments that will be passed to the function (`test`, `expected`), and secondly the actual arguments themselves that correspond to each of these names - the input data (the `test` argument), and the expected result (the `expected` argument). In this case, we are passing in two tests to `test_daily_mean()` which will be run sequentially.

The big pluses here are that we don't need to write separate functions for each of them, which can mean writing our tests scales better as our code becomes more complex and we need to write more tests.

> ## Write Parameterised Unit Tests
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
$ git commit -m "Add initial test cases for daily_max() and daily_min(), add parameterisation"
~~~
{: .language-bash}


## Using Code Coverage to Understand How Much of Our Code is Tested

Pytest can't think of test cases for us. We still have to decide what to test and how many tests to run. Our best guide here is economics: we want the tests that are most likely to give us useful information that we don't already have. For example, if `daily_mean(np.array([[2, 0], [4, 0]])))` works, there's probably not much point testing `daily_mean(np.array([[3, 0], [4, 0]])))`, since it's hard to think of a bug that would show up in one case but not in the other.

Now, we should try to choose tests that are as different from each other as possible, so that we force the code we're testing to execute in all the different ways it can - to ensure our tests have a high degree of **code coverage**.

A simple way to check the code coverage for a set of tests is to use `pytest` to tell us how many statements in our code are being tested. By installing a Python package to our virtual environment called `pytest-cov` that is used by pytest and using that, we can find this out:

~~~
$ conda install pytest-cov
$ pytest --cov=inflammation.models tests/test_models.py
~~~
{: .language-bash}

So here, we specify the additional named argument `--cov` to pytest specifying the code to analyse for test coverage.

~~~
============================= test session starts ==============================
platform darwin -- Python 3.8.5, pytest-6.2.2, py-1.10.0, pluggy-0.13.1
rootdir: /Users/user/Projects/SSI/intermediate-swc/python-intermediate-inflammation
plugins: cov-2.11.1
collected 9 items

tests/test_models.py .........                                           [100%]

---------- coverage: platform darwin, python 3.8.5-final-0 -----------
Name                     Stmts   Miss  Cover
--------------------------------------------
inflammation/models.py       9      1    89%
--------------------------------------------
TOTAL                        9      1    89%


============================== 9 passed in 0.26s ===============================
~~~
{: .output}

Here we can see that our tests are doing very well - 89% of statements in `inflammation/models.py` have been executed. But which statements are not being tested? The additional argument `--cov-report term-missing` can tell us:

~~~
$ pytest --cov=inflammation.models --cov-report term-missing tests/test_models.py
~~~
{: .language-bash}

~~~
...
Name                     Stmts   Miss  Cover   Missing
------------------------------------------------------
inflammation/models.py       9      1    89%   14
------------------------------------------------------
TOTAL                        9      1    89%
...
~~~
{: .output}

So there's still one statement not being tested at line 14, and it turns out it's in the function `load_csv()`. So, here we should consider whether or not to write a test for this function, and in general, any others that may not be tested. Of course, if there are hundreds or thousands of lines that are not covered it may not be feasible to write tests for them all. But we should prioritise the ones for which we write tests, considering how often they're used, how complex they are, and importantly, the extent to which they affect our program's results.

We should also update our `environment.yml` file with our latest package environment, which now includes `pytest-cov`, and commit it:

~~~
$ conda env export --from-history > environment.yml
$ cat environment.yml
~~~
{: .language-bash}

You'll notice `pytest-cov` and `coverage` have been added. Let's commit this file and push our new branch to GitHub:

~~~
$ git add environment.yml
$ git commit -m "Add coverage support"
$ git push origin test-suite
~~~
{: .language-bash}


## Limits to Testing

Like any other piece of experimental apparatus, a complex program requires a much higher investment in testing than a simple one. Putting it another way, a small script that is only going to be used once, to produce one figure, probably doesn't need separate testing: its output is either correct or not. A linear algebra library that will be used by thousands of people in twice that number of applications over the course of a decade, on the other hand, definitely does. The key is identify and prioritise against what will most affect the code's ability to generate accurate results.

It's also important to remember that unit testing cannot catch every bug in an application, no matter how many tests you write. To mitigate this manual testing is also important. Also remember to test using as much input data as you can, since very often code is developed and tested against the same small sets of data. Increasing the amount of data you test against - from numerous sources - gives you greater confidence that the results are correct.

Our software will inevitably increase in complexity as it develops. Using automated testing where appropriate can save us considerable time, especially in the long term, and allows others to verify against correct behaviour.

{% include links.md %}
