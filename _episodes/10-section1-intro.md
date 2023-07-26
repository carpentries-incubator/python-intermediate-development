---
title: "Section 1: Setting Up Environment For Collaborative Code Development"
colour: "#fafac8"
start: true
teaching: 10
exercises: 0
questions:
- "What tools are needed to collaborate on code development effectively?"
objectives:
- "Provide an overview of all the different tools that will be used in this course."
keypoints:
- "In order to develop (write, test, debug, backup) code efficiently,
you need to use a number of different tools."
- "When there is a choice of tools for a task you will have
to decide which tool is right for you, which may be a matter of personal preference or what the team or community you belong to is using."
---

The first section of the course is dedicated to setting up your environment for collaborative software development.
In order to build working (research) software efficiently
and to do it in collaboration with others rather than in isolation,
you will have to get comfortable with using a number of different tools interchangeably
as they’ll make your life a lot easier.
There are many options when it comes to deciding
which software development tools to use for your daily tasks -
we will use a few of them in this course that we believe make a difference.
There are sometimes multiple tools for the job -
we select one to use but mention alternatives too.
As you get more comfortable with different tools and their alternatives,
you will select the one that is right for you based on your personal preferences
or based on what your collaborators are using.

![Tools needed to collaborate on code development effectively](../fig/section1-overview.png){: .image-with-shadow width="800px" }

Here is an overview of the tools we will be using.

> ## Setup, Common Issues & Fixes
> Have you [setup and installed](../setup.html) all the tools and accounts required for this course?
> Check the list of [common issues, fixes & tips](../common-issues/index.html)
> if you experience any problems running any of the tools you installed -
> your issue may be solved there.
{: .callout}

### Command Line & Python Virtual Development Environment
We will use the [command line](https://en.wikipedia.org/wiki/Shell_(computing))
(also known as the command line shell/prompt/console)
to run our Python code
and interact with the version control tool Git and software sharing platform GitHub.
We will also use command line tools
[`venv`](https://docs.python.org/3/library/venv.html)
and [`pip`](https://pip.pypa.io/en/stable/)
to set up a Python virtual development environment
and isolate our software project from other Python projects we may work on.

**Note:** *some Windows users experience the issue where Python hangs from Git Bash
(i.e. typing `python` causes it to just hang with no error message or output) -
[see the solution to this issue](../common-issues/index.html#python-hangs-in-git-bash).*

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

### Git & GitHub
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

Let's get started with setting up our software development environment!

{% include links.md %}
