---
title: "Developing Software In a Team: Code Review"
teaching: 30
exercises: 40
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
layout: lesson_mermaid
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
>  * Fork and pull model
>  * Shared repository model
>
> **Fork and Pull Model**
>
> In this model, anyone can **fork** an existing repository
> (to create their copy of the project linked to the source)
> and push changes to their personal fork.
> A contributor can work independently on their own fork as they do not need
> permissions on the source repository to push modifications to a fork they own.
> The changes from contributors can then be **pulled** into the source repository
> by the project maintainer on request and after a code review process.
> This model is popular with open source projects as it
> reduces the start up costs for new contributors
> and allows them to work independently without upfront coordination
> with source project maintainers.
> So, for example, you may use this model when you are an external collaborator on a project
> rather than a core team member.
>
> **Shared Repository Model**
>
> In this model, collaborators are granted push access to a single shared code repository.
> By default, collaborators have write access to the main branch.
> However, it is best practice to create feature branches for new developments,
> and protect the main branch. See the extra on [protecting the main branch](../protect-main-branch)
> for how to do this.
> While it requires more upfront coordination, it is easier to share each others
> work, so it works well for more stable teams.
> This model is more prevalent with teams and organizations collaborating on private projects.
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

 - [Over-the-shoulder code review](https://about.gitlab.com/topics/version-control/what-is-code-review/#Over-the-shoulder%20reviews) -
     have one developer talk the other developer through the changes whilst sat at the same machine.
 - [Pair programming](https://about.gitlab.com/topics/version-control/what-is-code-review/#Pair%20programming) -
     have two developers work on the code at the same time.
 - [Formal code inspection](https://en.wikipedia.org/wiki/Fagan_inspection) -
     have up to 6 partipants go through a formalised process to inspect the code for defects.
 - [Tool assisted code review](https://about.gitlab.com/topics/version-control/what-is-code-review/#Tool-assisted%20reviews) -
     have a developer uses tools such as GitHub to review the code independently and give feedback.

You can read more about these techniques in [Five Types of Review](https://www.khoury.northeastern.edu/home/lieber/courses/cs4500/f07/lectures/code-review-types.pdf)

It is worth trying multiple code review techniques to see what works
best for you and your team.
We will have a look at the **tool-assisted code review process**, which is likely to be the most effective and efficient.
We will use GitHub's built-in code review tool - **pull requests**, or PRs.
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
while the feature branch that contains changes you would like to be applied is the **compare branch**.

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
you will need to specify the base branch and the compare branch.

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

Here is an outline of the process of a tool based code review that we will be following:

```mermaid
%% Must disable useMaxWidth to have the diagram centre
%%{init: { 'sequence': {'useMaxWidth':false} } }%%
sequenceDiagram
    participant A as Author
    participant R as Reviewer
    A->>A: Write some code
    A->>R: Raise a pull request
    R->>R: Add comments to a review
    R->>A: Submit a review
    loop Until approved
        A->>R: Address or respond to review comments
        R->>A: Clarify or resolve comments
    end
    R->>A: Approve pull request
    A->>A: Merge pull request
```

Recall [solution requirements SR1.1.1](../31-software-requirements/index.html#solution-requirements)
from an earlier episode.
Your fictional colleague has implemented it according to the specification
and pushed it to a branch `feature-std-dev`.
You will turn this branch into a pull request for your fictional colleague on your
repository.
You will then engage in code review for the change (acting as a code reviewer) on
a course mate's repository.
Once complete, you will respond to the pull request on your repository from another team member.

## Raising a pull request for your fictional colleague

1. Head over to your remote repository in GitHub.
2. Navigate to the pull requests tab
3. Create a new pull request by clicking the green `New pull request` button.
   ![GitHub pull requests tab](../fig/github-pull-request-tab.png){: .image-with-shadow width="900px"}
4. Select the base and the compare branch, e.g. `main` and `feature-std-dev`, respectively.
   Recall that the base branch is where you want your changes to be merged
   and the compare branch contains your changes.
5. Click `Create pull request` to open the request
   ![Creating a new pull request.](../fig/github-create-pull-request.png){: .image-with-shadow width="900px"}
6. Add a comment describing the nature of the changes,
   and then submit the pull request by clicking `Create pull request`.
![Submitting a pull request.](../fig/github-submit-pullrequest.png){: .image-with-shadow width="900px"}
7. At this point, the code review process is initiated.

We will now discuss what to look for in a code review,
before practising this on this fictional change.

## Reviewing a pull request

Once a review has been raised it is over to the reviewer to review the code
and submit a review.

### Things to look for in a code review

Reviewing code effectively takes practice.
However, here is some guidance on the kinds of things you should
be looking for when reviewing a piece of code.

Start by understanding what the code _should_ do, by reading the specification/user requirements,
the pull request description and talking to the developer.
In this case, understand what [SR1.1.1](../31-software-requirements/index.html#solution-requirements) means.

Once you're happy, start reading the code (skip the test code for now). You're
going to be assessing the code in 4 key areas:

* Is the code readable
* Is the code a minimal change
* Is the structure of the code clear
* Is there appropriate and up-to-date documentation

**Is the code readable**

* Think about do the names of the variables, do they [follow guidelines for good
names?](../15-coding-conventions/index.html#l#naming-conventions)
* Do you understand what conditions in each if statements are for?
* Do the function names match the behavior of the function.

**Is the code a minimal change**

* Does the code reimplement anything that already exists, either
elsewhere in the codebase or in a library you know about?
* Does the code implement something that isn't on the ticket?

**Is the structure of the code clear**

* Do functions do just one thing?
* Is the code using the right level of modularity?
* Is the code consistent with the structure of the rest of the code?

**Is there appropriate and up-to-date documentation**

* If functionality has changed, has corresponding documentation been
updated?
* If new functions have been added, do they have appropriate
levels of documentation?
* Does the documentation make sense?
* Are there clear and useful comments that explain complex designs
and focus on the "why/because" rather than the "what/how"?

### Adding a review comment

To add comments to a review, you need to open up the pull request.
Then go to the `Files changed` tab.
![The files changed tab of a pull request](../fig/github-pull-request-files-changed.png){: .image-with-shadow }
When you find a line that you want to add a comment to, click on the
plus (+) icon next to line.
![Adding a review comment to a pull request](../fig/github-pull-request-add-comment.png){: .image-with-shadow }
You can also add comments referring to multiple lines by clicking the plus and
dragging down over the relevant lines.

If you want to make a concrete suggestion, such as renaming a variable, you
can click the `Add a suggestion button` (which looks like a document with a plus and a minus in it).
This will populate the comment with the existing code, and you can edit it to be
what you think the code should be.
![Adding a suggestion to a pull request](../fig/github-pull-request-add-suggestion.png){: .image-with-shadow }
GitHub will then provide a button for the author to apply your change directly.

Write your comment in the box, and then click `Start review`.
This will save your comment, but not publish it yet.

You can use `Add single comment` to immediately post a comment.
However, it is best to batch the comments into a single review, so that the author
knows when you have finished adding comments
(and avoid spamming their email with notifications).

Continue adding comments in this way, using the `Add review comment` button
on subsequent comments.

> ## Effective review comments
>
> * Make sure your review comments are specific and actionable.
> * Try to be as specific as you can, rather than "this code is unclear"
> prefer, "I don't understand what values this variable can hold".
> * Make it clear in the comment if you want something to change as part
> of this pull request.
> * Ideally provide a concrete suggestion (e.g. better variable name).
{: .callout}

> ## Exercise: review some code
>
> Pair up in the group and go to the pull request they created on their repo.
> If there are an odd number of people in your group, three people can go in a round robin fashion
> (the first team member will review the pull request on the second member’s repository
> and receives comments on the pull request on their repository from
> the third team member).
> If you are going through the material on your own and do not have a collaborator,
> you can be the reviewer on the pull requests on your own repository.
>
> Review the code, looking for the kinds of problems that we have just discussed.
> There are examples of all the 4 main areas in the pull request,
> so try to make at least one suggestion for each area.
>
> Don't submit your review just yet.
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

Once you have built the list, go through the tests in the pull request. Make sure
the tests test what you expect (so inspect them closely!).

## Submit a review

Once you have a list of tests you want the author to add, it is time to
submit your review.

To do this, click the `Finish your review` button at the top of the Files
changed tab.

![Using the finishing your review dialog](../fig/github-submit-pr-review.png)

In the comment box, you can add any comments that aren't
associated with a specific line.
For example, you can put the list of tests that you want to see
added here.

Next you will select to one of `Comment`, `Approve` or `Request changes`.

* Use `Approve` if you would be happy for the code to
go in with no further changes.
* Use `Request changes` to communicate to the author that
they should address your comments before you will approve it.
* Use `Comment` if you don't want to express a decision on
whether the code should be accepted. For example, if you've been asked
to look at a specific part of the code, or if you are part way through
a review, but wanted to share some comments sooner.

Finally, you can press `Submit review`.
This will publish all the comments you've made on the review and
let the author know that the review is complete and it is their
turn for action.

> ## Exercise: review the code for suitable tests
>
> Remind yourself of the specification of SR1.1.1 and write a list of
> tests you'd expect to see for this feature.
> Review the code again and expand this list to include any other
> edge cases the code makes you think of.
> Go through the tests in the pull request and work out which tests are present.
>
> Once you are happy, you can submit your review.
> Select `Request changes` to let the author know they need to address your comments.
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

> ## What *not* to look for in a code review
>
> The overriding priority for reviewing code should be making sure progress is being made -
> don't let perfect be the enemy of good here.
> According to [“Best Kept Secrets of Peer Code Review” (Cohen, 2006)](https://www.amazon.co.uk/Best-Kept-Secrets-Peer-Review/dp/1599160676)
> it has been shown that the first hour of reviewing code is the most effective,
> with diminishing returns after that.
>
> To that end, here are a few things you *shouldn't* be trying to spot when reviewing:
>
> * Linting issues, or anything else that an automated tool can spot - get CI to do it.
> * Bugs - instead make sure there are tests for all cases.
> * Issues that pre-date the change - raise a PR fixing these issues separately to avoid heading down a rabbit hole.
> * Architecture re-writes - try to have design discussions upfront,
      or else have a meeting to decide whether the code needs to be rewritten.
{: .callout}

## Responding to review comments

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
> comment has been suitably addressed, you can mark it as resolved.
> Once you're happy they have all been addressed, you can approve the PR.
> To approve a PR, submit a new review and this time select `Approve`.
> This tells the author you are happy for them to merge the pull request.
{: .challenge}

## Approve a pull request

1. Once the reviewer approves the changes, the person whose repository it is can
   merge onto the base branch.
   Typically, it is the responsibility of the code's author to do the merge
   but this may differ from team to team.
   In our case, you will merge the changes on the PR on your repository.
   ![Merging a pull request in GitHub](../fig/github-merge-pull-request.png){: .image-with-shadow width="900px"}
2. Delete the merged branch to reduce the clutter in the repository.

## Making code easy to review

There are a few things you can do when raising a pull request to make it
as easy as possible for the reviewer to review your code:

* Keep the changes **small**.
* Keep each commit as **one logical change**.
* Provide a **clear description** of the change.
* **Review your code yourself**, before requesting a review.

The most important thing to keep in mind is how long your pull request is.
Smaller changes, that just make one small improvement, will be much quicker and easier to
review.
There is no golden rule, but [studies into code review](https://smartbear.com/resources/ebooks/the-state-of-code-review-2020-report/) show that you should not review more
than 400 lines of code at a time, so this is a reasonable target to aim for.
You can refer to some [studies](https://jserd.springeropen.com/articles/10.1186/s40411-018-0058-0)
and [Google recommendations](https://google.github.io/eng-practices/review/developer/small-cls.html)
as to what a "large pull request" is but be aware that it is not an exact science.

Even within a single review, try to keep each commit to be making one logical change.
This can help if your review would otherwise be too large.
In particular, if you've reformatted, refactored and changed the behavior of the
code make sure each of these is in a separate commit
(i.e reformat the code, commit, refactor the code, commit, alter the behavior of the code, commit).

Make sure you write a clear description of the content and purpose of the change.
This should be provided as the pull request description.
This should provide the context needed to read the code.

It is also a good idea to review your code yourself,
before requesting a review.
In doing this you will spot the more obvious issues with your code,
allowing your reviewer to focus on the  things you cannot spot.

## Empathy in review comments

Code is written by humans (mostly!), and code review is a form of communication.
As such, empathy is important for effective reviewing.

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
developing the code.
Everyone should believe that the process provides value.

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
> In this episode we have looked at why and how to use a tool driven code review process
> using GitHub pull requests. We've also looked at some best practices for doing
> code reviews in general.
>
> Now think about how you typically develop code.
> What benefits do you think you would see for introducing a code review process in
> your work environment.
> How you might institute code review practices within your environment.
> Write down a process for a tool assisted code review, answering the questions
> above.
>
> Once complete, discuss with the rest of the class what are the advantages of
> a code review process and
> what challenges you think you'd face in implementing this process in your own working environment.
> > ## Solution
> > The purposes of code review include:
> > - improving internal code readability, understandability, quality and maintainability
> > - checking for coding standards compliance, code uniformity and consistency
> > - checking for test coverage and detecting bugs and code defects early
> > - detecting performance problems and identifying code optimisation points
> > - finding alternative/better solutions.
> > - sharing knowledge of the code, and of coding standards and expectations of quality
> >
> > Finally, it helps increase the sense of collective code ownership and responsibility,
> > which in turn helps increase the "bus factor"
> > and reduce the risk resulting from information and capabilities
> > being held by a single person "responsible" for a certain part of the codebase
> > and not being shared among team members.
> >
> > Challenges you might face introducing a code review process:
> > - Complaints that it is a waste of time
> > - Creating a negative atmosphere where people are overly critical of each others work, or are defensive of their own
> > - Perfectionism leading to slower development
> > - People not sharing code to avoid the review process
> >
> > Make sure to monitor whether these are happening, and adjust the process accordingly.
> {: .solution}
{: .challenge}

## Other reading

There are multiple perspectives to a code review process -
from general practices to technical details relating to different roles involved in the process.
We have discussed the main points, but do check these useful code review blogs from [
Swarmia](https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/?utm_term=code%20review&utm_campaign=Code+review+best+practices&utm_source=adwords&utm_medium=ppc&hsa_acc=6644081770&hsa_cam=14940336179&hsa_grp=131344939434&hsa_ad=552679672005&hsa_src=g&hsa_tgt=kwd-17740433&hsa_kw=code%20review&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gclid=Cj0KCQiAw9qOBhC-ARIsAG-rdn7_nhMMyE7aeSzosRRqZ52vafBOyMrpL4Ypru0PHWK4Rl8QLIhkeA0aAsxqEALw_wcB)
and [Smartbear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/).

The key thing is to try it, and iterate the process until it works well for your team.

{% include links.md %}
