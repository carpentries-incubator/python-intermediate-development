# Contributing Guidelines

## Contributor Agreement

By contributing to this project, you agree that we may redistribute your work under the 
[Creative Commons Attribution 4.0 International Public License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) as specified by the project’s [licence file](LICENSE.md).

## Code of Conduct

When contributing to this project you are expected to abide by The Carpentries 
[Code of Conduct](https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html#code-of-conduct-summary-view). 

## Contact Us

To get in touch with the lesson maintainers, send an email to [python-inter-inflammation@lists.carpentries.org][email].

## How to Contribute

You will need a [GitHub account][github-join] to contribute to this project, and can do so in a variety of ways, including:

* Reporting problems and suggesting changes to the lesson material or project documentation (e.g. [README](README.md),
contributing guidelines, etc.) via project issues,
* Commenting, voting and participating in discussions on existing issues or proposed changes and pull requests,
* Contributing changes to the lesson material via pull requests.

### Markdown Source Files

The source files for the lesson (as well as most of the lesson project files) are written in [Markdown](https://github.github.com/gfm/). 
Markdown is quite a flexible markup language, and we suggest to follow some guidelines on Markdown format to make editing 
these files easier.

Regular prose should not exceed 100 characters per line. This helps avoid line wrapping 
in editors which can make comparing changes in the source code difficult. 

Please attempt to follow [semantic line breaks](https://sembr.org/) when editing or adding 
prose in the explanatory portions of the lesson. Don’t worry about this when editing code examples. 
Briefly, semantic line breaks means:

* Create a newline after a sentence (punctuated with a ‘.’, ‘!’, or ‘?’)
* Create a newline after an independent clause (punctuated with comma, semi-colon, colon or em dash)
* Create a newline to satisfy line length guides (100 characters in our case).

### Lesson Template

The lesson is developed using The [Carpentries Jekyll lesson template](https://github.com/carpentries/styles/) and 
you should be familiar with it before making bigger contributions (as you will likely need to install and render 
your branch of the lesson locally to test your proposed changes). You can check out the 
[lesson example guide](https://carpentries.github.io/lesson-example) and the [corresponding lesson template source repository](https://github.com/carpentries/styles/) 
to familiarise yourself with the lesson template and file structure before making a pull request with substantial changes. 

### Reporting Problems and Suggesting Changes via Issues

If you notice a problem with the lesson material or want to suggest a change or start a conversation on a 
lesson-related topic - you can do so by creating a new issue on the [project’s issues page](https://github.com/carpentries-incubator/python-intermediate-development/issues). 
Before opening a new issue, check the list of opened issues first to see if there is already an existing 
report/discussion on the same subject. If so, consider adding your thoughts to the existing issue instead 
of starting a new one.

While we welcome suggestions on how to extend the material, due to its size we may not be able to accommodate 
all such requests. You should, however, feel free to create your own [fork of the material](https://github.com/carpentries-incubator/python-intermediate-development/fork) 
and make any requested changes there and create a pull request to bring your changes back into 
the main material to be considered by the lesson maintainers. 


### Commenting and Voting

We welcome people to comment and vote on any issues, discussions or pull requests that they feel are important - 
this is an opportunity to explain your point of view and discuss why certain changes are needed.

Voting is done by leaving a reaction (👍 for +1, 👎 for -1) on an issue or pull request. Votes on issues may be 
used when prioritising work, and votes on pull requests may be taken into account by the project maintainers 
when deciding whether to accept it.

### Contributions to Lesson Material via Pull Requests

Changes to the lesson can only be done via pull requests from branches of the material:

* We welcome pull requests that address[ identified and reported issues/problems](https://github.com/carpentries-incubator/python-intermediate-development/issues)
with the lesson, e.g. look for issues labelled “help wanted” or “good first issue” (for novice contributors).
* Try to group suggested changes into pull requests logically, e.g. if you are fixing a number of typos in the
lesson we suggest grouping them together in a single pull request.
* Pull requests that add a lot of new material or a new episode to the lesson without discussing this first with
the lesson [maintainers](mailto:python-intermediate-inflammation@lists.carpentries.org) are discouraged. 
* Before starting the work, make sure there is a related issue open (so you can reference it in your pull
request and use it for discussions). You can also put a comment on the relevant issue saying that you intend
to address the issue so that any duplication of effort is avoided.

#### Automated Pull Requests for Changes via GitHub Interface

Small changes can be made directly using the GitHub user interface. Simply open the relevant file on 
the [gh-pages branch](https://github.com/carpentries-incubator/python-intermediate-development), 
click the pencil icon to edit, make your change, and click the "Propose changes" button - GitHub 
will automatically create a fork (a separate copy of the lesson repository under your GitHub account), a 
feature branch from the **gh-pages branch** and a pull request for you.

#### Manual Pull Requests from a Forked Repository

If you are not making a change via the GitHub’s interface - you will have to manually create a 
[fork](https://github.com/carpentries-incubator/python-intermediate-development/fork) from the 
lesson repository and a feature branch (to contain your changes) from the **gh-pages branch**. 

If you are working locally on your machine, make sure that your local feature branch is pushed 
to your remote fork on GitHub. From the GitHub interface of your fork, select your feature branch, 
click the 'Pull Request' button and fill out the pull request form. In the description/comment 
section if the form, make sure to include:

* a brief summary of what changes were made
* why the changes were made, with links to any relevant issues or discussions

Your pull request should trigger a notification for the repository’s maintainers, and a member 
of the team will review your pull request in a timely manner. Check in from time to time, 
or wait for notifications of any reviewer comments or build failures.

If you need to make additional code changes (e.g. in response to reviewers’ comments), 
just push them to your feature branch on your fork and GitHub will update the open pull request automatically.


## Credit

We maintain a list of contributors to this project under the [AUTHORS file](https://github.com/carpentries-incubator/python-intermediate-development/blob/gh-pages/AUTHORS) in the project root. If you make a pull request that gets accepted and merged, or contribute significantly to a discussion around one of the issues in the project, and would like to be recognised on this list - please append your name, email address and affiliation to the end of this file and create a new pull request with these changes.


## Thank You

Thank you for considering contributing to this project!

[github]: https://github.com
[github-flow]: https://guides.github.com/introduction/flow/
[github-join]: https://github.com/join
[email]: mailto:python-inter-inflammation@lists.carpentries.org
[dc-issues]: https://github.com/issues?q=user%3Adatacarpentry
[dc-lessons]: http://datacarpentry.org/lessons/
[dc-site]: http://datacarpentry.org/
[discuss-list]: http://lists.software-carpentry.org/listinfo/discuss
[github]: https://github.com
[github-flow]: https://guides.github.com/introduction/flow/
[github-join]: https://github.com/join
[how-contribute]: https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github
[issues]: https://guides.github.com/features/issues/
[swc-issues]: https://github.com/issues?q=user%3Aswcarpentry
[swc-lessons]: https://software-carpentry.org/lessons/
[swc-site]: https://software-carpentry.org/
[c-site]: https://carpentries.org/
[lc-site]: https://librarycarpentry.org/
[lc-issues]: https://github.com/issues?q=user%3Alibrarycarpentry
