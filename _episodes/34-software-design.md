---
title: "Software Design"
teaching: 15
exercises: 20
questions:
- "Where do we start when beginning a new software project?"
- "How do people use software?"
- "How can we make sure the components of our software are reusable?"
- "How do we add components to an MVC application?"
objectives:
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Identify common components of multi-layer software projects."
- "Better understand the components of an MVC architecture."
keypoints:
- "Planning software projects in advance can save a lot of effort later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change."
- "These components can be as small as a single function, or be a software package in their own right."
- "When writing software used for research, requirements *always* change."
---

## Introduction

As a piece of software grows, it will reach a point where there's too much code for you to keep in mind at once.
At this point, it becomes particularly important that the software be designed sensibly.

It's not easy come up with a complete definition for the term **software design**, but some of the common aspects are:

- **Algorithm design** - What method are we going to use to solve the core business problem?
- **Software architecture** - What components will the software have and how will they cooperate?
- **System architecture** - What other things will this software have to interact with and how?
- **UI/UX** (User Interface / User Experience) - How will users interact with the software?

As usual, the sooner you adopt a practice in the lifecycle of your project, the easier it will be.
So we should think about the design of our software from the very beginning, ideally even before we start writing code - but if you didn't, it's never too late to start.

## Types of Software

Before we start writing code, we would like to have a reasonable idea of who will be using our software and what they want it to do.

This is often difficult, particularly when developing software for research, because the users and their needs can change with very little warning.
Maybe we have an idea for a new research project that could use our existing code, or maybe a research group at another institution wants to use it to support their work in a slightly different environment.

Despite this potential for change, there are a few characteristics of a piece of software which tend to remain fixed.
Some of the most important questions you should ask when beginning a new software project are:

- Where does it run?
- How do you interact with it?
- Why do you use it?

The answers to these questions will provide us with some **design constraints** which any software we write must satisfy.
For example, a design constraint when writing a mobile app would be that it needs to work with a touch screen interface - we might have some software that works really well from the command line, but on a typical mobile phone there isn't a command line interface that people can access.

> ## Types of Software
>
> Many design choices in a software project depend on the environment in which the software is expected to run.
>
> Think about some software you are familiar with (could be software you have written yourself or by someone else) and how the environment it is used in have affected its design or development.
> Here are some examples of questions you can use to get started:
>
> - What environment does the software run in?
> - How do people interact with it?
> - Why do people use it?
> - What features of the software have been affected by these factors?
> - If the software needed to be used in a different environment, what difficulties might there be?
>
> Some examples of design / development choices constrained by environment might be:
>
> - Mobile Apps
>   - Must have graphical interface suitable for a touch display
>   - Usually distributed via controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications with a range of Operating System (OS) versions
>     - But OS is unlikely to be anything other than Android or iOS
>   - Documentation probably in the software itself or on web page
>   - Typically written in one of the platform preferred languages (e.g. Java, Kotlin, Swift)
> - Embedded Software
>   - May have no user interface - user interface may be physical buttons
>   - Usually distributed pre-installed on physical device
>   - Often runs on low power device with limited memory and CPU performance - must take care to use these resources efficiently
>   - Exact specification of hardware is known - often not necessary to support multiple devices
>   - Documentation probably in technical manual with separate user manual
>   - May need to run continuously for the lifetime of the device
>   - Typically written in a lower-level language (e.g. C) for better control of resources
>
> > ## Some More Examples
> >
> > - Desktop Application
> >   - Has graphical interface for use with mouse and keyboard
> >   - May need to work on multiple, very different Operating Systems
> >   - May be intended for users to modify / compile themselves
> >   - Should work on wide range of hardware configurations
> >   - Documentation probably either in manual or in software itself
> > - Command-line Application - UNIX Tool
> >   - User interface is text based, probably via command-line arguments
> >   - Intended to be modified / compiled by users - though most will choose not to
> >   - Documentation has standard formats - also accessible from command-line
> >   - Should be usable as part of a pipeline
> > - Command-line Application - High Performance Computing
> >   - Similar to UNIX Tool
> >   - Usually supports running across multiple networked machines simultaneously
> >   - Usually operated via scheduler - interface should be scriptable
> >   - May need to run on wide range of hardware (e.g. different CPU architectures)
> >   - May need to process large amounts of data
> >   - Often entirely or partially written in a lower-level language for performance (e.g. C, C++, Fortran)
> > - Web Application
> >   - Usually has components which run on server and components which run on the user's device
> >   - Graphical interface should usually support both Desktop and Mobile devices
> >   - Clientside component should run on range of browsers and Operating Systems
> >   - Documentation probably part of the software itself
> >   - Clientside component typically written in JavaScript
> {: .solution}
{: .challenge}

## Software Architecture

At the beginning of this episode we defined **Software Architecture** with the question, "what components will the software have and how will they cooperate?"
Software engineering borrowed this term, and a few other terms, from architects (of buildings) as many of the processes and techniques have some similarities.

One of the other important terms we borrowed is **'Pattern'**, such as in **Design Patterns** and **Architecture Patterns**.
This term is often attributed to the book 'A Pattern Language' by Christopher Alexander *et al* published in 1977 and refers to a template solution to a problem commonly encountered when building a system.

Design patterns are relatively small-scale templates which we can use to solve problems which affect a small part of our software.
For example, the Adapter pattern may be useful if part of our software needs to consume data from a number of different external data sources.
Using this pattern, we can create a component whose responsibility is transforming the calls for data to the expected format, so the rest of our program doesn't have to worry about it.

Architecture patterns are similar, but larger scale templates which operate at the level of whole programs, or collections or programs.
Model-View-Controller is one of the best known architecture patterns.

There are many online sources of information about design and architecture patterns, often giving concrete examples of cases where they may be useful.
One particularly good source is [Refactoring Guru](https://refactoring.guru/design-patterns).

### MVC Revisted

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

In the next section we'll be looking at one method we might choose to help us manage our data storage.

{% include links.md %}
