---
title: 4.3 Packaging Code for Release and Distribution
teaching: 0
exercises: 20
---

::::::::::::::::::::::::::::::::::::::: objectives

- Describe the steps necessary for sharing Python code as installable packages.
- Use Poetry to prepare an installable package.
- Explain the differences between runtime and development dependencies.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How do we prepare our code for sharing as a Python package?
- How do we release our project for other people to install and reuse?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Why Package our Software?

We have now got our software ready to release -
the last step is to package it up so that it can be distributed.

For very small pieces of software,
for example a single source file,
it may be appropriate to distribute to non-technical end-users as source code,
but in most cases we want to bundle our application or library into a package.
A package is typically a single file which contains within it our software
and some metadata which allows it to be installed and used more simply -
e.g. a list of dependencies.
By distributing our code as a package,
we reduce the complexity of fetching, installing and integrating it for the end-users.

In this session we will introduce
one widely used method for building an installable package from our code.
There are range of methods in common use,
so it is likely you will also encounter projects which take different approaches.

There is some confusing terminology in this episode around the use of the term "package".
This term is used to refer to both:

- A directory containing Python files / modules and an `__init__.py` - a "module package"
- A way of structuring / bundling a project for easier distribution and installation -
  a "distributable package"

## Packaging our Software with Poetry

### Installing Poetry

Because we have recommended GitBash if you are using Windows,
we are going to install Poetry using a different method to the officially recommended one.
If you are on MacOS or Linux,
are comfortable with installing software at the command line
and want to use Poetry to manage multiple projects,
you may instead prefer to follow the official
[Poetry installation instructions](https://python-poetry.org/docs/#installation).

We can install Poetry much like any other Python distributable package, using `pip`:

```bash
$ source venv/bin/activate
$ python3 -m pip install poetry
```

To test, we can ask where Poetry is installed:

```bash
$ which poetry
```

```output
/home/alex/python-intermediate-inflammation/venv/bin/poetry
```

If you do not get similar output,
make sure you have got the correct virtual environment activated.

Poetry can also handle virtual environments for us,
so in order to behave similarly to how we used them previously,
let us change the Poetry config to put them in the same directory as our project:

```bash
$ poetry config virtualenvs.in-project true
```

### Setting up our Poetry Config

Poetry uses a **pyproject.toml** file to describe
the build system and requirements of the distributable package.
This file format was introduced to solve problems with bootstrapping packages
(the processing we do to prepare to process something)
using the older convention with **setup.py** files and to support a wider range of build tools.
It is described in
[PEP 518 (Specifying Minimum Build System Requirements for Python Projects)](https://www.python.org/dev/peps/pep-0518/).

Make sure you are in the root directory of your software project
and have activated your virtual environment,
then we are ready to begin.

To create a `pyproject.toml` file for our code, we can use `poetry init`.
This will guide us through the most important settings -
for each prompt, we either enter our data or accept the default.

*Displayed below are the questions you should see
with the recommended responses to each question so try to follow these,
although use your own contact details!*

**NB: When you get to the questions about defining our dependencies,
answer no, so we can do this separately later.**

:::::::::::::::::::::::::::::::::::::::::  callout

## It's Not Interactive?

If you're using Git Bash for Windows, depending on your configuration, you may find after typing this command that you don't have an interactive set of questions displayed.
Instead, you may find the `pyproject.toml` file is simply generated with a set of default values.

If this happens, you can edit the `pyproject.toml` file and change the values in this file, similarly to how we have in the output below.

:::::::::::::::::::::::::::::::::::::::::

```bash
$ poetry init
```

```output
This command will guide you through creating your pyproject.toml config.

Package name [example]:  inflammation
Version [0.1.0]: 1.0.0
Description []:  Analyse patient inflammation data
Author [None, n to skip]: James Graham <J.Graham@software.ac.uk>
License []:  MIT
Compatible Python versions [^3.11]: ^3.11

Would you like to define your main dependencies interactively? (yes/no) [yes] no
Would you like to define your development dependencies interactively? (yes/no) [yes] no
Generated file

[tool.poetry]
name = "inflammation"
version = "1.0.0"
description = "Analyse patient inflammation data"
authors = ["James Graham <J.Graham@software.ac.uk>"]
license = "MIT"

[tool.poetry.dependencies]
python = "^3.11"

[tool.poetry.dev-dependencies]

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"


Do you confirm generation? (yes/no) [yes] yes
```

Note that we have called our package "inflammation" in the setup above,
instead of "inflammation-analysis".
This is because Poetry will automatically find our code
if the name of the distributable package matches the name of our module package.
If we wanted our distributable package to have a different name,
for example "inflammation-analysis",
we could do this by explicitly listing the module packages to bundle -
see [the Poetry docs on packages](https://python-poetry.org/docs/pyproject/#packages)
for how to do this.

### Project Dependencies

Previously, we looked at using a `requirements.txt` file to define the dependencies of our software.
Here, Poetry takes inspiration from package managers in other languages,
particularly NPM (Node Package Manager),
often used for JavaScript development.

Tools like Poetry and NPM understand that there are two different types of dependency:
runtime dependencies and development dependencies.
Runtime dependencies are those dependencies that
need to be installed for our code to run, like NumPy.
Development dependencies are dependencies which
are an essential part of your development process for a project,
but are not required to run it.
Common examples of developments dependencies are linters and test frameworks,
like `pylint` or `pytest`.

When we add a dependency using Poetry,
Poetry will add it to the list of dependencies in the `pyproject.toml` file,
add a reference to it in a new `poetry.lock` file,
and automatically install the package into our virtual environment.
If we do not yet have a virtual environment activated,
Poetry will create it for us - using the name `.venv`,
so it appears hidden unless we do `ls -a`.
Because we have already activated a virtual environment, Poetry will use ours instead.
The `pyproject.toml` file has two separate lists,
allowing us to distinguish between runtime and development dependencies.

```bash
$ poetry add matplotlib numpy
$ poetry add --group dev pylint
$ poetry install
```

These two sets of dependencies will be used in different circumstances.
When we build our package and upload it to a package repository,
Poetry will only include references to our runtime dependencies.
This is because someone installing our software through a tool like `pip` is only using it,
but probably does not intend to contribute to the development of our software
and does not require development dependencies.

In contrast, if someone downloads our code from GitHub,
together with our `pyproject.toml`,
and installs the project that way,
they will get both our runtime and development dependencies.
If someone is downloading our source code,
that suggests that they intend to contribute to the development,
so they will need all of our development tools.

Have a look at the `pyproject.toml` file again to see what's changed.

### Packaging Our Code

The final preparation we need to do is to
make sure that our code is organised in the recommended structure.
This is the Python module structure -
a directory containing an `__init__.py` and our Python source code files.
Make sure that the name of this Python package
(`inflammation` - unless you have renamed it)
matches the name of your distributable package in `pyproject.toml`
unless you have chosen to explicitly list the module packages.

By convention distributable package names use hyphens,
whereas module package names use underscores.
While we could choose to use underscores in a distributable package name,
we cannot use hyphens in a module package name,
as Python will interpret them as a minus sign in our code when we try to import them.

Once we have got our `pyproject.toml` configuration done and our project is in the right structure,
we can go ahead and build a distributable version of our software:

```bash
$ poetry build
```

This should produce two files for us in the `dist` directory.
The one we care most about is the `.whl` or **wheel** file.
This is the file that `pip` uses to distribute and install Python packages,
so this is the file we would need to share with other people who want to install our software.

Now if we gave this wheel file to someone else,
they could install it using `pip` -
you do not need to run this command yourself,
you have already installed it using `poetry install` above.

```bash
$ python3 -m pip install dist/inflammation*.whl
```

The star in the line above is a **wildcard**,
that means Bash should use any filenames that match that pattern,
with any number of characters in place for the star.
We could also rely on Bash's autocomplete functionality and type `dist/inflammation`,
then hit the <kbd>Tab</kbd> key if we have only got one version built.

After we have been working on our code for a while and want to publish an update,
we just need to update the version number in the `pyproject.toml` file
(using [SemVer](https://semver.org/) perhaps),
then use Poetry to build and publish the new version.
If we do not increment the version number,
people might end up using this version,
even though they thought they were using the previous one.
Any re-publishing of the package, no matter how small the changes,
needs to come with a new version number.
The advantage of [SemVer](https://semver.org/) is that the change in the version number
indicates the degree of change in the code and thus the degree of risk of breakage when we update.

```bash
$ poetry build
```

In addition to the commands we have already seen,
Poetry contains a few more that can be useful for our development process.
For the full list see the [Poetry CLI documentation](https://python-poetry.org/docs/cli/).

The final step is to publish our package to a package repository.
A package repository could be either public or private -
while you may at times be working on public projects,
it is likely the majority of your work will be published internally
using a private repository such as JFrog Artifactory.
Every repository may be configured slightly differently,
so we will leave that to you to investigate.

## What if We Need More Control?

Sometimes we need more control over the process of
building our distributable package than Poetry allows.
There many ways to distribute Python code in packages,
with some degree of flux in terms of which methods are most popular.
For a more comprehensive overview of Python packaging you can see the
[Python docs on packaging](https://packaging.python.org/en/latest/),
which contains a helpful guide to the overall
[packaging process, or 'flow'](https://packaging.python.org/en/latest/flow/),
using the [Twine](https://pypi.org/project/twine/) tool to
upload created packages to PyPI for distribution as an alternative.

:::::::::::::::::::::::::::::::::::::::  challenge

## Optional Exercise: Enhancing our Package Metadata

The [Python Packaging User Guide](https://packaging.python.org/)
provides documentation on
[how to package a project](https://packaging.python.org/en/latest/tutorials/packaging-projects/)
using a manual approach to building a `pyproject.toml` file,
and using Twine to upload the distribution packages to PyPI.

Referring to the
[section on metadata](https://packaging.python.org/en/latest/tutorials/packaging-projects/#configuring-metadata)
in the documentation,
enhance your `pyproject.toml` with some additional metadata fields
to improve the information your package.


::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::: keypoints

- Poetry allows us to produce an installable package and upload it to a package repository.
- Making our software installable with Pip makes it easier for others to start using it.
- For complete control over building a package, we can use a `setup.py` file.

::::::::::::::::::::::::::::::::::::::::::::::::::


