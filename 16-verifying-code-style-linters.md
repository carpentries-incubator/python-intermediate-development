---
title: 1.6 Verifying Code Style Using Linters
teaching: 15
exercises: 5
---

::::::::::::::::::::::::::::::::::::::: objectives

- Use code linting tools to verify a program's adherence to a Python coding style convention.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What tools can help with maintaining a consistent code style?
- How can we automate code style checking?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Verifying Code Style Using Linters

We have seen how we can use PyCharm to help us format our Python code in a consistent style.
This aids reusability,
since consistent-looking code is easier to modify
since it is easier to read and understand.
We can also use tools,
called [**code linters**](https://en.wikipedia.org/wiki/Lint_%28software%29),
to identify consistency issues in a report-style.
Linters analyse source code to identify and report on stylistic and even programming errors.
Let us look at a very well used one of these called `pylint`.

First, let us ensure we are on the `style-fixes` branch once again.

```bash
$ git switch style-fixes
```

Pylint is just a Python package so we can install it in our virtual environment using:

```bash
$ python3 -m pip install pylint
```

We should also update our `requirements.txt` with this new addition:

```bash
$ python3 -m pip freeze --exclude-editable > requirements.txt
```

Pylint is a command-line tool that can help our code in many ways:

- **Check PEP 8 compliance:**
  whilst in-IDE context-sensitive highlighting such as that provided via PyCharm
  helps us stay consistent with PEP 8 as we write code, this tool provides a full report
- **Perform basic error detection:** Pylint can look for certain Python type errors
- **Check variable naming conventions**:
  Pylint often goes beyond PEP 8 to include other common conventions,
  such as naming variables outside of functions in upper case
- **Customisation**:
  you can specify which errors and conventions you wish to check for, and those you wish to ignore

Pylint can also identify **code smells**.

:::::::::::::::::::::::::::::::::::::::::  callout

## How Does Code Smell?

There are many ways that code can exhibit bad design
whilst not breaking any rules and working correctly.
A *code smell* is a characteristic that indicates
that there is an underlying problem with source code, e.g.
large classes or methods,
methods with too many parameters,
duplicated statements in both if and else blocks of conditionals, etc.
They aren't functional errors in the code,
but rather are certain structures that violate principles of good design
and impact design quality.
They can also indicate that code is in need of maintenance and refactoring.

The phrase has its origins in Chapter 3 "Bad smells in code"
by Kent Beck and Martin Fowler in
[Fowler, Martin (1999). Refactoring. Improving the Design of Existing Code. Addison-Wesley. ISBN 0-201-48567-2](https://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672/).

::::::::::::::::::::::::::::::::::::::::::::::::::

Pylint recommendations are given as warnings or errors,
and Pylint also scores the code with an overall mark.
We can look at a specific file (e.g. `inflammation-analysis.py`),
or a package (e.g. `inflammation`).
Let us look at our `inflammation` package and code inside it (namely `models.py` and `views.py`).
From the project root do:

```bash
$ pylint inflammation
```

You should see an output similar to the following:

```output
************* Module inflammation.models
inflammation/models.py:13:23: C0303: Trailing whitespace (trailing-whitespace)
inflammation/models.py:34:0: C0305: Trailing newlines (trailing-newlines)
************* Module inflammation.views
inflammation/views.py:4:0: W0611: Unused numpy imported as np (unused-import)

------------------------------------------------------------------
Your code has been rated at 8.50/10 (previous run: 8.50/10, +0.00)
```

Your own outputs of the above commands may vary depending on
how you have implemented and fixed the code in previous exercises
and the coding style you have used.

The five digit codes, such as `C0303`, are unique identifiers for warnings,
with the first character indicating the type of warning.
There are five different types of warnings that Pylint looks for,
and you can get a summary of them by doing:

```bash
$ pylint --long-help
```

Near the end you'll see:

```output
  Output:
    Using the default text output, the message format is :
    MESSAGE_TYPE: LINE_NUM:[OBJECT:] MESSAGE
    There are 5 kind of message types :
    * (C) convention, for programming standard violation
    * (R) refactor, for bad code smell
    * (W) warning, for python specific problems
    * (E) error, for probable bugs in the code
    * (F) fatal, if an error occurred which prevented pylint from doing
    further processing.
```

So for an example of a Pylint Python-specific `warning`,
see the "W0611: Unused numpy imported as np (unused-import)" warning.

It is important to note that while tools such as Pylint are great at giving you
a starting point to consider how to improve your code,
they will not find everything that may be wrong with it.

:::::::::::::::::::::::::::::::::::::::::  callout

## How Does Pylint Calculate the Score?

The Python formula used is
(with the variables representing numbers of each type of infraction
and `statement` indicating the total number of statements):

```bash
10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)
```

For example, with a total of 31 statements of models.py and views.py,
with a count of the errors shown above, we get a score of 8.00.
Note whilst there is a maximum score of 10, given the formula,
there is no minimum score - it is quite possible to get a negative score!


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Further Improve Code Style of Our Project

Select and fix a few of the issues with our code that Pylint detected.
Make sure you do not break the rest of the code in the process and that the code still runs.
After making any changes, run Pylint again to verify you have resolved these issues.

::::::::::::::::::::::::::::::::::::::::::::::::::

Make sure you commit and push `requirements.txt`
and any file with further code style improvements you did on to `style-fixes` branch and then
merge all these changes into your development branch.

For the time being, we will not merge
the development branch onto `main` until we finish testing our code a bit further and automating
those tests with GitHub's Continuous Integration service called GitHub Actions
(to be covered in the next section).
Note that it is also possible to automate the linting kinds of code checks
with GitHub Actions - we will come back to automated linting in the episode on
["Diagnosing Issues and Improving Robustness"](24-diagnosing-issues-improving-robustness.md).

```bash
$ git add requirements.txt
$ git commit -m "Added Pylint library"
$ git push origin style-fixes
$ git switch develop
$ git merge style-fixes
$ git push origin develop
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Optional Exercise: Improve Code Style of Your Other Python Projects

If you have a Python project you are working on or you worked on in the past,
run it past Pylint to see what issues with your code are detected, if any.


::::::::::::::::::::::::::::::::::::::::::::::::::

::: challenge

## Optional Exercise: More on Pylint

Checkout [this optional exercise](17-section1-optional-exercises.md)
to learn more about `pylint`.

:::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use linting tools on the command line (or via continuous integration) to automatically check your code style.

::::::::::::::::::::::::::::::::::::::::::::::::::


