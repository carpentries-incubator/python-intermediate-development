---
title: "Developing Software In a Team: Code Review"
teaching: 15
exercises: 30
questions:
- "How do we develop software in a team?"
- "What is code review and how it can improve the quality of code?"
objectives:
- "Describe commonly used code review techniques."
- "Understand how to do a pull request via GitHub to engage in code review with a team and contribute to a shared code repository."
keypoints:
- "Code review is a team software quality assurance practice where team members look at parts of the codebase in order to improve their code's readability, understandability, quality and maintainability."
- "It is important to agree on a set of best practices and establish a code review process in a team to help to
sustain a good, stable and maintainable code for many years."
---

## Introduction

So far in this course we’ve focused on learning software design
and (some) technical practices, tools and infrastructure that
help the development of software in a team environment, but in an individual setting.
Despite developing tests to check our code - no one else from the team had a look at our code
before we merged it into the main development stream.
Software is often designed and built as part of a team,
so in this episode we'll be looking at how to manage the process of team software development
and improve our code by engaging in code review process with other team members.

> ## Collaborative Code Development Models
> The way your team provides contributions to the shared codebase depends on
> the type of development model you use in your project.
> Two commonly used models are:
>
> - **fork and pull model** -
>   where anyone can **fork** an existing repository
>   (to create their copy of the project linked to the source)
>   and push changes to their personal fork.
>   A contributor can work independently on their own fork as they do not need
>   permissions on the source repository to push modifications to a fork they own.
>   The changes from contributors can then be **pulled** into the source repository
>   by the project maintainer on request and after a code review process.
>   This model is popular with open source projects as it
>   reduces the start up costs for new contributors
>   and allows them to work independently without upfront coordination
>   with source project maintainers.
>   So, for example, you may use this model when you are an external collaborator on a project
>   rather than a core team member.
> - **shared repository model** -
>   where collaborators are granted push access to a single shared code repository.
>   Even though collaborators have write access to the main development and production branches,
>   the best practice of creating feature branches for new developments
>   and when changes need to be made is still followed.
>   This is to enable easier testing of the new code
>   and initiate code review and general discussion about a set of changes
>   before they are merged into the development branch.
>   This model is more prevalent with teams and organisations collaborating on private projects.
{: .callout}

Regardless of the collaborative code development model you and your collaborators use -
code reviews are one of the widely accepted best practices for software development in teams
and something you should adopt in your development process too.

## Code Review

[Code review][code-review] is a software quality assurance practice
where one or several people from the team (different from the code's author)
check the software by viewing parts of its source code.

Code review is one of the most useful team code development practices -
someone checks your design or code for errors, they get to learn from your solution,
having to explain code to someone else clarifies
your rationale and design decisions in your mind too,
and collaboration helps to improve the overall team software development process.
It is universally applicable throughout the software development cycle -
from design to development to maintenance.
According to Michael Fagan, the author of the
[code inspection technique](https://en.wikipedia.org/wiki/Fagan_inspection),
rigorous inspections can remove 60-90% of errors from the code
even before the first tests are run ([Fagan, 1976](https://doi.org/10.1147%2Fsj.153.0182)).
Furthermore, according to Fagan,
the cost to remedy a defect in the early (design) stage is 10 to 100 times less compared to
fixing the same defect in the development and maintenance stages, respectively.
Since the cost of bug fixes grows in orders of magnitude throughout the software lifecycle,
it is far more efficient to find and fix defects
as close as possible to the point where they were introduced.

There are several **code review techniques** with various degree of formality
and the use of a technical infrastructure, including:

 - Over-the-shoulder code review
 - Pair programming
 - [Fagan code inspection]((https://en.wikipedia.org/wiki/Fagan_inspection))
 - Tool assisted code review

It is worth trying multiple code review techniques to see what works
best for you and your team. We will have a look at the **tool-assisted code review process**, which is likely to be the most effective and efficient.
We will use GitHub's built-in code review tool - **pull requests**.
It is a lightweight tool, included with GitHub's core service for free
and has gained popularity within the software development community in recent years.

## Code Reviews via GitHub's Pull Requests

Pull requests are fundamental to how teams review and improve code
on GitHub (and similar code sharing platforms) -
they let you tell others about changes you've pushed to a branch in a repository on GitHub
and that your code is ready for review.
Once a pull request is opened,
you can discuss and review the potential changes with others on the team
and add follow-up commits based on the feedback
before your changes are merged from your feature branch into the `develop` branch.
The name 'pull request' suggests you are **requesting** the codebase moderators
to **pull** your changes into the codebase.

Such changes are normally done on a feature branch,
to ensure that they are separate and self-contained,
that the main branch only contains "production-ready" work,
and that the `develop` branch contains code that has already been extensively tested.
You create a branch for your work based on one of the existing branches
(typically the `develop` branch but can be any other branch),
do some commits on that branch,
and, once you are ready to merge your changes,
create a pull request to bring the changes back to the branch that you started from.
In this context, the branch from which you branched off to do your work
and where the changes should be applied back to
is called the **base branch**,
while the feature branch that contains changes you would like to be applied is the **head branch**.

How you create your feature branches and open pull requests in GitHub will depend on
your collaborative code development model:

- In the shared repository model,
  in order to create a feature branch and open a pull request based on it
  you must have write access to the source repository or,
  for organisation-owned repositories,
  you must be a member of the organisation that owns the repository.
  Once you have access to the repository,
  you proceed to create a feature branch on that repository directly.
- In the fork and pull model,
  where you do not have write permissions to the source repository,
  you need to fork the repository first
  before you create a feature branch (in your fork) to base your pull request on.

In both development models,
it is recommended to create a feature branch for your work and the subsequent pull request,
even though you can submit pull requests from any branch or commit.
This is because, with a feature branch,
you can push follow-up commits as a response to feedback
and update your proposed changes within a self-contained bundle.
The only difference in creating a pull request between the two models is
how you create the feature branch.
In either model, once you are ready to merge your changes in -
you will need to specify the base branch and the head branch.

## Code Review and Pull Requests In Action

Let's see this in action -
you are going to act as a reviewer on a change to the codebase raised by a
fictional colleague on one of your course mate's repository.
Once this is done, you will then take on the role of the fictional colleague
and respond to the review on your repository.
If you are completing this course by yourself, you can raise the review on
your own repository, review it there and finally respond to your own review
comments. This is actually a very sensible thing to do in general - looking
at your own code in a review window will allow you to spot mistakes you
didn't see before!

Recall [solution requirements SR1.1.1](../31-software-requirements/index.html#solution-requirements)
from an earlier episode.
Your fictional colleague has implemented it according to the specification
and pushed it to a branch `feature-std-dev`.
You will turn this branch into a pull request for your fictional colleague on your
repository.
You will then engage in code review for the change (acting as a code reviewer) on
a course mate's repository.
Once complete, you will respond to the pull request on your repository from another team member.

### Raising a pull request for your fictional colleague

1. Head over to the remote repository in GitHub
   and locate your colleagues (`feature-std-dev`) branch from the dropdown box on the Code tab
   (you can search for your branch or use the "View all branches" option).
   ![All repository branches in GitHub](../fig/github-branches.png){: .image-with-shadow width="600px"}
2. Open a pull request by clicking "Compare & pull request" button.
   ![Submitting a pull request in GitHub](../fig/github-create-pull-request.png){: .image-with-shadow width="900px"}
3. Select the base and the head branch, e.g. `main` and `feature-std-dev`, respectively.
   Recall that the base branch is where you want your changes to be merged
   and the head branch contains your changes.
4. Add a comment describing the nature of the changes,
   and then submit the pull request.
5. Repository moderator and other collaborators on the repository (code reviewers)
   will be notified of your pull request by GitHub.
6. At this point, the code review process is initiated.

Find someone else to swap repositories with (i.e. you will review the pull request
they just raised on their repository). If there are an odd number, three people could
go round robin (i.e. person A reviews code on person Bs repo, who reviews code on
person C's repository, who reviews the code on person A's repository).

If you are completing the course on your own, you will switch to being the reviewer
of the pull request you just opened.

### Things to look for in a code review

Reviewing code effectively takes practice.
However, here is some guidance on the kinds of things you should
be looking for when reviewing a piece of code.

Start by understanding what the code _should_ do, by reading the specification/user requirements,
the pull request description and talking to the developer.
In this case, understand what SR1.1.1 means.

Once you're happy, start reading the code (skip the test code for now). You're
going to be assessing the code in 4 key areas:

* Is the code readable
* Is the code a minimal change
* Is the structure of the code clear
* Is there appropriate and up-to-date documentation

#### Is the code readable

Think about do the names of the variables, do they [follow guidelines for good
names?](../15-coding-conventions/index.html#l#naming-conventions)

Do you understand what conditions in each if statements are for?

Do the function names match the behavior of the function.

#### Is the code a minimal change

Does the code reimplement anything that already exists, either
elsewhere in the codebase or in a library you know about?

Does the code implement something that isn't on the ticket?

#### Is the structure of the code clear

Do functions do just one thing? Have appropriate design
patterns been used (e.g. separating out the model logic from
any view considerations)?

However, if you finding yourself suggesting a full redesign,
then this is best done in person. Ideally big design questions
would be addressed before code is written. If that hasn't happened,
it is normally better to iterate on an imperfect architecture
rather than throwing it away and starting again, but this will
depend on the code in question.

#### Is there appropriate and up-to-date documentation

If functionality has changed, has corresponding documentation been
updated? If new functions have been added, do they have appropriate
levels of documentation? Does the documentation make sense?

Are there clear and useful comments that explain complex designs
and focus on the "why/because" rather than the "what/how"?

### Effective review comments

Make sure your review comments are specific and actionable.

Try to be as specific as you can, rather than "this code is unclear"
prefer, "I don't understand what values this variable can hold".

Make it clear in the comment if you want something to change as part
of this PR. Ideally provide a concrete suggestion (e.g. better variable name).

> ## Exercise: review some code
>
> Pick someone else in the group and go to the pull request they created on their repo.
> Review the code, looking for the kinds of problems that we have just discussed.
> There are examples of all the 4 main areas in the pull request,
> so try to make at least one suggestion for each area.
>
>> ## Solution
>>
>> Here are some of the things you might have found were wrong with the code:
>>
>> **Is the code readable**
>>
>> * Unclear function name `s_dev` - uses an uncommon abbreviation increasing mental load
>>    when reading code that calls this function, prefer `standard_deviation`.
>> * Variable `number` not clear what it contains --- prefer business-logic name like `mean` or `mean_of_data`
>>
>> **Is the code minimal**
>>
>> * Could have used `np.std` to compute standard deviation of data without having to reimplement
>>   from scratch.
>>
>> **Does the code have a clean structure**
>>
>> * Have the function return the data, rather than having the graph name (a view layer consideration)
>>   leak into the model code.
>>
>> **Is the documentation up to date and correct**
>>
>> * The docs say it returns the standard deviation, but it actually returns a dictionary containing
>>    the standard deviation.
> {: .solution}
{: .challenge}

### Making sure code is valid

The other key thing you want to verify in code review is that the code is correct and
well tested.
One approach to do this is to build up a list of tests you expect to see
(and the results you'd expect them to have),
and then verify that all these tests are present and correct.

Start by listing out all the tests you'd expect to see based on the specification.

As you are going through the code, add to this list with any more tests you think
of, making sure to add tests for:

* All paths through the code.
* Making each `if` statement be evaluated as `True` and `False`.
* Executing loops with empty, single and multi-element sequences.
* Edge cases that you spot.
* Any circumstances that you're not sure how certain code would behave.

Once you have built the list, go through the tests in the PR. Make sure
the tests test what you expect (so inspect them closely!). Add a comment
to the PR for any tests that are on your list that you can't find a suitable
test in the PR for.

> ## Exercise: review the code for suitable tests
>
> Remind yourself of the specification of UR1.1.1 and write a list of
> tests you'd expect to see for this feature.
> Review the code again and expand this list to include any other
> edge cases the code makes you think of.
> Finally, go through the tests in the PR and work out which tests are present.
> Request changes for any tests that you think are missing.
>
>> ## Solution
>>
>> Your list might include the following:
>>
>> 1. Standard deviation for one patient with multiple observations.
>> 2. Standard deviation for two patients.
>> 3. Graph includes a standard deviation graph.
>> 4. Standard deviation function should raise an error if given empty data.
>> 5. Computing standard deviation where deviation is different from variance.
>> 6. Standard deviation function should give correct result given negative inputs.
>> 7. Function should work with numpy arrays
>>
>> Looking at the tests in the PR, you might be content that tests for 1, 4 and 7 are present
>> so you would request changes to add tests 2, 3, 5 and 6.
>>
>> In looking at the test you hopefully noticed that the test for numpy arrays is currently
>> spuriously passing as it does not use the return value from the function in the assert.
>>
>> You may have spotted that the function actually computes the variance rather than
>> the standard deviation. Perhaps that is even what made you think to add the test
>> for some data where the variance and standard deviation are different.
>> In more complex examples, it is often easier to spot code that looks like it could  be wrong
>> and think of a test that will exercise it. This saves embarrassment if the code turns out
>> to be right, means you have the missing test written if it is wrong, and is often quicker
>> than trying to execute the code in your head to find out if it is correct.
>>
> {: .solution}
{: .challenge}

### What not to look for

The overriding priority for reviewing code should be making sure progress is being made -
don't let perfect be the enemy of good here.
According to [“Best Kept Secrets of Peer Code Review” (Cohen, 2006)](https://www.amazon.co.uk/Best-Kept-Secrets-Peer-Review/dp/1599160676)
it has been shown that the first hour of reviewing code is the most effective,
with diminishing returns after that.

To that end, here are a few things you *shouldn't* be trying to spot when reviewing:

#### Linting issues, or anything else that an automated tool can spot

Get the CI to do this - this will save the reviewer time, be more accurate
and avoid needless conflict.

#### Bugs

It is easier to make sure there are sufficient tests - you are not an accurate
computer simulator anyway.

#### Issues that pre-date the change

You may spot something that the reviewer didn't introduce and think they could
fix it while in the area, but this can be a rabbit hole. A better approach would be to
raise a PR after this one has been merged fixing the thing you spotted.

### Responding to review comments

When you receive comments on your review,
there are a few different things that you will want to do.

With some, you will understand and agree with what the reviewer is saying.
With these comments, you should make the change to your code on your branch.
Once you've made the change you can commit it.
It might be helpful to add a thumbs up reaction to the comment, so the reviewer knows
you have addressed it.

![Adding a emoji reaction to a review comment](../fig/github-add-emoji.png)

With some, the comment might not make total sense. You can reply to comments for clarification.

![Responding to a review comment](../fig/github-respond-to-review-comment.png)

However, if you disagree, or are really lost on what they are driving it, it will be best to
talk to them in person. Discussions done on code reviews can often feel quite adversarial -
discussing what the best solution is in person can often defuse this.

> ## Exercise: responding and addressing comments
>
> Look at the PR that you created on your repo, that should now have someone elses comments
> on it.
> For each comment, either reply explaining why you don't think the change is necessary
> or make the change and push a commit fixing it. You can reply to the comment indicating you
> have done it.
>
> At the same time, people will be addressing your comments. If you're happy that your
> comment has been suitably addressed, you can mark it as resolved. Once you're happy they
> have all been addressed, you can approve the PR.
{: .challenge}

### Closing a Pull Request

1. Once the reviewer approves your changes, the person whose repository it is can
   merge onto the base branch.
   Typically, it is the responsibility of the code's author to do the merge
   but this may differ from team to team.
   ![Merging a pull request in GitHub](../fig/github-merge-pull-request.png){: .image-with-shadow width="900px"}
2. Delete the merged branch to reduce the clutter in the repository.

Repeat the above actions for the pull request on your repository.

## Making code easy to review

There are a few things you can do when raising a pull request to make it
as easy as possible for the reviewer to review your code:

The most important thing to keep in mind is how long your pull request is.
Smaller changes, that just make one small improvement, will be much quicker and easier to
review.
There is no golden rule, but [studies into code review](https://smartbear.com/resources/ebooks/the-state-of-code-review-2020-report/) show that you should not review more
than 400 lines of code at a time so this is a reasonable target to aim for.
You can refer to some [studies](https://jserd.springeropen.com/articles/10.1186/s40411-018-0058-0)
and [Google recommendations](https://google.github.io/eng-practices/review/developer/small-cls.html)
as to what a "large pull request" is but be aware that it is not exact science.

Even within a single review, try to keep each commit to be making one logical change.
This can help if your review would otherwise be too large.
In particular, if you've reformatted, refactored and changed the behavior of the
code make sure each of these is in a separate commit
(i.e reformat the code, commit, refactor the code, commit, alter the behavior of the code, commit).

Make sure you write a clear description of the content and purpose of the change.
This should be provided as the pull request description.
This should provide the context needed to read the code.

It is also a good idea to review your code yourself.
In doing this you will spot the more obvious issues with your code,
allowing your reviewer to focus on the  things you cannot spot.

## Empathy in review comments

Code is written by humans (mostly!), and code review is a form of communication.
As such empathy is important for effective reviewing.

When reviewing code, it can be sometimes frustrating when code is confusing, particularly
as it will be implemented differently to how you would have done it.
However, it is important as a reviewer to be compassionate to the
person whose code you are reviewing.
Specifically:

* Identify positives in code as and when you find them (particularly if it is an improvement on
  something you've previously fed back on in a previous review).
* Remember different doesn't mean better - only request changes if the code is wrong or hard to understand.
* Only provide a few non-critical suggestions - you are aiming for better rather than perfect.
* Ask questions to understand why something has been done a certain way rather than assuming you
  know a better way.
* If a conversation is taking place on a review and hasn't been resolved by a
  single back-and-forth exchange, then schedule a conversation to discuss instead
  (recording the results of the discussion in the PR).

## Designing a review process

To be effective, code review needs to be a process that is followed by everyone
developing the code. Everyone should believe that process provides value.

One way to foster this is to design the process as a team.
When you're doing this you should consider:

* Do all changes need to go through code review
* What technologies will you use to manage the review process
* How quickly do you expect someone to review the code once you've raised a PR?
* How long should be spent reviewing code?
* What kind of issues are (and aren't) appropriate to raise in a PR?
* How will someone know when they are expected to take action (e.g. review a PR).

You could also consider using pull request states in GitHub:
 - Open a pull request in a `DRAFT` state to show progress or request early feedback;
 - `READY FOR REVIEW` when you are ready for feedback
 - `CHANGES REQUESTED` to let the author know
     they need to fix the requested changes or discuss more;
 - `APPROVED` to let the author they can merge their pull request.

Once you've introduced a review process, you should monitor (either formally or
informally) how well it is working.

It is important that reviews are processed quickly, to avoid costly context switching.
We recommend aiming for 3 hours to get a first review, with the PR being merged the same
day in most cases. If you are regularly missing these targets, then you should review
where things are getting stuck and work out what you can do to move things along.

> ## Exercise: Code Review in Your Own Working Environment
>
> In this episode we have looked at how to use a tool driven code review process
> using GitHub pull requests. We've also looked at some best practices for doing
> code reviews in general.
>
> Now think about how you typically develop code,
> and how you might institute code review practices within your own working environment.
> Write down a process for a tool assisted code review, answering the questions
> above.
>
> Once complete, discuss with the rest of the class what challenges you think
> you'd face in implementing this process in your own working environment.
{: .challenge}

## Other reading

There are multiple perspectives to a code review process -
from general practices to technical details relating to different roles involved in the process.
We have discussed the main points, but do check these useful code review blogs from [
Swarmia](https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/?utm_term=code%20review&utm_campaign=Code+review+best+practices&utm_source=adwords&utm_medium=ppc&hsa_acc=6644081770&hsa_cam=14940336179&hsa_grp=131344939434&hsa_ad=552679672005&hsa_src=g&hsa_tgt=kwd-17740433&hsa_kw=code%20review&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gclid=Cj0KCQiAw9qOBhC-ARIsAG-rdn7_nhMMyE7aeSzosRRqZ52vafBOyMrpL4Ypru0PHWK4Rl8QLIhkeA0aAsxqEALw_wcB)
and [Smartbear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/).

The key thing is to try it, and iterate the process until it works well for your team.

{% include links.md %}
