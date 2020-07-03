---
title: "Preparing Software for Reuse"
teaching: 40
exercises: 20
questions:
- "Key question (FIXME)"
objectives:
- "Use code linting tools to verify a program's adherence to a Python coding style"
- "Describe minimum components of software documentation to aid reuse"
- "Understand other documentation components and where they are useful"
- "Create a repository README file to guide others to successfully reuse a program"
- "Describe the basic types of open source software licence"
- "Explain the importance of conforming to data policy and regulation"
keypoints:
- "The reuse battle is won before it is fought. Use good practices consistently throughout development and not just at the end."
---

## The levels of software reusability - good practice revisited

Whilst we want to ensure our software is reusable by others, as well as ourselves, we should be clear what we mean by 'reusable'. There are a number of definitions out there, but a helpful one written by [Benureau and Rougler in 2017](https://dx.doi.org/10.3389/fninf.2017.00069) offers the following levels by which software can be characterised:

1. Re-runnable: the code is simply executable and can be run again (but there are no guarantees beyond that)
2. Repeatable: the software will produce the same result more than once
3. Reproducible: published research results generated from the same version of the software can be generated again from the same input data
4. Reusable: easy to use, understand, and modify
5. Replicable: the software can act as an available reference for any ambiguity in the algorithmic descriptions made in the published article. That is, a new implementation can be created from the descriptions in the article that provide the same results as the original implementation, and that the original - or reference - implementation, can be used to clarify any ambiguity in those descriptions for the purposes of reimplementation

Later levels imply the earlier ones. So what should we aim for? As researchers who develop software - or developers who write research software - we should be aiming for at least the fourth one: reusability. Reproducibility is required if we are to successfully claim that what we are doing when we write software fits within acceptable scientific practice, but it is also crucial that we can write software that can be *understood* by others. If others are unable to verify that a piece of software follows published algorithms and ideally *modified*. Where 'others', of course, can include a future version of ourselves.

> ## Reproducibility and non-determinism
>
> FIXME: a note on how software that is intrinsically non-deterministic still fits within the bounds of repeatability and reproducibilty, and the importance of defining acceptable bounds for that.
>
{: .callout}

FIXME: use this narrative throughout section, e.g. where a practice helps us achieve one of these levels

FIXME: add section that highlights practices already covered in the course in the context of these, as a framework?

## Verifying code style using linters



## Documenting code for reuse

### Minimum documentation to aim for

### Creating a README

## Choosing an open source licence

## Conforming to data policy and regulation

{% include links.md %}
