---
title: Setup
---

You will need the following software installed and working correctly on your system to be able to follow the workshop.

## Shell/Terminal Program
You can use a shell program such as  Bash. If you already have a shell other than Bash you can use that instead, that is fine as none of the content of this workshop is specific to Bash.
  - On Windows the Bash shell will be installed as part of the Git (gitforwindows - see below) distribution
  - On MacOS and Linux you will already have a shell available

To test the installation, start your shell/terminal program and type:
~~~
$ date
~~~
{: .language-bash}

If your shell is working - it should return the current date and time similar to:
~~~
(base) alex@MacBook-Pro python-intermediate-development % date
Wed 21 Apr 2021 11:38:19 BST
~~~
{: .output}
  
## Git Version Control Tool
Git is a program that can accessed via a shell/terminal.

  - On Windows Git can be downloaded from [https://gitforwindows.org/](https://gitforwindows.org/) - this will 
  install the shell program as well as Git 
  - On MacOS Git should be included as part of xcode-tools and should be available from your shell/terminal
  - On Linux Git can be installed using your favourite package manager

To test the installation, start your shell program and type:
~~~
$ git help
~~~
{: .language-bash}

If your Git installation is working you should see something like:
~~~
(base) alex@MacBook-Pro python-intermediate-development % git help
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
$ git help
~~~
{: .output}

### GitHub Account                     
For the purposes of the workshop, you will also need a GitHub account. 
GitHub is a free, online host for Git repositories that you will use during the workshop to store your code in. 
You can create an account at [https://github.com/](https://github.com/) if you don't already have one.

## Anaconda Python Distribution
We will be using the Anaconda Python Distribution for the workshop. The material is not tested with other Python distributions and is specific to Anaconda.
  - Anaconda can be downloaded from [https://www.anaconda.com/products/individual](https://www.anaconda.com/products/individual)
  - We will also be using the `conda` package manager that comes with the Anaconda Python distribution
  
To test your Anaconda installation in your shell type:
~~~
$ conda -V
~~~
{: .language-bash}
If all is well with your installation, you should see something like:
~~~       
conda 4.9.2
~~~
{: .output}

To make sure you are using the Anaconda distribution of Python and not some other distribution you may have on your system, 
 type the following in your shell:
 ~~~
 $ python -V
 ~~~
 {: .language-bash}
This should enter you into a Python console and you should see something like:
 ~~~
(base) alex@MacBook-Pro python-intermediate-development % python
Python 3.8.5 (default, Sep  4 2020, 02:22:02) 
[Clang 10.0.0 ] :: Anaconda, Inc. on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
 ~~~
 {: .language-bash}
 Press `CONTROL-D` on to exit the Python console.
  
## PyCharm - Python Integrated Development Environment
  - PyCharm can be downloaded from [https://www.jetbrains.com/pycharm/download](https://www.jetbrains.com/pycharm/download)
  - The Community edition is fine, though if you are developing software for the purpose of academic research you may be eligible for a free license for the Professional edition which contains extra features
  
{% include links.md %}
