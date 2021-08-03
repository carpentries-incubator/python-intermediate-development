---
layout: episode
title: "Setting the Scene"
start: true
teaching: 30
exercises: 0
questions:
- "What are we going to teach in this workshop?"
- "What different software development tools will we be using?"
objectives:
- "Setting the scene and expectations"
- "Making sure everyone has all the necessary software is installed"
keypoints:
- "This lesson focuses on core, intermediate skills covering the whole software development life-cycle 
that will be of most use to anyone working collaboratively on code."
- "The lesson follows on from the novice Software Carpentry lesson, but this not a prerequisite for attending as long as
you have some basic Python, Shell and Git skills and you have been using them to write code to help with your work."
---

## Introduction
So, you have gained basic software development skills either by self-learning or attending, e.g., a [novice Software 
Carpentry course][swc-lessons]. You have been applying those skills for a while by writing code to help with your work 
and you feel comfortable developing code and troubleshooting problems. However, your software 
has now reached a point where there’s too much code to be kept in one script. It is perhaps involving more 
researchers (developers) and users, and more collaborative development effort is needed to add new functionality 
while ensuring previous development efforts remain functional and maintainable. 
This lesson teaches some intermediate software engineering skills to help you design more robust software code, 
automate the process of testing and verifying its correctness and support collaborations with others in a way that mimics a typical collaborative 
software development process and using a number of different **software development tools and techniques** 
simultaneously and interchangeably as you would use them in a real life. 

The material is organised into the following 
four bigger sections.

![Course overview](../fig/course-overview.png){: .image-with-shadow width="800px" }

1. In the first section we are going to familiarise ourselves with using various tools and techniques for 
software development and a typical collaborative code development cycle: 
- **PyCharm** (an Integrated Development Environment (IDE) tool) for **code development, testing and debugging**, 
- **command line shell** for running code and interacting with **command line tool Git** for version control and 
branching the code out for developing new features in parallel,
- **GitHub** (central and remote source code management platform supporting version control with Git) for code backup, sharing and 
collaborative development, 
- **virtual environments** for isolating a project from other projects developed on the same machine, and 
- **Python code style guide** (PEP8) to make sure our code is documented, readable and consistently formatted.
2. Once we know our way around different code development tools, techniques and conventions, in the second section we learn:
- how to set up a **test framework** and write tests to verify the correct behaviour of the code, and 
- how to automate and scale testing with **Continuous Integration (CI)** using 
**GitHub Actions** (a CI service available on GitHub).
3. In the third section, we step away from writing code for a bit to look into different **software design paradigms** 
to understand the wider landscape in which you can design software and to help you with the 
design decisions you have to make. Each paradigm represents a slightly different way of thinking about and structuring 
the code and each has certain strengths and weaknesses when used to solve particular types of problems - 
useful to know so you can recognise where it might be useful to switch in your own code. 
4. Finally, we are back to practical applications and learning to **publish and release 
software for reuse** by others. You will work with your fellow learners on a group project (as you would do when 
collaborating on a software project in a team) and we will address best practices in **documenting**, **licencing**, **tracking 
issues**, and **supporting your software**.

After attending this workshop, you will be equipped with skills and tools for intermediate software development in Python, 
as well as general skills on writing robust software collaboratively making it easier to use, develop, 
and sustain it in the future for yourself and others. Note that, while this material is Python-specific 
and uses a particular Python IDE (PyCharm), skills taught here are transferable to other 
programming languages and IDEs (e.g. Spyder, Atom, etc.).

> ## Prerequisite Knowledge
> This is an intermediate-level software development course intended for people who have already been developing code in 
> Python (or other languages), e.g. for at least a few months, and applying it to their own problems 
> after gaining basic software development skills. 
> So, it is expected for you to have some prerequisite knowledge on the topics covered, as outlined at the [beginning of the lesson](/index.html#prerequisites).
Check out this [quiz](../quiz/index.html) to help you test your prior knowledge and determine if this course is for you.  
{: .callout} 

> ## Required Software
Please make sure that you have all the necessary software installed as described in the [Setup](../setup.html) section. 
This section also contains instructions on how to test your setup. 
{: .callout} 

> ## Outdated Screenshots
> Throughout this lesson we will make use and show content from Graphical User Interface (GUI) tools (PyCharm and GitHub). 
> These are evolving tools and platforms, always adding new features and new visual elements. 
> Screenshots in the lesson may then become out-of-sync, refer or show content that no longer exists or is different to 
> what you see on your machine. If during the lesson you find screenshots that no longer match what you see or have 
> a big discrepancy with what you see, please [open an issue](https://github.com/softwaresaved/python-intermediate-development/issues/new) describing what you see and how it differs from the lesson 
> content. Feel free to add as many screenshots as necessary to clarify the issue.
{: .callout} 

{% include links.md %}
