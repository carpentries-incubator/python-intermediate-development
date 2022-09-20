---
title: "Software Architecture and Design"
teaching: 15
exercises: 30
questions:
- "Where do we start when beginning a new software project?"
- "How can we make sure the components of our software are reusable?"
objectives:
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Understand the use of common design patterns to improve the extensibility, reusability and overall quality of software."
- "Understand the components of MVC and multi-layer architectures."
keypoints:
- "Planning software projects in advance can save a lot of effort and reduce 'technical debt' later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change. 
Such components can be as small as a single function, or be a software package in their own right."
- "When writing software used for research, requirements will almost *always* change."
- "*'Good code is written so that is readable, understandable, covered by automated tests, not over complicated and does well what is intended to do.'*"
---

## Introduction

In this episode, we'll be looking at how we can design our software to ensure it meets the requirements, but also retains the other qualities of good software.
As a piece of software grows, it will reach a point where there's too much code for us to keep in mind at once.
At this point, it becomes particularly important that the software be designed sensibly.
What should be the overall structure of our software, how should all the pieces of functionality fit together, and how should we work towards fulfilling this overall design throughout development?

It's not easy come up with a complete definition for the term **software design**, but some of the common aspects are:

- **Algorithm design** - what method are we going to use to solve the core business problem?
- **Software architecture** - what components will the software have and how will they cooperate?
- **System architecture** - what other things will this software have to interact with and how will it do this?
- **UI/UX** (User Interface / User Experience) - how will users interact with the software?

As usual, the sooner you adopt a practice in the lifecycle of your project, the easier it will be.
So we should think about the design of our software from the very beginning, ideally even before we start writing code - but if you didn't, it's never too late to start.


The answers to these questions will provide us with some **design constraints** which any software we write must satisfy.
For example, a design constraint when writing a mobile app would be that it needs to work with a touch screen interface - we might have some software that works really well from the command line, but on a typical mobile phone there isn't a command line interface that people can access.


## Software Architecture

At the beginning of this episode we defined **Software Architecture** with the question, "what components will the software have and how will they cooperate?"
Software engineering borrowed this term, and a few other terms, from architects (of buildings) as many of the processes and techniques have some similarities.

One of the other important terms we borrowed is **'Pattern'**, such as in **Design Patterns** and **Architecture Patterns**.
This term is often attributed to the book ['A Pattern Language' by Christopher Alexander *et al.*](https://en.wikipedia.org/wiki/A_Pattern_Language) published in 1977 and refers to a template solution to a problem commonly encountered when building a system.

Design patterns are relatively small-scale templates which we can use to solve problems which affect a small part of our software.
For example, the [Adapter pattern](https://en.wikipedia.org/wiki/Adapter_pattern) (which allows a class that does not 
have the "right interface" to be reused)
may be useful if part of our software needs to consume data from a number of different external data sources.
Using this pattern, we can create a component whose responsibility is transforming the calls for data to the expected format, so the rest of our program doesn't have to worry about it.

Architecture patterns are similar, but larger scale templates which operate at the level of whole programs, or collections or programs.
Model-View-Controller is one of the best known architecture patterns.

There are many online sources of information about design and architecture patterns, often giving concrete examples of cases where they may be useful.
One particularly good source is [Refactoring Guru](https://refactoring.guru/design-patterns).

### MVC Revisited

**Model-View-Controller** (MVC) is just one of the common architectural patterns.
We've been developing our software using a Model-View-Controller (MVC) architecture so far, but that's not the only choice we could have made.

There are many variants of an MVC-like pattern (such as [Model-View-Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP), [Model-View-Viewmodel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) (MVVM), etc.), but in most cases, the distinction between these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

Let's start with adding a view that allows us to see the data for a single patient.
First, we need to add the code for the view itself and make sure our `Patient` class has the necessary data - including the ability to pass a list of measurements to the `__init__` method.
Note that your Patient class may look very different now, so adapt this example to fit what you have.

~~~ python
# file: inflammation/views.py

...

def display_patient_record(patient):
    """Display data for a single patient."""
    print(patient.name)
    for obs in patient.observations:
        print(obs.day, obs.value)
~~~
{: .language-python}

~~~ python
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
        if observations is not None:
            self.observations = observations

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1].day + 1

            except IndexError:
                day = 0

        new_observation = Observation(value, day)

        self.observations.append(new_observation)
        return new_observation
~~~
{: .language-python}

Now we need to make sure people can call this view - that means connecting it to the controller and ensuring that there's a way to request this view when running the program.
The changes we need to make here are that the `main` function needs to be able to direct us to the view we've requested - and we need to add to the command line interface the necessary data to drive the new view.

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


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='A basic patient data management system')

    parser.add_argument(
        'infiles',
        nargs='+',
        help='Input CSV(s) containing inflammation series for each patient')

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

    args = parser.parse_args()

    main(args)
~~~
{: .language-python}

We've added two options to our command line interface here: one to request a specific view and one for the patient ID that we want to lookup.
For the full range of features that we have access to with `argparse` see the [Python module documentation](https://docs.python.org/3/library/argparse.html?highlight=argparse#module-argparse).
Allowing the user to request a specific view like this is a similar model to that used by the popular Python library Click - if you find yourself needing to build more complex interfaces than this, Click would be a good choice.
You can find more information in [Click's documentation](https://click.palletsprojects.com/).

For now, we also don't know the names of any of our patients, so we've made it `'UNKNOWN'` until we get more data.

We can now call our program with these extra arguments to see the record for a single patient:

~~~
python3 inflammation-analysis.py --view record --patient 1 data/inflammation-01.csv
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

### Multilayer Architecture

Another common architectural pattern is **Multilayer Architecture**.
Software designed using this architecture pattern is split into layers, each of which is responsible for a different part of the process of manipulating data.

Often, the software is split into three layers:

- **Presentation Layer**
  - This layer is responsible for managing the interaction between our software and the people using it
  - Similar to the **View** component in the MVC pattern
- **Application Layer / Business Logic Layer**
  - This layer performs most of the data processing required by the presentation layer
  - Could be in any part of an MVC-style architecture, but most commonly the **Model**
- **Persistence Layer / Data Access Layer**
  - This layer handles data storage and provides data to the rest of the system
  - Has some overlap with the MVC **Model**

## Addressing New Requirements

So far in this episode we've extended our application - designed around an MVC architecture - with a new view to see a patient's data.
Let's now take a step back to the solution requirements we discussed in the previous episode:

- *Functional Requirements* focus on functions and features of a solution. For our software, building on our user requirements, e.g.:
  - SR1.1.1 (from UR1.1): add standard deviation to data model and include in graph visualisation view
  - SR1.2.1 (from UR1.2): add a new view to generate a textual representation of statistics, which is invoked by an optional command line argument
- *Non-functional Requirements* focus on *how* the behaviour of a solution is expressed or constrained, e.g. performance, security, usability, or portability. These are also known as *quality of service* requirements. For our project, e.g.:
  - SR2.1.1 (from UR2.1): generate graphical statistics report on clinical workstation configuration in under 30 seconds

## How Should I Test *This*?

Sometimes when we make changes to our code that we plan to test later, we find the way we've implemented that change doesn't lend itself well to how it should be tested. So what should we do?

Consider requirement SR1.2.1 - we have (at least) two things we should test in some way, for which we could write unit tests. For the textual representation of statistics, in a unit test we could invoke our new view function directly with known inflammation data and test the text output as a string against what is expected. The second one, invoking this new view with an optional command line argument, is more problematic since the code isn't structured in a way where we can easily invoke the argument parsing portion to test it. To make this more amenable to unit testing we could move the command line parsing portion to a separate function, and use that in our unit tests. So in general, it's a good idea to make sure your software's features are modularised and accessible via logical functions.

We could also consider writing unit tests for SR2.1.1, ensuring that the system meets our performance requirement, so should we? We do need to verify it's being met with the modified implementation, however it's generally considered bad practice to use unit tests for this purpose. This is because unit tests test *if* a given aspect is behaving correctly, whereas performance tests test *how efficiently* it does it. Performance testing produces measurements of performance which require a different kind of analysis (using techniques such as [*code profiling*](https://towardsdatascience.com/how-to-assess-your-code-performance-in-python-346a17880c9f)), and require careful and specific configurations of operating environments to ensure fair testing. In addition, unit testing frameworks are not typically designed for conducting such measurements, and only test units of a system, which doesn't give you an idea of performance of the system as it is typically used by stakeholders.

The key is to think about which kind of testing should be used to check if the code satisfies a requirement, but also what you can do to make that code amenable to that type of testing.

> ## Exercise: Implementing Requirements
> 
> Pick one of the requirements SR1.1.1 or SR1.1.2 above to implement and create an appropriate feature branch - 
> e.g. `add-std-dev` or `add-view`.
> 
> One aspect you should consider first is whether the new requirement can be implemented within the existing design. If not, how does the design need to be changed to accommodate the inclusion of this new feature? Also try to ensure that the changes you make are amenable to unit testing: is the code suitably modularised such that the aspect under test can be easily invoked with test input data and its output tested?
> 
> If you have time, feel free to implement the other requirement, or invent your own!
> 
> **Note: do not add the tests for the new feature just yet - even though you would normally add the tests along 
> with the new code, we will do this in a later episode. Equally, do not merge your changes to the 
> `develop` branch just yet.**
{: .challenge}

## Best Practices for 'Good' Software Design

Aspirationally, what makes good code can be summarised in the following quote from the [Intent HG blog](https://intenthq.com/blog/it-audience/what-is-good-code-a-scientific-definition/):

> *“Good code is written so that is readable, understandable, covered by automated tests, not over complicated and
> does well what is intended to do.”*

By taking time to design our software to be easily modifiable and extensible, we can save ourselves a lot of time later when requirements change.
The sooner we do this the better - ideally we should have at least a rough design sketched out for our software before we write a single line of code.
This design should be based around the structure of the problem we're trying to solve: what are the concepts we need to represent and what are the relationships between them.
And importantly, who will be using our software and how will they interact with it?

Here's another way of looking at it.

Not following good software design and development practices can lead to accumulated 'technical debt', which (according to [Wikipedia](https://en.wikipedia.org/wiki/Technical_debt)), is the "cost of additional rework caused by choosing an easy (limited) solution now
instead of using a better approach that would take longer". So, the pressure to achieve project goals 
can sometimes lead to quick and easy solutions, which make the software become more messy, more complex, 
more difficult to understand and maintain. The extra effort required to make 
changes in the future is the interest paid on the (technical) debt. It's natural for software to accrue some 
technical debt, but it's important to pay off that debt during a
maintenance phase - simplifying, clarifying the code, making it easier to understand -
to keep these interest payments on making changes manageable. If this isn't done, the software may accrue too much
technical debt, and it can become too messy and prohibitive to maintain and develop, and then it cannot evolve.

Importantly, there is only so much time available. How much effort should we spend on designing our code properly and using good development practices? The following [XKCD comic](https://xkcd.com/844/) summarises this tension:

![Writing good code comic](../fig/xkcd-good-code-comic.png){: .image-with-shadow width="400px" }

At an intermediate level there are a wealth of practices that *could* be used, and applying suitable design and coding practices is what separates an *intermediate developer* from someone who has just started coding. The key for an intermediate developer is to balance these concerns for each software project appropriately, and employ design and development practices *enough* so that progress can be made. It's very easy to under-design software, but remember it's also possible to over-design software too.

One practice that should always be considered, and has been shown to be very effective in team-based 
software development, is that of *code review*. Code reviews help to ensure the 'good' coding standards are achieved 
and maintained within a team by having multiple people have a look and comment on key code changes to see how they fit 
within the codebase. Such reviews check the correctness of the new code, test coverage, functionality changes, 
and confirm that they follow the coding guides and best practices. Let's have look at some code review techniques 
available to us.

{% include links.md %}
