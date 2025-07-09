---
title: Instructor Notes
---

:::::::::::::::::::::::::::::::::::::::::  callout

## Common Issues \& Tips

Check out a [list of issues](../learners/common-issues.md) previous participants of the course encountered
and some tips to help you with troubleshooting at the workshop.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Course Design

The course follows a narrative around
a software development team working on an existing software project
that is analysing patients' inflammation data
(from the [novice Software Carpentry Python course](https://software-carpentry.org/lessons).
The course is meant to be delivered as a single unit
as the course's code examples and exercises built on top of previously covered topics and code -
so skipping or missing bits of the course would cause students to
get out of sync and cause them difficulties in following subsequent sections.

A typical learner for the course is
someone who has gained foundational software development skills in using Git,
command line shell and Python
(e.g. by attending prior courses or by self-learning),
and has used these skills for individual code development and scripting.
They are now joining the development team where they will require
a number of software development tools and intermediate software development skills
to engineer their code more properly
taking into consideration the lifecycle of software,
team ethic, writing software for stakeholders,
and applying a process to understanding, designing, building, releasing, and maintaining software.

The course has been separated into 5 sections:

- Section 1: Setting Up Environment For Collaborative Code Development
- Section 2: Ensuring Correctness of Software at Scale
- Section 3: Software Development as a Process
- Section 4: Collaborative Software Development for Reuse
- Section 5: Improving and Managing Software Over Its Lifetime

Each section can be approximately delivered in a half-day but even better if you can allow 1 day per section.

## Course Delivery

The course is intended primarily for self-learning
but other modes of delivery have been used successfully
(e.g. fully instructor-led code-along mode or mixing in elements of instructor-led with self-work).
The way the course has been delivered so far is that
students are organised in small groups from the outset
and initially work individually through the material.
In later sections,
exercises involve more group work
and people from the same group form small development teams
and collaborate on a mini software project
(to provide more in-depth practice for software development in teams).
There is a bunch of helpers on hand who sit with learners in groups.
This provides a more comfortable and less intimidating learning environment
with learners more willing to engage and chat with their group colleagues about what they are doing
and ask for help.

The course can be delivered online or in-person.
A good ratio is 4-6 learners to 1 helper.
If you have a smaller number of helpers than groups -
helpers can roam around to make sure groups are making progress.
While this course can be live-coded by an instructor as well,
we felt that intermediate-level learners are capable of
going through the material on their own at a reasonable speed
and would not require to code-along to the same extent as novice learners.
In later stages, exercises require participants to develop code more individually
so they can review and comment on each other's code,
so the codes need to be sufficiently different for these exercises to be effective.
For instructor-led mode of delivery, you can have an instructor live-code these group exercises
after learners have been given a chance to work on them as a team.

A workshop kicks off with everyone together at the start of each day.
One of course leads/helpers provides workshop introduction
and motivation to paint the bigger picture and set the scene for the whole workshop.
In addition, a short intro to the section topics is provided on each day,
to explain what the students will be learning and doing on that particular day.
After that, participants are split into groups
and go through the materials for that day on their own with helpers on hand.
Each section holds optional exercises at the end for fast learners to go through if they finish early.
At the end of each section, all reconvene for a joint Q\&A session, feedback and wrap-up.
If participants have not finished all exercises for a section (in "self-learning with helpers" mode),
they are asked to finish them off before the next section starts
to make sure everyone is in sync as much as possible and are working on similar things
(though students will inevitably cover the material at different speeds).
This synchronisation becomes particularly important for later workshop stages
when students start with group exercises.

Although not explicitly endorsed,
it is quite possible for learners to do the course using VS Code instead of PyCharm.
There is a section for setting up VS Code in the [this adjacent extras page](../learners/vscode.md).
However, when progressing through the section [Integrated Software Development Environments](../episodes/13-ides.md),
it can be a bit difficult for learners to pay attention to both pages.
Therefore, some instructors have found it helpful to perform a demonstration on their own machines of how to use VS Code to achieve the same functionality as PyCharm.
It is worthwhile preparing this in advance of the session.

### Helpers Roles and Responsibilities

At the workshop, when using the "self-learning with helpers" delivery mode, everyone in the training team is a helper and
there are no instructors per se.
You may have more experienced helpers delivering introductions to the workshop and sections.
Contact the course authors for section intro slides you can reuse, and you can also find slides for each
section in the course repository (for instructor-led delivery mode).

Roles and responsibilities of helpers include:

- Being familiar with the material
- Facilitating groups/breakout rooms and helping people going through the material
- Try to prepare a few questions/discussion points
  to take to groups/breakout rooms to make sure the groups are engaged
  (but note some learners may find discussions distracting so try to find a balance)
- Taking notes on what works well and what not - throughout the workshop -
  from their individual perspective and perspectives of students:
  - Collecting general feelings and comments
  - Their thoughts as a potential student and instructor
- Noting mistakes, inconsistencies and learning obstacles in the materials
- Recording issues or doing PRs in the lesson repository during or after of the workshop
- Helping students get through the material
  but also being ready to answer questions on applying the material in learners' domains,
  if possible
- Monitoring the progress of students
  - get up every now and then and do a walk around the room, look at stickies and have a peak at
    computer screens (particularly if the session is running a bit behind)
  - ask any learners that you might have helped previously how they are getting on

### Group Exercises

Here is some advice on how best to sync and organise group exercises in later stages of the course.

- For earlier workshop stages,
  where learners go through the material individually (though placed in groups),
  maintaining the same group composition is not all that important.
  However, it would be good to maintain the same teams once group exercises start,
  as group will chose one software project to be the "team project" to work on.
- Take a note of who was in which group between different days
  (e.g. in a share document where people can sign up),
  as people tend to forget (especially for online workshop).
- Some group exercises start in the middle (rather than at the beginning) of a section.
  This means that synchronisation is needed to make sure
  everyone starts at the same time during that particular session.
  As some students will naturally be ready faster,
  perhaps have a shared document for people to put their names down
  as they are ready to start with the group exercises,
  and organise them in teams based on the speed they are covering the material.
  Even if these groups change from previous days,
  it will ensure people's idle time is minimised.
- People may lose motivation in the later stages involving teamwork
  if some team members are missing -
  while this may be inevitable due to other commitments,
  make it clear during workshop advertising
  that people should try to commit workshop days/times.
- Make it obvious to the learners that they should
  catch up with any unfinished material or exercises from the previous session
  before joining the next one -
  this is even more important for group exercises so the teams are not stalled.




