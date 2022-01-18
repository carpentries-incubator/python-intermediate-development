---
title: "Developing Software In a Team"
teaching: ""
exercises: ""
questions: 
- "What is code review and how it can improve the quality of code?"
objectives:
- "Describe commonly used code review techniques."
- "Understand how to do a pull request via GitHub to engage in code review with a team and contribute to a shared code repository."
keypoints:
- "Code review is a team software quality assurance practice where team members look at parts of the codebase in order 
to improve code readability, understandability, quality and maintainability."
- "It is important to agree on a set of best practices and establish a code review process in a team to help to 
sustain a good, stable and maintainable code for many years."
---
 
## Introduction

So far in this course we’ve focused on learning software design and (some) technical practices, tools 
and infrastructure that help the development of software in a team environment, but in an individual setting.
Despite developing tests to check our code - no one else from the team had a look at our code 
before we merged it into the main development stream. Software is often designed and built as part of a team, 
so in this episode we'll be looking at how to manage the process of team software development and improve our 
code by engaging in code review process with other team members.

Code review is one of the most useful team code development practices - someone checks your design or code for errors, they get to learn from your solution and having to 
explain code to someone else clarifies your rationale and design decisions in your mind too, and collaboration 
helps to improve the overall team software development process. It is universally applicable throughout
the software development cycle - from design to development to maintenance. According to Michael Fagan, the 
author of the [code inspection technique](https://en.wikipedia.org/wiki/Fagan_inspection), rigorous inspections can 
remove 60-90% of errors from the code even before the 
first tests are run ([Fagan, 1976](https://doi.org/10.1147%2Fsj.153.0182)). 
Furthermore, according to Fagan, the cost to remedy a defect in the early (design) stage is 10 to 100 times less 
compared to fixing the same defect in the development and maintenance 
stages, respectively. Since the cost of bug fixes grows in orders of magnitude throughout the software 
lifecycle, it is essential to find and fix defects as close as possible to the point where they were introduced.

Before we dive into code review techniques, let's have a brief look into team software development models 
used by Git/GitHub and similar distributed version control systems and code sharing platforms which may influence 
the way how code reviews are implemented in your team.

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
- checking for test coverage and detecting bugs and code defects early
- detecting performance problems and identifying code optimisation points
- finding alternative/better solutions.

An effective code review prevents errors from creeping into your software by improving code quality at an early
stage of the software development process. It helps with learning, i.e. sharing knowledge about the codebase,
solution approaches, expectations regarding quality, coding standards, etc. Developers use code review feedback 
from more senior developers to improve their own coding practices and expertise. Finally, it helps increase the sense of 
collective code ownership and responsibility, which in turn helps increase the "bus factor" and reduce the risk resulting from 
information and capabilities being held by a single person "responsible" for a certain part of the codebase and 
not being shared among team members.

### Code Review Roles and Responsibilities
Depending on the size of the team and its code review process, some the following roles are involved:
- **code author** is the writer of the ‘code under review’ who aims to improve the codebase in a certain aspect and 
enhance their knowledge in the process.
- **reviewers** are technical members of the team (potentially with different expertises)
checking for defects, errors and further improvements in the code in accordance with the code 
specifications, standards, and domain knowledge.
- **moderator or review lead** is a skilled and technical team member who leads the review process and co-ordinates 
with the author.
- **manager** manages the execution of reviews, allocates time in the project schedule and sometimes also play the role of a reviewer.
                
### Code Review Techniques
There are several ways to conduct code reviews, with differing degree of formality and the use of 
a technical infrastructure:

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
- **Fagan code inspection** is a formal and heavyweight process of 
finding defects in specifications or designs during various phases of the software development process. There are 
several roles taken by different team members in a Fagan inspection and each inspection is a formal 7-step process 
with a predefined entry and exit criteria. See [Fagan inspection](https://en.wikipedia.org/wiki/Fagan_inspection) for 
full details on this method.
- **Tool-assisted code review** process uses a specialised tool to facilitate the process of code review, which typically
helps with the following tasks: (1) collecting and displaying the updated files and highlighting what has changed, (2) 
facilitating a conversation between team members (reviewers and developers), and (3) allowing code administrators and 
product managers a certain control and overview of the code development workflow. Modern tools may provide a handful 
of other functionalities too, such as metrics (e.g. inspection rate, defect rate, defect density).

Each of the above techniques have their pros and cons and varying degrees practicality - 
it is up to the team to decide which one is best and most suitable for the project and stick to it.
We will have a look at GitHub's built-in code review tool - **pull requests** - which is lightweight, 
included with GitHub's core service for free and has gained popularity within the software development community 
in recent years.

## Code Reviews via GitHub's Pull Requests

Pull requests are fundamental to how teams review and improve code on GitHub (and similar code sharing platforms) -
they let you tell others about changes you've pushed to a branch in a repository on GitHub and that your 
code is ready for review. Once a pull request is opened, you can discuss and review the potential changes with others 
on the team and add follow-up commits based on the feedback before your changes are merged into 
the main `develop` branch. The name 'pull request' suggests you are **requesting** the codebase 
moderators to **pull** your changes into the codebase. 

Such changes are normally done in a 
(feature) branch, to ensure that they are separate and self-contained and 
that the default branch only contains "production-ready" work. You create a branch for your work
based on one of the existing branches (typically the `develop` branch but can be any other branch), 
do some commits on that branch, and, once you are ready to merge your changes, create a pull request to bring 
the changes back to that branch. In this 
context, the branch from which you branched off to do your work and where the changes should be applied 
back to is called the **base branch**, while the feature branch that contains changes you would like to be applied
is the **head branch**.
 
How you create your feature branches and open pull requests in GitHub will depend on your collaborative code 
development model:

- In the shared repository model, in order to create a feature branch and open a 
pull request based on it you must have write access to the source repository or, for organisation-owned repositories, 
you must be a member of the organisation that owns the repository. Once you have access to the repository, you proceed 
to create a feature branch on that repository directly.
- In the fork and pull model, where you do not have write permissions to the source repository, you need to fork the
repository first before you create a feature branch (in your fork) to base your pull request on.

In both development models, it is recommended to create a feature branch for your work and 
the subsequent pull request, even though you can submit pull requests from any branch or commit. This is because, 
with a feature branch, you can push follow-up commits as a response to feedback and update your proposed changes within
a self-contained bundle. 
The only difference in creating a pull request between the two models is how you create the feature branch. 
In either model, once you are ready to merge your changes in - you will need to specify the base branch and the head
branch. 

Let's see this in action - you and your fellow learners are going to be organised in small teams and assume to be 
collaborating in the shared repository model. Next, you will propose changes to another team member's 
repository (which become the shared repositories in this context) a via pull request 
and engage in code review with them. You will receive pull requests on your repository
from other team members too, in which case you take on the role of the repository moderator and code reviewer.
           
### Adding Collaborators to a Shared Repository
You need to add the other team member(s) as collaborator(s) on your repository 
to enable them to create branches and pull requests. To do so, each repository owner needs to:

1. Head over to Settings section of your software project's repository in GitHub.
2. Select tab 'Manage access' and click 'Add people' button.
   ![Managing access to a repository in GitHub](../fig/github-manage-access.png){: .image-with-shadow width="900px"}
3. Add your collaborators by their GitHub usernames, full names or email addresses.
   ![Adding collaborators to a repository in GitHub](../fig/github-add-collaborators.png){: .image-with-shadow width="900px"}
4. Collaborators will be notified of your invitation to join your repository based on their notification preferences.
5. Once they accept the invitation, they will have the "collaborator"-level access to your repository and will show up
in the list of our collaborators.

See the full details on ["collaborator" permissions for personal repositories](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-user-account/managing-user-account-settings/permission-levels-for-a-user-account-repository).
Note that repositories owned by an organisation have a [more granular access control](https://docs.github.com/en/get-started/learning-about-github/access-permissions-on-github) compared to that of personal
repositories.

### Preparing Your Local Environment for a Pull Request

1. Obtain the GitHub URL of the shared repository you will be working on and clone it locally.
2. Create a local feature branch called `feature_x_tests` off the `develop` branch.
3. Review the code already in the project and familiarise yourself with it. It should be similar to the project 
you have worked on so far.

### Submitting a Pull Request

1. Starting off from the last exercise in the previous episode, on your feature branch `feature_x_tests` add the missing 
tests and verify they run correctly. Add as many commits as necessary.
2. Push your branch remotely to the shared repository.
3. Head over to GitHub and locate your branch from the repository home page. 
4. Open a pull request by clicking "Create pull request" button. 

  TODO: add a screenshot
5. Team members (collaborators on the repository) will be notified of your pull request by GitHub.
6. At this point, the code review process is initiated.

On the repository you own, you will also receive a pull request from other team members.

### Code Review

1. The moderator will review your changes and provide feedback to you 
in the form of comments.
2. Respond to their comments and do any subsequent commits, as requested by reviewers.
3. It may take a few rounds of exchanging comments and discussions until your team is ready to accept your changes. 

Perform the above actions on the pull request you received, this time acting as a reviewer.

### Closing a Pull Request

7. Once the moderator approves your changes, either one of you can merge the branch onto `develop`. Typically, it is 
the responsibility of the code's author to do the merge.

  TODO: add a screenshot
9. Delete the merged branch to reduce the clutter in the repository.

Repeat the above actions for the pull request you received.

## Best Practices for Code Reviews
        
There are multiple perspectives to a code review process - from general practices to technical details 
relating to different roles involved in the process. It is critical for the code's quality, stability and maintainability 
that the team decides on this process and sticks to it. Here are some examples of best practices for you to consider 
(also check these useful code review blogs from [Swarmia](https://www.swarmia.com/blog/a-complete-guide-to-code-reviews/?utm_term=code%20review&utm_campaign=Code+review+best+practices&utm_source=adwords&utm_medium=ppc&hsa_acc=6644081770&hsa_cam=14940336179&hsa_grp=131344939434&hsa_ad=552679672005&hsa_src=g&hsa_tgt=kwd-17740433&hsa_kw=code%20review&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gclid=Cj0KCQiAw9qOBhC-ARIsAG-rdn7_nhMMyE7aeSzosRRqZ52vafBOyMrpL4Ypru0PHWK4Rl8QLIhkeA0aAsxqEALw_wcB) and [Smartbear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/)):
   
1. Decide the focus of a code review process, e.g.:
   - code design and functionality - does the code fit in the overall design and does it do what was intended? 
   - code understandability and complexity - is the code readable and would another developer be able to understand it?
   - tests - does the code have automated tests?
   - naming - are names used for variables and functions descriptive, do they follow naming conventions?
   - comments and documentation - are there clear and useful comments that explain complex designs well and focus 
on the "why/because" rather than the "what/how"? 
2. Do not review code too quickly and do not review for too long in one sitting. According to
[“Best Kept Secrets of Peer Code Review” (Cohen, 2006)](https://www.amazon.co.uk/Best-Kept-Secrets-Peer-Review/dp/1599160676) - the first hour of review 
matters the most as detection of defects significantly drops after this period. [Studies into code review](https://smartbear.com/resources/ebooks/the-state-of-code-review-2020-report/) 
also show that you should not review more than 400 lines of code at a time. Conducting more frequent shorter reviews 
seems to be the most effective.
3. Decide on the level of depth for code reviews to maintain the balance between the creation time
and time spent reviewing code - e.g. reserve them for critical portions of code and avoid nit-picking on small 
details. Try using automated checks and linters when possible, e.g. for consistent usage of certain terminology across the code and code styles.
4. Communicate clearly and effectively - when reviewing code, be explicit about the action you request from the author.
5. Foster a positive feedback culture:
  - give feedback about the code, not about the author
  - accept that there are multiple correct solutions to a problem
  - sandwich criticism with positive comments and praise
7. Utilise multiple code review techniques - use email, pair programming, over-the-shoulder, team discussions and 
tool-assisted or any combination that works for your team. However, for the most effective and efficient code reviews, 
tool-assisted process is recommended.
9. From a more technical perspective: 
   - use a feature branch for pull requests as you can push follow-up commits if you need to update
         your proposed changes
   - avoid large pull requests as they are more difficult to review. You can refer to some [studies](https://jserd.springeropen.com/articles/10.1186/s40411-018-0058-0) and [Google recommendations](https://google.github.io/eng-practices/review/developer/small-cls.html) 
   as to what a "large pull request" is but be aware that it is not exact science.
   - don't force push to a pull request as it changes the repository history
         and can corrupt your pull request for other collaborators
   - use pull request states in GitHub effectively (based on your team's code review process) - e.g. in GitHub 
   you can open a 
   pull request in a `DRAFT` state to show progress or request early feedback; `READY FOR REVIEW` when you are ready 
   for feedback; `CHANGES REQUESTED` to let the author know they need to fix the requested changes or discuss more; 
   `APPROVED` to let the author they can merge their pull request.

{% include links.md %}
