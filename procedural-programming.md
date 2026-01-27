---
title: "Extra Content: Procedural Programming"
teaching: 10
exercises: 0
---

::: questions
- What is procedural programming?
- Which situations/problems is procedural programming well suited for?
:::
::: objectives
- Describe the core concepts that define the procedural programming paradigm
- Describe the main characteristics of code that is written in procedural programming
  style
:::


In procedural programming code is grouped into
procedures (also known as routines -  reusable piece of code that performs a specific action but
have no return value) and functions (similar to procedures but return value after an execution).
Procedures and function both perform a single task, with exactly one entry and one exit point and
containing a series of logical steps (instructions) to be carried out.
The primary concern is the *process* through which the input is transformed into the desired output.

Key features of procedural programming include:

- Sequence control: the code execution process goes through the steps in a defined order, with clear starting and ending points.
- Modularity: code can be divided into separate modules or procedures to perform specific tasks, making it easier to maintain and reuse.
- Standard data structures: Procedural Programming makes use of standard data structures such as
  arrays, lists, and records to store and manipulate data efficiently.
- Abstraction: procedures encapsulate complex operations and allow them to be represented as simple, high-level commands.
- Execution control: variable implementations of loops, branches, and jumps give more control over the flow of execution.

To better understand procedural programming, it is useful to compare it with other prevalent
programming paradigms such as
[object-oriented programming](../learners/object-oriented-programming.md) (OOP)
and [functional programming](../learners/functional-programming.md)
to shed light on their distinctions, advantages, and drawbacks.

Procedural programming uses a very detailed list of instructions to tell the computer what to do
step by step. This approach uses iteration to repeat a series of steps as often as needed.
Functional programming is an approach to problem solving that treats every computation as a
mathematical function (an expression) and relies more heavily on recursion as a primary control
structure (rather than iteration).
Procedural languages treat data and procedures as two different
entities whereas, in functional programming, code is also treated as data - functions
can take other functions as arguments or return them as results.
Compare and contract [two different implementations](../learners/functional-programming.md#functional-vs-procedural-programming)
of the same functionality in procedural and functional programming styles
to better grasp their differences.

Procedural and [object-oriented programming](../learners/object-oriented-programming.md) have fundamental differences in their approach to
organising code and solving problems.
In procedural programming, the code is structured around functions and procedures that execute a
specific task or operations. Object-oriented programming is based around objects and classes,
where data is encapsulated within objects and methods on objects that used to manipulate that data.
Both procedural and object-oriented programming paradigms support [abstraction and modularization](../episodes/33-code-decoupling-abstractions.md).
Procedural programming achieves this through procedures and functions, while OOP uses classes and
objects.
However, OOP goes further by encapsulating related data and methods within objects,
enabling a higher level of abstraction and separation between different components.
Inheritance and polymorphism are two vital features provided by OOP, which are not intrinsically
supported by procedural languages. [Inheritance](../learners/object-oriented-programming.md#inheritance) allows the creation of classes that inherit
properties and methods from existing classes – enabling code reusability and reducing redundancy.
[Polymorphism](../episodes/33-code-decoupling-abstractions.md#polymorphism) permits a single function or method to operate on multiple data types or objects,
improving flexibility and adaptability.

The choice between procedural, functional and object-oriented programming depends primarily on
the specific project requirements and personal preference.
Procedural programming may be more suitable for smaller projects, whereas OOP is typically
preferred for larger and more complex projects, especially when working in a team.
Functional programming can offer more elegant and scalable solutions for complex problems,
particularly in parallel computing.

::: keypoints:
- Procedural Programming emphasises a structured approach to coding, using
  a sequence of tasks and subroutines to create a well-organised program.
:::
