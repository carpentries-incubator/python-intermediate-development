---
title: "Software Requirements"
teaching: 15
exercises: 30
questions:
- "Where do we start when beginning a new software project?"
- "How can we capture and organise what is required for software to function as intended?"
objectives:
- "Describe the different types of software requirements."
- "Explain the difference between functional and non-functional requirements."
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Derive new user and solution requirements from business requirements."
keypoints:
- "When writing software used for research, requirements will almost *always* change."
- "Consider non-functional requirements (*how* the software will behave) as well as functional requirements (*what* the software is supposed to do)."
- "The environment in which users run our software has an effect on many design choices we might make."
- "Consider the expected longevity of any code before you write it."
- "The perspective and language of a particular requirement stakeholder group should be reflected in requirements for that group."
---

The requirements of our software are the basis on which the whole project rests -
if we get the requirements wrong, we'll build the wrong software.
However, it's unlikely that we'll be able to determine all of the requirements upfront.
Especially when working in a research context,
requirements are flexible and may change as we develop our software.

## Types of Requirements

Requirements can be categorised in many ways,
but at a high level a useful way to split them is into
*business requirements*,
*user requirements*,
and *solution requirements*.
Let's take a look at these now.

### Business Requirements

Business requirements describe what is needed from the perspective of the organisation,
and define the strategic path of the project,
e.g. to increase profit margin or market share,
or embark on a new research area or collaborative partnership.
These are captured in something like a Business Requirements Specification.

For adapting our catchment software project, example business requirements could include:

- BR1: improving the statistical quality of data reporting
  to meet the needs of external audits 
- BR2: increase the throughput of data analyses
  to meet higher demand as more more measurement sites are added

> ## Exercise: New Business Requirements
> Think of a new hypothetical business-level requirements for this software.
> This can be anything you like, but be sure to keep it at the high-level of the business itself.
>
>> ## Solution
>> One hypothetical new business requirement (BR3) could be
>> extending our data system to keep track of which catchment areas contain each measurement station.
>> 
>> Another hypothetical new business requirement (BR4) may be 
>> adding correlation tests between measurement sites -
>> e.g. to help establish catchment response to rainfall.
> {: .solution}
{: .challenge}

### User (or Stakeholder) Requirements

These define what particular stakeholder groups each expect from an eventual solution,
essentially acting as a bridge between the higher-level business requirements
and specific solution requirements.
These are typically captured in a User Requirements Specification.

For our inflammation project,
they could include things for trial managers such as (building on the business requirements):

- UR1.1 (from BR1): 
  add support for statistical measures in generated trial reports
  as required by revised auditing standards (standard deviation, ...)
- UR1.2 (from BR1): add support for producing textual representations of statistics in trial reports
  as required by revised auditing standards
- UR2.1 (from BR2): ability to have an individual data report processed and generated
  in under 30 seconds (if we assume it usually takes longer than that)

> ## Exercise: New User Requirements
>
> Break down your new business requirements from the
> [previous exercise](../31-software-requirements/index.html#exercise-new-business-requirements)
> into a number of logical user requirements,
> ensuring they stay above the level and detail of implementation.
>> ## Solution
>> For our business requirement BR3 from the previous exercise,
>> the new user/stakeholder requirements may be the ability to 
>> see all the measurement sites within a given catchment area (UR3.1),
>> and to find out which catchment area any given measurement site is in (UR3.2).
>>
>> For our business requirement BR4 from the previous exercise,
>> the new user/stakeholder requirements may be the ability to 
>> see the correlations between each measurement site, and data type,
>> in all reports and graphs (UR4.1).
> {: .solution}
{: .challenge}

### Solution Requirements

Solution (or product) requirements describe characteristics that software must have to
satisfy the stakeholder requirements.
They fall into two key categories:

- *Functional requirements* focus on functions and features of a solution.
  For our software, building on our user requirements, e.g.:
    - SR1.1.1 (from UR1.1):
      add standard deviation to data model and include a graph visualisation view
    - SR1.2.1 (from UR1.2):
      add a new view to generate a textual representation of statistics,
      which is invoked by an optional command line argument
- *Non-functional requirements* focus on
  *how* the behaviour of a solution is expressed or constrained,
  e.g. performance, security, usability, or portability.
  These are also known as *quality of service* requirements.
  For our project, e.g.:
    - SR2.1.1 (from UR2.1):
      generate graphical statistics report on a project workstation configuration
      in under 30 seconds
                          
> ## Labelling Requirements
> Note that the naming scheme we used for labelling our requirements is quite arbitrary -
> you should reference them in a way that is consistent
> and makes sense within your project and team.
{: .callout}


#### The Importance of Non-functional Requirements

When considering software requirements,
it's *very* tempting to just think about the features users need.
However, many design choices in a software project quite rightly depend on
the users themselves and the environment in which the software is expected to run,
and these aspects should be considered as part of the software's non-functional requirements.

> ## Exercise: Types of Software
>
> Think about some software you are familiar with
> (could be software you have written yourself or by someone else)
> and how the environment it is used in have affected its design or development.
> Here are some examples of questions you can use to get started:
>
> - What environment does the software run in?
> - How do people interact with it?
> - Why do people use it?
> - What features of the software have been affected by these factors?
> - If the software needed to be used in a different environment,
>   what difficulties might there be?
>
> Some examples of design / development choices constrained by environment might be:
>
> - Mobile Apps
>   - Must have graphical interface suitable for a touch display
>   - Usually distributed via a controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications
>     with a range of Operating System (OS) versions
>     - But OS is unlikely to be anything other than Android or iOS
>   - Documentation probably in the software itself or on a Web page
>   - Typically written in one of the platform preferred languages
>     (e.g. Java, Kotlin, Swift)
> - Embedded Software
>   - May have no user interface - user interface may be physical buttons
>   - Usually distributed pre-installed on a physical device
>   - Often runs on low power device with limited memory and CPU performance -
>     must take care to use these resources efficiently
>   - Exact specification of hardware is known -
>     often not necessary to support multiple devices
>   - Documentation probably in a technical manual with a separate user manual
>   - May need to run continuously for the lifetime of the device
>   - Typically written in a lower-level language (e.g. C) for better control of resources
>
> > ## Some More Examples
> >
> > - Desktop Application
> >   - Has a graphical interface for use with mouse and keyboard
> >   - May need to work on multiple, very different operating systems
> >   - May be intended for users to modify / compile themselves
> >   - Should work on a wide range of hardware configurations
> >   - Documentation probably either in a manual or in the software itself
> > - Command-line Application - UNIX Tool
> >   - User interface is text based, probably via command-line arguments
> >   - Intended to be modified / compiled by users - though most will choose not to
> >   - Documentation has standard formats - also accessible from the command line
> >   - Should be usable as part of a pipeline
> > - Command-line Application - High Performance Computing
> >   - Similar to a UNIX Tool
> >   - Usually supports running across multiple networked machines simultaneously
> >   - Usually operated via a scheduler - interface should be scriptable
> >   - May need to run on a wide range of hardware
> >     (e.g. different CPU architectures)
> >   - May need to process large amounts of data
> >   - Often entirely or partially written in a lower-level language for performance
> >     (e.g. C, C++, Fortran)
> > - Web Application
> >   - Usually has components which run on server and components which run on the user's device
> >   - Graphical interface should usually support both Desktop and Mobile devices
> >   - Client-side component should run on a range of browsers and operating systems
> >   - Documentation probably part of the software itself
> >   - Client-side component typically written in JavaScript
> {: .solution}
{: .challenge}

> ## Exercise: New Solution Requirements
> Now break down your new user requirements from the
> [earlier exercise](../31-software-requirements/index.html#exercise-new-user-requirements)
> into a number of logical solution requirements (functional and non-functional),
> that address the detail required to be able to implement them in the software.
>> ## Solution
>> For our new hypothetical business requirement BR3,
>> new functional solution requirements could be extending
>> the clinical trial system to keep track of:
>> - the names and location, or geographic extent, of all measurement sites (SR3.1.1) and catchment areas (SR3.1.2) involved in the project
>> - the name of the catchment area for a particular measurement site (SR3.1.3)
>> - a group of measurement sites within a particular catchment area (SR3.2.1).
> {: .solution}
{: .challenge}

> ## Optional Exercise: Requirements for Your Software Project
>
> Think back to a piece of code or software (either small or large) you've written,
> or which you have experience using.
> First, try to formulate a few of its key business requirements,
> then derive these into user and then solution requirements
> (in a similar fashion to the ones above in *Types of Requirements*).
{: .challenge}


### Long- or Short-Lived Code?

Along with requirements, here's something to consider early on.
You, perhaps with others, may be developing open-source software
with the intent that it will live on after your project completes.
It could be important to you that your software is adopted and used by other projects
as this may help you get future funding.
It can make your software more attractive to potential users
if they have the confidence that they can fix bugs that arise or add new features they need,
if they can be assured that the evolution of the software is not dependant upon
the lifetime of your project.
The intended longevity and post-project role of software should be reflected in its requirements -
particularly within its non-functional requirements -
so be sure to consider these aspects.

On the other hand, you might want to knock together some code to prove a concept
or to perform a quick calculation
and then just discard it.
But can you be sure you'll never want to use it again?
Maybe a few months from now you'll realise you need it after all,
or you'll have a colleague say "I wish I had a..."
and realise you've already made one.
A little effort now could save you a lot in the future.

## From Requirements to Implementation, via Design

In practice, these different types of requirements are sometimes confused and conflated
when different classes of stakeholder are discussing them, which is understandable:
each group of stakeholders has a different view of *what is required* from a project.
The key is to understand the stakeholder's perspective as to
how their requirements should be classified and interpreted,
and for that to be made explicit.
A related misconception is that each of these types are simply
requirements specified at different levels of detail.
At each level, not only are the perspectives different,
but so are the nature of the objectives and the language used to describe them,
since they each reflect the perspective and language of their stakeholder group.

It's often tempting to go right ahead and implement requirements within existing software,
but this neglects a crucial step:
do these new requirements fit within our existing design,
or does our design need to be revisited?
It may not need any changes at all,
but if it doesn't fit logically our design will need a bigger rethink
so the new requirement can be implemented in a sensible way.
We'll look at this a bit later in this section,
but simply adding new code without considering
how the design and implementation need to change at a high level
can make our software increasingly messy and difficult to change in the future.


{% include links.md %}
