---
title: "Software Architecture"
teaching: 15
exercises: 0
layout: episode
questions:
- "What should we consider when designing software?"
objectives:
- "Understand the components of multi-layer software architectures."
keypoints:
- "Software architecture provides an answer to the question 
'what components will the software have and how will they cooperate?'."
---

## Software Architecture

**Software architecture** provides an answer to the question
"what components will the software have and how will they cooperate?".
Software engineering borrowed this term, and a few other terms,
from architects (of buildings) as many of the processes and techniques have some similarities.
One of the other important terms we borrowed is 'pattern',
such as in **design patterns** and **architecture patterns**.
This term is often attributed to the book
['A Pattern Language' by Christopher Alexander *et al.*](https://en.wikipedia.org/wiki/A_Pattern_Language)
published in 1977
and refers to a template solution to a problem commonly encountered when building a system.

Design patterns are relatively small-scale templates
which we can use to solve problems which affect a small part of our software.
For example, the **[adapter pattern](https://en.wikipedia.org/wiki/Adapter_pattern)**
(which allows a class that does not have the "right interface" to be reused)
may be useful if part of our software needs to consume data
from a number of different external data sources.
Using this pattern,
we can create a component whose responsibility is
transforming the calls for data to the expected format,
so the rest of our program doesn't have to worry about it.

Architecture patterns are similar,
but larger scale templates which operate at the level of whole programs,
or collections or programs.
Model-View-Controller (which we chose for our project) is one of the best known architecture patterns.
Many patterns rely on concepts from [Object Oriented Programming](/object-oriented-programming/index.html).

There are many online sources of information about design and architecture patterns,
often giving concrete examples of cases where they may be useful.
One particularly good source is [Refactoring Guru](https://refactoring.guru/design-patterns).

### Multilayer Architecture

One common architectural pattern for larger software projects is **Multilayer Architecture**.
Software designed using this architecture pattern is split into layers,
each of which is responsible for a different part of the process of manipulating data.

Often, the software is split into three layers:

- **Presentation Layer**
  - This layer is responsible for managing the interaction between
    our software and the people using it
  - May include the **View** components if also using the MVC pattern
- **Application Layer / Business Logic Layer**
  - This layer performs most of the data processing required by the presentation layer
  - Likely to include the **Controller** components if also using an MVC pattern
  - May also include the **Model** components
- **Persistence Layer / Data Access Layer**
  - This layer handles data storage and provides data to the rest of the system
  - May include the **Model** components of an MVC pattern
    if they're not in the application layer

Although we've drawn similarities here between the layers of a system and the components of MVC,
they're actually solutions to different scales of problem.
In a small application, a multilayer architecture is unlikely to be necessary,
whereas in a very large application,
the MVC pattern may be used just within the presentation layer,
to handle getting data to and from the people using the software.

{% include links.md %}
