---
title: "When to abstract, and when not to."
teaching: 0
exercises: 0
questions:
- "How to tell what is and isn't an appropriate abstraction."
- "How to design larger solutions."
objectives:
- "Understand how to determine correct abstractions. "
- "How to design large changes to the codebase."
keypoints:
- "YAGNI - you ain't gonna need it - don't create abstractions that aren't useful."
- "The best code is simple to understand and test, not the most clever or uses advanced language features."
- "Sketching a diagram of the code can clarify how it is supposed to work, and troubleshoot problems early."
---

## Introduction

In this section we have explored a range of techniques for architecting code:

 * Using pure functions assembled into pipelines to perform analysis
 * Using established patterns to discuss design
 * Separating different considerations, such as how data is presented from how it is stored
 * Using classes to create abstractions

None of these techniques are always applicable, and they are not sufficient to design a good technical solution.

## Architecting larger changes

When creating a new application, or creating a substantial change to an existing one,
it can be really helpful to sketch out the intended architecture on a whiteboard
(pen and paper works too, though of course it might get messy as you iterate on the design!).

The basic idea is you draw boxes that will represent different units of code, as well as
other components of the system (such as users, databases etc).
Then connect these boxes with lines where information or control will be exchanged.
These lines represent the interfaces in your system.

As well as helping to visualise the work, doing this sketch can troubleshoot potential issues.
For example, if there is a circular dependency between two sections of the design.
It can also help with estimating how long the work will take, as it forces you to consider all the components that
need to be made.

Diagrams aren't foolproof, and often the stuff we haven't considered won't make it on to the diagram
but they are a great starting point to break down the different responsibilities and think about
the kinds of information different parts of the system will need.


> ## Exercise: Design a high-level architecture
> Sketch out a design for a new feature requested by a user
>
> *"I want there to be a Google Drive folder that when I upload new inflammation data to
> the software automatically pulls it down and updates the analysis.
> The new result should be added to a database with a timestamp.
> An email should then be sent to a group email notifying them of the change."*
>
> TODO: this doesn't generate a very interesting diagram
>
>> ## Solution
>> An example design for the hypothetical problem. (TODO: incomplete)
>> ```mermaid
graph TD
    A[(GDrive Folder)]
    B[(Database)]
    C[GDrive Monitor]
    C -- Checks periodically--> A
    D[Download inflammation data]
    C -- Trigger update --> D
    E[Parse inflammation data]
    D --> E
    F[Perform analysis]
    E --> F
    G[Upload analysis]
    F --> G
    G --> B
    H[Notify users]
>> ```
> {: .solution}
{: .challenge}

## An abstraction too far

So far we have seen how abstractions are good for making code easier to read, maintain and test.
However, it is possible to introduce too many abstractions.

> All problems in computer science can be solved by another level of indirection except the problem of too many levels of indirection

When you introduce an abstraction, if the reader of the code needs to understand what is happening inside the abstraction,
it has actually made the code *harder* to read.
When code is just in the function, it can be clear to see what it is doing.
When the code is calling out to an instance of a class that, thanks to polymorphism, could be a range of possible implementations,
the only way to find out what is *actually* being called is to run the  code and see.
This is much slower to understand, and actually obfuscates meaning.

It is a judgement as to whether you have make the code too abstract.
If you have to jump around a lot when reading the code that is a clue that is too abstract.
Similarly, if there are two parts of the code that always need updating together, that is
again an indication of an incorrect or over-zealous abstraction.


## You Ain't Gonna Need It

There are different approaches to designing software.
One principle that is popular is called You Ain't Gonna Need it - "YAGNI" for short.
The idea is that, since it is hard to predict the future needs of a piece of software,
it is always best to design the simplest solution that solves the problem at hand.
This is opposed to trying to imagine how you might want to adapt the software in future
and designing the code with that in mind.

Then, since you know the problem you are trying to solve, you can avoid making your solution unnecessarily complex or abstracted.

In our example, it might be tempting to abstract how the `CSVDataSource` walks the file tree into a class.
However, since we only have one strategy for exploring the file tree, this would just create indirection for the sake of it
- now a reader of CSVDataSource would have to read a different class to find out how the tree is walked.
Maybe in the future this is something that needs to be customised, but we haven't really made it any harder to do by *not* doing this prematurely
and once we have the concrete feature request, it will be easier to design it appropriately.

> All of this is a judgement.
> For example, in this case, perhaps it *would* make sense to at least pull the file parsing out into a separate
> class, but not have the CSVDataSource be configurable.
> That way, it is clear to see how the file tree is being walked (there's no polymorphism going on)
> without mixing the *parsing* code in with the file finding code.
> There are no right answers, just guidelines.
{: .callout}

> ## Exercise: Applying to real world examples
> Thinking about the examples of good and bad code you identified at the start of the episode.
> Identify what kind of principles were and weren't being followed
> Identify some refactorings that could be performed that would improve the code
> Discuss the ideas as a group.
{: .challenge}

## Conclusion

Good architecture is not about applying any rules blindly, but instead practise and taking care around important things:

* Avoid duplication of code or data.
* Keeping how much a person has to understand at once to a minimum.
* Think about how interfaces will work.
* Separate different considerations into different sections of the code.
* Don't try and design a future proof solution, focus on the problem at hand.

Practise makes perfect.
One way to practise is to consider code that you already have and think how it might be redesigned.
Another way is to always try to leave code in a better state that you found it.
So when you're working on a less well structured part of the code, start by refactoring it so that your change fits in cleanly.
Doing this, over time, with your colleagues, will improve your skills as software architecture as well as improving the code.
