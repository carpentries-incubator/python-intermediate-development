---
title: "Packaging Code for Distribution"
teaching: 0
exercises: 30
questions:
- "How do we prepare our code for sharing as a Python package?"
- "How do we release our project for other people to install?"
objectives:
- "Describe the steps necessary for sharing Python code as installable packages."
- "Use Poetry to prepare an installable package."
- "Explain the differences between runtime and development dependencies."
- "Upload an installable Python package to a package index."
keypoints:
- "Poetry allows us to produce an installable package and upload it to a package index."
- "Making our software installable with pip makes it easier for others to start using it."
- "For complete control over building a package, we can use a setup.py file."
---

## Why Package our Software?

We've now got our software ready to release - the last step is to package it up so that it can be distributed.

For very small pieces of software, for example a single source file, it may be appropriate to distribute as-is, but in most cases we want to bundle our application or library into a package.
A package is typically a single file which contains within it our software and some metadata which allows it to be installed and used more simply - e.g. a list of dependencies.
By distributing our code as a package, we reduce the complexity of fetching, installing and integrating it for the end-users.

In this session we'll introduce two different methods for building an installable package from our code.
The first, using a tool called **Poetry**, is the simpler of the two methods, so we'll walk through the complete packaging process and end up with a package uploaded to the PyPI test site.
The second method, using **setup.py**, is the more traditional method and gives us full control, but is more complicated - we won't cover this fully, but it might be something you want to investigate further in future.

## Packaging our Software with Poetry

### Installing Poetry

Before we start this section, let's make sure that we don't have any virtual environments currently activated.
This is because Poetry is typically installed at the user level, not just within a particular virtual environment.
If we don't currently have a virtual environment activated this will give us an error message or tell us to use `source deactivate` - that's fine.

~~~ bash
deactivate
~~~
{: .language-bash}

The recommended install method for Poetry is to download an execute an installer script.
The exact method for this will vary depending on your choice of operating system - the instructions below assume you are using Ubuntu Linux.
For alternative methods, see https://python-poetry.org/docs/#installation.

~~~ bash
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -
~~~
{: .language-bash}

If this fails, it's possible we need to install an extra dependency and try again:

~~~ bash
sudo apt install virtualenv
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -
~~~
{: .language-bash}

Once Poetry has installed itself, we need to make sure our shell can find it - the install process should give you a line to be added at the bottom of your shell config file.
If you're on Ubuntu, the file we need to add it to is `~/.bashrc` and the line should be similar to the one below.
If you're on MacOS, the file will probably be `~/.zshrc` and the line to add will be slightly different.

~~~ bash
export PATH="$HOME/.local/bin:$PATH"
~~~
{: .language-bash}

Once we've finished installing, the simplest thing to do here is to just close our terminal and open another one.
Then the changes that Poetry makes should have been applied automatically for us.

To test, we can ask where Poetry is installed:

~~~ bash
which poetry
~~~
{: .language-bash}

~~~
/home/sabsr3/.local/bin/poetry
~~~
{: .output}

If you don't get similar output, then we can try activating it manually and checking again.
This would need to be done each time we open a new terminal and want to use Poetry.
The file to source might be different depending on your system.

~~~ bash
source $HOME/.poetry/env
which poetry
~~~
{: .language-bash}

~~~
/home/sabsr3/.poetry/bin/poetry
~~~
{: .output}

Poetry can also handle virtual environments for us, so in order to behave similarly to how we used them previously, let's change the Poetry config to put them in the same directory as our project:

~~~ bash
poetry config virtualenvs.in-project true
~~~
{: .language-bash}

### Setting up our Poetry Config

Poetry uses a **pyproject.toml** file to describe the build system and requirements of the package.
This file format was described in [PEP 518](https://www.python.org/dev/peps/pep-0518/) to solve problems with bootstrapping (the processing we do to prepare to process something) packages using the older convention **setup.py** files and to support a wider range of build tools.

> ## Python Enhancement Proposals
>
> PEP here stands for Python Enhancement Proposals.
> PEPs are design documents for the Python community, typically specifications or conventions for how to do something in Python, a description of a new feature in Python, etc.
>
> One of the most frequently referred to PEPs is [PEP8](https://www.python.org/dev/peps/pep-0008/) which acts as the Python community style guide.
> This document gives suggestions for how to format our Python code to ensure that it's easily readable by other developers.
{: .callout}

First let's make sure we're in the root directory of our software project:

~~~ bash
cd
cd se-day4/code/poetry_project
~~~
{: .language-bash}

Because we're going to use Poetry to manage our dependencies and virtual environment for us, we should deactivate and remove our previous virtual environment to make sure it's clean.
Remember that when we do `deactivate` we might get an error or warning if we weren't already in a virtual environment - this is fine.

~~~ bash
deactivate
rm -rf venv
~~~
{: .language-bash}

Now we're ready to begin.

To create a `pyproject.toml` file for our code, we can use `poetry init`.
This will guide us through the most important settings - for each prompt, we either enter our data or accept the default.
For the package name, make sure this has some unique identifier in it so it doesn't match the package name of anyone else - I've used my name here, you could use your name, or some random text.
This is because, if we want to upload it to the test version of PyPI at the end, it will need to be globally unique.
Note that, usually when we're naming a Python installable package, we use hyphens to separate words.

When we get to the questions about defining our dependencies, we'll answer no, so we can do this separately later.

~~~ bash
poetry init
~~~
{: .language-bash}

~~~
This command will guide you through creating your pyproject.toml config.

Package name [example]:  inflam-jgraham
Version [0.1.0]: 0.1.0
Description []:  Example project for using Poetry to build packages
Author [None, n to skip]: James Graham <J.Graham@software.ac.uk>
License []:  MIT
Compatible Python versions [^3.8]: ^3.8

Would you like to define your main dependencies interactively? (yes/no) [yes] no
Would you like to define your development dependencies interactively? (yes/no) [yes] no
Generated file

[tool.poetry]
name = "inflam-jgraham"
version = "0.1.0"
description = "Analyse patient inflammation data"
authors = ["James Graham <J.Graham@software.ac.uk>"]
license = "MIT"

[tool.poetry.dependencies]
python = "^3.8"

[tool.poetry.dev-dependencies]

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"


Do you confirm generation? (yes/no) [yes] yes
~~~
{: .output}

### Project Dependencies

Previously, we looked at using a `requirements.txt` file to define the dependencies of our software.
Here, Poetry takes inspiration from package managers in other languages, particularly NPM (Node Package Manager), often used in JavaScript.

Tools like Poetry and NPM understand that there are two different types of dependency: runtime dependencies and development dependencies.
Runtime dependencies are those dependencies that need to be installed for our code to run, like NumPy.
Development dependencies are dependencies which are an essential part of your development process for a project, but are not required to run it.
Common examples of developments dependencies are linters and test frameworks, like Pylint or Pytest.

When we add a dependency using Poetry, Poetry will add it to the list of dependencies in the `pyproject.toml` file, add a reference to it in a new `poetry.lock` file, and automatically install the package into our virtual environment.
If we don't yet have a virtual environment, Poetry will create it for us - using the name `.venv`, so it appears hidden unless we do `ls -a`.
The `pyproject.toml` file has two separate lists, allowing us to distinguish between runtime and development dependencies.

~~~ bash
poetry add matplotlib numpy~=1.20.0
poetry add --dev pylint
poetry install
~~~
{: .language-bash}

These two sets of dependencies will be used in different circumstances.
When we build our installable package and upload it to a package index, Poetry will only include references to our runtime dependencies.
This is because someone installing our software through a tool like `pip` is using it, but probably doesn't intend to contribute to the development of our software.

In contrast, if someone downloads our code from GitHub, with our `pyproject.toml` and installs the project using that, they will get both our runtime and our development dependencies.
If someone is downloading our source code, that suggests that they intend to contribute to the development of it, so they'll need all of our development tools.

Have a look at the `pyproject.toml` file again to see what's changed.

### Packaging Our Code

Next, we need to make sure that our code is organised in the recommended Python code package structure.
This is the package (yes, we use the same word to mean two different things...) structure that we encountered in the refactoring section - a directory containing an `__init__.py` and our Python source code files.

We've provided an example of a semi-realistic Python application in the code directory for today.
You'll have to rename this package so that it matches the name you told Poetry about, but with underscores instead of hyphens.
By convention installable package (the type we install with `pip`) names use hyphens, whereas code package (a directory of Python files) names use underscores.
While we could choose to use underscores in an installable package name, we cannot use hyphens in a code package name, as Python will interpret them as a minus sign when we try to import them.

~~~ bash
mv inflammation inflammation_jgraham
~~~
{: .language-bash}

Once we've got our `pyproject.toml` configuration done and our code in the right structure, we can go ahead and build a distributable version of our software:

~~~ bash
poetry build
~~~
{: .language-bash}

This should produce two files for us in the `dist` directory.
The one we care most about is the `.whl` or **wheel** file.
This is the file that `pip` uses to distribute and install Python packages, so this is the file we'd need to share with other people who want to install our software.

Now if we gave this wheel file to someone else, they could install it using `pip` - you don't need to run this command yourself, you've already installed it using `poetry install` above.

~~~ bash
pip3 install dist/poetry_project*.whl
~~~
{: .language-bash}

The star in the line above is a **wildcard**, that means Bash should use any filenames that match that pattern, with any number of characters in place for the star.
We could also rely on Bash's autocomplete functionality and type `dist/poetry_project`, then hit the <kbd>Tab</kbd> key.

### Sharing Our Package With The World

The final step in distributing our code is to upload it to a package index.
To help us test our packages, PyPI provides a test index at [https://test.pypi.org/](https://test.pypi.org/) that we can use.
Packages uploaded to the test index aren't accessible to a normal `pip install`, so no one's going to accidentally install our software yet.

Firstly, we need to create an account at [https://test.pypi.org/](https://test.pypi.org/).
Click the register link to the top right, and fill in your account details.
Once you've created your account, click the link to request a verification email and then click the link in the email to verify your account.

Now, we need to tell Poetry about our account on the test PyPI server.
Replace `your_pypi_username` with your actual test.pypi.org username.
When we enter the second of the following commands, Poetry will also ask us to enter our test.pypi.org password:

~~~ bash
poetry config repositories.testpypi https://test.pypi.org/legacy/
poetry config http-basic.testpypi your_pypi_username
~~~
{: .language-bash}

> ## Security Alert!
>
> Since we're publishing our code for other people to use, we need to take care to do this securely.
> If someone gets access to our PyPI account, they could potentially upload a malicious version of one of our packages.
> This has happened with several JavaScript packages in the past.
>
> To improve our security, we should use an **API key / token** rather than a username and password.
>
> For more information, see the [PyPI FAQs](https://test.pypi.org/help/#apitoken).
{: .callout}

Finally, we're ready to go.
To publish the our software that we've been working so hard on, there's just one more command:

~~~ bash
poetry publish -r testpypi
~~~
{: .language-bash}

If we now go to [https://test.pypi.org](https://test.pypi.org/) and search for our package name, we should find our newly published software.
If it's not there yet, try again in a minute - it sometimes takes a couple of minutes to show up.
We can even install this package ourselves using `pip`, but we need to tell `pip` to use the testing version of PyPI and make sure we've got rid of the previous installation.
In this example, replace `your_package_name` with the name of your package from `pyproject.toml`

~~~ bash
source .venv/bin/activate
pip3 uninstall your_package_name
pip3 install -i https://test.pypi.org/simple/ your_package_name
~~~
{: .language-bash}

Note that there is a space between the URL and your package name in the line above.

After we've been working on our code for a while and want to publish an update, we just need to update the version number in the `pyproject.toml` file (using SemVer perhaps), then use Poetry to build and publish the new version.
If we don't increment the version number, people might end up using this version, even though they thought they were using the previous one.
Any re-publishing of the package, no matter how small the changes, needs to come with a new version number.

~~~ bash
poetry build
poetry publish -r testpypi
~~~
{: .language-bash}

In addition to the commands we've already seen, Poetry contains a few more that can be useful for our development process.
For the full list see the Poetry [CLI documentation](https://python-poetry.org/docs/cli/).

If you've made it this far, congratulations, you've successfully published and installed a Python package!
Though it's becoming increasingly common for academic software to be shared under an open source license, not many people go this extra step and make their code installable so easily.
Remember that the easier we make it for people to use our code and get involved with the project, the easier it is for people to reproduce and build upon our work.
Funders are also starting to put greater emphasis on sharing the outputs of our projects as this increases the impact of our work and the impact of their money.

> ## Adding Some Detail
>
> Using the [Poetry documentation](https://python-poetry.org/docs/), investigate how we might go about adding more detail to our page on the package index website.
> We want people to be able to find our package and to be able to tell if it's going to be useful to them.
> What extra information can we add to the `pyproject.toml` file to help with this?
{: .challenge}

## What If We Need More Control?

Sometimes we need more control over the process of building our installable package than Poetry allows.
In these cases, we have to use the method that existed before Poetry - a `setup.py` file.
Because this is a Python file, we can use the full power of Python to describe how to setup our project.

One of the common cases where this is particularly useful is if our project has components in different languages.
For example, to speed up some of the core parts we might write some of our functions in C, then call these from our Python code.
Using a `setup.py` gives us the flexibility to handle building these components in different ways and bring them together at the end.

In the template repository for one of the SABS mini-projects, we have an example of a basic, general purpose `setup.py` file.
You can find this file [https://github.com/SABS-R3/2020-software-engineering-projects-pk/blob/master/setup.py](https://github.com/SABS-R3/2020-software-engineering-projects-pk/blob/master/setup.py).

> ## Our Own Setup.py (Optional)
>
> Compare this example `setup.py` file to the Poetry `pyproject.toml` file we created previously.
> At the bottom, in the arguments to the `setup` function, we have many of the same pieces of metadata.
>
> The [Python Packaging User Guide](https://packaging.python.org/) provides documentation on the details of packaging a project using `setup.py`.
> In this guide, they use Twine to upload the package to PyPI, instead of Poetry as we did previously.
>
> Using the example `setup.py` file and this documentation, can you produce a `setup.py` file for our Poetry project?
>
> Which configuration style do you prefer for projects like this one?
{: .challenge}

{% include links.md %}
