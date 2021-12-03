---
title: "Section 3: Software Design and Development"
colour: "#fcecc0"
start: true
teaching: 5
exercises: 0
questions:
- "How can we use common patterns and paradigms to improve the robustness of our software?"
objectives:
- "Design software around a number of common patterns and paradigms to improve extensibility, testability and overall sustainability."
keypoints:
- "Each of the major programming paradigms are suited to different kinds of problem."
- "A single piece of software will often contain instances of multiple paradigms."
- "By deliberately designing our software, we can avoid or mitigate many of the common issues encountered when working 
with legacy software."
---
In this section, we are going to start adding more code to our project and engage in code review activities with our 
peers. But before we write more code, we are going to look a bit into different software design paradigms and 
design architectures to
understand a broader set of approaches you can take to design software and to help you with the design decisions
you have to make. Modern software will often contain instances of multiple paradigms so it is worthwhile being familiar 
with them and knowing when to switch. 

Normally, you would make these design considerations early on - before you even start writing code. 
However, sometimes you
inherit code from someone else or you yourself have written some code that now needs to grow and become more robust.
At this point, before your software grows even more and becomes harder to manage,
it becomes particularly important that you rethink its design.

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }

{% include links.md %}
