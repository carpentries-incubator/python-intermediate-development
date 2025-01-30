---
title: 'Section 1: Setting Up Environment For Collaborative Code Development'
teaching: 10
exercises: 0
---

::::::::::::::::::::::::::::::::::::::: objectives

- Provide an overview of all the different tools that will be used in this course.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What tools are needed to collaborate on code development effectively?

::::::::::::::::::::::::::::::::::::::::::::::::::

The first section of the course is dedicated to setting up your environment for collaborative software development
and introducing the project that we will be working on throughout the course.
In order to build working (research) software efficiently
and to do it in collaboration with others rather than in isolation,
you will have to get comfortable with using a number of different tools interchangeably
as they will make your life a lot easier.
There are many options when it comes to deciding
which software development tools to use for your daily tasks -
we will use a few of them in this course that we believe make a difference.
There are sometimes multiple tools for the job -
we select one to use but mention alternatives too.
As you get more comfortable with different tools and their alternatives,
you will select the one that is right for you based on your personal preferences
or based on what your collaborators are using.

![Section 1 Overview](fig/section1-overview.svg){alt='Tools needed to collaborate on code development effectively'}

<!---
Source of the above image can be rendered in the Mermaid live editor:
<https://mermaid.live/edit#pako:eNpdkttKAzEQhl9lyIVsoS14AtkLQW3RggVRUJC9GXdn20A2s0wmLSK-u0m3K2IuQpj83z-H5MvU3JApTet4X29RFB6fKw9p3RSnc3ghVes3EHsYooFb3aMQkN9ZYd-R18oPdzNYBXaoBOgbkOghm5dp77occdbTFBKmEd1fgwAnsFosw2jzShIsZ9yrsDvYhW3OOhjeW01E2h_ix8i8iU2J9-TcbJ-OSmP2p-XT1aTys9k13BZn82xu28_U1L-GahahWj2FMIFBf1ecpxGMgoZ25LjPBR-HgQEQeuE6MwOyKC7mcMfO4QcLqt3RUfuXbllAKAY6Qsvicg5r9LjJs_6taAB5RwI2zcjZltR2NDFT05F0aJv0cF9ZVRndUkeVKdOxoRaj08pU_jtJMSq_fPralCqRpib2TXqihcWNYGfKFl1IUWqssqyHz3D4E6NyebgZ6R79O_PIff8AoRHADA>

The mermaid source (with one less dash in arrows than needed):

flowchart LR
  A(1. Setting up
  software environment

  - Isolate and run code: command line, virtual environment & IDE
  - Version control and share code: Git & GitHub
  - Write well-written code: PEP8)

  A -> B(2. Verifying software correctness)
  B -> C(3. Software development as a process)
  C -> D(4. Collaborative development for reuse)
  D -> E(5. Managing software over its lifetime)
-->

Here is an overview of the tools we will be using.

:::::::::::::::::::::::::::::::::::::::::  callout

## Setup, Common Issues \& Fixes

Have you [setup and installed](../learners/setup.md) all the tools and accounts required for this course?
Check the list of [common issues, fixes \& tips](../learners/common-issues.md)
if you experience any problems running any of the tools you installed -
your issue may be solved there.


::::::::::::::::::::::::::::::::::::::::::::::::::

### Command Line \& Python Virtual Development Environment

We will use the [command line](https://en.wikipedia.org/wiki/Shell_\(computing\))
(also known as the command line shell/prompt/console)
to run our Python code
and interact with the version control tool Git and software sharing platform GitHub.
We will also use command line tools
[`venv`](https://docs.python.org/3/library/venv.html)
and [`pip`](https://pip.pypa.io/en/stable/)
to set up a Python virtual development environment
and isolate our software project from other Python projects we may work on.

***Note:** some Windows users experience the issue where Python hangs from Git Bash
(i.e. typing `python` causes it to just hang with no error message or output) -
[see the solution to this issue](../learners/common-issues.md#python-hangs-in-git-bash).*

### Integrated Development Environment (IDE)

An IDE integrates a number of tools that we need
to develop a software project that goes beyond a single script -
including a smart code editor, a code compiler/interpreter, a debugger, etc.
It will help you write well-formatted and readable code that conforms to code style guides
(such as [PEP8](https://www.python.org/dev/peps/pep-0008/) for Python)
more efficiently by giving relevant and intelligent suggestions
for code completion and refactoring.
IDEs often integrate command line console and version control tools -
we teach them separately in this course
as this knowledge can be ported to other programming languages
and command line tools you may use in the future
(but is applicable to the integrated versions too).

We will use [PyCharm](https://www.jetbrains.com/pycharm/) in this course -
a free, open source IDE.

### Git \& GitHub

[Git](https://git-scm.com/) is a free and open source distributed version control system
designed to save every change made to a (software) project,
allowing others to collaborate and contribute.
In this course, we use Git to version control our code in conjunction with [GitHub](https://github.com/)
for code backup and sharing.
GitHub is one of the leading integrated products and social platforms
for modern software development, monitoring and management -
it will help us with
version control,
issue management,
code review,
code testing/Continuous Integration,
and collaborative development.
An important concept in collaborative development is version control workflows
(i.e. how to effectively use version control on a project with others).

### Python Coding Style

Most programming languages will have associated standards and conventions for how the source code
should be formatted and styled.
Although this sounds pedantic,
it is important for maintaining the consistency and readability of code across a project.
Therefore, one should be aware of these guidelines
and adhere to whatever the project you are working on has specified.
In Python, we will be looking at a convention called PEP8.

Let us get started with setting up our software development environment!



:::::::::::::::::::::::::::::::::::::::: keypoints

- In order to develop (write, test, debug, backup) code efficiently, you need to use a number of different tools.
- When there is a choice of tools for a task you will have to decide which tool is right for you, which may be a matter of personal preference or what the team or community you belong to is using.

::::::::::::::::::::::::::::::::::::::::::::::::::


