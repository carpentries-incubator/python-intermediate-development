---
title: "Virtual Environments For Software Development"
start: false
teaching: 30
exercises: 0
questions:
- "What are virtual environments in software development and why you should use them?"
- "How can we manage Python virtual environments and external (third-party) packages?"
objectives:
- "Set up a Python virtual environment for our software project using `venv` and `pip`."
- "Run our software from the command line."

keypoints:
- "Virtual environments keep Python versions and dependencies required by different projects separate."
- "Use `venv` to create and manage Python virtual environments."
- "Use `pip` to install and manage Python third-party packages."
- "`pip` allows you to declare all dependencies for a project in a separate
file (by convention called `requirements.txt`) which can be shared with collaborators/users and used to replicate a virtual environment."
- "Use `pip3 freeze > requirements.txt` to take snapshot of your project's dependencies."
- "Use `pip3 install -r requirements.txt` to replicate someone else's virtual environment on you machine from
the `requirements.txt` file."
---

## Introduction
So far we have checked out our software project from GitHub and inspected its contents and architecture a bit.
We now want to run our code to see what it does - let's do that from the command line shell.
For the most part of the course we will run our code and interact with Git from the shell,
and, while we will develop and debug our code using the PyCharm IDE and it is possible to use Git from PyCharm too, typing commands in shell 'forces' you to familiarise yourself and learn shell well - a bonus is that this knowledge is
transferable to running code in other programming languages and is independent from any IDE
you may use in the future.

If you have a little peak into our code (e.g. do `cat inflammation/views.py` from the project root), you will see the
following two lines somewhere at the top.

~~~
from matplotlib import pyplot as plt
import numpy as np
~~~
{: .language-python}

This means that our code requires two *external libraries* (also called third-party packages or dependencies) -
`numpy` and `matplotlib`.
Python applications often use packages and modules that don’t come as part of the standard Python distribution. This means
that you will have to use a *package manager* tool to install them on your system. Applications will also sometimes need a
specific version of an external library, for example because the application may require that a particular
bug has been fixed, or a specific version of Python interpreter. This means it may not be possible for one Python
installation and setup to meet the requirements of every application you may work with. The solution for this problem is to create a *virtual
environment*, a self-contained directory that contains a Python installation for a particular version of Python
plus a number of additional packages.

Virtual environments are not just a feature of Python - all modern programming languages use them to isolate code
of a specific project and make it easier to develop, run, test and share code with others. In this episode, we learn how
to set up a virtual environment to develop our code and manage our external dependencies.

## Virtual Environments
So what exactly are virtual environments, and why use them?

A Python virtual environment is an **isolated working copy** of a specific version of
Python interpreter together with specific versions of a number of packages installed into that
virtual environment which allow you to work on a particular
project without worry of affecting other projects. A virtual environment is simply a *directory with a particular
structure* which includes links to and enables multiple side-by-side installations of
different Python interpreters or different versions of the same third party package to coexist on your machine and only one to be selected for each of our projects.

As more dependencies are added to your Python project over time, you can add them to
its specific virtual environment and avoid a great deal of confusion by having separate (smaller) virtual environments
for each project rather than one huge global environment with potential package version clashes. Another big motivator
for using virtual environments is that they make sharing your code with others much easier (as we will see shortly).
Here are some typical scenarios where the usage of virtual environments is highly recommended (almost unavoidable):
- You have an older project that only works under Python 2. You do not have the time to migrate the project to Python 3
or it may not even be possible as some of the third party dependencies are not available under Python 3. You have to
start another project under Python 3. The best way to do this on a single machine is to set up 2 separate Python virtual
environments.
- One of your Python 3 projects is locked to use a particular older version of a third party dependency. You cannot use the
latest version of the
dependency as it breaks things in your project. In a separate branch of your project, you want to try and fix problems
introduced by the new version of the dependency without affecting the working version of your project. You need to set up
a separate virtual environment for your branch to 'isolate' your code while testing the new feature.

You do not have to worry too much about specific versions of packages that your project depends on most of the time.
Virtual environments enable you to always use the latest available version without specifying it explicitly.
They also enable you to use a specific older version of a package for your project, should you need to.

> ## A Specific Python or Package Version is Only Ever Installed Once
> Note that you will not have a separate Python or package installations for each of your projects - they will only
ever be installed once on your system but will be referenced from different virtual environments.
>
{: .callout}

### Managing Python Virtual Environments

There are several commonly used command line tools for managing Python virtual environments:
- `venv`, available by default from the standard `Python` distribution from `Python 3.3+`
- `virtualenv`, needs to be installed separately but supports both `Python 2.7+` and `Python 3.3+`
- `pipenv`, created to fix certain shortcomings of `virtualenv`
- `conda` which comes together with the Anaconda Python distribution

While there are pros and cons for using each of the above, all will do the job of managing Python
virtual environments for you and it may be a matter of personal preference which one you go for.
In this course, we will use `venv` to create and manage our
virtual environment (which is the preferred way for Python 3.3+). The upside is that `venv` virtual environments created from the command line are
also recognised and picked up automatically by PyCharm IDE.

### Managing Python Packages

Part of managing your (virtual) working environment involves installing, updating and removing external packages
on your system. Package manager tool `pip` is most commonly used for this - it interacts
 and obtains the packages from the central repository called [Python Package Index (PyPI)](https://pypi.org/).
`pip` can now be used with all Python distributions (including Anaconda).

> ## A Note on Anaconda and `conda`
> Anaconda is an open source Python
> distribution commonly used for scientific programming - it conveniently installs Python and a
> number of commonly used scientific computing packages so you do not have to obtain them separately.
> `conda` (that comes with the Anaconda distribution) is a command line
> tool with
> dual functionality - (1) it is a package manager that helps you find Python packages from
> remote package repositories and install them on your system, and (2) it is also a virtual environment manager.
> So, if you are using Anaconda Python distribution, you can use `conda` for both tasks instead of using `venv` and `pip`.
>
{: .callout}

> ## Mixing `pip` and `conda` for Anaconda Users
> Sometimes packages that you need are not available via `conda`, in which case you will have to mix
> the use of both `conda` and `pip` to manage your packages. Recent versions of `conda` have improved support
> for interoperability between `conda` and `pip` and, while `pip` only installs Python packages from PyPI package
> repository, conda can now install packages from [Anaconda Repository](https://repo.anaconda.com/)
> and [Anaconda Cloud](https://anaconda.org/), as well as
> [PyPI](https://pypi.org/) by using `pip` in an active `conda` environment. You can now also search for
> PyPI packages via [Anaconda Cloud](https://anaconda.org/search) and filtering by package type.
>
> The advice from the [Anaconda blog](https://www.anaconda.com/blog/using-pip-in-a-conda-environment) is:
"*... when combining `conda` and `pip`, it is best to use an isolated `conda` environment.
Only after `conda` has been used to install as many packages as possible should `pip` be used to install any remaining software.*"
>
{: .callout}

### Many Tools for the Job

Things with installing and managing Python distributions, third party packages and virtual environments are, well,
complex. There is abundance of tools for each task, each with its advantages and disadvantages, and there are different
ways to achieve the same effect (and even different ways to install the same tool!).
Note that each Python distribution comes with its own version of
`pip` - and if you have several Python versions installed you have to be extra careful to use the correct `pip` to
manage external packages for that Python version.

`venv` and `pip` are considered the *de facto* standards for virtual environment and package management for Python 3.
However, advantages of using Anaconda and `conda` are that you get (most of the) packages needed for
scientific code development included with the distribution. If you are only collaborating with others who are also using
Anaconda, you may find that `conda` satisfies all your needs. It is good, however, to be aware of all these tools,
and use them accordingly. As you become more familiar with them you will realise that equivalent tools work in a similar
way even though the command syntax may be different (and that there are equivalent tools for other programming languages
too to which your knowledge can be ported).

<img src="../fig/python-environment-hell.png" alt="Python environment hell XKCD comic"/>
<p style="text-align: center;">Python Environment Hell<br>
From <a href="https://xkcd.com/1987/" target="_blank">XKCD</a> (Creative Commons Attribution-NonCommercial 2.5 License)</p>

Let us have a look at how we can create and manage virtual environments from command line using `venv` and manage packages using `pip`.

### Creating a `venv` Environment
Creating a virtual environment with `venv` is done by executing the following command:

~~~
$ python3 -m venv /path/to/new/virtual/environment
~~~
{: .language-bash}

where `/path/to/new/virtual/environment` is a path to a directory where you want to place it.
This will create the target directory for the virtual environment (and any parent directories that don’t exist already).

For our project, let's create a virtual environment called `inflammation` off the project root:
~~~
$ python3 -m venv inflammation
~~~
{: .language-bash}

If you list the contents of the newly created `inflammation` directory, you should see something like:

~~~
$ ls -l inflammation
~~~
{: .language-bash}
~~~
total 8
drwxr-xr-x  12 alex  staff  384  5 Oct 11:47 bin
drwxr-xr-x   2 alex  staff   64  5 Oct 11:47 include
drwxr-xr-x   3 alex  staff   96  5 Oct 11:47 lib
-rw-r--r--   1 alex  staff   90  5 Oct 11:47 pyvenv.cfg
~~~
{: .output}

Running the `python3 -m venv inflammation` command created the target directory called `inflammation`
containing:

- `pyvenv.cfg` configuration file with a home key pointing to the Python installation from which the command was run,
- `bin` subdirectory (`Scripts` on Windows) containing a symlink of the Python interpreter binary used to create the
environment and the standard Python library,
- `lib/pythonX.Y/site-packages` subdirectory (`Lib\site-packages` on Windows) to contain its own independent set of installed Python packages isolated from other projects,
- various other configuration and supporting files and subdirectories.

Once you’ve created a virtual environment, you need to activate it:

~~~
$ source inflammation/bin/activate
(inflammation) $
~~~
{: .language-bash}

Activating the virtual environment will change your shell’s prompt to show what virtual environment
you are currently using (indicated by its name in round brackets at the start of the prompt),
and modify the environment so that running Python will get you the particular
version of Python configured in your virtual environment.

### Installing Packages in an Environment With `pip`

We noticed earlier that our code depends on two *external libraries* - `numpy` and `matplotlib`. In order
for the code to run on your machine, you need to
install these two dependencies into your virtual environment.

To install the latest version of a package with `pip` you use the `pip install` command and specify the package’s name, e.g.:

~~~
(inflammation) $ pip3 install numpy
(inflammation) $ pip3 install matplotlib
~~~
{: .language-bash}

or like this to install multiple packages at once for short:

~~~
(inflammation) $ pip3 install numpy matplotlib
~~~
{: .language-bash}

If you run the `pip install` command on a package that is already installed, `pip` will notice this and do nothing.

To install a specific version of a Python package give the package name followed by `==` and the version number, e.g.
`pip3 install numpy==1.21.1`.

To specify a minimum version of a Python package, you can
do `pip3 install numpy>=1.20`.

To upgrade a package to the latest version, e.g. `pip3 install --upgrade numpy`.

To display information about a particular installed package do:

~~~
(inflammation) $ pip3 show numpy
~~~
{: .language-bash}
~~~
Name: numpy
Version: 1.21.2
Summary: NumPy is the fundamental package for array computing with Python.
Home-page: https://www.numpy.org
Author: Travis E. Oliphant et al.
Author-email: None
License: BSD
Location: /Users/alex/work/SSI/Carpentries/python-intermediate-inflammation/inflammation/lib/python3.9/site-packages
Requires:
Required-by: matplotlib
~~~
{: .output}

To list all packages installed with `pip` (in your current virtual environment):

~~~
(inflammation) $ pip3 list
~~~
{: .language-bash}
~~~
Package         Version
--------------- -------
cycler          0.10.0
kiwisolver      1.3.2
matplotlib      3.4.3
numpy           1.21.2
Pillow          8.3.2
pip             21.1.3
pyparsing       2.4.7
python-dateutil 2.8.2
setuptools      57.0.0
six             1.16.0
~~~
{: .output}

To uninstall a package installed in the virtual environment do: `pip3 uninstall package-name`.
You can also supply a list of packages to uninstall at the same time.

### Exporting/Importing an Environment With `pip`

You are collaborating on a project with a team so, naturally, you will want to share your environment with your
collaborators so they can easily 'clone' your software project with all of its dependencies and everyone
can replicate equivalent virtual environments on their machines. `pip` has a handy way of exporting,
saving and sharing virtual environments.

To export your active environment - use `pip freeze` command to
produce a list of packages installed in the virtual environment.
A common convention is to put this list in a `requirements.txt` file:

~~~
(inflammation) $ pip3 freeze > requirements.txt
(inflammation) $ cat requirements.txt
~~~
{: .language-bash}
~~~
cycler==0.10.0
kiwisolver==1.3.2
matplotlib==3.4.3
numpy==1.21.2
Pillow==8.3.2
pyparsing==2.4.7
python-dateutil==2.8.2
six==1.16.0
~~~
{: .output}


The first of the above commands will create a `requirements.txt` file in your current directory.
The `requirements.txt` file can then be committed to a version control system (e.g. Git) and
get shipped as part of your software and shared with collaborators and/or users. They can then replicate your environment and
install all the necessary packages from the project root as follows:

~~~
(inflammation) $ pip3 install -r requirements.txt
~~~
{: .language-bash}

As your project grows - you may need to update your environment for a variety of reasons. For example, one of your project's dependencies has
just released a new version (dependency version number update), you need an additional package for data analysis
(adding a new dependency) or you have found a better package and no longer need the older package (adding a new and
removing an old dependency). What you need to do in this case (apart from installing the new and removing the
packages that are no longer needed from your virtual environment) is update the contents of the `requirements.txt` file
accordingly by re-issuing `pip freeze` command and propagate the updated `requirements.txt` file to your collaborators
via your code sharing platform (e.g. GitHub).

> ## Official Documentation
> For a full list of options and commands, consult the [official `venv` documentation](https://docs.python.org/3/library/venv.html)
> and the [Installing Python Modules with `pip` guide](https://docs.python.org/3/installing/index.html#installing-index). Also check out the guide ["Installing packages using pip and virtual environments"](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#installing-packages-using-pip-and-virtual-environments).
{: .testimonial}

## Running Python Scripts From Command Line
Now that your environment has been set up and activated, you are ready to run our `inflammation-analysis.py` script
from the command line. You should already be located in the root of the `python-intermediate-inflammation` directory
(if not, navigate to it from the command line now). To run the script, type the following command:

~~~
(inflammation) $ python3 inflammation-analysis.py
~~~
{: .language-bash}

~~~
usage: inflammation-analysis.py [-h] infiles [infiles ...]
inflammation-analysis.py: error: the following arguments are required: infiles
~~~
{: .output}

In the above command, we tell the command line shell two things:

1. to find a Python interpreter (in this case, the one that was configured via the virtual environment), and
2. to use it to run our script `inflammation-analysis.py`, which resides in the current directory.

As we can see, the Python interpreter ran our script, which threw an error -
`inflammation-analysis.py: error: the following arguments are required: infiles`. It looks like the script expects
a list of input files to process. Do not worry about this error for now -
we will learn how to fix and write tests to detect errors in
the following episodes.

{% include links.md %}
