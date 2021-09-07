---
title: "Section 1: Environment For Collaborative Code Development"
colour: "#fcecc0"
start: true
teaching: 10
exercises: 0
questions:
- "What tools are needed to collaborate on code development effectively?"
objectives:
- "Clone the software project and set up a development environment using command line shell, PyCharm, Git and GitHub"
keypoints:
- "In order to develop (write, test, debug, backup) code yourself or in collaboration with others, 
you may need to use a number of different software development tools interchangeably"
- "When there is a choice of tools for a task you will have 
to decide which tool is right for you, which may be a matter of personal preference or what the community you belong to is using"
---

The first section of the workshop is dedicated to setting up your environment for collaborative software development. 
In order to build working (research) software 
efficiently and to do it collaboration with others rather than isolation, you will have to get comfortable 
with using a number of different tools interchangeably as they’ll make your life a lot easier. 
There are many options when it comes to deciding on which software development tools to use for your daily tasks - we
will use a few of them in this workshop that we believe make a difference. There are sometimes multiple tools for the
job - we select one to use but mention alternatives too. As you get more comfortable with different tools and 
their alternatives, you will select the one that is right for you based on your personal preferences or 
based on what your collaborators are using.  

![Tools needed to collaborate on code development effectively](../fig/section1-overview.png){: .image-with-shadow width="800px" }

Here is an overview of the tools we will be using in this workshop.

### Command Line & Virtual Development Environment
We use a command line shell (also known as a command line prompt/console, command line, or simply shell) to set up a virtual 
development environment and isolate our software project from other projects we may work on, to run our code and 
interact with a version control tool Git.

### Integrated Development Environment (IDE)
An IDE integrates a number of tools that we need to develop a software project 
that goes beyond a single script - including a smart code editor, 
a code compiler/interpreter, a debugger, etc. It will help you write well-formatted & readable code that conforms to 
code style guides (such as PEP8 for Python) more efficiently by giving relevant and intelligent suggestions for 
code completion and refactoring. 
IDEs often integrates command line console and version control tools - we teach 
them separately in this workshop as this knowledge can be ported to other programming languages and command line tools 
you may use in the future (but is perfectly fine to use these integrated versions too).

### Git & GitHub
Git is a free and open source distributed version control system designed to save every change made to a 
(software) project, allowing others to collaborate and contribute. In this workshop,
we use Git to version control our code in conjunction with GitHub for code backup and sharing. 
GitHub is one of the leading integrated products and 
social platforms for modern software development, monitoring and management - it will help us with 
version control, issue management, code review, code testing/Continuous Integration, and collaborative development.

Let's set up our software development environment!
