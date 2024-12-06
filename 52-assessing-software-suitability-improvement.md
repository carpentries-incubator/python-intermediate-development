---
title: 5.2 Assessing Software for Suitability and Improvement
teaching: 15
exercises: 30
---

::::::::::::::::::::::::::::::::::::::: objectives

- Explain why a critical mindset is important when selecting software
- Conduct an assessment of software against suitability criteria
- Describe what should be included in software issue reports and register them

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What makes good code actually good?
- What should we look for when selecting software to reuse?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

What we have been looking at so far enables us to adopt
a more proactive and managed attitude and approach to the software we develop.
But we should also adopt this attitude when
selecting and making use of third-party software we wish to use.
With pressing deadlines it is very easy to reach for
a piece of software that appears to do what you want
without considering properly whether it is a good fit for your project first.
A chain is only as strong as its weakest link,
and our software may inherit weaknesses in any dependent software or create other problems.

Overall, when adopting software to use it is important to consider
not only whether it has the functionality you want,
but a broader range of qualities that are important for your project.
Adopting a critical mindset when assessing other software against suitability criteria
will help you adopt the same attitude when assessing your own software for future improvements.

## Assessing Software for Suitability

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Decide on Your Group's Repository!

You all have your code repositories you have been working on throughout the course so far.
For the upcoming exercise,
groups will exchange repositories and review the code of the repository they inherit,
and provide feedback.

1. Decide as a team on one of your repositories that will represent your group.
  You can do this any way you wish,
  but if you are having trouble then a pseudo-random number might help:
  `python -c "import numpy as np; print(np.random.randint(low=1, high=<size_group_plus_1>))"`
2. Add the URL of the repository to
  the section of the shared notes labelled 'Decide on your Group's Repository',
  next to your team's name.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Conduct Assessment on Third-Party Software

*The scenario:* It is envisaged that a piece of software developed by another team will be
adopted and used for the long term in a number of future projects.
You have been tasked with conducting an assessment of this software
to identify any issues that need resolving prior to working with it,
and will provide feedback to the developing team to fix these issues.

1. As a team, briefly decide who will assess which aspect of the repository,
  e.g. its documentation, tests, codebase, etc.
2. Obtain the URL for the repository you will assess from the shared notes document,
  in the section labelled 'Decide on your Group's Repository' -
  see the last column which indicates which team's repository you are assessing.
3. Conduct the assessment
  and register any issues you find on the other team's software repository on GitHub.
4. Be meticulous in your assessment and register as many issues as you can!

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Supporting Your Software - How and How Much?

Within your collaborations and projects, what should you do to support other users?
Here are some key aspects to consider:

- Provide contact information:
  so users know what to do and how to get in contact if they run into problems
- Manage your support:
  an issue tracker - like the one in GitHub - is essential to track and manage issues
- Manage expectations:
  let users know the level of support you offer,
  in terms of when they can expect responses to queries,
  the scope of support (e.g. which platforms, types of releases, etc.),
  the types of support (e.g. bug resolution, helping develop tailored solutions),
  and expectations for support in the future (e.g. when project funding runs out)

All of this requires effort, and you cannot do everything.
It is therefore important to agree and be clear on
how the software will be supported from the outset,
whether it is within the context of a single laboratory,
project,
or other collaboration,
or across an entire community.


::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::: keypoints

- It is as important to have a critical attitude to adopting software as we do to developing it.
- As a team agree on who and to what extent you will support software you make available to others.

::::::::::::::::::::::::::::::::::::::::::::::::::


