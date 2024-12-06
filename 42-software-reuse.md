---
title: 4.2 Preparing Software for Reuse and Release
start: no
teaching: 35
exercises: 15
---

::::::::::::::::::::::::::::::::::::::: objectives

- Describe the different levels of software reusability
- Explain why documentation is important
- Describe the minimum components of software documentation to aid reuse
- Create a repository README file to guide others to successfully reuse a program
- Understand other documentation components and where they are useful
- Describe the basic types of open source software licence
- Explain the importance of conforming to data policy and regulation
- Prioritise and work on improvements for release as a team

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What can we do to make our programs reusable by others?
- How should we document and license our code?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

In previous episodes we have looked at skills, practices, and tools to help us
design and develop software in a collaborative environment.
In this lesson we will be looking at
a critical piece of the development puzzle that builds on what we have learnt so far -
sharing our software with others.

## The Levels of Software Reusability - Good Practice Revisited

Let us begin by taking a closer look at software reusability and what we want from it.

Firstly, whilst we want to ensure our software is reusable by others, as well as ourselves,
we should be clear what we mean by 'reusable'.
There are a number of definitions out there,
but a helpful one written by [Benureau and Rougler in 2017](https://dx.doi.org/10.3389/fninf.2017.00069)
offers the following levels by which software can be characterised:

1. Re-runnable: the code is simply executable
  and can be run again (but there are no guarantees beyond that)
2. Repeatable: the software will produce the same result more than once
3. Reproducible: published research results generated from the same version of the software
  can be generated again from the same input data
4. Reusable: easy to use, understand, and modify
5. Replicable: the software can act as an available reference
  for any ambiguity in the algorithmic descriptions made in the published article.
  That is, a new implementation can be created from the descriptions in the article
  that provide the same results as the original implementation,
  and that the original - or reference - implementation,
  can be used to clarify any ambiguity in those descriptions for the purposes of reimplementation

Later levels imply the earlier ones.
So what should we aim for?
As researchers who develop software - or developers who write research software -
we should be aiming for at least the fourth one: reusability.
Reproducibility is required if we are to successfully claim that
what we are doing when we write software fits within acceptable scientific practice,
but it is also crucial that we can write software that can be *understood*
and ideally *modified* by others.
If others are unable to verify that a piece of software follows published algorithms,
how can they be certain it is producing correct results?
Where 'others', of course, can include a future version of ourselves.

## Documenting Code to Improve Reusability

Reproducibility is a cornerstone of science,
and scientists who work in many disciplines are expected to document
the processes by which they have conducted their research so it can be reproduced by others.
In medicinal, pharmacological, and similar research fields for example,
researchers use logbooks which are then used to write up protocols and methods for publication.

Many things we have covered so far contribute directly to making our software
reproducible - and indeed reusable - by others.
A key part of this we will cover now is software documentation,
which is ironically very often given short shrift in academia.
This is often the case even in fields where
the documentation and publication of research method is otherwise taken very seriously.

A few reasons for this are that writing documentation is often considered:

- A low priority compared to actual research (if it is even considered at all)
- Expensive in terms of effort, with little reward
- Writing documentation is boring!

A very useful form of documentation for understanding our code is code commenting,
and is most effective when used to explain complex interfaces or behaviour,
or the reasoning behind why something is coded a certain way.
But code comments only go so far.

Whilst it is certainly arguable that writing documentation is not as exciting as writing code,
it does not have to be expensive and brings many benefits.
In addition to enabling general reproducibility by others, documentation...

- Helps bring new staff researchers and developers up to speed quickly with using the software
- Functions as a great aid to research collaborations involving software,
  where those from other teams need to use it
- When well written, can act as a basis for detailing
  algorithms and other mechanisms in research papers,
  such that the software's functionality can be *replicated* and re-implemented elsewhere
- Provides a descriptive link back to the science that underlies it.
  As a reference, it makes it far easier to know how to
  update the software as the scientific theory changes (and potentially vice versa)
- Importantly, it can enable others to understand the software sufficiently to
  *modify and reuse* it to do different things

In the next section we will see that writing
a sensible minimum set of documentation in a single document does not have to be expensive,
and can greatly aid reproducibility.

### Writing a README

A README file is the first piece of documentation
(perhaps other than publications that refer to it)
that people should read to acquaint themselves with the software.
It concisely explains what the software is about and what it is for,
and covers the steps necessary to obtain and install the software
and use it to accomplish basic tasks.
Think of it not as a comprehensive reference of all functionality,
but more a short tutorial with links to further information -
hence it should contain brief explanations and be focused on instructional steps.

Our repository already has a README that describes the purpose of the repository for this workshop,
but let us replace it with a new one that describes the software itself.
First let us delete the old one:

```bash
$ rm README.md
```

In the root of your repository create a replacement `README.md` file.
The `.md` indicates this is a **Markdown** file,
a lightweight markup language which is basically a text file with
some extra syntax to provide ways of formatting them.
A big advantage of them is that they can be read as plain-text files
or as source files for rendering them with formatting structures,
and are very quick to write.
GitHub provides a very useful [guide to writing Markdown][github-markdown] for its repositories.

Let us start writing `README.md` using a text editor of your choice and add the following line.

```markdown
# Inflam
```

So here, we are giving our software a name.
Ideally something unique, short, snappy, and perhaps to some degree an indicator of what it does.
We would ideally rename the repository to reflect the new name, but let us leave that for now.
In Markdown, the `#` designates a heading, two `##` are used for a subheading, and so on.
The Software Sustainability Institute's
[guide on naming projects][ssi-choosing-name]
and products provides some helpful pointers.

We should also add a short description underneath the title.

```markdown
# Inflam
Inflam is a data management system written in Python that manages trial data used in clinical inflammation studies.
```

To give readers an idea of the software's capabilities, let us add some key features next:

```markdown
# Inflam
Inflam is a data management system written in Python that manages trial data used in clinical inflammation studies.

## Main features
Here are some key features of Inflam:

- Provide basic statistical analyses over clinical trial data
- Ability to work on trial data in Comma-Separated Value (CSV) format
- Generate plots of trial data
- Analytical functions and views can be easily extended based on its Model-View-Controller architecture
```

As well as knowing what the software aims to do and its key features,
it is very important to specify what other software and related dependencies
are needed to use the software (typically called `dependencies` or `prerequisites`):

```markdown
# Inflam
Inflam is a data management system written in Python that manages trial data used in clinical inflammation studies.

## Main features
Here are some key features of Inflam:

- Provide basic statistical analyses over clinical trial data
- Ability to work on trial data in Comma-Separated Value (CSV) format
- Generate plots of trial data
- Analytical functions and views can be easily extended based on its Model-View-Controller architecture

## Prerequisites
Inflam requires the following Python packages:

- [NumPy](https://www.numpy.org/) - makes use of NumPy's statistical functions
- [Matplotlib](https://matplotlib.org/stable/index.html) - uses Matplotlib to generate statistical plots

The following optional packages are required to run Inflam's unit tests:

- [pytest](https://docs.pytest.org/en/stable/) - Inflam's unit tests are written using pytest
- [pytest-cov](https://pypi.org/project/pytest-cov/) - Adds test coverage stats to unit testing
```

Here we are making use of Markdown links,
with some text describing the link within `[]` followed by the link itself within `()`.

One really neat feature - and a common practice - of using many CI infrastructures is that
we can include the status of running recent tests within our README file.
Just below the `# Inflam` title on our README.md file,
add the following (replacing `<your_github_username>` with your own:

```markdown
# Inflam
![Continuous Integration build in GitHub Actions](https://github.com/<your_github_username>/python-intermediate-inflammation/actions/workflows/main.yml/badge.svg?branch=main)
...
```

This will embed a *badge* (icon) at the top of our page that
reflects the most recent GitHub Actions build status of your software repository,
essentially showing whether the tests that were run
when the last change was made to the `main` branch succeeded or failed.

That's got us started with documenting our code,
but there are other aspects we should also cover:

- *Installation/deployment:* step-by-step instructions for setting up the software so it can be used
- *Basic usage:* step-by-step instructions that cover using the software to accomplish basic tasks
- *Contributing:* for those wishing to contribute to the software's development,
  this is an opportunity to detail what kinds of contribution are sought and how to get involved
- *Contact information/getting help:* which may include things like key author email addresses,
  and links to mailing lists and other resources
- *Credits/acknowledgements:* where appropriate, be sure to credit those who
  have helped in the software's development or inspired it
- *Citation:* particularly for academic software,
  it is a very good idea to specify a reference to an appropriate academic publication
  so other academics can cite use of the software in their own publications and media.
  You can do this within a separate
  [CITATION text file](https://github.com/citation-file-format/citation-file-format)
  within the repository's root directory and link to it from the Markdown
- *Licence:* a short description of and link to the software's licence

For more verbose sections,
there are usually just highlights in the README with links to further information,
which may be held within other Markdown files within the repository or elsewhere.

We will finish these off later.
See [Matias Singer's curated list of awesome READMEs](https://github.com/matiassingers/awesome-readme) for inspiration.

### Other Documentation

There are many different types of other documentation you should also consider
writing and making available that's beyond the scope of this course.
The key is to consider which audiences you need to write for,
e.g. end users, developers, maintainers, etc.,
and what they need from the documentation.
There is a Software Sustainability Institute
[blog post on best practices for research software documentation](https://www.software.ac.uk/blog/2019-06-21-what-are-best-practices-research-software-documentation)
that helpfully covers the kinds of documentation to consider
and other effective ways to convey the same information.

One that you should always consider is **technical documentation**.
This typically aims to help other developers understand your code
sufficiently well to make their own changes to it,
including external developers, other members in your team and a future version of yourself too.
This may include documentation that covers the software's architecture,
including its different components and how they fit together,
API (Application Programming Interface) documentation
that describes the interface points designed into your software for other developers to use,
e.g. for a software library,
or technical tutorials/'HOW TOs' to accomplish developer-oriented tasks.

## Choosing an Open Source Licence

Software licensing is a whole topic in itself, so we'll just summarise here.
Your institution's Intellectual Property (IP) team will be able to offer specific guidance that
fits the way your institution thinks about software.

In IP law, software is considered a creative work of literature,
so any code you write automatically has copyright protection applied.
This copyright will usually belong to the institution that employs you,
but this may be different for PhD students.
If you need to check,
this should be included in your employment/studentship contract
or talk to your university's IP team.

Since software is automatically under copyright, without a licence no one may:

- Copy it
- Distribute it
- Modify it
- Extend it
- Use it (actually unclear at present - this has not been properly tested in court yet)

Fundamentally there are two kinds of licence,
**Open Source licences** and **Proprietary licences**,
which serve slightly different purposes:

- *Proprietary licences* are designed to pass on limited rights to end users,
  and are most suitable if you want to commercialise your software.
  They tend to be customised to suit the requirements of the software
  and the institution to which it belongs -
  again your institutions IP team will be able to help here.
- *Open Source licences* are designed more to protect the rights of end users -
  they specifically grant permission to make modifications and redistribute the software to others.
  The [website Choose A License](https://choosealicense.com/) provides recommendations
  and a simple summary of some of the most common open source licences.

Within the open source licences, there are two categories, **copyleft** and **permissive**:

- The permissive licences such as MIT and the multiple variants of the BSD licence
  are designed to give maximum freedom to the end users of software.
  These licences allow the end user to do almost anything with the source code.
- The copyleft licences in the GPL still give a lot of freedom to the end users,
  but any code that they write based on GPLed code must also be licensed under the same licence.
  This gives the developer assurance that anyone building on their code is also
  contributing back to the community.
  It's actually a little more complicated than this,
  and the variants all have slightly different conditions and applicability,
  but this is the core of the licence.

Which of these types of licence you prefer is up to you and those you develop code with.
If you want more information, or help choosing a licence,
the [Choose An Open-Source Licence](https://choosealicense.com/)
or [tl;dr Legal](https://tldrlegal.com/) sites can help.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Preparing for Release

In a (hopefully) highly unlikely and thoroughly unrecommended scenario,
your project leader has informed you of the need to release your software
within the next half hour,
so it can be assessed for use by another team.
You'll need to consider finishing the README,
choosing a licence,
and fixing any remaining problems you are aware of in your codebase.
Ensure you prioritise and work on the most pressing issues first!

::::::::::::::::::::::::::::::::::::::::::::::::::

## Merging into `main`

Once you have done these updates,
commit your changes,
and if you are doing this work on a feature branch also ensure you merge it into `develop`,
e.g.:

```bash
$ git switch develop
$ git merge my-feature-branch
```

Finally, once we have fully tested our software
and are confident it works as expected on `develop`,
we can merge our `develop` branch into `main`:

```bash
$ git switch main
$ git merge develop
$ git push origin main
```

The software on your `main` branch is now ready for release.

## Tagging a Release in GitHub

There are many ways in which Git and GitHub can help us make a software release from our code.
One of these is via **tagging**,
where we attach a human-readable label to a specific commit.
Let us see what tags we currently have in our repository:

```bash
$ git tag
```

Since we have not tagged any commits yet, there is unsurprisingly no output.
We can create a new tag on the last commit in our `main` branch by doing:

```bash
$ git tag -a v1.0.0 -m "Version 1.0.0"
```

So we can now do:

```bash
$ git tag
```

```output
v.1.0.0
```

And also, for more information:

```bash
$ git show v1.0.0
```

You should see something like this:

```output
tag v1.0.0
Tagger: <Name> <email>
Date:   Fri Dec 10 10:22:36 2021 +0000

Version 1.0.0

commit 2df4bfcbfc1429c12f92cecba751fb2d7c1a4e28 (HEAD -> main, tag: v1.0.0, origin/main, origin/develop, origin/HEAD, develop)
Author: <Name> <email>
Date:   Fri Dec 10 10:21:24 2021 +0000

	Finalising README.

diff --git a/README.md b/README.md
index 4818abb..5b8e7fd 100644
--- a/README.md
+++ b/README.md
@@ -22,4 +22,33 @@ Flimflam requires the following Python packages:
 The following optional packages are required to run Flimflam's unit tests:

 - [pytest](https://docs.pytest.org/en/stable/) - Flimflam's unit tests are written using pytest
-- [pytest-cov](https://pypi.org/project/pytest-cov/) - Adds test coverage stats to unit testing
\ No newline at end of file
+- [pytest-cov](https://pypi.org/project/pytest-cov/) - Adds test coverage stats to unit testing
+
+## Installation
+- Clone the repo ``git clone repo``
+- Check everything runs by running ``python -m pytest`` in the root directory
+- Hurray 
+
+## Contributing
+- Create an issue [here](https://github.com/Onoddil/python-intermediate-inflammation/issues)
+  - What works, what does not? You tell me
+- Randomly edit some code and see if it improves things, then submit a [pull request](https://github.com/Onoddil/python-intermediate-inflammation/pulls)
+- Just yell at me while I edit the code, pair programmer style!
+
+## Getting Help
+- Nice try
+
+## Credits
+- Directed by Michael Bay
+
+## Citation
+Please cite [J. F. W. Herschel, 1829, MmRAS, 3, 177](https://ui.adsabs.harvard.edu/abs/1829MmRAS...3..177H/abstract) if you used this work in your day-to-day life.
+Please cite [C. Herschel, 1787, RSPT, 77, 1](https://ui.adsabs.harvard.edu/abs/1787RSPT...77....1H/abstract) if you actually use this for scientific work.
+
+## License
+This source code is protected under international copyright law.  All rights
+reserved and protected by the copyright holders.
+This file is confidential and only available to authorized individuals with the
+permission of the copyright holders.  If you encounter this file and do not have
+permission, please contact the copyright holders and delete this file.
\ No newline at end of file
```

So now we have added a tag, we need this reflected in our Github repository.
You can push this tag to your remote by doing:

```bash
$ git push origin v1.0.0
```

:::::::::::::::::::::::::::::::::::::::::  callout

## What is a Version Number Anyway?

Software version numbers are everywhere,
and there are many different ways to do it.
A popular one to consider is [**Semantic Versioning**](https://semver.org/),
where a given version number uses the format MAJOR.MINOR.PATCH.
You increment the:

- MAJOR version when you make incompatible API changes
- MINOR version when you add functionality in a backwards compatible manner
- PATCH version when you make backwards compatible bug fixes

You can also add a hyphen followed by characters to denote a pre-release version,
e.g. 1.0.0-alpha1 (first alpha release) or 1.2.3-beta4 (fourth beta release)


::::::::::::::::::::::::::::::::::::::::::::::::::

We can now use the more memorable tag to refer to this specific commit.
Plus, once we have pushed this back up to GitHub,
it appears as a specific release within our code repository
which can be downloaded in compressed `.zip` or `.tar.gz` formats.
Note that these downloads just contain the state of the repository at that commit,
and not its entire history.

Using features like tagging allows us to highlight commits that are particularly important,
which is very useful for *reproducibility* purposes.
We can (and should) refer to specific commits for software in
academic papers that make use of results from software,
but tagging with a specific version number makes that just a little bit easier for humans.

## Conforming to Data Policy and Regulation

We may also wish to make data available to either
be used with the software or as generated results.
This may be via GitHub or some other means.
An important aspect to remember with sharing data on such systems is that
they may reside in other countries,
and we must be careful depending on the nature of the data.

We need to ensure that we are still conforming to
the relevant policies and guidelines regarding how we manage research data,
which may include funding council,
institutional,
national,
and even international policies and laws.
Within Europe, for example, there is the need to conform to things like [GDPR][gdpr].
it is a very good idea to make yourself aware of these aspects.



:::::::::::::::::::::::::::::::::::::::: keypoints

- The reuse battle is won before it is fought. Select and use good practices consistently throughout development and not just at the end.

::::::::::::::::::::::::::::::::::::::::::::::::::


