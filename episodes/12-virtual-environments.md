---
title: 1.2 Virtual Environments For Software Development
start: no
teaching: 30
exercises: 0
---

::::::::::::::::::::::::::::::::::::::: objectives

- Set up a Python virtual environment for our software project using `pdm`.
- Declare, install and update our project's external dependencies using `pdm`.
- Run our software from the command line.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What are virtual environments in software development and why you should use them?
- How can we manage Python virtual environments and external (third-party) libraries?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

So far we have cloned our software project from GitHub and inspected its contents and architecture a bit.
We now want to run our code to see what it does -
let us do that from the command line.
For the most part of the course we will run our code
and interact with Git from the command line.
While we will develop and debug our code using an IDE
and it is possible to use Git from the IDE too,
typing commands in the command line allows you to familiarise yourself and learn it well.
A bonus is that this knowledge is transferable to running code in other programming languages
and is independent from any IDE you may use in the future.

If you have a little peek into our code
(e.g. run `cat inflammation/views.py` from the project root),
you will see the following two lines somewhere at the top.

```python
from matplotlib import pyplot as plt
import numpy as np
```

This means that our code requires two **external libraries**
(also called third-party packages or dependencies) -
`numpy` and `matplotlib`.
Python applications often use external libraries that don't come as part of the standard Python distribution.
This means that you will have to use a *package manager* tool to install them on your system.
Applications will also sometimes need a
specific version of an external library
(e.g. because they were written to work with feature, class,
or function that may have been updated in more recent versions),
or a specific version of Python interpreter.
This means that each Python application you work with may require a different setup
and a set of dependencies so it is useful to be able to keep these configurations
separate to avoid confusion between projects.
The solution for this problem is to create a self-contained
**virtual environment** per project,
which contains a particular version of Python installation
plus a number of additional external libraries.

Virtual environments are not just a feature of Python -
most modern programming languages use a similar mechanism to isolate libraries or dependencies
for a specific project, making it easier to develop, run, test and share code with others.
Some examples include Bundler for Ruby, Conan for C++, or Maven with classpath for Java.
This can also be achieved with more generic package managers like Spack,
which is used extensively in HPC settings to resolve complex dependencies.
In this episode, we learn how to set up a virtual environment to develop our code
and manage our external dependencies.

## Virtual Environments

So what exactly are virtual environments, and why use them?

A Python virtual environment helps us create an **isolated workspace** for our software project.
This workspace comes with a Python interpreter together with the versions of any external libraries that your project needs (e.g. NumPy or SciPy).
Python virtual environments are implemented as directories with a particular structure, containing links to specified dependencies allowing isolation from other software projects on your machine that may require different versions of Python or external libraries.

As more external libraries are added to your Python project over time,
you can add them to its specific virtual environment
and avoid a great deal of confusion by having
separate (smaller) virtual environments for each project
rather than one huge global environment with potential package version clashes.
Another big motivator for using virtual environments is
that they make sharing your code with others much easier
(as we will see shortly).
Here are some typical scenarios where
the use of virtual environments is highly recommended (almost unavoidable):

- You have an older project that is pinned to an older version of Python.
  You do not have the time to migrate the project to a newer version,
  or it may not even be possible as some of the third party dependencies
  have not been updated.
  You have to start another project that requires a recent version of Python.
  The best way to do this on a single machine is
  to set up two separate Python virtual environments.
- One of your projects is locked to use
  a particular older version of a third party dependency.
  You cannot use the latest version of the dependency as it breaks things in your project.
  In a separate branch of your project,
  you want to try and fix problems introduced by the new version of the dependency
  without affecting the working version of your project.
  You need to set up a separate virtual environment for your branch to
  'isolate' your code while testing the new feature.

You do not have to worry too much about specific versions of external libraries
that your project depends on most of the time.
Virtual environments also enable you to always use
the latest available version without specifying it explicitly.
They also enable you to use a specific older version of a package for your project, should you need to.

:::::::::::::::::::::::::::::::::::::::::  callout

## A Specific Python or Package Version is Only Ever Installed Once

Note that you will not have a separate Python or package installations for each of your projects -
they will only ever be installed once on your system but will be referenced
from different virtual environments.

::::::::::::::::::::::::::::::::::::::::::::::::::

### Managing Python Virtual Environments

There are many commonly used command line tools for managing Python virtual environments:

- `venv`, available by default from the standard `Python` distribution from `Python 3.3+`
- `virtualenv`, needs to be installed separately but offers more features and supports more Python versions
- `conda`, package and environment management system
  (also included as part of the Anaconda Python distribution often used by the scientific community)
- `pipenv`, created to fix certain shortcomings of `virtualenv`
- `poetry`, a modern Python packaging tool which handles virtual environments automatically
- `uv`, an extremely fast Python package and project manager, written in Rust, and owned by Astral
- `pdm`, a modern Python package and dependency manager supporting the latest PEP standards.

The first few of these tools manage *environments* only.
The later ones (`pipenv`, `poetry`, `uv`, `pdm`) are **project managers**: they look after the virtual environment, the packages installed into it, and the metadata describing your project, all through a single command line tool.
While there are pros and cons for using each of the above,
all will do the job of managing Python virtual environments for you
and it may be a matter of personal preference which one you go for.
In this course, we will use `pdm` to create and manage our virtual environment because is that it removes a whole class of common mistakes:
you don't have to remember which environment is active,
which `pip` belongs to which Python installation,
or which packages you installed by hand three months ago.

As this comic points out, managing Python and its environments used to be quite complex without these tools.

![Python Environment Hell from [XKCD](https://xkcd.com/1987/) (Creative Commons Attribution-NonCommercial 2.5 License)](fig/python-environment-hell.png){alt='Python environment hell XKCD comic'}

:::::::::::::::::::::::::::::::::::::::::  callout

## A Note on Anaconda and `conda`

Anaconda is an open source Python distribution commonly used for scientific programming - it conveniently installs Python, package and environment management through `conda`, and a  number of commonly used scientific computing packages so you do not have to obtain them separately.
However, recent [licence changes](https://www.datacamp.com/blog/navigating-anaconda-licensing) have made Anaconda less appealing.
There are truly open alternatives like [conda-forge](https://conda-forge.org/).

`conda` is an independent command line tool
(available separately from the Anaconda distribution) with dual functionality:

1. It is a package manager that helps you find Python and non-Python packages from remote package repositories and install them on your system, and
2. It is also a virtual environment manager.
   So, you can use `conda` for both tasks instead of using `venv` and `pip`.

::::::::::::::::::::::::::::::::::::::::::::::::::

Let us have a look at how we can create and manage a virtual environment
and its packages from the command line using `pdm`.

::::::::::::::::::::::::::::::::::::::::::  prereq

### Making Sure You Can Invoke PDM and Python

Install PDM according to its [website instructions](https://pdm-project.org/en/latest/#recommended-installation-method), which at the time of writing is a `curl` command:

```bash
curl -sSL https://pdm-project.org/install.sh | bash
```

You can inspect the Bash script at the URL `curl` is grabbing from if you want to make sure it isn't doing anything sketchy.

Then, test that PDM is available on your `PATH` by executing:

```bash
pdm --version
```

```output
PDM, version 2.28.2
```

If this fails, revisit the [setup instructions](../learners/setup.md) for this course.

PDM can manage Python interpreters for you,
but it is good to check that you also have a system Python available:

```bash
python --version
```

If you are using Windows and invoking `python` command causes your Git Bash terminal to hang with no error message or output, you may
need to create an alias for the python executable `python.exe`, as explained in the [troubleshooting section](../learners/common-issues.md#python-hangs-in-git-bash).


::::::::::::::::::::::::::::::::::::::::::::::::::

### Creating a Virtual Environment Using `pdm`

Our project already contains a `pyproject.toml` file, the standard file that describes a Python project, its metadata and its dependencies.
Because of this, we do not need to create the project from scratch; we can ask PDM to set everything up for us with a single command.

First, ensure you are within the project root directory, then:

```bash
pdm install
```

```output
WARNING: Lockfile does not exist
Updating the lock file...
WARNING: Project requires a python version of >=3.10, The virtualenv is being created for you as it cannot be matched to the right version.
INFO: python.use_venv is on, creating a virtualenv for this project...
Virtualenv is created successfully at 
/home/user/python-intermediate-inflammation/.venv
Changes are written to pdm.lock.
  0:00:00 🔒 Lock successful.  
All packages are synced to date, nothing to do.
  ✔ Install python-intermediate-inflammation 0.0.0 successful

  0:00:00 🎉 All complete! 0/0
```

Your output will look a little different depending on the Python version and paths on your machine.
That one command did several things for us:

1. it created a virtual environment for the project in the `.venv` directory,
2. it created a **lock file** called `pdm.lock`, which records the exact version of every package the environment should contain, and
3. it installed our own project into that environment (more on this below).

Our project does not declare any external dependencies yet, so there was not much for PDM to install... yet.

:::::::::::::::::::::::::::::::::::::::::  callout

## Choosing a Python Interpreter

By default PDM will pick a suitable Python interpreter from the ones installed on your machine and remember the choice in a file called `.pdm-python`.
You can inspect what it selected with `pdm info`, change it with `pdm use`, and even have PDM download and install a Python version for you with, for example, `pdm python install 3.14`.
This is handy when a project needs a Python version that is not available through your operating system.

::::::::::::::::::::::::::::::::::::::::::::::::::

### What PDM Actually Created

The virtual environment PDM built for us is an ordinary Python virtual environment of the kind that `venv` produces; there is nothing magic about it.
If you list the contents of the `.venv` directory, on a Mac or Linux system
(slightly different on Windows as explained below) you should see something like:

```bash
$ ls -l .venv
```

```output
total 20
drwxrwxr-x 2 user user 4096 Aug 19 18:08 bin/
-rw-rw-r-- 1 user user  194 Aug 19 18:08 CACHEDIR.TAG
drwxrwxr-x 2 user user 4096 Aug 19 18:08 include/
drwxrwxr-x 3 user user 4096 Aug 19 18:08 lib/
-rw-rw-r-- 1 user user  750 Aug 19 18:08 pyvenv.cfg
```

So, a virtual environment is a directory containing:

- `pyvenv.cfg` configuration file with a home key pointing to the Python installation it was created from,
- `bin` subdirectory (called `Scripts` on Windows) containing a symlink of the Python interpreter binary used to create the environment and the standard Python library,
- `lib/pythonX.Y/site-packages` subdirectory (called `Lib\site-packages` on Windows) to contain its own independent set of installed Python packages isolated from other projects, and
- various other configuration and supporting files and subdirectories.

Had we not been using PDM, we could have created exactly this ourselves with `python -m venv .venv` and then installed packages into it by using `pip`.
It is worth knowing this is all a virtual environment is, so that the environment does not feel like a black box.
But from here on, we will let PDM do the work of managing this environment.

Note that since our software project is being tracked by Git, the newly created `.venv` directory will show up in version control.
We will see how to tell Git to ignore it in one of the subsequent episodes.

:::::::::::::::::::::::::::::::::::::::::  callout

## Naming and Locating Virtual Environments

Storing the environment inside the project directory and calling it "venv" or ".venv" is the usual convention.
This way when you come across such a subdirectory within a software project, you know it contains its virtual environment details.
PDM uses `.venv` in the project root by default.
You can ask PDM to create additional, named environments elsewhere (e.g. `pdm venv create --name py312 3.12`) and list them with `pdm venv list`, which is useful when you want to test your code against several Python versions.
Here are some references for the naming conventions:

- [The Hitchhiker's Guide to Python](https://docs.python-guide.org/dev/virtualenvs/)
  notes that "venv" is the general convention used globally
- [The Python Documentation](https://docs.python.org/3/library/venv.html)
  indicates that ".venv" is common
- ["venv" vs ".venv" discussion](https://discuss.python.org/t/trying-to-come-up-with-a-default-directory-name-for-virtual-environments/3750)

::::::::::::::::::::::::::::::::::::::::::::::::::

### Running Commands In Your Environment

With PDM you do not normally activate the virtual environment at all.
Instead, you prefix commands with `pdm run` and PDM makes sure they are executed using the project's environment:

```bash
pdm run python --version
```

```output
Python 3.14.2  # your version will differ depending on your system
```

This works from anywhere inside the project, and it works the same way for you and for your collaborators, regardless of what is or is not activated in their shell.

If you would still like an activated shell---for example because you are running many commands in a row---PDM will print the activation command for you to evaluate:

```bash
echo $(pdm venv activate)
```

```output
# The output will vary depending on your OS and current shell, which is precisely why this command is useful
source /home/user/python-intermediate-inflammation/.venv/bin/activate
```

Activating the virtual environment will change your command line's prompt to show what virtual environment you are currently using (indicated by its name in round brackets at the start of the prompt):

```bash
eval $(pdm venv activate)
```

```output
# Your prompt should look something like this:
(python-intermediate-inflammation-3.14) $
```

Materially, this modifies the environment so that running `python` will get you the particular version of Python configured in your virtual environment.
You can verify this by checking the path with the command `which`:

```bash
which python
```

```output
/home/user/python-intermediate-inflammation/.venv/bin/python
```

When you're done working on your project, you can exit the environment with:

```bash
deactivate
```

For the rest of this course we will write commands using `pdm run`, so you do not need to keep an environment activated.

### Installing External Packages Using `pip`

We noticed earlier that our code depends on two *external packages/libraries* -
`numpy` and `matplotlib`.
In order for the code to run on your machine,
you need to install these two dependencies into your virtual environment.

To install the latest version of a package with `pip`
you use pip's `install` command and specify the package's name, e.g.:

```bash
(venv) $ python3 -m pip install numpy
(venv) $ python3 -m pip install matplotlib
```

or like this to install multiple packages at once for short:

```bash
(venv) $ python3 -m pip install numpy matplotlib
```

:::::::::::::::::::::::::::::::::::::::::  callout

## How About `pip3 install <package-name>` Command?

You may have seen or used the `pip3 install <package-name>` command in the past, which is shorter
and perhaps more intuitive than `python3 -m pip install`. However, the
[official Pip documentation](https://pip.pypa.io/en/stable/user_guide/#running-pip) recommends
`python3 -m pip install` and core Python developer Brett Cannon offers a
[more detailed explanation](https://snarky.ca/why-you-should-use-python-m-pip/)
of edge cases when the two commands may produce different results and why `python3 -m pip install`
is recommended. In this material, we will use `python3 -m` whenever we have to invoke a Python
module from command line.


::::::::::::::::::::::::::::::::::::::::::::::::::

If you run the `python3 -m pip install` command on a package that is already installed,
`pip` will notice this and do nothing.

To install a specific version of a Python package
give the package name followed by `==` and the version number,
e.g. `python3 -m pip install numpy==1.21.1`.

To specify a minimum version of a Python package,
you can do `python3 -m pip install numpy>=1.20`.

To upgrade a package to the latest version, e.g. `python3 -m pip install --upgrade numpy`.

To display information about a particular installed package do:

```bash
(venv) $ python3 -m pip show numpy
```

```output
Name: numpy
Version: 1.26.2
Summary: Fundamental package for array computing in Python
Home-page: https://numpy.org
Author: Travis E. Oliphant et al.
Author-email: 
License: Copyright (c) 2005-2023, NumPy Developers.
All rights reserved.
...
Required-by: contourpy, matplotlib
```

To list all packages installed with `pip` (in your current virtual environment):

```bash
(venv) $ python3 -m pip list
```

```output
Package         Version
--------------- -------
contourpy       1.2.0
cycler          0.12.1
fonttools       4.45.0
kiwisolver      1.4.5
matplotlib      3.8.2
numpy           1.26.2
packaging       23.2
Pillow          10.1.0
pip             23.0.1
pyparsing       3.1.1
python-dateutil 2.8.2
setuptools      67.6.1
six             1.16.0
```

To uninstall a package installed in the virtual environment do: `python3 -m pip uninstall <package-name>`.
You can also supply a list of packages to uninstall at the same time.

### Installing Our Local Project as a Package Using `pip`

Often when working on a Python project, the project itself will be a Python package (like `numpy` or `matplotlib` above) or at the very least it might be useful to treat it like a package.
Said another way, it is usually the case we want a convenient way to call the Python code we are writing from another location, and making this code accessible as a package is the best way to do this.
We will save the details of Python packaging for [a future episode](43-software-release.md), and for the meantime we can use the minimal package setup that our project already comes with, which is contained in the `pyproject.toml` file.
Once again, we can use `pip` to install our local package:

```bash
python3 -m pip install --editable .
```

If the above command fails for you - your `pip` installation is older than version 21.3.
Such older versions of `pip` do not support `pyproject.toml` as the package metadata.
Given these versions of `pip` are now over 4 years old, we strongly recommend that you update `pip` if you can with:

```bash
python3 -m pip install --upgrade pip
```

This is similar syntax to above, with two important differences:

1. The `--editable` or `-e` flag indicates that the package we are specifying should be an "editable" install.
   An "editable" install is one that allows the package in our environment to change dynamically based on source code locally.
   This is very convenient when we are developing the package because we can instantly see changes when we call the code from within our virtual environment, rather than having to install the local package again to get the updates.
2. The argument `'.'` indicates that the package we want to install is located in the current directory.
   The `pyproject.toml` file located in this directory then handles the rest.


If we reissue the `pip list` command we should now see our local package with the name `python-intermediate-inflammation` in the output:

```output
Package                          Version     Editable project location
-------------------------------- ----------- ----------------------------------------------------------------------------------------------
contourpy                        1.3.1
cycler                           0.12.1
exceptiongroup                   1.2.2
fonttools                        4.56.0
iniconfig                        2.0.0
kiwisolver                       1.4.8
matplotlib                       3.10.0
numpy                            2.2.3
packaging                        24.2
pillow                           11.1.0
pip                              22.0.2
pluggy                           1.5.0
pyparsing                        3.2.1
pytest                           8.3.4
python-dateutil                  2.9.0.post0
python-intermediate-inflammation 0.0.0       /path/to/your/project/directory/python-intermediate-inflammation
setuptools                       59.6.0
six                              1.17.0
tomli                            2.2.1
```

### Exporting/Importing Virtual Environments Using `pip`

You are collaborating on a project with a team so, naturally,
you will want to share your environment with your collaborators
so they can easily 'clone' your software project with all of its dependencies
and everyone can replicate equivalent virtual environments on their machines.
`pip` has a handy way of exporting, saving and sharing virtual environments.

To export your active environment use the `python3 -m pip freeze --exclude-editable` command to produce a list of packages installed in the virtual environment.
A common convention is to put this list in a `requirements.txt` file:

```bash
(venv) $ python3 -m pip freeze --exclude-editable > requirements.txt
(venv) $ cat requirements.txt
```

```output
contourpy==1.2.0
cycler==0.12.1
fonttools==4.45.0
kiwisolver==1.4.5
matplotlib==3.8.2
numpy==1.26.2
packaging==23.2
Pillow==10.1.0
pyparsing==3.1.1
python-dateutil==2.8.2
six==1.16.0
```

The first of the above commands will create a `requirements.txt` file in your current directory.
Yours may look a little different,
depending on the version of the packages you have installed,
as well as any differences in the packages that they themselves use.
Also, we need to use the `--exclude-editable` command so that our local package is not included in the output, otherwise pip will try to pull from a specific commit at the time we made the editable install, which is not what we want.

The `requirements.txt` file can then be committed to a version control system
(we will see how to do this using Git in one of the following episodes)
and get shipped as part of your software and shared with collaborators and/or users.
They can then replicate your environment
and install all the necessary packages from the project root as follows:

```bash
(venv) $ python3 -m pip install -r requirements.txt --editable .
```

As your project grows you may need to update your environment for a variety of reasons.
For example, one of your project's dependencies has just released a new version
(dependency version number update),
you need an additional package for data analysis (adding a new dependency)
or you have found a better package and no longer need the older package
(adding a new and removing an old dependency).
What you need to do in this case
(apart from installing the new and removing the packages that are no longer needed
from your virtual environment)
is update the contents of the `requirements.txt` file accordingly
by re-issuing `pip freeze` command
and propagate the updated `requirements.txt` file to your collaborators
via your code sharing platform (e.g. GitHub).

:::::::::::::::::::::::::::::::::::::  testimonial

## Official Documentation

For a full list of options and commands,
consult the [official `venv` documentation](https://docs.python.org/3/library/venv.html)
and the [Installing Python Modules with `pip` guide](https://docs.python.org/3/installing/index.html#installing-index).
Also check out the guide
["Installing packages using `pip` and virtual environments"](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#installing-packages-using-pip-and-virtual-environments).


::::::::::::::::::::::::::::::::::::::::::::::::::

## Running Python Scripts From Command Line

Congratulations!
Your environment is now activated and set up
to run our `inflammation-analysis.py` script from the command line.

You should already be located in the root of the `python-intermediate-inflammation` directory
(if not, please navigate to it from the command line now).
To run the script, type the following command:

```bash
(venv) $ python3 inflammation-analysis.py
```

```output
usage: inflammation-analysis.py [-h] infiles [infiles ...]
inflammation-analysis.py: error: the following arguments are required: infiles
```

In the above command, we tell the command line two things:

1. to find a Python interpreter
  (in this case, the one that was configured via the virtual environment), and
2. to use it to run our script `inflammation-analysis.py`,
  which resides in the current directory.

As we can see, the Python interpreter ran our script, which threw an error -
`inflammation-analysis.py: error: the following arguments are required: infiles`.
It looks like the script expects a list of input files to process,
so this is expected behaviour since we do not supply any. 

We should run our code as follows, passing one (or more) data file(s) as input:

```bash
(venv) $ python3 inflammation-analysis.py data/inflammation-01.csv
```

## Optional Exercises

Have a look at [some optional exercises](17-section1-optional-exercises.md).


:::::::::::::::::::::::::::::::::::::::: keypoints

- Virtual environments keep Python versions and dependencies required by different projects separate.
- A virtual environment is itself a directory structure.
- Use `venv` to create and manage Python virtual environments.
- Use `pip` to install and manage Python external (third-party) libraries.
- `pip` allows you to declare all dependencies for a project in a separate file (by convention called `requirements.txt`) which can be shared with collaborators/users and used to replicate a virtual environment.
- Use `python3 -m pip freeze --exclude-editable > requirements.txt` to take snapshot of your project's dependencies.
- Use `python3 -m pip install -r requirements.txt` to replicate someone else's virtual environment on your machine from the `requirements.txt` file.

::::::::::::::::::::::::::::::::::::::::::::::::::


