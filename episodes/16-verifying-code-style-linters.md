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

We have seen how we can use an IDE to help us format our Python code in a consistent style.
This aids reusability,
since consistent-looking code is easier to modify
since it is easier to read and understand.
We can also use tools,
called [**code linters**](https://en.wikipedia.org/wiki/Lint_%28software%29),
to identify consistency issues in a report-style.
Linters analyse source code to identify and report on stylistic and even programming errors.
Let us look at a very well used one of these called `ruff`.

First, let us ensure we are on the `style-fixes` branch once again.

```bash
$ git switch style-fixes
```

Ruff is written in Rust, which makes it very fast as compared to other Python linters.
It can be installed in our virtual environment using `pip`:

```bash
$ python3 -m pip install ruff
```

We should also update our `requirements.txt` with this new addition:

```bash
$ python3 -m pip freeze --exclude-editable > requirements.txt
```

Ruff is a command-line tool that can help our code in many ways:

- **Check PEP 8 compliance:**
  whilst in-IDE context-sensitive highlighting helps us stay consistent with PEP 8 as we write code, this tool provides a full report
- **Perform basic error detection:** Ruff can look for certain Python type errors
- **Check variable naming conventions**:
  Ruff can go beyond PEP 8 to include other common conventions,
  such as naming variables outside of functions in upper case
- **Customisation**:
  you can specify which errors and conventions you wish to check for, and those you wish to ignore
- **Automatic fixes**:
  Ruff supports automatic fixes for some lint errors.

Ruff can also identify **code smells**.

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

In addition, Ruff includes the functionality of a formatter: it can be used
to apply a stardardized format to Python files, so that the resulting layout
makes the code more consistent and readable. We will not cover Ruff's use as
a formatter here, but you can learn more about this topic from the
[Ruff documentation](https://docs.astral.sh/ruff/formatter/).

Ruff recommendations are given as warnings or errors.
We can look at a specific file (e.g. `inflammation-analysis.py`),
or a package (e.g. `inflammation`).
Let us look at our `inflammation` package and code inside it (namely `models.py` and `views.py`).
From the project root do:

```bash
$ ruff check inflammation
```

You should see an output similar to the following:

```output
F401 [*] `numpy` imported but unused
 --> inflammation/views.py:4:17
  |
3 | from matplotlib import pyplot as plt
4 | import numpy as np
  |                 ^^
  |
help: Remove unused import: `numpy`

Found 1 error.
[*] 1 fixable with the `--fix` option.
```

Your own outputs of the above commands may vary depending on
how you have implemented and fixed the code in previous exercises
and the coding style you have used.

The alphanumeric codes, such as `F401`, are unique identifiers for lint rules.
Ruff implements rules as derived by other tools and conventions - the starting
letter of the code refers to the tool or convention the rule is derived from.
To learn more about a lint rule, e.g. `F401`, you can run:

```bash
$ ruff rule F401
```
Ruff will tell you that `F401`, as all other `F`-rules, are derived from the
[Pyflakes](https://pypi.org/project/pyflakes/) Python linter, and give you
examples, explanations and some reasoning on why the rule exists.
The full list of rules that Ruff supports is available
[as part of the Ruff documentation](https://docs.astral.sh/ruff/rules/).

Note that by default Ruff does not check for all rules, but it enables
only a subset that is considered a reasonable choice to identify common errors.
You can enable a specific set of rules using the `--select` option. For instance,
try to include the following set of rules, which are derived from some of the most
popular tools, such as [pycodestyle](https://pypi.org/project/pycodestyle/)
(`E` rules) and [isort](https://pypi.org/project/isort/) (`I` rules):

```bash
$ ruff check --select E,F,I inflammation
```

Ruff will identify more problems in the codebase:

```output
I001 [*] Import block is un-sorted or un-formatted
 --> inflammation/views.py:3:1
  |
1 |   """Module containing code for plotting inflammation data."""
2 |
3 | / from matplotlib import pyplot as plt
4 | | import numpy as np
  | |__________________^
  |
help: Organize imports

F401 [*] `numpy` imported but unused
 --> inflammation/views.py:4:17
  |
3 | from matplotlib import pyplot as plt
4 | import numpy as np
  |                 ^^
  |
help: Remove unused import: `numpy`

Found 2 errors.
[*] 2 fixable with the `--fix` option.
```

It is important to note that while tools such as Ruff are great at giving you
a starting point to consider how to improve your code,
they will not find everything that may be wrong with it.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Add Ruff configurations to the `pyproject.toml` file

You can define the Ruff configuration for a project by adding a section to the
`pyproject.toml` file. For instance, you can define the set of rules to be checked
for your codebase. Following [the Ruff documentation](https://docs.astral.sh/ruff/linter/),
add a section to the `pyproject.toml` to enable the `E`, `W`, `F`, `UP`, `A`, `B`, `SIM`,
and `I` rules for the project. Verify that the configuration is respected when running
`ruff` (without the `--select` option):

```bash
$ ruff check inflammation
```

::::::::::::::::::::::::::::::::  solution

Add the following section to the `pyproject.toml`:

```toml
[tool.ruff.lint]
select = ["E", "W", "F", "UP", "A", "B", "SIM", "I"]
```

Running `ruff check inflammation` should indeed show problems with some of
the `W` and `I` rules, which are not enabled with the default Ruff settings.

::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Further Improve Code Style of Our Project

Select and fix a few of the issues with our code that Ruff detected.
You can try using the Ruff's `--fix` command-line option to automatically fix
(some of) the issues. If you manually edit the code, make sure you do not break
the rest of the code in the process and that the code still runs.
After making any changes, run Ruff again to verify you have resolved these issues.

::::::::::::::::::::::::::::::::::::::::::::::::::

Make sure you commit and push `requirements.txt`, `pyproject.toml`,
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
$ git add requirements.txt pyproject.toml
$ git commit -m "Added Ruff library"
$ git push origin style-fixes
$ git switch develop
$ git merge style-fixes
$ git push origin develop
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Optional Exercise: Improve Code Style of Your Other Python Projects

If you have a Python project you are working on or you worked on in the past,
run it past Ruff to see what issues with your code are detected, if any.

::::::::::::::::::::::::::::::::::::::::::::::::::

::: challenge

## Optional Exercise: More on Ruff

Checkout [this optional exercise](17-section1-optional-exercises.md)
to learn more about `ruff`.

:::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use linting tools on the command line (or via continuous integration) to automatically check your code style.

::::::::::::::::::::::::::::::::::::::::::::::::::


