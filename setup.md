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

Make sure to use the same email address you used to open an account on GitHub that you will use for this course (see below).

### GitHub Account
GitHub is a free, online host for Git repositories that you will use during the course to store your code in so 
you will need to open a free [GitHub](https://github.com/) account unless you don't already have one.

### Secure Access To GitHub Using Git From Command Line
In order to access GitHub using Git from your machine securely, you need to set up a way of authenticating yourself 
with GitHub through Git. The recommended way to do that for this course is to set up 
[*SSH authentication*](https://www.ssh.com/academy/ssh/public-key-authentication) - a 
method of authentication that is more secure than sending [*passwords over HTTPS*](https://security.stackexchange.com/questions/110415/is-it-ok-to-send-plain-text-password-over-https) and which requires a pair of keys - one public that you 
upload to your GitHub account, and one private that remains on your machine. 

GitHub provides full documentation and guides on how to:
- [generate an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), and
- [add an SSH key to a GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

A short summary of the commands you need to perform is shown below.

To generate an SSH key pair, you will need to run the `ssh-keygen` command from your command line tool/GitBash 
and provide **your identity for the key pair** (e.g. the email address you used to register with GitHub) 
via the `-C` parameter as shown below. Note that the `ssh-keygen` command can be run with different 
parameters - e.g. to select a specific public key algorithm and key length; if you do not use them `ssh-keygen` will generate an [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#:~:text=RSA%20involves%20a%20public%20key,by%20using%20the%20private%20key.) key pair for you by default. It will also prompt you to answer a few questions - e.g. where to save the keys on your machine and 
a passphrase to use to protect your private key. Pressing 'Enter' on these prompts 
will get `ssh-keygen` to use the default key location (within `.ssh` folder in your home directory) and set the passphrase to empty.

~~~
$ ssh-keygen -C "your-github-email@example.com"
~~~
{: .language-bash}
~~~
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/alex/.ssh/id_rsa):
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/alex/.ssh/id_rsa
Your public key has been saved in /Users/alex/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:pR53Y9KcYlZZ+A/ZM85Y1N/9TE7xeTdJ5G/5Gvt/b+M your-github-email@example.com
The key's randomart image is:
+---[RSA 3072]----+
|             .o..|
|            .o.+.|
|          . o.o+O|
|         o + .+B&|
|        S * B =OX|
|       . = = o +*|
|        .     . .|
|               =o|
|              +EO|
+----[SHA256]-----+
~~~
{: .output}

Next, you need to copy your public key (**not your private key - this is important!**) over to 
your GitHub account. The `ssh-keygen` command above will let you know where your public key is saved (the file should have the 
extension ".pub"), and you can get its contents as, e.g.:
~~~
$ cat /Users/alex/.ssh/id_rsa.pub
~~~
{: .language-bash}
~~~
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOTBh3oZ3IzFJ2bGa1TxqDA3r+BVso48hrMJElLNafkEfSQXwxdst4mfiki/sQ/HeBBaoGEhZYMOwXbPAl4oJsVc0sXDZKPr+Da7wzuhnLVlEqfy+H9Pis99aCgivWI9MJktfSHd9bczyrGFLedSuD6BtBLeL/lgh7kIsKGAfpm0ZVnkDPSssqC9/TKJpyFXyf8yRA6t3GaFPDLylNiU16Xeu82Ntjsx5CqhnUG5lDFrJeERc7ShAZY6YMhp28DEe3SC/X/3/ZITXuHjCJqO82u0NJ5W+r2ZmD87Nqt5//jXJy0OpP0aQjVRlGTOWYUck117Ow9wyfhri9sKDpUOchD20pc287V2E5f6/df3kPrsEF284Y+lwoPyF/ei0qNaJsDpLaf/JL5hIwc9NO3KkVpWS7dH0cNsFpt+uLaai7QFFEg4hdJF2SdgkPmyobquoICzN5LPEskibHAtU2jDDg6tuOWbgQoyz6nYWVOdDCyjhPHCkVrznDi9NSQyP0UQ8= your-github-email@example.com
~~~
{: .output}

Copy your last line of output that starts with "ssh-rsa" and ends with your email address 
(it may start with a different algorithm name if you did not go for RSA and it may have gone over multiple lines if your command line window
is not wide enough).

Finally, go to your [GitHub Settings -> SSH and GPG keys -> Add New](https://github.com/settings/ssh/new) page to add a new 
SSH public key. Give your key a memorable name (e.g. the name of the computer you are working on that contains the 
private key counterpart), paste the public key 
from your clipboard into the box labelled "Key" (making sure it does not contain any line breaks), then click the "Add SSH key" button.

> ## What About Passwords?
> While using passwords over HTTPS for authentication is easier to setup and will allow you *read access* to your repository on GitHub from your machine, 
it alone is not sufficient any more to allow you to send changes or *write* to your remote repository on GitHub. This is because, 
on 13 August 2021, GitHub has [strengthened security requirements for all authenticated Git operations](https://github.blog/changelog/2021-08-12-git-password-authentication-is-shutting-down/). This means you would need to use a 
personal access token instead of your password for added security each time you need to authenticate yourself to 
GitHub from the command line (e.g. when you want to push your local changes to your code repository on GitHub).
While using
SSH key pair for authentication may seem complex, once set up, it is actually more convenient than keeping track of/caching
your access token.
{: .callout}

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
> We recommend using at least Python version 3.8+ but any [supported version](https://devguide.python.org/#status-of-python-branches) should work (i.e. version 3.7 onward. 
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
