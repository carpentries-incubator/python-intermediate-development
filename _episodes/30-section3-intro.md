---
title: "Section 3: Designing Software to Meet Requirements"
colour: "#fafac8"
start: true
teaching: 5
exercises: 0
questions:
- "How can we design and write 'good' software that meets its goals and requirements?"
objectives:
- "Define the fundamental stages in a software development process."
keypoints:
- "By deliberately designing our software, we can avoid or mitigate many of the common issues encountered when working 
with legacy software and/or accumulated 'technical debt'."
---

**TODO: check intro and see if it needs revising based on the sections topics and objectives.**

In this section, we will take a step back from coding development practices and tools and look at the bigger picture of software as a *process* of development: from good software design based on clear requirements to an implementation that meets those requirements. We'll see how requirements fit into software development,
as well as different classes of requirements and how to interpret them.
We'll look at how to take these forward through design to implementation,
and what needs to be considered when writing unit tests to see if an implementation satisfies its requirements.

We will then look a bit past the language specifics and capabilities of Python and into 
different software design paradigms and design architectures to understand a broader set of approaches 
you can take to design software. Modern software will often contain instances of multiple paradigms so it is 
worthwhile being familiar with them and knowing when to switch in order to make better code. 
Normally, you would make these design considerations early on - before you even start writing code. 
However, sometimes you
inherit code from someone else or you yourself have written some code that now needs to grow and become more robust.
At this point, before your software grows even more and becomes harder to manage,
it becomes particularly important that you reconsider its design - is it still fit for purpose, or are modifications and extensions becoming increasingly difficult to make?

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }

{% include links.md %}
                            

{% comment %}
Designing and Developing "Good" Software in Teams
- **Software paradigms and design architectures** for solving different problems based on clear requirements
- **Writing "good" software** that is understandable, modular, extensible and tested
- **Publishing and releasing software** for reuse by others
- **Collaborative code development and review** to improve software sustainability and avoid the accumulation of ‘technical debt’.
{% endcomment %}
