---
title: "Software Improvement through Feedback"
teaching: 5
exercises: 25
questions:
- "How should we handle feedback on our software?"
- "How, and to what extent, should we provide support to our users?"
objectives:
- "Prioritise and work on externally registered issues"
- "Respond to submitted issue reports and provide feedback"
- "Explain the importance of software support and choosing a suitable level of support"
keypoints:
- ""
---

When a software project has been around for even just a short amount of time, you'll likely discover many aspects that can be improved. These can come from issues that have been registered via collaborators or users, but also those you're aware of internally, which should also be registered as issues. When starting a new software project, you'll also have to determine how you'll handle all the requirements. But which ones should you work on first, which are the most important and why, and how should you organise all this work?

Software has a fundamental role to play in doing science, but unfortunately software development is often given short shrift in academia when it comes to prioritising effort. There are also many other draws on our time in addition to the research, development, and writing of publications that we do, which makes it all the more important to prioritise our time for development effectively.

In this lesson we'll be looking at prioritising work we need to do and what we can use from the agile perspective of project management to help us do this in our software projects.


## Estimation as a foundation for prioritisation

For simplicity, we'll refer to our issues as *requirements*, since that's essentially what they are - new requirements for our software to fulfil.

But before we can prioritise our requirements, there are some things we need to find out.

Firstly, we need estimates for how long each requirement will take to resolve, since we cannot meaningfully prioritise requirements without knowing what the effort tradeoffs will be. Even if we know how important each requirement is, how would we even know if completing the project is possible? Or if we don't know how long it will take to deliver those requirements s we deem to be critical to the success of a project, how can we know if we can include other less important ones?

It is often not the reality, but estimation should ideally be done by the people likely to do the actual work (i.e. the Research Software Engineers, researchers, or developers). It shouldn't be done by project managers or PIs simply because they are not best placed to estimate, and those doing the work are the ones who are effectively committing to these figures.

> ## Why is it so difficult to estimate?
>
> Estimation is a very valuable skill to learn, and one that is often difficult. Lack of experience in estimation can play a part, but a number of psychological causes can also contribute. One of these is Dunning-Kruger, a type of cognitive bias in which people tend to overestimate their abilities, whilst in opposition to this is imposter syndrome, where due to a lack of confidence people underestimate their abilities. The key message here is to be honest about what you can do, and find out as much information that is reasonably appropriate before arriving at an estimate.
>
> More experience in estimation will also help to reduce these effects. So keep estimating!
{: .callout}

An effective way of helping to make your estimates more accurate is to do it as a team. Other members can ask prudent questions that may not have been considered, and bring in other sanity checks and their own development experience. Just talking things through can help uncover other complexities and pitfalls, and raise crucial questions to clarify ambiguities.

> ## Estimate!
>
> As a team go through the issues that your partner team has registered with your software repository, and estimate how long each issue will take to resolve in minutes. Do this by blind consensus first, each anonymously submitting an estimate, and then discuss your rationale and decide on a final estimate. Make sure you are able to complete your estimates in the allotted time!
>
> > ## Solution
> {: .solution}
>
{: .challenge}

In general, we'd also need to know:

- *The period of time we have to resolve these requirements* - e.g. before the next software release, pivotal demonstration, or other deadline requiring their completion. This is known as a **timebox**
- *How much overall effort we have available* - i.e. who will be involved and how much of their time we will have during this period


# Using MoSCoW to prioritise work

Now we have our estimates we can decide how important each requirement is to the success of the project. This should be decided by the project stakeholders; those - or their representatives - who have a stake in the success of the project and are either directly affected or affected by the project, e.g. Principle Investigators, researchers, Research Software Engineers, collaborators, etc.

To prioritise these requirements we can use a method called **MoSCoW**, a way to reach a common understanding with stakeholders on the importance of successfully delivering each requirement for a timebox. MoSCoW is an acronym that stands for **Must have**, **Should have**, **Could have**, and **Won't have**. Each requirement is discussed by the stakeholder group and falls into one of these categories:

- *Must Have* (MH) - these requirements are critical to the current timebox for it to succeed. Even the inability to deliver just one of these would cause the project to be considered a failure.
- *Should Have* (SH) - these are important requirements but not *necessary* for delivery in the timebox. They may be as *important* as Must Haves, but there may be other ways to achieve them or perhaps they can be held back for a future development timebox.
- *Could Have* (CH) - these are desirable but not necessary, and each of these will be included in this timebox if it can be achieved.
- *Won't Have* (WH) - these are agreed to be out of scope for this timebox, perhaps because they are the least important or not critical for this phase of development.

In typical use, the ratio to aim for of requirements to the MH/SH/CH categories is 60%/20%/20%. Importantly, the division is by the requirement *estimates*, not by number of requirements, so 60% means 60% of the overall estimated effort for requirements are Must Haves. This effectively forces a tradeoff between

This gives you a unique degree of control of your project. It awards you 40% of flexibility with allocating your effort depending on what's critical and how things progress. The idea is that even if you are only able to deliver the Must Haves, whilst it may not have everything initially requested you have delivered a *successful* project.

FIXME: bit on how to assign issues to a new milestone

> ## Prioritise!
>
> Put your stakeholder hats on, and as a team apply MoSCoW to the repository issues to determine how you will prioritise effort to resolve them in the stated allotted time. Try to stick to the 60/20/20 rule, and assign all issues you'll be working on (i.e. not Won't Haves) to a new milestone, e.g. version 1.1
>
> > ## Solution
> {: .solution}
>
{: .challenge}

## Using sprints to organise and work on requirements

FIXME: add small bit on sprints and how to assign repository issues to people

> ## Conduct a mini-sprint
>
> For the remaining time in this lesson, assign repository issues to team members and work on resolving them. Once an issue has been resolved, notable progress made, or an impasse has been reached, provide concise feedback on the repository issue.
>
> > ## Solution
> {: .solution}
>
{: .challenge}


FIXME: describe milestones, add those issues outstanding or not worked on to a new milestone

{% include links.md %}
