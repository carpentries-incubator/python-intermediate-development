---
title: "Section 3: Software Architecture and Design"
colour: "#fcecc0"
start: true
teaching: 5
exercises: 0
questions:
- "How can we use common patterns and paradigms to improve the sustainability of our software?"
objectives:
- "Design software around a number of common patterns and paradigms to improve extensibility, testability and overall sustainability."
keypoints:
- "Each of the major programming paradigms are suited to different kinds of problem."
- "A single piece of software will often contain instances of multiple paradigms."
- "By deliberately designing our software, we can avoid or mitigate many of the common issues encountered when working with legacy software."
---
In this section, we step away from writing code for a bit to look into different software design paradigms to
understand a broader set of approaches you can take to design software and to help you with the design decisions
you have to make. Each paradigm represents a slightly different way of thinking about and structuring the code
and each has certain strengths and weaknesses when used to solve particular types of problems - useful to know so
you can recognise where it might be useful to switch in your own code.

Normally, you would make these considerations early on - before you even start writing code. However, sometimes you
inherit code from someone else or you yourself have written some code that now needs to grow and become more robust.
At this point, before your software grows even more and becomes harder to manage,
it becomes particularly important that you rethink the design of your software, including:

- **algorithm design**: what method are you going to use to solve the core problem?
- **software architecture**: what components will the software have and how will they interoperate?
- **system architecture**: what system components will this software have to interact with and how?
- **UI/UX (User Interface / User Experience)**: how will users interact with the software?

![Software design and architecture](../fig/section3-overview.png){: .image-with-shadow width="800px" }
