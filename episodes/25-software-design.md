---
title: "Software Design"
teaching: 90
exercises: 0
questions:
- "Where do we start when beginning a new software project?"
- "How do people use software?"
- "How can we make sure the components of our software are reusable?"
- "What should we do when our requirements change?"
objectives:
- "Describe some of the different categories of software and explain how the requirements of each category may differ"
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
- "Consider issues which contribute to the usability of a piece of software"
keypoints:
- "Planning software projects in advance can save a lot of effort later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change."
- "When writing software used for research, requirements *always* change."
---

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

> ## Types of Software
>
> Many design choices in a software project depend on the environment in which the software is expected to run.
>
> How many different software environments can you think of?
> In small groups, discuss some of these environments and how aspects of each one might impact the design choices of the software running there.
>
> Some examples might be:
> - Mobile Apps
>   - Mush have graphical interface suitable for a touch display
>   - Usually distributed via controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications with range of Operating System versions
>   - Documentation probably in software itself or on web page
>   - Typically written in one of the platform prefered languages (e.g. Java, Swift)
> - Embedded Software
>   - May have no user interface - user interface may be physical buttons
>   - Usually distributed pre-installed on physical device
>   - Often runs on low power device with limited memory and CPU performance
>   - Exact specification of hardware is known - often not necessary to support multiple devices
>   - Documentation probably in technical manual with separate user manual
>   - May need to run continuously for the lifetime of the device
>   - Typically written in lower-level language (e.g. C) for better control of resources
>
> Again in small groups, discuss some software you are familiar with (could be software you have written yourself or by someone else).
> Use the three questions to explain the environment in which the software is intended to be used.
>
> What features of the software have been affected by these factors?
> If the software needed to be used in a different environment, what difficulties might there be?
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
> >   - Documentation has expected formats - also accessible from command-line
> > - Command-line Application - High Performance Computing
> >   - Similar to UNIX Tool
> >   - Usually supports running across multiple networked machines simultaneously
> >   - Usually operated via scheduler - interface should be scriptable
> >   - May need to run on wide range of hardware (e.g. different CPU architectures)
> >   - May need to process large amounts of data
> >   - Often written in lower-level language for performance (e.g. C, C++, Fortran)
> > - Web Application
> >   - Usually has components which run on server and components which run on the user's device
> >   - Graphical interface should support Desktop or Mobile devices
> >   - Clientside component should run on range of browsers and Operating Systems
> >   - Documentation probably part of the software itself
> >   - Clientside component typically written in JavaScript
> {: .solution}
{: .challenge}


## Multi-layer Architectures

### MVC Revisted

- Emphasise following the spirit, not the letter
- Many similar alternatives, what we have have here is actually closer to MVVM

### The Persistence Layer

- Databases
- ORM


## Software Systems

- How should software interact with users?
- How should software interact with other software?
   - Piping in and out


{% include links.md %}
