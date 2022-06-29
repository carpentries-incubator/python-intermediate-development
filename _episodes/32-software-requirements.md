---
title: "Software Requirements"
teaching: 15
exercises: 30
questions:
- "Where do we start when beginning a new software project?"
- "FIXME"
objectives:
- "FIXME"
keypoints:
- "When writing software used for research, requirements will almost *always* change."
- "FIXME"
---

FIXME: introduction

So far in this episode we've extended our application - designed around an MVC architecture - with a new view to see a patient's data. Let's now take a further step back from design and implementation to the level of software requirements. Requirements can be categorised in many ways, but at a high level a useful way to split them is into *Business Requirements*, *User Requirements*, and *Solution Requirements*. Let's take a look at these now.

### Business Requirements

Business requirements describe what is needed from the perspective of the organisation, and define the strategic path of the project, e.g. to increase profit margin or market share, or embark on a new research area or collaborative partnership. These are captured in something like a Business Requirements document.

For adapting our inflammation software project, example business requirements could include:

- BR1: improving the statistical quality of clinical trial reporting to meet the needs of external audits 
- BR2: increasing the throughput of trial analyses to meet higher demand during peak periods

### User (or Stakeholder) Requirements

These define what particular stakeholder groups each expect from an eventual solution, essentially acting as a bridge between the higher-level business requirements and specific solution requirements. These are typically captured in a User Requirements Specification.

For our inflammation project, they could include things for trial managers such as (building on the business requirements):

- UR1 (from BR1): add support for statistical measures in generated trial reports as required by revised auditing standards (standard deviation, ...)
- UR2 (from BR2): add support for producing textual representations of statistics in trial reports as required by revised auditing standards
- UR3 (from BR2): ability to have an individual trial report processed and generated in under 30 seconds (if we assume it usually takes longer than that)

### Solution Requirements

Solution (or product) requirements describe characteristics that a concrete solution or product must have to satisfy the stakeholder requirements They fall into two key categories:

- *Functional Requirements* focus on functions and features of a solution. For our software, building on our user requirements, e.g.
    - SR1 (from UR1): add standard deviation to data model and include in graph visualisation view
    - SR2 (from UR2): add a new view to generate a textual representation of statistics, which is invoked by an optional command line argument
- *Non-functional Requirements* focus on *how* the behaviour of a solution is expressed or constrained, e.g. performance, security, usability, or portability. These are also known as *quality of service* requirements. For our project, e.g.:
    - SR3 (from UR3): generate graphical statistics report on clinical workstation configuration in under 30 seconds

FIXME: add exercise

### From Requirements to Implementation, via Design

In practice, these different types of requirements are sometimes confused and conflated when different classes of stakeholder are discussing them, which is understandable: each group of stakeholder has a different view of *what is required* from a project. The key is to understand the stakeholder's perspective as to how their requirements should be classified and interpreted, and for that to be made explicit. A related misconception is that each of these types are simply requirements specified at different levels of detail. At each level, not only are the perspectives different, but so are the nature of the objectives and the language used to describe them.

It's often tempting to go right ahead and implement requirements within our software, but this neglects a crucial step: do these new requirements fit within our existing design, or does our design need to be revisited? It may not need any changes at all, but if it doesn't fit logically our design will need a bigger rethink so the new requirement can be implemented in a sensible way. We'll look at this a bit later in this episode, but simply adding new code without considering how the design and implementation need to change at a high level can make our software increasingly messy and difficult to change in the future.


{% include links.md %}
