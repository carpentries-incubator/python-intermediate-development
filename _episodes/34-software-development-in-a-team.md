---
title: "Developing Software In a Team"
teaching: ""
exercises: ""
questions: 
- "What is code review and how it can improve the quality of the codebase?"
objectives:
- "Describe commonly used code review techniques."
- "Understand how to do a pull request (PR) via GitHub to contribute to a team codebase."
keypoints:
- "Code review is a team software quality assurance practice where team members look at parts of the codebase in order 
to improve code readability, understandability, quality and maintainability."
---

>## Note
> - This episode needs finishing off - it contains soma suggested and basic structure (with some content) and is missing exercises.
> - For an  online workshop, we could split learners in pairs and add each other as collaborators 
> on their repositories. Then have them create PRs on each others repos and do code review on PRs received on own repos. 
> Because we cannot do multiple screen sharing we cannot do pair programming and over-the-shoulder programming in an online setting 
> but this may be possible in in person setting (so have 2 people pair program and then do a PR on the third team member's repo, then 
> do code reviews independently).
> - Exercise suggestions:
>    - adding tests to the code written in the previous episode
>    - adding additional views over the data 
> - This will give learners a chance to to write more code independently and different from the 
> suggested solutions. This will enable them to be able to comment more on each other's solutions.
> - Also need to be able to introduce conflicts in exercises so that learners can look into resolving conflicts.
> - **From AZ: mention various code review techniques but focus on code review as part of pull requests**
{: .note}

## Introduction

So far in this course we’ve focused on learning software design and (some) technical practices, tools 
and infrastructure that help the development of software in a team environment, but in an individual setting.
Despite developing tests to check our code - no one else from the team had a look at our code 
before we merged it into the main development stream. Software is often designed and built as part of a team, 
so in this episode we'll be looking at how to manage the process of team software development and improve our 
code by engaging in code review process with other team members.

## Collaborative Code Development Models
The way you use pull requests depends on the type of development model you use in your project. 
You can use the **fork and pull model** or the **shared repository model**.

### Fork and Pull Model
In the fork and pull model, anyone can fork an existing repository and push changes to their personal fork. 
You do not need permission to the source repository to push to a user-owned fork. The changes can be pulled 
into the source repository by the project maintainer via pull requests. When you open a pull request proposing 
changes from your user-owned fork to a branch in the source (upstream) repository, you can allow anyone with 
push access to the upstream repository to make changes to your pull request. You may use this model when you are an external collaborator on a project rather than a core team member. This model is popular with open
source projects as it reduces the amount of friction for new contributors and allows people to work
independently without upfront coordination.

### Shared Repository Model
In the shared repository model, collaborators are granted push access to a single shared repository and 
feature branches are created when changes need to be made. Pull requests are useful in this model as 
they initiate code review and general discussion about a set of changes before the changes are merged 
into the main development branch. This model is more prevalent with smaller teams and organisations 
collaborating on private projects.

## Code Review

[Code review][code-review] is a software quality
assurance practice where one or several people from the team (different from the code's author) check the software by
viewing parts of its source code with the purpose of:

- improving internal code readability, understandability, quality and maintainability
- checking for coding standards compliance, code uniformity and consistency
- detecting bugs and code defects early
- detecting performance problems and identifying code optimisation points
- finding alternative/better solutions.

An effective code review prevents errors from creeping into your software by improving code quality at an early
stage of the software development process. It helps with learning, i.e. knowledge transfer about the codebase,
solution approaches, expectations regarding quality, etc. As a senior developer typically conducts a code
review while a junior developer may use this feedback to improve their own coding - it then further leads to
improving team members’ expertise. Finally, it helps increase sense of collective code ownership and responsibility.

There are several ways to conduct code reviews - here we mention two commonly used ones.

### Pair Programming
One way to conduct code review is **pair programming** - two developers sit together
at a computer, but only one of them actively codes whereas the other provides real-time feedback. It is a
great tool to inspect new code and train developers, especially if an experienced team member walks a younger
developer through the new code, providing explanations and suggestions through a conversation. It is conducted
in-person and synchronously but it can be time-consuming as the reviewer cannot do any other work during the
pair programming period.

### Tool-Assisted Code Review
A tool-assisted code review process uses a specialised tool to facilitate the process of code review, which typically
helps with the following tasks:

- displaying the updated files and highlighting what has changed
- facilitate a conversation between team members (reviewers and developers)

Modern tools may provide a handful of other functionalities. GitHub has a built-in code review tool -
**pull requests** - included with its core service for free. in its pull requests.
Pull requests are fundamental to how teams review and improve code on GitHub (and similar code sharing platforms).
They let you tell others about changes you've pushed to a branch in a repository on GitHub. As the name says - you are effectively **requesting** the codebase maintainers to **pull** your changes into the codebase.
Once a pull request is opened, you can discuss and review the potential changes with other on the team
and add follow-up commits before your changes are merged into the `develop` or `main` branch.



Let's do some exercises now to practice code review via pull requests. For this, you 
will have to be organised in small teams with your fellow learners.

...

Exercise suggestions:
- adding tests to the code written in the previous episode
- adding additional views over the data

{% include links.md %}
