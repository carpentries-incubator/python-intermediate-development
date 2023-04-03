---
title: Setup
---

You will need the following software installed and working correctly on your system to be able to follow the course.

> ## Common Issues & Tips
> If you are having issues installing or running some of the tools below,
check a list of [common issues](./common-issues/index.html) other course participants encountered and some useful tips for using the tools and working through the material.
{: .callout}

## Command Line Tool
You will need a command line tool (shell/console) in order to run Python scripts and version control your code with Git.
- On Windows, it is recommended to use **Git Bash** (which is included in
  [Git For Windows package](https://gitforwindows.org/) - see the Git installation section below). The use of Windows command line tool `cmd` is not suitable for the course.
- On macOS and Linux, you will already have a command line tool available on your system. You can use a command line tool such as [**Bash**](https://www.gnu.org/software/bash/),
  or any other [command line tool that has similar syntax to Bash](https://en.wikipedia.org/wiki/Comparison_of_command_shells),
  since none of the content of this course is specific to Bash. Note that starting with macOS Catalina,
  Macs will use [Zsh (Z shell)](https://www.zsh.org/) as the default command line tool instead of Bash.

To test your command line tool, start it up and type:
~~~
$ date
~~~
{: .language-bash}

If your command line program is working - it should return the current date and time similar to:
~~~
Wed 21 Apr 2021 11:38:19 BST
~~~
{: .output}

## Git Version Control Tool
Git is a program that can be accessed from your command line tool.

- On Windows, it is recommended to use **Git Bash**, which comes included as part of the [Git For Windows package](https://gitforwindows.org/) and will
  install the Bash command line tool as well as Git.
- On macOS, Git is included as part of Apple's [Xcode tools](https://en.wikipedia.org/wiki/Xcode)
  and should be available from the command line as long as you have XCode. If you do not have XCode installed, you can download it from
  [Apple's App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12) or you can
  [install Git using alternative methods](https://git-scm.com/download/mac).
- On Linux, Git can be installed using your favourite package manager.

To test your Git installation, start your command line tool and type:
~~~
$ git help
~~~
{: .language-bash}

If your Git installation is working you should see something like:
~~~
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

When you use Git on a machine for the first time, you need to configure a few things:

* your name, 
* your email address (used to uniquely identify you commit a change),
* preferred text editor for Git to use (e.g. `nano` or another text editor of your choice),
* whether you want to use these settings globally (i.e. for every Git project on your machine).

This can be done from the command line as follows:
~~~
$ git config --global user.name "Your Name"
$ git config --global user.email "name@example.com"
$ git config --global core.editor "nano -w"
~~~
{: .language-bash}

Make sure to use the same email address you used to open an account on Bitbucket that you will use for this course.

### Secure Access To Bitbucket Using Git From Command Line
In order to access Bitbucket using Git from your machine securely, you need to set up a way of authenticating yourself 
with Bitbucket through Git. The recommended way to do that for this course is to set up 
[*SSH authentication*](https://www.ssh.com/academy/ssh/public-key-authentication) - a 
method of authentication that is more secure than sending [*passwords over HTTPS*](https://security.stackexchange.com/questions/110415/is-it-ok-to-send-plain-text-password-over-https) and which requires a pair of keys - one public that you 
upload to your Bitbucket account, and one private that remains on your machine. 

Bitbucket provides full documentation and guides on how to [generate an SSH key and add the key to your Bitbucket account](https://support.atlassian.com/bitbucket-cloud/docs/configure-ssh-and-two-step-verification/).

## Python Distribution
The material has been developed using the [standard Python distribution version 3.8](https://www.python.org/downloads/)
and is using `venv` for virtual environments and `pip` for package management.
The material has not been extensively tested with other Python distributions and package managers,
but most sections are expected to work with some modifications.
For example, package installation and virtual environments would need to be managed differently, but Python script
invocations should remain the same regardless of the Python distribution used.

To download a Python distribution for your operating system,
please head to [Python.org](https://www.python.org/downloads/).

>## Recommended Python Version
> We recommend using at least Python version 3.8+ but any [supported version](https://devguide.python.org/versions/#versions) should work (i.e. version 3.7 onward. 
> Specifically, we recommend upgrading from Python 2.7 wherever possible; continuing to use it will likely result in difficulty finding supported dependencies or syntax errors).
{: .callout}

You can
test your Python installation from the command line with:
~~~
$ python3 --version
~~~
{: .language-bash}
If all is well with your installation, you should see something like:
~~~       
Python 3.8.2
~~~
{: .output}

To make sure you are using the standard Python distribution and not some other distribution you may have on your system,
type the following in your shell:
 ~~~
 $ python3
 ~~~
{: .language-bash}
This should enter you into a Python console and you should see something like:
 ~~~
Python 3.8.2 (default, Jun  8 2021, 11:59:35) 
[Clang 12.0.5 (clang-1205.0.22.11)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
 ~~~
{: .language-bash}
Press `CONTROL-D` or type `exit()` to exit the Python console.

### `venv` and `pip`
If you are using a Python 3 distribution from [Python.org](https://www.python.org/),
`venv` and `pip` will be automatically installed for you. If not, please make sure you have these
two tools (that correspond to your Python distribution) installed on your machine.

## PyCharm IDE
We use JetBrains's [PyCharm Python Integrated Development Environment](https://www.jetbrains.com/pycharm) for the course.
PyCharm can be downloaded from [the JetBrains website](https://www.jetbrains.com/pycharm/download).
The Community edition is fine, though if you are developing software for the purpose of academic research you may be eligible for a free license for the Professional edition which contains extra features.

{% include links.md %}
