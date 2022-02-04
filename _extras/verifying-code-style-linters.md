---
title: "Additional Material: Verifying Code Style Using Linters"
teaching: 15
exercises: 5
questions:
- "What other tools help with maintaining a consistent coding style?"
- "How can we automate code style checking?"
objectives:
- "Use code linting tools to verify a program's adherence to a Python coding style"
- "Integrate linting tool style checking into a continuous integration job"
keypoints:
- "Use linting tools on the command line or via continuous integration to automatically check your code style."
---

## Verifying Code Style Using Linters

We've seen how we can use PyCharm to help us format our Python in a consistent style. This aids reusability, since consistent-looking code is easier to modify since it's easier to read and understand if it's consistent.

We can also use tools to identify consistency issues in a report-style too, using code **linters**. Linters analyse source code to identify and report on stylistic and even programming errors. Let's look at a very well used one of these called `pylint`.

First, let's ensure we are on the `develop` branch.

~~~
$ git branch
~~~
{: .language-bash}

You should see something like:

~~~
* develop
  main
...
~~~
{: .output}

If you see you are on a different branch, add, commit and push any changes (if there are any) and switch to the `develop` branch with `git checkout develop`.

Pylint is just a Python packages so we can install it in our virtual environment using:

~~~
$ pip3 install pylint
$ pylint --version
~~~
{: .language-bash}

We should see the version of Pylint, something like:

~~~
pylint 2.7.2
...
~~~
{: .output}

We should also update our `requirements.txt` with this new addition:

~~~
$ pip3 freeze > requirements.txt
~~~
{: .language-bash}

Pylint is a command-line tool that can help our code in many ways:

- *Check PEP8 compliance:* whilst in-IDE context-sensitive highlighting such as that provided via PyCharm helps us stay consistent with PEP8 as we write code, this tool provides a full report
- *Perform basic error detection:* Pylint can look for certain Python type errors
- *Check variable naming conventions*: pylint often goes beyond PEP8 to include other common conventions, such as naming variables outside of functions in upper case
- *Customisation*: you can specify which errors and conventions you wish to check for, and those you wish to ignore

Pylint can also identify **code smells**.

> ## How Does Code Smell?
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

And you should see something like...

~~~
************* Module inflammation.models
inflammation/models.py:20:0: C0301: Line too long (111/100) (line-too-long)
inflammation/models.py:29:0: C0301: Line too long (111/100) (line-too-long)
inflammation/models.py:38:0: C0301: Line too long (111/100) (line-too-long)
inflammation/models.py:60:4: W0622: Redefining built-in 'max' (redefined-builtin)

------------------------------------------------------------------
Your code has been rated at 8.71/10 (previous run: 8.44/10, +0.27)
~~~
{: .output}

Your own output will vary depending on how you have implemented previous exercises, and the coding style you have used. In the above example, we can see that we have redefined a built-in Python function called `max` in a previous exercise (within the `patient_normalise` function) which probably isn't a good idea and may have some undesired effects. It's important to note that while such tools are great at giving you a starting point to consider how to improve your code, they won't find everything wrong with it.

The five digit code e.g. `C0301` is a unique identifier for that type of warning, with the first character indicating the type of warning. There are five different types of warning that Pylint looks for, and you can get a summary of them by doing:

~~~
$ pylint --long-help
~~~
{: .language-bash}

Near the end you'll see:

~~~
  Output:
    Using the default text output, the message format is :
    MESSAGE_TYPE: LINE_NUM:[OBJECT:] MESSAGE
    There are 5 kind of message types :
    * (C) convention, for programming standard violation
    * (R) refactor, for bad code smell
    * (W) warning, for python specific problems
    * (E) error, for probable bugs in the code
    * (F) fatal, if an error occurred which prevented pylint from doing
    further processing.
~~~
{: .output}

So for an example of a Pylint Python-specific `warning`, see our accidental redefinition of `max` above.

> ## How Does Pylint Calculate the Score?
>
> The Python formula used is (with the variables representing numbers of each type of infraction and `statement` indicating the total number of statements):
>
> ~~~
> 10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)
> ~~~
> {: .language-bash}
>
> For example, with a total of 31 statements of models.py and views.py, with a count of the errors shown above, we get 8.71 rounded up. Note whilst there is a maximum score of 10, given the formula, there is no minimum score - it's quite possible to get a negative score!
{: .callout}

Now we can also add this Pylint execution to our continuous integration builds. For example, to add it to GitHub Actions we can add the following to our `.github/workflows/main.yml` at the end:

~~~
...
    - name: Check style with Pylint
      run: |
        python3 -m pylint --fail-under=0 --reports=y inflammation
...
~~~
{: .language-bash}

Note we need to add `--fail-under=0` otherwise the builds will fail if we don't get a 'perfect' score of 10! This seems unlikely, so let's be more pessimistic. We've also added `--reports=y` which will give us a more detailed report of the code analysis.

Then we can just add this to our repo and trigger a build:

~~~
$ git add .github/workflows/main.yml requirements.txt
$ git commit -m "Add Pylint run to build"
$ git push
~~~
{: .language-bash}

Then once complete, under the build(s) reports you should see an entry with the output from Pylint as before, but with an extended breakdown of the infractions by category as well as other metrics for the code, such as the number and line percentages of code, docstrings, comments, and empty lines.

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

Now when we run Pylint we won't be penalised for having a reasonable line length. For some further hints and tips on how to approach using Pylint for a project, see [this article](https://pythonspeed.com/articles/pylint/).


{% include links.md %}
