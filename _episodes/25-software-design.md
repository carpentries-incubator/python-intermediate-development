---
title: "Software Design"
teaching: 90
exercises: 0
questions:
- "Key question (FIXME)"
objectives:
- "Describe some of the different categories of software and explain how the requirements of each category may differ"
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
- "Consider issues which contribute to the usability of a piece of software"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

As a piece of software grows, it will reach a point where there's too much code for you to keep in mind at once.
At this point, it becomes particularly important that the software be designed sensibly.

It's not easy come up with a complete definition for the term **software design**, but some of the common aspects are:

- **Algorithm design** - What method are we going to use to solve the core business problem?
- **Software architecture** - What components will the software have and how will they cooperate?
- **System architecture** - What other things will this software have to interact with and how?
- **UI/UX** (User Interface / User Experience) - How will users interact with the software?

As usual, the sooner you adopt a practice in the lifecycle of your project, the easier it will be.
So we should think about the design of our software from the very beginning - ideally even before we start writing code.

## Types of Software

Before we start writing code, we would like to have a reasonable idea of who will be using our software and what they want it to do.

This is often difficult, particularly when developing software for research, because the users and their needs can change with very little warning.
Maybe we have an idea for a new research project that could use our existing code, or maybe a research group at another institution wants to use it.o

Despite this potential for change

- Where does it run?
- How do you interact with it?
- Why do you use it?

- Desktop Application
- Command-line Application
  - UNIX tools
  - HPC
- Mobile Apps
- Web
  - Serverside
  - Frontend
- Embedded


## Multi-layer Architectures

### MVC Revisted

- Emphasise following the spirit, not the letter
- Many similar alternatives, what we have have here is actually closer to MVVM

### The Persistence Layer

- Databases
- ORM


## Software Systems

- How should software interact with users?
- How should software interact with other software?
   - Piping in and out


{% include links.md %}
