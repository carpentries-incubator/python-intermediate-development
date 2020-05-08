---
title: "Virtual Environments For Software Development"
start: false
teaching: 20
exercises: 10
questions:
- "What are virtual environments in software design?"
- "What are the advantages of using virtual environments?"
- "How to set up and manage a Python virtual environment?"
objectives:
- "Set up a Python virtual environment for a software project using `conda`"
- "Manage and share virtual environments using `environment.yml` file"
- "Use `conda` or `pip` to manage Python packages"

keypoints:
- "A virtual environment is a tool that helps to keep dependencies required by different projects separate by creating isolated spaces for them that contain per-project dependencies."
- "Instead of installing packages individually, `pip` allows you to declare all dependencies in a `requirements.txt` file that can be easily shared with your collaborators."
- "Use `conda env export > environment.yml` or `pip freeze` to take snapshot of your project's dependencies."
- "Use `conda env create -f environment.yml` or `pip -r requirements.txt` to replicate a virtual environment."
---

## Running Scripts From Command Line
If you attended a Python workshop in the past, you may recall that we can also run Python scripts directly from the 
command line. Let's run our `patientdb.py` script using Python from the command line.

First, we can make use of the Python Anaconda environment `patient` we created from PyCharm for our project. 
Open up a new terminal and type the following to list all the environments Anaconda is aware of:

~~~
$conda env list
~~~
{: .language-bash}

We can see our environment we created (`patient`) in this list, so let's use that:

~~~
$conda activate patient
~~~
{: .language-bash}

Now we can run our script in that environment, ensuring first we are in the directory where it resides:

~~~
$cd swc-intermediate-template
$python patientdb.py
~~~
{: .language-bash}

~~~
usage: patientdb.py [-h] infiles [infiles ...]
patientdb.py: error: too few arguments
~~~
{: .output}

So here, we're doing a very similar thing to what PyCharm was doing when running our script: we give the command line the Python interpreter to run (which will use the one in the virtual environment we created) and our script, which resides in the local directory.

## Virtual Environments
So what exactly is a virtual environment, and why use them? 

Consider developing a number of different Python projects that each have their own package dependencies (and versions of those dependencies) on the same machine. It could quickly become confusing as to which packages and package versions are required by each project, making it difficult for others to run your scripts themselves (or yourself on another machine!). Additionally, different scripts may need to use different versions of the same package.

A Python virtual environment is an isolated working copy (a self-contained directory tree) of a specific version of Python together with specific versions of a number of installed packages which allows you to work on a particular project without worry of affecting other projects. In other words, it enables multiple side-by-side installations of Python and different versions of the same third party package to coexist on your machine and only one to be selected for each of your projects. As more dependencies are added as you develop your Python 
software project, you can add them to this specific virtual environment and avoid a great deal of confusion by having separate virtual environments for each project.

Here are some typical virtual environment use cases:
- You have an older project that only works under Python 2. You do not have the time to migrate the project to Python 3 or it may not even be possible as some of the third party dependencies are not available under Python 3. You have to start another project under Python 3. The best way to do this on a single machine is to set up 2 separate Python virtual environments. 
- One of your projects is locked to use a particular older version of a third party dependency. You cannot use the latest version of the 
dependency as it breaks things in your project. In a separate branch of your project, you want to try and fix problems introduced by the new version of the dependency without affecting the working version of your project.

You do not have to worry too much about specific versions of packages that your project depends on most of the time. 
Virtual environments enable you to always use the latest available version without specifying it explicitly. 
They also enable you to use a specific older version of a package to be used by your project, if need be.

> ## A specific Python or package version is only ever installed once
> Note that you will not have a separate Python or package installations for each of your projects - they will only ever be installed once on your system but will be referenced to from different virtual environments.  
>
{: .callout}

## Creating a Python Virtual Environment

There are several commonly used tools for creating Python virtual environments:
- `conda` virtual environments, which we have already used from PyCharm
- `venv` is available by default in `Python 3.3+`
- `virtualenv` needs to be installed separately, but supports `Python 2.7+` and `Python 3.3+`
- `pipenv` was created due to some shortcomings of `virtualenv`

While there are pros and cons for using each of the above, they all will do the job of managing Python 
virtual environments for you and it may be a matter of personal preference which one you go for. 
For the purposes of this workshop, we will continue to use `conda` to manage our virtual environment. 

To create a virtual environment with `conda` from command line within a software project directory, you can do:
~~~
$conda create -n myenv
~~~
{: .language-bash}
where `myenv` is the name of the environment you are creating.

To create an environment with a specific version of Python:
~~~
$conda create -n myenv python=3.6
~~~
{: .language-bash}

To create an environment with a specific version of a package:
~~~
$conda create -n myenv scipy=0.15.0
~~~
{: .language-bash}

Switching or moving between environments is called activating the environment. 
We have already seen previously how to active an environment:
~~~
$conda activate myenv
~~~
{: .language-bash}

and verify that the new environment was installed correctly:
~~~
$conda env list
~~~
{: .language-bash}           

## Managing and Sharing Python Virtual Environments
You may want to share your environment with someone else - for example, so they can re-create a software 
project that you have developed. To allow them to quickly reproduce your environment, with all of its packages and 
versions, you can save and share a copy of your environment via an `environment.yml` file.

### Exporting an environment 
To export your active environment to a new file:
 ~~~
 $conda env export > environment.yml
 ~~~
 {: .language-bash}   
 
### Importing an environment
Share the exported `environment.yml` file with the other person. To create the environment from the `environment.yml` 
file, the other person has to do:
 ~~~
 $conda env create -f environment.yml
 ~~~
 {: .language-bash} 
 
### Updating an environment
You may need to update your environment for a variety of reasons. For example, one of your project's dependencies has 
just released a new version (dependency version number update), you need an additional package for data analysis (adding a new dependency) or you have found a better package and no longer need the older package (adding new and removing old dependency).
   
All you need to do is update the contents of your `environment.yml` file accordingly and then run the following command
to propagate to your environment:
 ~~~
 $conda env update --file environment.yml  --prune
 ~~~
{: .language-bash}    

## Managing Python Packages
Anaconda a Python distribution commonly used for scientific programming (it installs `Python` and a number of commonly 
used scientific computing packages). `conda` (that comes with Anaconda distribution) is a tool - an open source package management system 
helps you find `Python` packages from a package repository and install them on your system. As we have just seen, `conda`
in much more - it is also a virtual environment management system. In a way, `conda` provides the 
functionalities of commonly used Python package management system called `pip` and virtual environment systems like 
`venv` or `virtualenv`. If you are using Anaconda Python distribution, it makes sense (and reduces confusion) 
to use `conda` for all the above tasks. But it is equally possibly to mix the use of both `conda` and `pip` to manage Python third party packages.
 
### Package Management With `conda`
If you decide to go with `conda` for package management, to install a Python package with `conda` do:
...
### Package Management With `pip`
If you install any `Python` distribution other than Anaconda, you will find yourself using `pip` for package management. 
As of `Python 3.???`, it comes together with `pip` and no separate installation of `pip` is needed. 
To install a Python package with `pip` do:
... 

While `pip` is not a virtual environment manager, it allows you to export all dependencies of your project into a 
`requirements.txt` file that can be easily shared with your collaborators in a similar manner as `environment.yml`:
 ~~~
 $pip freeze
 ~~~    
{: .language-bash}    
   
and to install them from the `requirements.txt` file as:
~~~
$pip install -r requirements.txt
~~~        
{: .language-bash}    

{% include links.md %}
