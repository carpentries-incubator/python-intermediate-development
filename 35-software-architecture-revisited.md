---
title: 3.5 Software Architecture Revisited
teaching: 15
exercises: 30
---

::::::::::::::::::::::::::::::::::::::: objectives

- Analyse new code to identify Model, View, Controller aspects.
- Refactor new code to conform to an MVC architecture.
- Adapt our existing code to include the new re-architected code.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How do we handle code contributions that do not fit within our existing architecture?

::::::::::::::::::::::::::::::::::::::::::::::::::

In the previous few episodes we have looked at the importance and principles of good software architecture and design,
and how techniques such as code abstraction and refactoring fulfil that design within an implementation,
and help us maintain and improve it as our code evolves.

Let us now return to software architecture and consider how we may refactor some new code to fit within our existing MVC architectural design using the techniques we have learnt so far.

## Revisiting Our Software's Architecture

Recall that in our software project, the **Controller** module is in `inflammation-analysis.py`,
and the View and Model modules are contained in
`inflammation/views.py` and `inflammation/models.py`, respectively.
Data underlying the Model is contained within the directory `data`.

Looking at the code in the branch `full-data-analysis` (where we should be currently located),
we can notice that the new code was added in a separate script `inflammation/compute_data.py` and
contains a mix of Model, View and Controller code.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Identify Model, View and Controller Parts of the Code

Looking at the code inside `compute_data.py`, what parts could be considered
Model, View and Controller code?

:::::::::::::::  solution

## Solution

- Computing the standard deviation belongs to Model.
- Reading the data from CSV files also belongs to Model.
- Displaying of the output as a graph is View.
- The logic that processes the supplied files is Controller.
  
  

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

Within the Model further separations make sense.
For example, as we did in the before, separating out the impure code that interacts with
the file system from the pure calculations helps with readability and testability.
Nevertheless, the MVC architectural pattern is a great starting point when thinking about
how you should structure your code.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Split out the Model, View and Controller Code

Refactor `analyse_data()` function so that the Model, View and Controller code
we identified in the previous exercise is moved to appropriate modules.

:::::::::::::::  solution

## Solution

The idea here is for the `analyse_data()` function not to have any "view" considerations.
That is, it should just compute and return the data and
should be located in `inflammation/models.py`.

```python
def analyse_data(data_source):
    """Calculate the standard deviation by day between datasets
    Gets all the inflammation csvs within a directory, works out the mean
    inflammation value for each day across all datasets, then graphs the
    standard deviation of these means."""
    data = data_source.load_inflammation_data()
    daily_standard_deviation = compute_standard_deviation_by_data(data)

    return daily_standard_deviation
```

There can be a separate bit of code in the Controller `inflammation-analysis.py`
that chooses how data should be presented, e.g. as a graph:

```python
if args.full_data_analysis:
    _, extension = os.path.splitext(infiles[0])
    if extension == '.json':
        data_source = JSONDataSource(os.path.dirname(infiles[0]))
    elif extension == '.csv':
        data_source = CSVDataSource(os.path.dirname(infiles[0]))
    else:
        raise ValueError(f'Unsupported file format: {extension}')
    data_result = analyse_data(data_source)
    graph_data = {
        'standard deviation by day': data_result,
    }
    views.visualize(graph_data)
    return
```

Note that this is, more or less, the change we did to write our regression test.
This demonstrates that splitting up Model code from View code can
immediately make your code much more testable.
Ensure you re-run our regression test to check this refactoring has not
changed the output of `analyse_data()`.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

At this point, you have refactored and tested all the code on branch `full-data-analysis`
and it is working as expected. The branch is ready to be incorporated into `develop`
and then, later on, `main`, which may also have been changed by other developers working on
the code at the same time so make sure to update accordingly or resolve any conflicts.

```bash
$ git switch develop
$ git merge full-data-analysis
```

Let us now have a closer look at our Controller, and how can handling command line arguments in Python
(which is something you may find yourself doing often if you need to run the code from a
command line tool).

### Controller Structure

You will have noticed already that structure of the `inflammation-analysis.py` file
follows this pattern:

```python
# import modules

def main(args):
    # perform some actions

if __name__ == "__main__":
    # perform some actions before main()
    main(args)
```

In this pattern the actions performed by the script are contained within the `main` function
(which does not need to be called `main`,
but using this convention helps others in understanding your code).
The `main` function is then called within the `if` statement `__name__ == "__main__"`,
after some other actions have been performed
(usually the parsing of command-line arguments, which will be explained below).
`__name__` is a special dunder variable which is set,
along with a number of other special dunder variables,
by the python interpreter before the execution of any code in the source file.
What value is given by the interpreter to `__name__` is determined by
the manner in which it is loaded.

If we run the source file directly using the Python interpreter, e.g.:

```bash
$ python3 inflammation-analysis.py
```

then the interpreter will assign the hard-coded string `"__main__"` to the `__name__` variable:

```python
__name__ = "__main__"
...
# rest of your code
```

However, if your source file is imported by another Python script, e.g:

```python
import inflammation-analysis
```

then the interpreter will assign the name `"inflammation-analysis"`
from the import statement to the `__name__` variable:

```python
__name__ = "inflammation-analysis"
...
# rest of your code
```

Because of this behaviour of the interpreter,
we can put any code that should only be executed when running the script
directly within the `if __name__ == "__main__":` structure,
allowing the rest of the code within the script to be
safely imported by another script if we so wish.

While it may not seem very useful to have your controller script importable by another script,
there are a number of situations in which you would want to do this:

- for testing of your code, you can have your testing framework import the main script,
  and run special test functions which then call the `main` function directly;
- where you want to not only be able to run your script from the command-line,
  but also provide a programmer-friendly application programming interface (API) for advanced users.

### Passing Command-line Options to Controller

The standard Python library for reading command line arguments passed to a script is
[`argparse`](https://docs.python.org/3/library/argparse.html).
This module reads arguments passed by the system,
and enables the automatic generation of help and usage messages.
These include, as we saw at the start of this course,
the generation of helpful error messages when users give the program invalid arguments.

The basic usage of `argparse` can be seen in the `inflammation-analysis.py` script.
First we import the library:

```python
import argparse
```

We then initialise the argument parser class, passing an (optional) description of the program:

```python
parser = argparse.ArgumentParser(
    description='A basic patient inflammation data management system')
```

Once the parser has been initialised we can add
the arguments that we want argparse to look out for.
In our basic case, we want only the names of the file(s) to process:

```python
parser.add_argument(
    'infiles',
    nargs='+',
    help='Input CSV(s) containing inflammation series for each patient')
```

Here we have defined what the argument will be called (`'infiles'`) when it is read in;
the number of arguments to be expected
(`nargs='+'`, where `'+'` indicates that there should be 1 or more arguments passed);
and a help string for the user
(`help='Input CSV(s) containing inflammation series for each patient'`).

You can add as many arguments as you wish,
and these can be either mandatory (as the one above) or optional.
Most of the complexity in using `argparse` is in adding the correct argument options,
and we will explain how to do this in more detail below.

Finally we parse the arguments passed to the script using:

```python
args = parser.parse_args()
```

This returns an object (that we have called `args`) containing all the arguments requested.
These can be accessed using the names that we have defined for each argument,
e.g. `args.infiles` would return the filenames that have been input.

The help for the script can be accessed using the `-h` or `--help` optional argument
(which `argparse` includes by default):

```bash
$ python3 inflammation-analysis.py --help
```

```output
usage: inflammation-analysis.py [-h] infiles [infiles ...]

A basic patient inflammation data management system

positional arguments:
  infiles     Input CSV(s) containing inflammation series for each patient

optional arguments:
  -h, --help  show this help message and exit
```

The help page starts with the command line usage,
illustrating what inputs can be given (any within `[]` brackets are optional).
It then lists the **positional** and **optional** arguments,
giving as detailed a description of each as you have added to the `add_argument()` command.
Positional arguments are arguments that need to be included
in the proper position or order when calling the script.

Note that optional arguments are indicated by `-` or `--`, followed by the argument name.
Positional arguments are simply inferred by their position.
It is possible to have multiple positional arguments,
but usually this is only practical where all (or all but one) positional arguments
contains a clearly defined number of elements.
If more than one option can have an indeterminate number of entries,
then it is better to create them as 'optional' arguments.
These can be made a required input though,
by setting `required = True` within the `add_argument()` command.

:::::::::::::::::::::::::::::::::::::::::  callout

## Positional and Optional Argument Order

The usage section of the help page above shows
the optional arguments going before the positional arguments.
This is the customary way to present options, but is not mandatory.
Instead there are two rules which must be followed for these arguments:

1. Positional and optional arguments must each be given all together, and not inter-mixed.
  For example, the order can be either  "optional, positional" or "positional, optional",
  but not "optional, positional, optional".
2. Positional arguments must be given in the order that they are shown
  in the usage section of the help page.
  

::::::::::::::::::::::::::::::::::::::::::::::::::

### Additional Reading Material \& References

Now that we have covered and revisited [software architecture](../learners/software-architecture-extra.md)
and [different programming paradigms](../learners/programming-paradigms.md)
and how we can integrate them into our architecture,
there are two optional extra episodes which you may find interesting.

Both episodes cover the persistence layer of software architectures
and methods of persistently storing data, but take different approaches.
The episode on [persistence with JSON](../learners/persistence.md) covers
some more advanced concepts in Object Oriented Programming, while
the episode on [databases](../learners/databases.md) starts to build towards a true multilayer architecture,
which would allow our software to handle much larger quantities of data.

## Towards Collaborative Software Development

Having looked at some aspects of software design and architecture,
we are now circling back to implementing our software design
and developing our software to satisfy the requirements collaboratively in a team.
At an intermediate level of software development,
there is a wealth of practices that could be used,
and applying suitable design and coding practices is what separates
an intermediate developer from someone who has just started coding.
The key for an intermediate developer is to balance these concerns
for each software project appropriately,
and employ design and development practices enough so that progress can be made.

One practice that should always be considered,
and has been shown to be very effective in team-based software development,
is that of *code review*.
Code reviews help to ensure the 'good' coding standards are achieved
and maintained within a team by having multiple people
have a look and comment on key code changes to see how they fit within the codebase.
Such reviews check the correctness of the new code, test coverage, functionality changes,
and confirm that they follow the coding guides and best practices.
Let us have a look at some code review techniques available to us.



:::::::::::::::::::::::::::::::::::::::: keypoints

- Sometimes new, contributed code needs refactoring for it to fit within an existing codebase.
- Try to leave the code in a better state that you found it.

::::::::::::::::::::::::::::::::::::::::::::::::::


