---
title: 4.3 Software Packaging and Release
teaching: 0
exercises: 20
---

::::::::::::::::::::::::::::::::::::::: objectives

- Describe the steps necessary for sharing Python code as installable packages.
- Use `uv` to prepare an installable package.
- Explain the differences between runtime and development dependencies.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How do we prepare our code for sharing as a Python package?
- How do we release our project for other people to install and reuse?

::::::::::::::::::::::::::::::::::::::::::::::::::

We have now got our software ready to release. All the changes were made in the `main` branch.
The last step is to give it a version number and find a proper way to distribute it.
We will look at how to make a release on GitHub,
then we will look at how to package our code so that others can easily install and use it.

## Update the Version Number in `pyproject.toml`

We start on the `main` branch.

```bash
$ git switch main
```

First we need to update the version number in our code.
This is typically done in the `pyproject.toml` for Python projects.
We currently have the version set to `0.0.0`, so let us update it to `0.1.0`:


```toml
[project]
...
version = "0.1.0"
...
```

Then we need to commit this change to the `main` branch:

```bash
$ git add pyproject.toml
$ git commit -m "Update version number to 0.1.0"
```

Note that this is usually done on a feature branch and then merged into `main` with a pull request.


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

## Tagging a Release in GitHub

There are many ways in which Git and GitHub can help us make a software release from our code.
For example, we can use GitHub website to create a new release. 
In this episode, we will look at how to do this using Git **tagging** at the command line.

Let us see what tags we currently have in our repository:

```bash
$ git tag
```

Since we have not tagged any commits yet, there is unsurprisingly no output.
We can create a new tag on the last commit in our `main` branch by doing:

```bash
$ git tag -a 0.1.0 -m "Version 0.1.0"
```

So we can check the tags again:

```bash
$ git tag
```

A tag should now be listed:

```output
0.1.0
```

And also, for more information:

```bash
$ git show 0.1.0
```

So now we have added a tag, we need this reflected in our Github repository.
You can push this tag to your remote by doing:

```bash
$ git push origin 0.1.0
```

We can now use the more memorable tag to refer to this specific commit.
Plus, once we have pushed this back up to GitHub,
it appears as a specific release within our code repository
which can be downloaded in compressed `.zip` or `.tar.gz` formats.
Note that these downloads just contain the state of the repository at that commit,
and not its entire history.

Using tagging allows us to highlight commits that are particularly important,
which is very useful for *reproducibility* purposes.
We can (and should) refer to specific commits for software in
academic papers that make use of results from software,
but tagging with a specific version number makes that just a little bit easier for humans.


## Packaging our Software with uv

For very small pieces of software,
for example a single source file,
it may be appropriate to distribute to non-technical end-users as source code,
but in most cases we want to bundle our application or library into a package.
A package is typically a single file which contains within it our software
and some metadata which allows it to be installed and used more simply -
e.g. a list of dependencies.
By distributing our code as a package,
we reduce the complexity of fetching, installing and integrating it for the end-users.

::::::::::::::::::::::::::::::::::::::::::  callout

## Further reading: Python Packaging User Guide

You can refer to the [Python Packaging User Guide](https://packaging.python.org/)
for documentation on best practices and tools for packaging Python projects.

At the end of this episode, there is an optional exercise
where you can try more good practices for packaging your Python project

::::::::::::::::::::::::::::::::::::::::::

For packaging our code, we will introduce `uv`,
an extremely fast Python package and project manager, written in Rust. 


### Installing uv

On MacOS or Linux, you can install `uv` using the following command:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

On Windows, you can install `uv` by:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

You can refer to the [uv installation documentation](https://docs.astral.sh/uv/getting-started/installation/) 
for more details on installation.

### Packaging Our Code

The final preparation we need to do is to
make sure that our code is organised in the recommended structure.
This is the Python module structure -
a directory containing an `__init__.py` and our Python source code files.
Make sure that the name of this directory is `inflammation`, which
matches the following section in `pyproject.toml`:

```toml
[tool.setuptools]
packages = ["inflammation"]
```

Then "inflammation" will be the name of the package when it is installed.
Of course you can choose different names for your package,
but you must ensure that the `pyproject.toml` file is updated accordingly.

Once we have made sure our project is in the right structure,
we can go ahead and build a distributable version of our software:

```bash
$ uv build
```

This should produce two files in the `dist/` directory:

```output
dist/python_intermediate_inflammation-0.1.0.tar.gz
dist/python_intermediate_inflammation-0.1.0-py3-none-any.whl
```

The one we care most about is the `.whl` or **wheel** file.
This is the file that `pip` uses to distribute and install Python packages,
so this is the file we would need to share with other people who want to install our software.

By convention distributable package names use hyphens,
whereas module package names use underscores.
While we could choose to use underscores in a distributable package name,
we cannot use hyphens in a module package name,
as Python will interpret them as a minus sign in our code when we try to import them.

Now if we gave this wheel file to someone else,
they could install it using `pip` (you do not need to run this command yourself)

```bash
$ pip install python_intermediate_inflammation-0.1.0-py3-none-any.whl
```

And then they could import our package in their own Python environment:

```python
import inflammation
```

After we have been working on our code for a while and want to publish an update,
we just need to update the version number in the `pyproject.toml` file
(using [SemVer](https://semver.org/) perhaps),
then use `uv` to build and publish the new version.

`uv` can help easily increment the version number following Semantic Versioning conventions.
For example, to increment the minor version number, we can do:

```bash
$ uv version --bump minor
```

Then the version number in `pyproject.toml` will be updated from `0.1.0` to `0.2.0`. 

For more information about versioning with `uv`, see the [uv versioning documentation](https://docs.astral.sh/uv/guides/package/#updating-your-version).

### Project Dependencies

Tools like `uv` understand that there are two different types of dependency:
runtime dependencies and development dependencies.
Runtime dependencies are those dependencies that
need to be installed for our code to run, like `numpy`.
Development dependencies are dependencies which
are an essential part of your development process for a project,
but are not required to run it. Like `mkdocs` we used to build our documentation.

When we add a dependency using `uv`,
`uv` will add it to the list of dependencies in the `pyproject.toml` file,
and automatically install the package into our virtual environment, even if the 
virtual environment is not currently activated.

For example, one can add `numpy matplotlib` as a runtime dependency by doing:

```bash
$ uv add numpy matplotlib
```

This will add `numpy` and `matplotlib` to the list of runtime dependencies in `pyproject.toml`:

```toml
[project]
name = "python-intermediate-inflammation"
version = "0.2.0"
requires-python = ">=3.9"
dependencies = [
    "matplotlib>=3.9.4",
    "numpy>=2.0.2",
]
```

This is an alternative way to specify the dependencies than the `requirements.txt` file we created before.
The advantage of specifying dependencies in `pyproject.toml`, is that it centralizes this information in one place,
and we can also make a distinction between runtime and development dependencies.

To add `mkdocs` as a development dependency, the `--group` option can be used:

```bash
$ uv add --group dev mkdocs
```

This will add a new section to the `pyproject.toml` file for development dependencies:

```toml
[dependency-groups]
dev = [
    "mkdocs>=1.6.1",
]
```

By default, when someone installs our package using `pip`,
only the runtime dependencies will be installed, as development dependencies are not needed to run the code.

To install the development dependencies, one need to clone our repository
from GitHub and then specify the `dev` extra when installing:

```bash
$ pip install .[dev]
```

This behavior can be customized in the `pyproject.toml` file. Check the
[uv documentation on dependencies](https://docs.astral.sh/uv/concepts/projects/dependencies/?utm_source=chatgpt.com)

## What if We Need More Control?

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

- `uv` allows us to produce an installable package and upload it to a package repository.
- Making our software installable with Pip makes it easier for others to start using it.
- For complete control over building a package, we can use a `setup.py` file.

::::::::::::::::::::::::::::::::::::::::::::::::::


