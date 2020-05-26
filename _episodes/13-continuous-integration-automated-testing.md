---
title: "Continuous Integration for Automated Testing (FIXME)"
teaching: 15
exercises: 5
questions:
- "Key question (FIXME)"
objectives:
- "Describe the benefits of using Continuous Integration for further automation"
- "Enable Travis Continuous Integration for public open source repositories"
- "Use Travis to automatically run unit tests when changes are committed to a version control repository"
- "Use continuous integration to automatically run unit tests when changes are committed to a version control repository"
keypoints:
- "First key point. Brief Answer to questions. (FIXME)"
---

So far we've been manually running our tests as we require. So once we've made a change, or add a new feature with accompanying tests, we can re-run our tests, giving ourselves (and others who wish to run them) increased confidence that everything is working as expected. Now we're going to take further advantage of automation in a way that helps testing scale across a development team with very little overhead, using Continuous Integration.


## What is Continuous Integration?

The automated testing we've done so far only taking into account the state of the repository we have on our own machines. In a software project involving multiple developers working and pushing changes on a repository, it would be great to know holistically how all these changes are affecting our codebase without everyone having to pull down all the changes and test them. If we also take into account the testing required on different target user plaforms for our software and the changes being made to many repository branches, the effort required to conduct testing at this scale can quickly become intractable for a research project to sustain.

Continuous Integration (CI) aims to reduce this burden by further automation, and automation - wherever possible - helps us to reduce errors and makes predictable processes more efficient. The idea is that when a new change is committed to a repository, CI clones the repository, builds it if necessary, and runs any tests. Once complete, it presents a report to let you see what happened.


## Configuring our repository for continuous integration

We'll be using Travis-CI, a free continuous integration service. The first thing we need to do is let Travis install its GitHub App to GitHub:

1. Log into [https://travis-ci.com/]() with your GitHub account
2. Select your profile picture in the top right and select 'Activate & Migrate' under 'GitHub Apps Integration'
3. From the permissions window, select 'Only select repositories', and add the `swc-intermediate-template` repository
4. Select `Approve and install` to install the Travis application to GitHub

FIXME: add screenshot of permissions dialogue

Once we've done this, all we need to do now is add a `.travis.yml` file to the root of the repository, commit, and push it. For example:

~~~
language: python

python:
    - "3.7"

install:
    - pip install -r requirements.txt
    - pip install -e .

script:
    - pytest --cov=inflammation.models tests/test_stats.py
~~~
{: .language-bash}

Here, we are informing Travis that the software assumes a Python 3.7 environment (which will be built and provided for the CI run), and the script to execute. We already have our software dependencies in our `requirements.txt` file, and Travis will automatically use this to install these dependencies prior to running the script command.

### Triggering a build on Travis

Since we know that once a commit is pushed Travis will attempt to run a build, so if we commit and push this change a CI run will be triggered:

~~~
$ git add .travis.yml
$ git commit -m "Add Travis CI configuration" .travis.yml
$ git push
~~~
{: .language-bash}

Since we are only committing the Travis configuration file to the `test-suite` branch for the moment, only the contents of this branch will be used by Travis. We can pass this file upstream into other branches (i.e. via merges) when we're happy it works, which again highlights the usefulness of the feature-branch model - we can work in isolation on a feature until it's ready to be passed upstream without disrupting development on other branches.

### Checking build progress and reports

Handily, we can see the progress of the Travis build from our repository on GitHub by selecting the `test-suite` branch and then selecting `commits`.

FIXME: add screenshot of branches page with build in progress

You'll see a list of commits for this branch, and likely see an orange marker next to the latest commit (clicking on it yields `Some checks haven’t completed yet`) meaning the build is still in progress. This is a useful view, as over time, it will give you a history of commits, who did them, and whether the commit resulted in a successful Travis build or not.

Hopefully after a while, the marker will turn green indicating a successful build. Selecting it gives you even more information about the build, and selecting `The build` link takes you to Travis CI which will show you a complete log of the build and its output. The logs are actually truncated; selecting the grey arrows next to line numbers will expand them with more detail (such as output from running commands).

FIXME: add screenshot of Travis build log

Note that travis-ci.com offers continuous integration as a free service with unlimited builds on as many open source (i.e. public) repositories that you have. But a key limitation is that only 5 concurrent build jobs may run at one time.


## Limits to testing

Like any other piece of experimental apparatus, a complex program requires a much higher investment in testing than a simple one. Putting it another way, a small script that is only going to be used once, to produce one figure, probably doesn’t need separate testing: its output is either correct or not. A linear algebra library that will be used by thousands of people in twice that number of applications over the course of a decade, on the other hand, definitely does.

FIXME: more on limitations/cons: concerns about diverting effort away from new features, and the need to supplement automated testing with manual testing. Pros: potential economic savings as code becomes more complex to understand. Increased confidence in results, for yourselves and others.

{% include links.md %}
