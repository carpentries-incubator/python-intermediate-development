---
title: "Assessing Software for Suitability and Improvement"
teaching: 15
exercises: 30
questions:
- "What makes good code actually good?"
- "What should we look for when selecting software to reuse?"
objectives:
- "Explain why a critical mindset is important when selecting software"
- "Register a new issue with our code on our repository"
- "Describe some different types of issues we can have with software"
- "Conduct an assessment of software against suitability criteria"
- "Describe what should be included in software issue reports and register them"
keypoints:
- "It's as important to have a critical attitude to adopting software as we do to developing it."
- "We should use issues to keep track of software problems and other requests for change - even if we are the only developer and user."
- "As a team agree on who and to what extent you will support software you make available to others."
---

## Introduction

What we've been looking at so far enables us to adopt a more proactive and diligent attitude when developing our own software. But we should also adopt this attitude when selecting and making use of third-party software we wish to use. With pressing deadlines it's very easy to reach for a piece of software that appears to do what you want without considering properly whether it's a good fit for your project first. A chain is only as strong as its weakest link, and our software may inherit weaknesses in any dependent software or create other problems.

Overall, when adopting software to use it's important to consider not only whether it has the functionality you want, but a broader range of qualities that are important for your project.


## Using Issues to Record Problems With Software

As a piece of software is used, bugs and other issues will inevitably come to light - nothing is perfect! If you work on your code with collaborators, or have non-developer users, it can be helpful to have a single shared record of all the problems people have found with the code, not only to keep track of them for you to work on later, but to avoid the annoyance of people emailing you to report a bug that you already know about!

GitHub provides a framework (as does GitLab!) for managing bug reports, feature requests, and lists of future work - *Issues*.

Go back to the home page for your `python-intermediate-inflammation` repository, and click on the Issues tab.
You should see a page listing the open issues on your repository, currently none.

![List of project issues in GitHub](../fig/github-issue-list.png){: .image-with-shadow width="1000px"}

Let's go through the process of creating a new issue. Start by clicking the `New issue` button.

![Creating a new issue in GitHub](../fig/github-new-issue.png){: .image-with-shadow width="1000px"}

When you create an issue, you can provide a range of details added to them. They can be *assigned to a specific developer* for example - this can be a helpful way to know who, if anyone, is currently working to fix an issue (or a way to assign responsibility to someone to deal with it!).

They can also be assigned a **label**. The labels available for issues can be customised, and given a colour, allowing you to see at a glance from the Issues page the state of your code. The default labels include:

- Bug
- Documentation
- Enhancement
- Help Wanted
- Question

The *Enhancement* label can be used to create issues that *request new features*, or if they are created by a developer, *indicate planned new features*. As well as highlighting problems, the *Bug* label can make code much more usable by allowing users to find out if anyone has had the same problem before, and also how to fix (or work around) it on their end. Enabling users to solve their own problems can save you a lot of time and stress!

In general, a good bug report should contain only one bug, specific details of the environment in which the issue appeared (operating system or browser, version of the software and its dependencies), and sufficiently clear and concise steps that allow a developer to reproduce the bug themselves. They should also be clear on what the bug reporter considers factual ("I did this and this happened") and speculation ("I think it was caused by this"). If an error report was generated from the software itself, it's a very good idea to include that in the bug report.

The Enhancement label is a great way to communicate your future priorities to your collaborators, and also your future self - it’s far too easy to leave a software project for a few months to write a paper, then come back and have forgotten the improvements you were going to make. If you have other users for your code, they can use the label to request new features, or changes to the way the code operates. It’s generally worth paying attention to these suggestions, especially if you spend more time developing than running the code. It can be very easy to end up with quirky behaviour because of off-the-cuff choices during development. Extra pairs of eyes can point out ways the code can be made more accessible, and the easier a code is to use, then the more widely it will be adopted and the greater its impact will be.

> ## Wontfix
>
> One interesting label is **Wontfix**, which indicates that an issue simply won't be worked on for whatever reason. Maybe the bug it reports is outside of the use case of the software, or the feature it requests simply isn't a priority.
>
> The **Lock issue** and **Pin issue** buttons allow you to block future comments on an issue, and pin it to the top of the issues page. This can make it clear you've thought about an issue and dismissed it!
{: .callout}

Having open, publicly-visible lists of the the limitations and problems with your code is incredibly helpful. Even if some issues end up languishing unfixed for years, letting users know about them can save them a huge amount of work attempting to fix what turns out to be an unfixable problem on their end. It can also help you see at a glance what state your code is in, making it easier to prioritise future work!

> ## Our First Issue!
>
> Thinking back to the previous exercise on what makes good code, with a critical eye think of an aspect of the code you have developed so far that needs improvement. It could be a bug, for example, or a documentation issue with your README, or an enhancement. Enter the details of the issue with a suitable label and select `Submit new issue`.
>
> Time: 5 mins
{: .challenge}


### Mentions

As lots of bugs will have similar roots, GitHub lets you **reference one issue from another**. Whilst writing the description of an issue, or commenting on one, if you type <kbd>#</kbd> you should see a list of the issues and pull requests on the repository. They are coloured green if they're open, or white if they're closed. Continue typing the issue number, and the list will narrow, then you can hit <kbd>Return</kbd> to select the entry and link the two. You can also navigate the list with the <kbd>↑</kbd> and <kbd>↓</kbd> arrow keys.

If you realise that several of your bugs have common roots, or that one Enhancement can't be implemented before you've finished another, you can use the mention system to indicate which. This is a simple way to add much more information to your issues.

You can also use the mention system to link **GitHub accounts**. Instead of <kbd>#</kbd>, typing <kbd>@</kbd> will bring up a list of accounts linked to the repository. Users will receive notifications when somebody else references them which you can use to notify people when you want to check a detail with them, or let them know something has been fixed (much easier than writing out all the same information again in an email!).

> ## You Are A User
>
> This section focuses a lot on how issues can help communicate the current state of the code to others. As a sole developer, and possibly also the only user of the code too, you might be tempted to not bother with recording issues and features as you don't need to communicate the information to anyone else.
>
> Unfortunately, human memory isn't infallible! After spending six months writing your thesis, or a year working on a different sub-topic, it's inevitable you'll forget some of the plans you had and problems you faced. Not documenting these things can lead to you having to re-learn things you already put the effort into discovering before.
{: .callout}


## Assessing Software for Suitability

> ## Decide on your Group's Repository!
>
> You all have your code repositories you have been working on throughout the course so far. For the upcoming exercise, groups will exchange repositories and review the code of the repository they inherit, and provide feedback.
>
> Time: 5 mins
>
> 1. Decide as a team on one of your repositories that will represent your group. You can do this any way you wish.
> 2. Add the URL of the repository to the section in the Google Doc labelled 'Decide on your Group's Repository' for this day, next to your team name in the empty table cell
{: .challenge}

> ## Conduct Assessment on Third-Party Software
>
> *The scenario:* It is envisaged that a piece of software developed by another team will be adopted and used for the long term in a number of future projects. You have been tasked with conducting an assessment of this software to identify any issues that need resolving prior to working with it, and will provide feedback to the developing team to fix these issues.
>
> Time: 20 mins
>
> 1. As a team, briefly decide who will assess which aspect of the repository, e.g. its docs, tests, codebase, etc.
> 2. Obtain the URL for the repository you will assess from the Google Doc, in the section labelled 'Decide on your Group's Repository' - see the last column which indicates from which team you should get their repository URL
> 3. Conduct the assessment and register any issues you find on the other team's software repository
> 4. Be meticulous in your assessment and register as many issues as you can!
{: .challenge}


> ## Supporting Your Software - How and How Much?
>
> Within your collaborations and projects, what should you do to support other users? Here are some key aspects to consider:
>
> - Provide contact information: so users know what to do and how to get in contact if they run into problems
> - Manage your support: an issue tracker - like the one in GitHub - is essential to track and manage issues
> - Manage expectations: let users know the level of support you offer, in terms of when they can expect responses to queries, the scope of support (e.g. which platforms, types of releases, etc.), the types of support (e.g. bug resolution, helping develop tailored solutions), and expectations for support in the future (e.g. when project funding runs out)
>
> All of this requires effort, and you can't do everything. It's therefore important to agree and be clear on how the software will be supported from the outset, whether it's within the context of a single laboratory, project, or other collaboration, or across an entire community.
{: .callout}

{% include links.md %}
