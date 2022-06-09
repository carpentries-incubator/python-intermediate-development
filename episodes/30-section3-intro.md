---
title: "Section 3: Developing Software to Meet Requirements"
colour: "#fafac8"
start: true
teaching: 5
exercises: 0
questions:
- "How can we write design and write 'good' software that meets its goals?"
objectives:
- "FIXME"
keypoints:
- "By deliberately designing our software, we can avoid or mitigate many of the common issues encountered when working 
with legacy software and/or accumulated 'technical debt'."
---

FIXME: revise intro

In this section, we will take a step back from coding development practices and tools and look at the bigger picture of software as a *process* of development: from good software design based on clear requirements to an implementation that meets those requirements.

We'll see how requirements fit into software development,
as well as different classes of requirements and how to interpret them.
We'll look at how to take these forward through design to implementation,
and what needs to be considered when writing unit tests to see if an implementation satisfies its requirements.

We will then look a bit past the language specifics and capabilities of Python and into 
different software design paradigms and design architectures to understand a broader set of approaches 
you can take to design software. Modern software will often contain instances of multiple paradigms so it is 
worthwhile being familiar with them and knowing when to switch in order to make maintainable code. 
Normally, you would make these design considerations early on - before you even start writing code. 
However, sometimes you
inherit code from someone else or you yourself have written some code that now needs to grow and become more robust.
At this point, before your software grows even more and becomes harder to manage,
it becomes particularly important that you reconsider its design - is it still fit for purpose, or are modifications and extensions becoming increasingly difficult to make?

We'll also see how requirements fit into software development,
as well as different classes of requirements and how to interpret them.
We'll look at how to take these forward through design to implementation,
and what needs to be considered when writing unit tests to see if an implementation satisfies its requirements.

When changes - particularly big changes - are made to a codebase, how can we as a team ensure that these changes are well considered and represent good solutions?
And how can we increase the overall knowledge of a codebase across a team?
Sometimes project goals and time pressures take precedence and producing maintainable, reusable code is not given the
time it deserves. So, when a change or a new feature is needed - often the shortest route to making it work is taken
as opposed to a more well thought-out solution. For this reason, it is important not to write the code alone and in
isolation and use other team members verify each other's code and measure our coding standards against.
This process of having multiple team members comment on key code changes is called *code review* -
this is one of the most important practices of collaborative software development that helps ensure
the ‘good’ coding standards are achieved and maintained within a team.
We'll thus look at the benefits of reviewing code,
in particular, the value of this type of activity within a team,
and how this can fit within various ways of team working.
We'll see how GitHub can support code review activities via pull requests,
and how we can do these ourselves making use of best practices.

After that, we'll look at some general principles of software maintainability and the benefits that writing maintainable 
code can give you. There will also be some practice at identifying problems with existing code, and some general, established practices you can apply when writing new code or to the code you've already written.
We'll also look at how we can package software for release and distribution, using **Poetry** to manage our Python dependencies and produce a code package we can use with a Python package indexing service to illustrate these principles.

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }

{% include links.md %}
                            

{% comment %}
Designing and Developing "Good" Software in Teams
- **Software paradigms and design architectures** for solving different problems based on clear requirements
- **Writing "good" software** that is understandable, modular, extensible and tested
- **Publishing and releasing software** for reuse by others
- **Collaborative code development and review** to improve software sustainability and avoid the accumulation of ‘technical debt’.
{% endcomment %}
