---
title: "Section 3: Design and Development Techniques for Writing `Good` Code"
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
In this section, we are going to step back and think about the definition of "good code" - 
robust, maintainable, reusable - and how to achieve it by collaborating with our team members.

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
isolation and use other team members to measure our coding standards against and check and verify each other's code.

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }

{% include links.md %}
