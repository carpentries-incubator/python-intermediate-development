---
title: "Architecture Revisited: Extending Software"
teaching: 15
exercises: 0
questions:
- "How can we extend our software within the constraints of the MVC architecture?"
objectives:
- "Extend our software to add a view of a single patient in the study and the software's command line interface to request a specific view."
keypoints:
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change.
  Such components can be as small as a single function, or be a software package in their own right."
---

As we have seen, we have different programming paradigms that are suitable for different problems
and affect the structure of our code.
In programming languages that support multiple paradigms, such as Python,
we have the luxury of using elements of different paradigms paradigms and we,
as software designers and programmers,
can decide how to use those elements in different architectural components of our software.
Let's now circle back to the architecture of our software for one final look.

## MVC Revisited

We've been developing our software using the **Model-View-Controller** (MVC) architecture so far,
but, as we have seen, MVC is just one of the common architectural patterns
and is not the only choice we could have made.

There are many variants of an MVC-like pattern (such as
[Model-View-Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP),
[Model-View-Viewmodel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) (MVVM), etc.),
but in most cases, the distinction between these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software
that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

In this episode we'll be taking our Object Oriented code from the previous episode
and integrating it into our existing MVC pattern.
But first we will explain some features of
the Controller (`inflammation-analysis.py`) component of our architecture.

### Controller Structure

You will have noticed already that structure of the `inflammation-analysis.py` file
follows this pattern:

~~~
# import modules

def main():
    # perform some actions

if __name__ == "__main__":
    # perform some actions before main()
    main()
~~~
{: .language-python}

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

~~~
$ python3 inflammation-analysis.py
~~~
{: .language-bash}

then the interpreter will assign the hard-coded string `"__main__"` to the `__name__` variable:

~~~
__name__ = "__main__"
...
# rest of your code
~~~
{: .language-python}

However, if your source file is imported by another Python script, e.g:

~~~
import inflammation-analysis
~~~
{: .language-python}

then the interpreter will assign the name `"inflammation-analysis"`
from the import statement to the `__name__` variable:

~~~
__name__ = "inflammation-analysis"
...
# rest of your code
~~~
{: .language-python}

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

~~~
import argparse
~~~
{: .language-python}

We then initialise the argument parser class, passing an (optional) description of the program:

~~~
parser = argparse.ArgumentParser(
    description='A basic patient inflammation data management system')
~~~
{: .language-python}

Once the parser has been initialised we can add
the arguments that we want argparse to look out for.
In our basic case, we want only the names of the file(s) to process:

~~~
parser.add_argument(
    'infiles',
    nargs='+',
    help='Input CSV(s) containing inflammation series for each patient')
~~~
{: .language-python}

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

~~~
args = parser.parse_args()
~~~
{: .language-python}

This returns an object (that we've called `arg`) containing all the arguments requested.
These can be accessed using the names that we have defined for each argument,
e.g. `args.infiles` would return the filenames that have been input.

The help for the script can be accessed using the `-h` or `--help` optional argument
(which `argparse` includes by default):

~~~
$ python3 inflammation-analysis.py --help
~~~
{: .language-bash}

~~~
usage: inflammation-analysis.py [-h] infiles [infiles ...]

A basic patient inflammation data management system

positional arguments:
  infiles     Input CSV(s) containing inflammation series for each patient

optional arguments:
  -h, --help  show this help message and exit
~~~
{: .output}

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

> ## Positional and Optional Argument Order
>
> The usage section of the help page above shows
> the optional arguments going before the positional arguments.
> This is the customary way to present options, but is not mandatory.
> Instead there are two rules which must be followed for these arguments:
>
> 1. Positional and optional arguments must each be given all together, and not inter-mixed.
>    For example, the order can be either `optional - positional` or `positional - optional`,
>    but not `optional - positional - optional`.
> 2. Positional arguments must be given in the order that they are shown
>    in the usage section of the help page.
{: .callout}

Now that you have some familiarity with `argparse`,
we will demonstrate below how you can use this to add extra functionality to your controller.

### Adding a New View

Let's start with adding a view that allows us to see the data for a single patient.
First, we need to add the code for the view itself
and make sure our `Patient` class has the necessary data -
including the ability to pass a list of measurements to the `__init__` method.
Note that your Patient class may look very different now,
so adapt this example to fit what you have.

~~~
# file: inflammation/views.py

...

def display_patient_record(patient):
    """Display data for a single patient."""
    print(patient.name)
    for obs in patient.observations:
        print(obs.day, obs.value)
~~~
{: .language-python}

~~~
# file: inflammation/models.py

...

class Observation:
    def __init__(self, day, value):
        self.day = day
        self.value = value

    def __str__(self):
        return self.value

class Person:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Patient(Person):
    """A patient in an inflammation study."""
    def __init__(self, name, observations=None):
        super().__init__(name)

        self.observations = []
        ### MODIFIED START ###
        if observations is not None:
            self.observations = observations
        ### MODIFIED END ###

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1].day + 1

            except IndexError:
                day = 0

        new_observation = Observation(day, value)

        self.observations.append(new_observation)
        return new_observation
~~~
{: .language-python}

Now we need to make sure people can call this view -
that means connecting it to the controller
and ensuring that there's a way to request this view when running the program.
The changes we need to make here are that the `main` function
needs to be able to direct us to the view we've requested -
and we need to add to the command line interface - the controller -
the necessary data to drive the new view.

~~~
# file: inflammation-analysis.py

#!/usr/bin/env python3
"""Software for managing patient data in our imaginary hospital."""

import argparse

from inflammation import models, views


def main(args):
    """The MVC Controller of the patient data system.

    The Controller is responsible for:
    - selecting the necessary models and views for the current task
    - passing data between models and views
    """
    infiles = args.infiles
    if not isinstance(infiles, list):
        infiles = [args.infiles]

    for filename in infiles:
        inflammation_data = models.load_csv(filename)

        ### MODIFIED START ###
        if args.view == 'visualize':
            view_data = {
                'average': models.daily_mean(inflammation_data),
                'max': models.daily_max(inflammation_data),
                'min': models.daily_min(inflammation_data),
            }

            views.visualize(view_data)

        elif args.view == 'record':
            patient_data = inflammation_data[args.patient]
            observations = [models.Observation(day, value) for day, value in enumerate(patient_data)]
            patient = models.Patient('UNKNOWN', observations)

            views.display_patient_record(patient)
        ### MODIFIED END ###


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='A basic patient data management system')

    parser.add_argument(
        'infiles',
        nargs='+',
        help='Input CSV(s) containing inflammation series for each patient')

    ### MODIFIED START ###
    parser.add_argument(
        '--view',
        default='visualize',
        choices=['visualize', 'record'],
        help='Which view should be used?')

    parser.add_argument(
        '--patient',
        type=int,
        default=0,
        help='Which patient should be displayed?')
    ### MODIFIED END ###

    args = parser.parse_args()

    main(args)
~~~
{: .language-python}

We've added two options to our command line interface here:
one to request a specific view and one for the patient ID that we want to lookup.
For the full range of features that we have access to with `argparse` see the
[Python module documentation](https://docs.python.org/3/library/argparse.html?highlight=argparse#module-argparse).
Allowing the user to request a specific view like this is
a similar model to that used by the popular Python library Click -
if you find yourself needing to build more complex interfaces than this,
Click would be a good choice.
You can find more information in [Click's documentation](https://click.palletsprojects.com/).

For now, we also don't know the names of any of our patients,
so we've made it `'UNKNOWN'` until we get more data.

We can now call our program with these extra arguments to see the record for a single patient:

~~~
$ python3 inflammation-analysis.py --view record --patient 1 data/inflammation-01.csv
~~~
{: .language-bash}

~~~
UNKNOWN
0 0.0
1 0.0
2 1.0
3 3.0
4 1.0
5 2.0
6 4.0
7 7.0
...
~~~
{: .output}

> ## Additional Material
>
> Now that we've covered the basics of different programming paradigms
> and how we can integrate them into our multi-layer architecture,
> there are two optional extra episodes which you may find interesting.
>
> Both episodes cover the persistence layer of software architectures
> and methods of persistently storing data, but take different approaches.
> The episode on [persistence with JSON](/persistence) covers
> some more advanced concepts in Object Oriented Programming, while
> the episode on [databases](/databases) starts to build towards a true multilayer architecture,
> which would allow our software to handle much larger quantities of data.
{: .callout}


## Towards Collaborative Software Development

Having looked at some theoretical aspects of software design,
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
Let's have a look at some code review techniques available to us.
