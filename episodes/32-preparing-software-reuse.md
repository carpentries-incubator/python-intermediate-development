---
title: "Preparing Software for Reuse"
teaching: 40
exercises: 20
questions:
- "Key question (FIXME)"
objectives:
- "Describe the different levels of software reusability"
- "Use code linting tools to verify a program's adherence to a Python coding style"
- "Explain why documentation is important"
- "Describe the minimum components of software documentation to aid reuse"
- "Create a repository README file to guide others to successfully reuse a program"
- "Understand other documentation components and where they are useful"
- "Describe the basic types of open source software licence"
- "Explain the importance of conforming to data policy and regulation"
- "Prioritise and work on improvements for release as a team"
keypoints:
- "The reuse battle is won before it is fought. Use good practices consistently throughout development and not just at the end."
---

If previous episodes we've looked at skills, practices, and tools to help us design and develop software in a collaborative environment. In this lesson we'll be looking at a critical piece of the development puzzle that builds on what we've learnt so far - sharing our software with others.


## The levels of software reusability - good practice revisited

Let's begin by taking a closer look at software reusability and what we want from it.

Firstly, whilst we want to ensure our software is reusable by others, as well as ourselves, we should be clear what we mean by 'reusable'. There are a number of definitions out there, but a helpful one written by [Benureau and Rougler in 2017](https://dx.doi.org/10.3389/fninf.2017.00069) offers the following levels by which software can be characterised:

1. Re-runnable: the code is simply executable and can be run again (but there are no guarantees beyond that)
2. Repeatable: the software will produce the same result more than once
3. Reproducible: published research results generated from the same version of the software can be generated again from the same input data
4. Reusable: easy to use, understand, and modify
5. Replicable: the software can act as an available reference for any ambiguity in the algorithmic descriptions made in the published article. That is, a new implementation can be created from the descriptions in the article that provide the same results as the original implementation, and that the original - or reference - implementation, can be used to clarify any ambiguity in those descriptions for the purposes of reimplementation

Later levels imply the earlier ones. So what should we aim for? As researchers who develop software - or developers who write research software - we should be aiming for at least the fourth one: reusability. Reproducibility is required if we are to successfully claim that what we are doing when we write software fits within acceptable scientific practice, but it is also crucial that we can write software that can be *understood* by others. If others are unable to verify that a piece of software follows published algorithms and ideally *modified*. Where 'others', of course, can include a future version of ourselves.

> ## Reproducibility and non-determinism
>
> FIXME: a note on how software that is intrinsically non-deterministic still fits within the bounds of repeatability and reproducibilty, and the importance of defining acceptable bounds for that.
>
{: .callout}

FIXME: use this narrative throughout section, e.g. where a practice helps us achieve one of these levels

FIXME: add section that highlights practices already covered in the course in the context of these, as a framework?


## Verifying code style using linters

We've seen how we can use tools like `yapf` to automatically format our Python to enforce a consistent style. We can do this in a report-style too, using code **linters**. Linters analyse source code to identify and report on stylistic and even programming errors. Let's look at a very well used one of these called `pylint`. It's just a Python packages so we can install it in our virtual environment using:

~~~
$ pip install pylint
~~~
{: .language-bash}

We should also update our `requirements.txt` with this new addition:

~~~
$ pip freeze > requirements.txt
$ git add requirements.txt
$ git commit -m "Update with linting tool" requirements.txt
$ git push
~~~
{: .language-bash}

Pylint is a command-line tool that can help our code in many ways:

- *Check PEP8 compliance:* whilst in-IDE context-sensitive highlighting such as that provided via PyCharm helps us stay consistent with PEP8 as we write code, this tool provides a full report
- *Perform basic error detection:* Pylint can look for certain Python type errors
- *Check variable naming conventions*: pylint often goes beyond PEP8 to include other common conventions, such as naming variables outside of functions in upper case
- *Customisation*: you can specify which errors and conventions you wish to check for, and those you wish to ignore

Pylint can also identify **code smells**.

> ## How does code smell?
>
> There are many ways that code can exhibit bad design whilst not breaking any rules and working correctly. A *code smell* is a characteristic that indicates that there is an underlying problem with source code, e.g. large classes or methods, methods with too many parameters, duplicated statements in both if and else blocks of conditionals, etc. They aren't functional errors in the code, but rather are certain structures that violate principles of good design and impact design quality. They can also indicate that code is in need of maintenance.
>
> The phrase has it’s origins in Chapter 3 Bad smells in code by Kent Beck and Martin Fowler in Fowler, Martin (1999). Refactoring. Improving the Design of Existing Code. Addison-Wesley. ISBN 0-201-48567-2.
>
{: .callout}

Pylint recommendations are given as warnings or errors, and also scores the code with an overall mark. We can look at a specific file, or a module. Let's look at our `inflammation` module:

~~~
$ pylint inflammation
~~~
{: .language-bash}

FIXME: update pylint output when template repo complete and all exercises have been done

~~~
************* Module inflammation.models
inflammation/models.py:37:4: W0622: Redefining built-in 'max' (redefined-builtin)
************* Module inflammation.views
inflammation/views.py:4:0: W0611: Unused numpy imported as np (unused-import)

-----------------------------------
Your code has been rated at 7.60/10
~~~
{: .output}

We can also add this Pylint execution to our continuous integration builds. For example, to add it to GitHub Actions we can add the following to our `.github/workflows/main.yml`:

~~~
    - name: Check style with Pylint
      run: |
        pylint --fail-under=0 inflammation tests/test_*.py
~~~
{: .language-bash}

Note we need to add `--fail-under=0` otherwise the builds will fail if we don't get a 'perfect' score of 10! This seems unlikely, so let's be more pessimistic.

Then we can just add this to our repo and trigger a build:

~~~
$ git add .github/workflows/main.yml
$ git commit -m "Add Pylint run to build" .github/workflows/main.yml
$ git push
~~~
{: .language-bash}

Then we should see under 'Check style with Pylint', something like:

FIXME: update pylint output when template repo complete and all exercises have been done

~~~
Run pylint --fail-under=0 inflammation tests/test_*.py
************* Module tests/test_*.py
tests/test_*.py:1:0: F0001: No module named tests/test_*.py (fatal)
************* Module inflammation.models
inflammation\models.py:32:2: W0511: TODO(lesson-design) Add Patient class (fixme)
inflammation\models.py:33:2: W0511: TODO(lesson-design) Implement data persistence (fixme)
inflammation\models.py:34:2: W0511: TODO(lesson-design) Add Doctor class (fixme)
************* Module inflammation.views
inflammation\views.py:12:2: W0511: TODO(lesson-design) Extend to allow saving figure to file (fixme)
inflammation\views.py:4:0: W0611: Unused numpy imported as np (unused-import)

-----------------------------------

Your code has been rated at 7.50/10
~~~
{: .output}

So we specified a score of 0 as a minimum which is very low. If we decide as a team on a suitable minimum score for our codebase, we can specify this instead. There are also ways to specify specific style rules that shouldn't be broken which will cause Pylint to fail, which could be even more useful if we want to mandate a consistent style.

We can specify overrides to Pylint's rules in a file called `.pylintrc` which Pylint can helpfully generate for us. In our repository root directory:

~~~
$ pylint --generate-rcfile > .pylintrc
~~~
{: .language-bash}

Looking at this file, you'll see it's already populated. No behaviour is currently changed from the default by generating this file, but we can amend it to suit our team's coding style. For example, a typical rule to customise - favoured by many projects - is the one involving line length. You'll see it's set to 100, so let's set that to a more reasonable 120. While we're at it, let's also set our `file-under` in this file:

~~~
...
# Specify a score threshold to be exceeded before program exits with error.
fail-under=0
...
# Maximum number of characters on a single line.
max-line-length=120
...
~~~
{: .language-bash}

Don't forget to remove the `--fail-under` argument to Pytest in our GitHub Actions configuration file too, since we don't need it anymore.

Now when we run Pylint we won't be penalised for having a reasonable line length. For some further hints and tips on how to approach using Pylint for a project, see ![this article](https://pythonspeed.com/articles/pylint/).


## Documenting code for reuse

Reproducibility is a cornerstone of science, and scientists who work in many disciplines are expected to document the processes by which they've conducted their research so it can be reproduced by others. In medicinal, pharmacological, and similar research fields for example, researchers use logbooks which are then used to write up protocols and methods for publication.

Many things we've covered so far contribute directly to making our software reproducible - and indeed reusable - by others. A key part of this we'll cover now is software documentation, which is ironically very often given short shrift in academia. This is often the case even in fields where the documentation and publication of research method is otherwise taken very seriously.

A few reasons for this are that writing documentation is often considered:
 
- A low priority compared to actual research (if it's even considered at all)
- Expensive in terms of effort, with little reward
- Boring!

Whilst it's certainly arguable that writing documentation isn't as exciting as writing code, it doesn't have to be expensive and brings many benefits. In addition to enabling general reproducibility by others, documentation...

- Helps bring new staff researchers and developers up to speed quickly with using the software
- Functions as a great aid to research collaborations involving software where those from other teams need to use it
- When well written, can act as a basis for detailing algorithms and other mechanisms in research papers
- Provides a descriptive link back to the science that underlies it. As a reference, it makes it far easier to know how to update the software as the scientific theory changes (and potentially vice versa)

In the next section we'll see that writing a sensible minimum set of documentation in a single document doesn't have to be expensive, and can greatly aid reproducibility.


### Writing a README

A README file is the first piece of documentation (perhaps other than publications that refer to it) that people should read to acquaint themselves with the software. It concisely explains what the software is about and what it's for, and covers the steps necessary to obtain and install the software and use it to accomplish basic tasks. Think of it not as a comprehensive reference of all functionality, but more a short tutorial - hence it should contain brief explanations and be focused on instructional steps.

Let's create one for our repository now. In the root of your repository create a new file `README.md`. The `.md` indicates this is a **markdown** file, a lightweight markup language which is basically a text file with some extra syntax to provide ways of formatting them. A big advantage of them is that they can be read as plain-text files or as source files for rendering them with formatting structures.

FIXME: add GitHub markdown link to references - https://guides.github.com/features/mastering-markdown/

Let's start writing it.

~~~
# Inflam
~~~
{: .language-bash}

So here, we're giving our software a name. Ideally something unique, short, snappy, and perhaps to some degree an indicator of what it does. In markdown, the `#` designates a heading, two `##` are used for a subheading, and so on.

FIXME: add https://software.ac.uk/resources/guides/choosing-project-and-product-names to references

We should also add a short description.

~~~
FIXME: add description
~~~
{: .language-bash}

~~~
## Prerequisites

FIXME: add prereqs
~~~
{: .language-bash}

That's got us started, but there are other aspects we should cover:

- Installation/deployment
- Basic usage
- Contributing
- Contact information
- Credits
- License

We'll finish these later.

FIXME: adding links to build runs



![build](https://github.com/steve-crouch/swc-intermediate-template/workflows/CI/badge.svg?branch=master)


### Other documentation

FIXME: CITATION, technical documentation - architecture, design, API documentation, format/medium (within GitHub? Wiki?)

## Choosing an open source licence

FIXME: licence compatibility of third party dependencies

## Tagging a release in GitHub

> ## Preparing for release
>
> In a (hopefully) highly unlikely scenario, your project leader has informed your team of the need to release your software within the next 40 minutes, so it can be assessed for use by another team. You'll need to consider finishing the README, choosing a license, fixing any remaining problems you are aware of in your codebase, and when the repository is ready, tagging a release in GitHub. As a team prioritise and accomplish the work to be done so the software can be released on time.
>
> > ## Solution
> {: .solution}
>
{: .challenge}


## Conforming to data policy and regulation

FIXME: a couple of paragraphs centered around levels of policy and regulation - institutional, funding agency, and national regulation (?). Basically, find out what these are and follow them. Also applies to licensing


{% include links.md %}
