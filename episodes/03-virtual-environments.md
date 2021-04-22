---
title: "Virtual Environments For Software Development"
start: false
teaching: 20
exercises: 10
questions:
- "What are virtual environments in software design?"
- "What are the advantages of using virtual environments?"
- "How to set up and manage a Python virtual environment?"
- "How to install and manage Python third party packages?"
objectives:
- "Set up a Python virtual environment for a software project using `conda`"
- "Manage and share virtual environments using `environment.yml` file"
- "Use `conda` to manage Python third party packages"

keypoints:
- "A virtual environment is a tool that helps to keep dependencies required by different projects separate."
- "Use `conda` to manage Python virtual environments (but be aware of other tools, such as `venv`, `virtualenv` or `pipenv`)."
- "Use `conda` to manage Python packages (but be aware of other tools, such as `pip`)."
- "Instead of installing packages individually, `conda` allows you to declare all dependencies in a separate
file that can be easily shared with your collaborators."
- "Use `conda env --from-history export > environment.yml` to take snapshot of your project's dependencies."
- "Use `conda env create -f environment.yml` to replicate someone else's virtual environment on you machine."
---

## Introduction
In the previous episode, we have configured PyCharm to run our code from within the IDE. We mentioned that 
you can run also your code from a command line shell and this is what we will be going in this course as we will 
also interact with Git from the shell. This 'forces' you
to familiarise yourself and learn shell well - a bonus is that this knowledge is transferable to running code in other 
programming languages from within shell too. 

## Running Scripts From Command Line
Let's run our `patientdb.py` script using Python from the command line and use the
Python Anaconda environment `patient` we created from PyCharm. Open a new shell/terminal and type the 
following command to list all the environments Anaconda is aware of:

~~~
$ conda env list
~~~
{: .language-bash}

~~~
# conda environments:
#
patient                  /Users/alex/anaconda/envs/patient
base                  *  /Users/alex/opt/anaconda3
~~~
{: .output}

We can see the environment we created from PyCharm (which you may recall we called `patient` when we set it up) in this list, so let's use it. Note that in
order to use a `conda` environment from a shell, you have to activate it as follows (make sure you use the full environment path
unless it is a "named" environment):

~~~
$ conda activate patient
~~~
{: .language-bash}

> ## Activating Conda Environment 
Important thing to note here is that, although we created our `conda` environment called `patient` from PyCharm,
in order to use it from command line you have to activate it - PyCharm only works within its own context and does not
affect your shell.
>
{: .callout}

Now we can run our script in that environment, ensuring first we are located in our software project directory:

~~~
$ cd python-intermediate-inflammation
$ python patientdb.py
~~~
{: .language-bash}

~~~
usage: patientdb.py [-h] infiles [infiles ...]
patientdb.py: error: the following arguments are required: infiles
~~~
{: .output}

So here, we are doing a very similar thing to what PyCharm was doing when running our script. We tell the command line
shell two things:

1. the Python interpreter to use (which is the one configured in the virtual environment we created -
i.e. Anaconda Python), and
2. our script, which resides in the current directory.

## Virtual Environments
So what exactly is a virtual environment, and why use them?

Consider developing a number of different Python projects that each have their own package dependencies (and versions
of those dependencies) on the same machine. It could quickly become confusing as to which packages and package versions
are required by each project, making it difficult for you and others to run your scripts on different
machines.

A Python virtual environment is an **isolated working copy** of a specific version of
Python together with specific versions of a number of installed packages which allows you to work on a particular
project without worry of affecting other projects. In other words, it enables multiple side-by-side installations of
Python and different versions of the same third party package to coexist on your machine and only one to be selected
for each of your projects. As more dependencies are added to your Python project over time, you can add them to
this specific virtual environment and avoid a great deal of confusion
by having
separate virtual environments for each project.

Here are some typical virtual environment use cases:
- You have an older project that only works under Python 2. You do not have the time to migrate the project to Python 3
or it may not even be possible as some of the third party dependencies are not available under Python 3. You have to
start another project under Python 3. The best way to do this on a single machine is to set up 2 separate Python virtual
environments.
- One of your projects is locked to use a particular older version of a third party dependency. You cannot use the
latest version of the
dependency as it breaks things in your project. In a separate branch of your project, you want to try and fix problems
introduced by the new version of the dependency without affecting the working version of your project.

You do not have to worry too much about specific versions of packages that your project depends on most of the time.
Virtual environments enable you to always use the latest available version without specifying it explicitly.
They also enable you to use a specific older version of a package for your project, should you need to.

> ## A Specific Python or Package Version is Only Ever Installed Once
> Note that you will not have a separate Python or package installations for each of your projects - they will only
ever be installed once on your system but will be referenced from different virtual environments.
>
{: .callout}

## Managing Python Virtual Environments

There are several commonly used tools for managing Python virtual environments:
- `conda` which comes with Anaconda distribution and which we have already used from PyCharm
- `venv`, available by default from the standard `Python` distribution (`Python 3.3+`)
- `virtualenv`, which needs to be installed separately but supports both `Python 2.7+` and `Python 3.3+`
- `pipenv`, created to fix certain shortcomings of `virtualenv`

While there are pros and cons for using each of the above (see [the comparison](https://towardsdatascience.com/a-guide-to-conda-environments-bc6180fc533)), all will do the job of managing Python
virtual environments for you and it may be a matter of personal preference which one you go for 
(also see [this discussion](https://stackoverflow.com/questions/34398676/does-conda-replace-the-need-for-virtualenv) on Stackoverflow).
For the purposes of this workshop, we will continue to use `conda` to manage our virtual environments to reduce the amount
of different tools we have to introduce and learn and because it does the job.

> ## Anaconda and `conda`
Anaconda is a Python distribution commonly used for scientific programming - it conveniently installs Python and a
number of commonly used scientific computing packages. `conda` (that comes with Anaconda distribution) is a tool with
dual functionality - (1) it serves as an open source package management system that helps you find Python packages from a
package repository and install them on your system, and (2) it is also a virtual environment management system.
>
{: .callout}

Let us have a look at how we can create and manage `conda` virtual environments from command line.

### Creating a `conda` Environment
Remember, we have already created our `conda` virtual environment called `patient` from PyCharm, so we do not have to
do it again. Command line shell gives you a hint which environment is
currently active by pre-pending it to its prompt in round brackets: `(patient) alex@MacBook-Pro python-intermediate-inflammation %`.
If unsure, you can always issue the `conda env list` command - the current environment will be denoted with an asterisk (`*`):

~~~
$ conda env list
# conda environments:
#
patient               *  /Users/alex/anaconda/envs/patient
base                     /Users/alex/opt/anaconda3
~~~
{: .language-bash}


> ## Managing Conda Environments
> Refer to the official [Conda guide](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
for the documentation on managing environments.
>
> A quick list of shell commands to create, activate and deactivate a virtual environment called `myenv` with `conda`:
>~~~
>$conda create -n myenv
>$conda activate myenv
>$conda deactivate myenv
>~~~
>{: .language-bash}
{: .callout}

### Exporting a `conda` Environment

As your project grows, you will start installing new packages into your virtual environment 
and adding these dependencies to your code (we have already seen how that can be done from PyCharm and will cover 
package installation from command line next). Naturally, you will want to share your environment with your collaborators so 
that that they can easily 'clone' your software project with all of its dependencies. `conda` has a handy way of exporting,
saving and sharing an environment via an `environment.yml` file. To export your active environment to a file:

~~~
$ conda env --from-history export > environment.yml
~~~
{: .language-bash}

You can now share the exported `environment.yml` file with your collaborators. Typically, you will save the
`environment.yml` file in the root directory of your project and add it to your version control system.

> ## Note on `conda export`
> Note the use of `--from-history` parameter in the above `conda export` command. This is to make sure that the exported environment 
>will only include packages that were explicitly added to our environment. Without it, `conda export` would add 
>the platform-specific Python packages which reside in the 
>environment by default too, which could be problematic when sharing your environment with collaborators working on different platforms and operating systems.
>We will revisit this issue in one of the later episodes.  
>
{: .callout}

### Importing a `conda` Environment
To create the environment from an `environment.yml`
file, assuming that the `environment.yml` file is in the root directory of the project, do:

~~~
$ conda env create -f environment.yml
~~~
{: .language-bash}

### Updating a `conda` Environment
You may need to update your environment for a variety of reasons. For example, one of your project's dependencies has
just released a new version (dependency version number update), you need an additional package for data analysis
(adding a new dependency) or you have found a better package and no longer need the older package (adding a new and
removing an old dependency).

All you need to do is update the contents of your `environment.yml` file accordingly and then run the following command
to propagate to your environment:

~~~
$ conda env update --file environment.yml  --prune
~~~
{: .language-bash}

## Managing Python Packages
Let us recap - Anaconda is a Python distribution commonly used for scientific programming and `conda`
(that comes with Anaconda distribution) is an open source package management tool that helps you find `Python`
packages from a package repository and install them on your
system. As we have seen above, `conda` is also a virtual environment management tool. 

Another well known and commonly used Python
package management system is called `pip`. If you are using Anaconda Python distribution, it makes sense
(and reduces confusion)
to use `conda` for all these tasks. But sometimes packages that you need are not available via `conda`, 
in which case you will have to mix the use of both `conda` and `pip` to manage your packages. Recent versions
of `conda` have improved support for interoperability between `conda` and `pip` and, while `pip` only installs 
Python packages from [PyPI package repository](https://pypi.org/), `conda` can now install packages from 
[Anaconda Repository](https://repo.anaconda.com/) and [Anaconda Cloud](https://anaconda.org/) as well as PyPI by using `pip` in an active `conda` environment. 

> ## Mixing `pip` and `conda`
> The advice from the [Anaconda blog](https://www.anaconda.com/blog/using-pip-in-a-conda-environment) is: 
"... when combining `conda` and `pip`, it is best to use an isolated `conda` environment. 
Only after `conda` has been used to install as many packages as possible should `pip` be used to install any remaining software. "
>
{: .callout}

Things with installing and managing Python distributions, third party packages and virtual environments are, well,
complex. There is abundance of tools for each task, each with its advantages and disadvantages and there are different 
ways to achieve the same effect. Advantages of using Anaconda and `conda` are that you get all the packages needed for 
scientific code development included with the distribution. If you are only collaborating with others who are also using 
Anaconda, you may find that `conda` satisfies all your needs. It is good, however, to be aware of all these tools, 
and use them appropriately - we will continue to use `conda` only for all the aforementioned tasks throughout this workshop.

![python-environment-hell](../fig/python-environment-hell.png)
<p style="text-align: center;">Credit: XKCD, https://xkcd.com/1987/</p>

### Package Management With `conda` - an Overview

Here we have a quick overview of most commonly used commands to manage packages with `conda` - we will use some of them
in the following episodes. As always, refer to the
[official Conda guide](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-pkgs.html)
for the full documentation on managing packages.

To install a Python package with `conda` do:

~~~
$ conda install package-name
~~~
{: .language-bash}

To install a specific version of a `conda` package:

~~~
$ conda install package-name=2.3.4
~~~
{: .language-bash}

To specify only a major version of a `conda` package do:

~~~
$ conda install package-name=2
~~~
{: .language-bash}

The above commands install into the environment that is currently active. To install into a different environment do:

~~~
$ conda install package-name=2.3.4 -n some-other-environment
~~~
{: .language-bash}

To uninstall a `conda` package do:

~~~
$ conda remove package-name
~~~
{: .language-bash}

To list `conda` packages in a `conda` environment do:

~~~
$ conda list -n some-other-environment
~~~
{: .language-bash}

or to list all `conda` packages:

~~~
$ conda list
~~~
{: .language-bash}

{% comment %}
### Package Management With `pip`
If you install any `Python` distribution other than Anaconda, you will find yourself using `pip` for package management.
As of `Python 3.3`, it comes together with `pip` (and `venv`) and no separate installation is needed.

To install a Python package with `pip` do:

~~~
$ pip install package-name
~~~
{: .language-bash}

To install a specific version of a Python package:

~~~
$ pip install package-name=2.3.4
~~~
{: .language-bash}

To specify a minimum version of a Python package, do:

~~~
$ pip install 'package-name>=2.3.4'
~~~
{: .language-bash}

To uninstall a Python package installed with `pip` do:

~~~
$ pip uninstall package-name
~~~
{: .language-bash}

To list all packages installed with `pip`:

~~~
$ pip list
~~~
{: .language-bash}

While `pip` is not a virtual environment manager, it allows you to export all dependencies of your project into a
`requirements.txt` file that can be easily shared with your collaborators in a similar manner as `environment.yml`.

To export dependencies, from your project root do:

~~~
$ pip freeze
~~~
{: .language-bash}

The above command will create a `requirements.txt` file in your current directory.

To install dependencies from a `requirements.txt` file, from your project root where the file is located do:

~~~
$ pip install -r requirements.txt
~~~
{: .language-bash}

{% endcomment %}

{% include links.md %}
