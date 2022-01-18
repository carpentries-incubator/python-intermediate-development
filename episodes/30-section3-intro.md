---
title: "Section 3: Collaborative Software Design and Development for Reuse"
colour: "#fafac8"
start: true
teaching: 5
exercises: 0
questions:
- "What are some best practices for collaborative code development available to help us design and write 'good'
  software that will make it easier for us and others to further develop and reuse it?"
objectives:
- "Look at the bigger picture of software as a process of development: from 'good' software design 
based on clear requirements to an implementation that meets those requirements."
keypoints:
- "By deliberately designing our software, we can avoid or mitigate many of the common issues encountered when working 
with legacy software and/or accumulated 'technical debt'."
- "Agreeing on a set of best practices within a software development team will help 
to improve your software's understandability, extensibility, testability, reusability and overall sustainability."
---
In this section, we will take a step back from coding development practices and tools and look at the bigger picture of software as a *process* of development: from good software design based on clear requirements to an implementation that meets those requirements, and how doing these things well makes it easier for others to develop and reuse our software.

We will first look a bit past the language specifics and capabilities of Python and into 
different software design paradigms and design architectures to understand a broader set of approaches 
you can take to design software. Modern software will often contain instances of multiple paradigms so it is 
worthwhile being familiar with them and knowing when to switch in order to make maintainable code. 
Normally, you would make these design considerations early on - before you even start writing code. 
However, sometimes you
inherit code from someone else or you yourself have written some code that now needs to grow and become more robust.
At this point, before your software grows even more and becomes harder to manage,
it becomes particularly important that you rethink its design.

After that, we'll look at some general principles of software maintainability, the benefits that writing maintainable 
code can give you, and also getting some practice at identifying problems with existing code, and
some general, established practices you can apply when writing new code or to the code you've already written.
Sometimes project goals and time pressures take precedence and producing maintainable, reusable code is not given the 
time it deserves. So, when a change or a new feature is needed - often the shortest route to making it work is taken 
as opposed to a more well thought-out solution. For this reason, it is important not to write the code alone and in 
isolation and use other team members verify each other's code and measure our coding standards against.
This process of having multiple team members comment on key code changes is called *code review* - 
this is one of the most important practices of collaborative software development that helps ensure 
the ‘good’ coding standards are achieved and maintained within a team.

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }

{% include links.md %}
