---
title: "Software Architecture"
teaching: 15
exercises: 50
questions:
- "What is software architecture?"
- "What are components of Model-View-Controller (MVC) architecture?"
objectives:
- "Understand the use of common design patterns to improve the extensibility, reusability and 
overall quality of software."
- "List some best practices when designing software."
keypoints:
- "Try to leave the code in a better state that you found it."
---


## Software Architecture

A software architecture is the fundamental structure of a software system
that is typically decided at the beginning of project development
based on its requirements and is not that easy to change once implemented.
It refers to a "bigger picture" of a software system
that describes high-level components (modules) of the system, what their functionality/roles are 
and how they interact.

There are various [software architectures](/software-architecture-extra/index.html) around defining different ways of
dividing the code into smaller modules with well defined roles that are outside the scope of 
this course.
We have been developing our software using the **Model-View-Controller** (MVC) architecture,
but, MVC is just one of the common architectural patterns
and is not the only choice we could have made.

### Model-View-Controller (MVC) Architecture
MVC architecture divides the related program logic
into three interconnected modules:

- **Model** (data)
- **View** (client interface),  and
- **Controller** (processes that handle input/output and manipulate the data).

Model represents the data used by a program and also contains operations/rules
for manipulating and changing the data in the model.
This may be a database, a file, a single data object or a series of objects -
for example a table representing patients' data.

View is the means of displaying data to users/clients within an application
(i.e. provides visualisation of the state of the model).
For example, displaying a window with input fields and buttons (Graphical User Interface, GUI)
or textual options within a command line (Command Line Interface, CLI) are examples of Views.
They include anything that the user can see from the application.
While building GUIs is not the topic of this course,
we do cover building CLIs (handling command line arguments) in Python to a certain extent.

Controller manipulates both the Model and the View.
It accepts input from the View
and performs the corresponding action on the Model (changing the state of the model)
and then updates the View accordingly.
For example, on user request,
Controller updates a picture on a user's GitHub profile
and then modifies the View by displaying the updated profile back to the user.

### Separation of Responsibilities

Separation of responsibilities is important when designing software architectures
in order to reduce the code's complexity and increase its maintainability.
Note, however, there are limits to everything -
and MVC architecture is no exception.
Controller often transcends into Model and View
and a clear separation is sometimes difficult to maintain.
For example, the Command Line Interface provides both the View
(what user sees and how they interact with the command line)
and the Controller (invoking of a command) aspects of a CLI application.
In Web applications, Controller often manipulates the data (received from the Model)
before displaying it to the user or passing it from the user to the Model.

There are many variants of an MVC-like pattern 
(such as [Model-View-Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP),
[Model-View-Viewmodel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) (MVVM), etc.),
where the Controller role is handled slightly differently, 
but in most cases, the distinction between these patterns is not particularly important.
What really matters is that we are making conscious decisions about the architecture of our software
that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we do not need to stick to them exactly.

The key thing to take away is the distinction between the Model and the View code, while
the View and the Controller can be more or less coupled together (e.g. the code that specifies 
there is a button on the screen, might be the same code that specifies what that button does).
The View may be hard to test, or use special libraries to draw the UI, but should not contain any 
complex logic, and is really just a presentation layer on top of the Model.
The Model, conversely, should not care how the data is displayed. 
For example, the View may present dates as "Monday 24th July 2023", 
but the Model stores it using a `Date` object rather than its string representation.

## Our Project's Architecture (Revisited)

Recall that in our software project, the **Controller** module is in `inflammation-analysis.py`, 
and the View and Model modules are contained in 
`inflammation/views.py` and `inflammation/models.py`, respectively.
Data underlying the Model is contained within the directory `data`.

Looking at the code in the branch `full-data-analysis` (where we should be currently located),
we can notice that the new code was added in a separate script `inflammation/compute_data.py` and 
contains a mix of Model, View and Controller code.

> ## Exercise: Identify Model, View and Controller Parts of the Code
> Looking at the code inside `compute_data.py`, what parts could be considered 
> Model, View and Controller code?
>
>> ## Solution
>> * Computing the standard deviation belongs to Model.
>> * Reading the data from CSV files also belongs to Model.
>> * Displaying of the output as a graph is View.
>> * The logic that processes the supplied files is Controller.
> {: .solution}
{: .challenge}

Within the Model further separations make sense.
For example, as we did in the before, separating out the impure code that interacts with 
the file system from the pure calculations helps with readability and testability.
Nevertheless, the MVC architectural pattern is a great starting point when thinking about 
how you should structure your code.

> ## Exercise: Split out the Model, View and Controller Code
> Refactor `analyse_data()` function so that the Model, View and Controller code 
> we identified in the previous exercise is moved to appropriate modules.
>> ## Solution
>> The idea here is for the `analyse_data()` function not to have any "view" considerations.
>> That is, it should just compute and return the data and 
>> should be located in `inflammation/models.py`.
>>
>> ```python
>> def analyse_data(data_source):
>>     """Calculate the standard deviation by day between datasets
>>     Gets all the inflammation csvs within a directory, works out the mean
>>     inflammation value for each day across all datasets, then graphs the
>>     standard deviation of these means."""
>>     data = data_source.load_inflammation_data()
>>     daily_standard_deviation = compute_standard_deviation_by_data(data)
>>
>>     return daily_standard_deviation
>> ```
>> There can be a separate bit of code in the Controller `inflammation-analysis.py` 
>> that chooses how data should be presented, e.g. as a graph:
>>
>> ```python
>> if args.full_data_analysis:
>>   _, extension = os.path.splitext(InFiles[0])
>>   if extension == '.json':
>>     data_source = JSONDataSource(os.path.dirname(InFiles[0]))
>>   elif extension == '.csv':
>>     data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>>   else:
>>     raise ValueError(f'Unsupported file format: {extension}')
>>   data_result = analyse_data(data_source)
>>   graph_data = {
>>     'standard deviation by day': data_result,
>>   }
>>   views.visualize(graph_data)
>>   return
>> ```
>> Note that this is, more or less, the change we did to write our regression test.
>> This demonstrates that splitting up Model code from View code can
>> immediately make your code much more testable.
>> Ensure you re-run our regression test to check this refactoring has not
>> changed the output of `analyse_data()`.
> {: .solution}
{: .challenge}

At this point, you have refactored and tested all the code on branch `full-data-analysis`
and it is working as expected. The branch is ready to be incorporated into `develop`
and then, later on, `main`, which may also have been changed by other developers working on
the code at the same time so make sure to update accordingly or resolve any conflicts.

~~~
$ git switch develop
$ git merge full-data-analysis
~~~
{: .language-bash}

Let's now have a closer look at our Controller, and how can handling command line arguments in Python
(which is something you may find yourself doing often if you need to run the code from a 
command line tool).

### Controller Structure

You will have noticed already that structure of the `inflammation-analysis.py` file
follows this pattern:

~~~
# import modules

def main(args):
    # perform some actions

if __name__ == "__main__":
    # perform some actions before main()
    main(args)
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

This returns an object (that we have called `args`) containing all the arguments requested.
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
    For example, the order can be either  "optional, positional" or "positional, optional",
    but not "optional, positional, optional".
> 2. Positional arguments must be given in the order that they are shown
in the usage section of the help page.
{: .callout}

## Architecting Software

When designing a new software application, or making a substantial change to an existing one,
it can be really helpful to sketch out the intended architecture.
The basic idea is you draw boxes that will represent different units of code, as well as
other components of the system (such as users, databases, etc).
Then connect these boxes with lines where information or control will be exchanged.
These lines represent the interfaces in your system.

As well as helping to visualise the work, doing this sketch can troubleshoot potential issues.
For example, if there is a circular dependency between two sections of the design.
It can also help with estimating how long the work will take, as it forces you to consider all 
the components that need to be made.

Diagrams are not foolproof, but are a great starting point to break down the different 
responsibilities and think about the kinds of information different parts of the system will need.

> ## Exercise: Design a High-Level Architecture for a New Requirement
> Sketch out an architectural design for a new feature requested by a user.
>
> *"I want there to be a Google Drive folder such that when I upload new inflammation data to it,
> the software automatically pulls it down and updates the analysis.
> The new result should be added to a database with a timestamp.
> An email should then be sent to a group mailing list notifying them of the change."*
>
> You can  draw by hand on a piece of paper or whiteboard, or use an online drawing tool 
> such as [Excalidraw](https://excalidraw.com/).
>> ## Solution
>>
>> ![Diagram showing proposed architecture of the problem](../fig/example-architecture-diagram.svg){: width="600px" }
> {: .solution}
{: .challenge}

### Architectural & Programming Patterns

[Architectural]((https://www.redhat.com/architect/14-software-architecture-patterns)) and 
[programming patterns](https://refactoring.guru/design-patterns/catalog) are reusable templates for 
software systems and code that provide solutions for some common software design challenges. 
MVC is one architectural pattern. 
Patterns are a useful starting point for how to design your software and also provide 
a common vocabulary for discussing software designs with other developers.
They may not always provide a full design solution as some problems may require
a bespoke design that maps cleanly on to the specific problem you are trying to solve.

### Design Guidelines

Creating good software architecture is not about applying any rules or patterns blindly, 
but instead practise and taking care to:

* Discuss design with your colleagues before writing the code.
* Separate different concerns into different sections of the code.
* Avoid duplication of code or data.
* Keep how much a person has to understand at once to a minimum.
* Try not to have too many abstractions (if you have to jump around a lot when reading the 
code that is a clue that your code may be too abstract).
* Think about how interfaces will work (?).
* Not try to design a future-proof solution or to anticipate future requirements or adaptations 
of the software - design the simplest solution that solves the problem at hand.
* (When working on a less well-structured part of the code), start by refactoring it so that your 
change fits in cleanly.
* Try to leave the code in a better state that you found it.


### Additional Reading Material & References

Now that we have covered the basics of [software architecture](/software-architecture-extra/index.html) 
and [different programming paradigms](/programming-paradigms/index.html)
and how we can integrate them into our multi-layer architecture,
there are two optional extra episodes which you may find interesting.

Both episodes cover the persistence layer of software architectures
and methods of persistently storing data, but take different approaches.
The episode on [persistence with JSON](../persistence) covers
some more advanced concepts in Object Oriented Programming, while
the episode on [databases](../databases) starts to build towards a true multilayer architecture,
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
Let's have a look at some code review techniques available to us.

{% include links.md %}
