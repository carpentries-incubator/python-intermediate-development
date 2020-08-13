---
title: "Diagnosing Issues and Improving Robustness"
teaching: 25
exercises: 10
questions:
- "Once we know our program has errors, how can we identify where they are?"
- "How can we make our programs more resilient to failure?"
objectives:
- "Use a debugger to explore behaviour of a running program"
- "Describe and identify edge and corner test cases and explain why they are important"
- "Apply error handling and defensive programming techniques to improve robustness of a program"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

## Finding faults in software

Unit testing can tell us something's wrong, but it doesn't tell us where the error is or how it came about. We can do things like output program state at various points, perhaps using print statements to output the contents of variables, maybe even use a logging capability to output the state of everything as the program progresses, or look at intermediately generated files to give us an idea of what went wrong.

But such approaches only go so far and often these are time consuming and aren't enough. In complex programs like simulation codes, sometimes we need to get inside the code as it's running and explore. This is where using a **debugger** can be useful.


## Adding in all our tests

FIXME: change GitHub Actions main.yml to use just pytest to run all tests, show the failures - highlight test_patient_normalise() and patient_normalise(), test_transform.py


## Exploring code using a debugger

So let's have a look at this `patient_normalise()` function and its failed test.

~~~
def patient_normalise(data):
    """Normalise patient data between 0 and 1 of a 2D inflammation data array."""
    max = np.max(data, axis=0)
    return data / max[:, np.newaxis]
~~~
{: .language-python}

So here we're attempting to normalise each patient's inflammation data to values between 0 and 1: we find the maximum value for a patient, and using NumPy's elementwise division, divide each value by that maximum. In order to prevent an unwanted feature of NumPy called broadcasting, we need to add a blank axis to our array of patient maximums (FIXME: show why using code?). Note there is also an assumption in this calculation that the minimum value we want is always zero.

Our test in `tests/test_transform.py` is checking the normalisation function is correct for some test data.

~~~
@pytest.mark.parametrize(
    "test, expected",
    [
        ([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[0.33, 0.66, 1], [0.66, 0.83, 1], [0.77, 0.88, 1]])
    ])
def test_patient_normalise(test, expected):
    """Test normalisation works for arrays of one and positive integers."""
    from inflammation.models import patient_normalise
    npt.assert_almost_equal(np.array(expected), patient_normalise(np.array(test)), decimal=2)
~~~
{: .language-python}

Note the assumption here that a test accuracy of two decimal places is sufficient!

Let's use a debugger to see what's going on and why the function failed. Think of it like performing exploratory surgery - on code! Debuggers allow us to peer at the internal workings of a program, such as variables and other state, as it performs its functions.

FIXME: tour of debugger: show/explain inserting a breakpoint at return line, debugger interface and variables. Show max. Show PyCharm giving us values in-situ within the code editor. Show stack frames panel on left (quick intro to stack frames). Explore a bit.

FIXME: Identify something suspicious: data shape is only (40,) when it should be (60,) due to number of patients. Reason about values in max being perfectly uniform - odd. Emphasise that we're able to check the value of max inside the function execution - with a more complex (iterative, nested) example this would be tricky to know otherwise. So problem is max - axis is wrong. Should be 0. Use console -> evaluate expression (np.max(data, axis=1) to show this, then add 'max = ' to expression to show values can be changed within debugger. Fix, show test succeeds.

FIXME: importance of corner/edge cases. Externalising your cognition/understanding about your code into tests. Insufficiency of our current tests. Add 0 and 1 tests:

~~~
@pytest.mark.parametrize(
    "test, expected",
    [
        ([[0, 0, 0], [0, 0, 0], [0, 0, 0]], [[0, 0, 0], [0, 0, 0], [0, 0, 0]]),
        ([[1, 1, 1], [1, 1, 1], [1, 1, 1]], [[1, 1, 1], [1, 1, 1], [1, 1, 1]]),
        ([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[0.33, 0.66, 1], [0.66, 0.83, 1], [0.77, 0.88, 1]])
    ])
~~~
{: .language-python}

FIXME: 0's fail due to nan's (division by zero). How do we deal with this?

~~~
        ([[0, 0, 0], [0, 0, 0], [0, 0, 0]], [[0, 0, 0], [0, 0, 0], [0, 0, 0]]),
~~~
{: .language-python}

> ## Exploring tests for edge cases
>
> Think of some more suitable edge cases to test our `patient_normalise()` function and add them to the parametrised tests.
>
> > ## Solution
> > ~~~
> > ...
> > 
> > ...
> > ~~~
> > 
> > This one has forced me to think about whether this is behaviour I want to allow or not.
> > {: .language-python}
> {: .solution}
>
{: .challenge}

FIXME: show debugger with more complex example, stepping through code. Step over, step into. Resume program

FIXME: add something about debugging on command line?


## Defensive programming to avoid potential errors


FIXME: preconditions (protect your functions from bad data. This adheres to fail fast), postconditions (does out output make sense), invariants (these things should never happen, or should always be true). Don't take it too far and try to code for every conceivable eventuality. State the assumptions and limitations of your code for others. Where possible codify your assumptions

FIXME: add precondition of no values below zero (as per assumption), add assert postconditions of no values below 0 or above 1


## What about the other failed test?

FIXME: introduce TDD for next lesson



{% include links.md %}
