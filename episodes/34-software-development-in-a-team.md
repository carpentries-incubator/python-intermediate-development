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
 
{% comment %}
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

{% endcomment %}

## Introduction

So far in this course we’ve focused on learning software design and (some) technical practices, tools 
and infrastructure that help the development of software in a team environment, but in an individual setting.
Despite developing tests to check our code - no one else from the team had a look at our code 
before we merged it into the main development stream. Software is often designed and built as part of a team, 
so in this episode we'll be looking at how to manage the process of team software development and improve our 
code by engaging in code review process with other team members.

Code review is one of the most useful team code development practices - someone checks your design or code for errors, they get to learn from your solution and having to 
explain code to someone else clarifies the rationale and design decisions in your mind too, and collaboration 
helps to improve the overall team software development process. It is universally applicable throughout
the software development cycle - from design to development to maintenance. According to [Michael Fagan], the 
author of the [code inspection technique](https://en.wikipedia.org/wiki/Fagan_inspection), rigorous inspections can remove 60-90% of errors even before the 
first test is run ([Fagan, 1976](https://doi.org/10.1147%2Fsj.153.0182)). Furthermore, the cost to remedy a defect in the early (design)
stage is 10 to 100 times less compared to fixing the same defect in the development and maintenance 
stages, respectively. Since the cost of bug fixes grows in orders of magnitude through different software 
lifecycle stages, it is essential to find and fix defects as close as possible to the point where they were introduced.

Before we dive into code review techniques and tools, let's have a brief look into team software development models 
used by GitHub and similar distributed version control systems.

## Collaborative Code Development Models
The way your team provides contributions to the shared codebase depends on the type of development model you use in your project. 
Two commonly used models are the **fork and pull model** and the **shared repository model**.

### Fork and Pull Model
In the fork and pull model, anyone can **fork** an existing repository (to create their copy of the project linked to 
the source) and push changes to their personal fork. 
A contributor can work independently on their own fork as they 
do not need permissions on the source repository to push modifications to a fork they own. 
The changes from contributors can then be **pulled** into the source repository by the project maintainer on request 
and after a code review process. This model is popular with open
source projects as it reduces the start up costs for new contributors and allows them to work
independently without upfront coordination with source project maintainers. So, for example, 
you may use this model when you are an 
external collaborator on a project rather than a core team member.

### Shared Repository Model
In the shared repository model, collaborators are granted push access to a single shared code repository. 
Even though collaborators have write access to the main 
development and production branches, the best practice of creating feature branches for new developments and 
when changes need to be made is still followed. This is to enable easier testing of the new code and 
initiate code review and general discussion about a set of changes before they are merged 
into the main development branch. This model is more prevalent with teams and organisations 
collaborating on private projects.

Regardless of the collaborative code development model you and your collaborators use - code reviews are one of the 
widely accepted best practices for software development in teams and something you should adopt in your development 
process too.

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
stage of the software development process. It helps with learning, i.e. sharing knowledge about the codebase,
solution approaches, expectations regarding quality, coding standards, etc. Developers use code review feedback 
from more senior developers to improve their own coding practices and expertise. Finally, it helps increase the sense of 
collective code ownership and responsibility, which in turn helps increase the "bus factor" and reduce the risk resulting from 
information and capabilities being held by a single person "responsible" for a certain part of the codebase and 
not being shared among team members.

There are several ways to conduct code reviews, with differing degree of formality and the use of 
technical infrastructure:

- **Over-the-shoulder code review** is the most common and informal of code review techniques and involves one or more team 
members standing over the code author's shoulder while the author walks the reviewers through a set of code changes.
- **Email pass-around code review** is another form of lightweight code review where the code author packages up a set 
of changes and files and sends them over to reviewers via email. Reviewers examine the files and differences against the
code base, ask questions and discuss with the author and other developers, and suggest changes over email. 
The difficult part of this process is the manual collection the files under review and noting differences.
- **Pair programming** is a code development process that incorporates continuous code review - two developers sit together
at a computer, but only one of them actively codes whereas the other provides real-time feedback. It is a
great way to inspect new code and train developers, especially if an experienced team member walks a younger
developer through the new code, providing explanations and suggestions through a conversation. It is conducted
in-person and synchronously but it can be time-consuming as the reviewer cannot do any other work during the
pair programming period.
- **Fagan code inspection** is a formal and heavyweight team code review method and process of finding defects in 
source code or design specifications during various phases of the software development process - 
see [Fagan inspection](https://en.wikipedia.org/wiki/Fagan_inspection) for full details.
- **Tool-assisted code review** process uses a specialised tool to facilitate the process of code review, which typically
helps with the following tasks: (1) collecting and displaying the updated files and highlighting what has changed, (2) 
facilitating a conversation between team members (reviewers and developers), and (3) allowing code administrators and 
product managers a certain control and overview of the code development workflow. Modern tools may provide a handful of other functionalities too, such as metrics (e.g. inspection or defect rate).

Each of the above processes have their pros and cons and varying degrees of formality and practicality - 
it is up to the team to decide which best practices to follow and to define its code review process.
We will have a look at GitHub's built-in code review tool - **pull requests** - which is lightweight, 
included with GitHub's core service for free and has gained popularity within the software development community 
in recent years.

## Code Reviews via GitHub's Pull Requests

Pull requests are fundamental to how teams review and improve code on GitHub (and similar code sharing platforms) -
they let you tell others about changes you've pushed to a branch in a repository on GitHub and that your 
code is ready for review. Once a pull request is opened, you can discuss and review the potential changes with others 
on the team and add follow-up commits based on the feedback before your changes are merged into 
the main `develop` branch. The name 'pull request' means you are **requesting** the codebase 
maintainers to **pull** your changes into the codebase or to **approve** your pull request and you can merge the 
changes yourself if you have sufficient privileges on the repository (based on the collaborative code development model
used by your team).

These changes to the codebase are normally done in a separate (feature) branch, to ensure that they are separate and 
self-contained and that the default branch only contains "production-ready" work. You create a branch for your work
based on one of the existing branches (typically the `develop` branch but can be any other branch), 
do some commits on that branch, and, once you are ready to merge your changes, create a pull request to bring 
the changes back to that branch. In this 
context, the branch from which you branched off to do your work and where the changes should be applied 
back to is called the **base branch** and the **head branch** (your feature branch)
contains changes you would like to be applied.

### Creating Pull Requests
      
How you create your feature branches and open pull requests in GitHub will depend on your collaborative code development model:

- In the shared repository model, which we will assume in this course and exercises below, in order to create a feature branch and open a 
pull request based on it you must have write access to the source repository or, for organisation-owned repositories, 
you must be a member of the organisation that owns the repository. 
You can also see the [GitHub's "Creating a pull request" documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) 
for more details.
- In the fork and pull model, where you do not have write permissions to the source repository, you need to fork the
repository first before you create a branch (in your fork) to base your pull request on.
For more information, see the [GitHub's "Creating a pull request from a fork" documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork).

In either case, once you are ready to merge your changes in - you will need to specify the base branch and the head
branch. Let's see this in action in the shared repository model.

#### Preparing Your Local Environment for a Pull Request
#### Submitting a Pull Request
#### Code Review and Closing a Pull Request


## Best Practices for Code Reviews

You may recall that your team has already decided on the process  
for handling the branches in the project repository - using the `main` branch only for finished, approved 
and 'production-ready' code, the `develop` branch for 
work-in-progress code, and feature branches typically for bug fixes and adding new features to the code.

Similarly, your team should set the code review process - here are some recommendations:

- Use a feature branch for your pull request. While you can send 
pull requests from any branch or commit, with a feature branch you can push follow-up commits if you need to update 
your proposed changes.
- When pushing commits to a pull request, don't force push. Force pushing changes the repository history and can corrupt your pull request. If other collaborators branch the project before a force push, the force push may overwrite commits that collaborators based their work on.


{% include links.md %}
