---
title: "Software Design"
teaching: 30
exercises: 20
questions:
- "Where do we start when beginning a new software project?"
- "How do people use software?"
- "How can we make sure the components of our software are reusable?"
- "What should we do when our requirements change?"
objectives:
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
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
So we should think about the design of our software from the very beginning - ideally even before we start writing code.

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
> In small groups, discuss some software you are familiar with (could be software you have written yourself or by someone else) and how the environment it is used in have affected its design or development.
> Here are some examples of questions you can use to get started:
>
> - What environment does the software run in?
> - How do people interact with it?
> - Why do people use it?
> - What features of the software have been affected by these factors?
> - If the software needed to be used in a different environment, what difficulties might there be?
>
> Some examples of design / development choices constrained by environment might be:
> - Mobile Apps
>   - Must have graphical interface suitable for a touch display
>   - Usually distributed via controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications with range of Operating System (OS) versions
>     - But OS is unlikely to be anything other than Android or iOS
>   - Documentation probably in the software itself or on web page
>   - Typically written in one of the platform prefered languages (e.g. Java, Kotlin, Swift)
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

### MVC Revisted

**Model-View-Controller** (MVC) is just one of the common architectural patterns
We've been developing our software using a Model-View-Controller (MVC) architecture so far, but that's not the only choice we could have made.

In fact, we've not strictly been sticking to a formal MVC pattern and have ended up with something maybe a bit more like **Model-View-Presenter** (MVP).
The difference between these is mostly in the amount of work the Controller/Presenter does.
Since our 'Controller' is responsible for some of the data processing, it's really more like a Presenter.

In many cases, the distinction between some of these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

Lets start with adding a view that allows us to get the data for a single patient.
First, we need to add the code for the view itself and make sure our `Patient` class has the necessary data:

~~~
# file: inflammation/views.py

...

def display_patient(patient):
    """Display data for a single patient."""
    print(patient.name)
    print(patient.observations)
~~~
{: .language-python}

~~~
# file: inflammation/models.py

...

class Patient:
    def __init__(self, name, observations=None):
        self.name = name

        if observations is None:
            self.observations = []

        else:
            self.observations = observations

    def add_observation(self, obs):
        self.observations.append(obs)
~~~
{: .language-python}

Now we need to make sure people can call this view - that means connecting it to the controller and ensuring that there's a way to request this view when running the program.
The changes we need to make here are that the `main` function needs to be able to direct us to the view we've requested - and we need to add to the command line interface the necessary data to drive the new view.

~~~
# file: patientdb.py

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
            patient = models.Patient('UNKNOWN', inflammation_data[0])
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
        default=-1,
        help='Which patient should be displayed?')

    args = parser.parse_args()

    main(args)
~~~
{: .language-python}

We've added two options to our command line interface here: one to request a specific view and one for the patient id that we want to lookup.
For the full range of features that we have access to with `argparse` see the [Python module documentation](https://docs.python.org/3/library/argparse.html?highlight=argparse#module-argparse).
Allowing the user to request a specific view like this is a similar model to that used by the popular Python library Click - if you find yourself needing to build more complex interfaces than this, Click would be a good choice.
You can find more information in [Click's documentation](https://click.palletsprojects.com/en/7.x/).

For now, we also don't know the names of any of our patients, so we've made it `'UNKNOWN'` until we get more data.

We can now call our program with these extra arguments to see the record for a single patient:

~~~
python patientdb.py --view record --patient 1 data/inflammation-01.csv
~~~
{: .language-bash}

~~~
UNKNOWN
[ 0.  0.  1.  3.  1.  2.  4.  7.  8.  3.  3.  3. 10.  5.  7.  4.  7.  7.
 12. 18.  6. 13. 11. 11.  7.  7.  4.  6.  8.  8.  4.  4.  5.  7.  3.  4.
  2.  3.  0.  0.]
~~~
{: .output}

### Multilayer Architecture

Another common architectural pattern is **Multilayer Architecture**.
Software designed using a this architecture pattern is split into layers, each of which is responsible for a different part of the process of manipulating data.

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

{% include links.md %}