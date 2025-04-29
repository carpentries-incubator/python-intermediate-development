---
title: Installation Instructions
---

You will need the following software and accounts setup to be able to follow the course:

- [Command line tool](#command-line-tool) (such as Bash, Zsh or Git Bash)
- [Git version control program](#git-version-control-tool)
- [GitHub account](#github-account)
- [Python 3 distribution](#python-3-distribution)
- [PyCharm](#pycharm-ide) integrated development environment (IDE)

:::::::::::::::::::::::::::::::::::::::::  callout

## Common Issues \& Tips

If you are having issues installing or running some of the tools below,
check a list of [common issues](learners/common-issues.md) other course participants encountered and some useful tips for using the tools and working through the material.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Command Line Tool

You will need a command line tool (shell/console) in order to run Python scripts and version control your code with Git.

- On Windows, it is **strongly** recommended to use **Git Bash** (which is included in
  [Git For Windows package](https://gitforwindows.org/) - see the Git installation section below). The use of
  Windows command line tool `cmd` is not suitable for the course. We also advise against using
  [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/) for this course as we do not
  provide instructions for troubleshooting any potential issues between WSL and PyCharm.
- On macOS and Linux, you will already have a command line tool available on your system. You can use a command line tool such as [**Bash**](https://www.gnu.org/software/bash/),
  or any other [command line tool that has similar syntax to Bash](https://en.wikipedia.org/wiki/Comparison_of_command_shells),
  since none of the content of this course is specific to Bash. Note that starting with macOS Catalina,
  Macs will use [Zsh (Z shell)](https://www.zsh.org/) as the default command line tool instead of Bash.

To test your command line tool, start it up and type:

```bash
$ date
```

If your command line program is working - it should return the current date and time similar to:

```output
Wed 21 Apr 2021 11:38:19 BST
```

## Git Version Control Tool

Git is a program that can be accessed from your command line tool.

- On Windows, it is recommended to use **Git Bash**, which comes included as part of the [Git For Windows package](https://gitforwindows.org/) and will
  install the Bash command line tool as well as Git.
- On macOS, Git is included as part of Apple's [Xcode tools](https://en.wikipedia.org/wiki/Xcode)
  and should be available from the command line as long as you have Xcode. If you do not have Xcode installed, you can download it from
  [Apple's App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12) or you can
  [install Git using alternative methods](https://git-scm.com/download/mac).
- On Linux, Git can be installed using your favourite package manager.

To test your Git installation, start your command line tool and type:

```bash
$ git help
```

If your Git installation is working you should see something like:

```output
usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           [--config-env=<name>=<envvar>] <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone     Clone a repository into a new directory
   init      Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add       Add file contents to the index
   mv        Move or rename a file, a directory, or a symlink
   restore   Restore working tree files
   rm        Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect    Use binary search to find the commit that introduced a bug
   diff      Show changes between commits, commit and working tree, etc
   grep      Print lines matching a pattern
   log       Show commit logs
   show      Show various types of objects
   status    Show the working tree status

grow, mark and tweak your common history
   branch    List, create, or delete branches
   commit    Record changes to the repository
   merge     Join two or more development histories together
   rebase    Reapply commits on top of another base tip
   reset     Reset current HEAD to the specified state
   switch    Switch branches
   tag       Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch     Download objects and refs from another repository
   pull      Fetch from and integrate with another repository or a local branch
   push      Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
See 'git help git' for an overview of the system.
```

When you use Git on a machine for the first time, you need to configure a few things:

- your name,
- your email address (the one you used to open your GitHub account with, which will be used to uniquely identify your commits),
- preferred text editor for Git to use (e.g. `nano` or another text editor of your choice),
- whether you want to use these settings globally (i.e. for every Git project on your machine).

This can be done from the command line as follows:

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "name@example.com"
$ git config --global core.editor "nano -w"
```

### GitHub Account

GitHub is a free, online host for Git repositories that you will use during the course to store your code in so
you will need to open a free [GitHub](https://github.com/) account unless you do not already have one.

### Secure Access To GitHub Using Git From Command Line

In order to access GitHub using Git from your machine securely,
you need to set up a way of authenticating yourself with GitHub through Git.
The recommended way to do that for this course is to set up
[*SSH authentication*](https://www.ssh.com/academy/ssh/public-key-authentication) -
a method of authentication that is more secure than sending
[*passwords over HTTPS*](https://security.stackexchange.com/questions/110415/is-it-ok-to-send-plain-text-password-over-https)
and which requires a pair of keys -
one public that you upload to your GitHub account, and one private that remains on your machine.

GitHub provides full documentation and guides on how to:

- [generate an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), and
- [add an SSH key to a GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

A short summary of the commands you need to perform is shown below.

To generate an SSH key pair, you will need to run the `ssh-keygen` command from your command line tool/GitBash
and provide **your identity for the key pair** (e.g. the email address you used to register with GitHub)
via the `-C` parameter as shown below.
Note that the `ssh-keygen` command can be run with different parameters -
e.g. to select a specific public key algorithm and key length;
if you do not use them `ssh-keygen` will generate an
[RSA](https://en.wikipedia.org/wiki/RSA_\(cryptosystem\)#:~:text=RSA%20involves%20a%20public%20key,by%20using%20the%20private%20key.)
key pair for you by default.
GitHub now recommends that you use a newer cryptographic standard (such as [EdDSA](https://en.wikipedia.org/wiki/EdDSA) variant algorithm [Ed25519](https://cryptobook.nakov.com/digital-signatures/eddsa-and-ed25519)),
so please be sure to specify it using the `-t` flag as shown below.
It will also prompt you to answer a few questions -
e.g. where to save the keys on your machine and a passphrase to use to protect your private key.
Pressing 'Enter' on these prompts will get `ssh-keygen` to use the default key location (within
`.ssh` folder in your home directory)
and set the passphrase to empty.

```bash
$ ssh-keygen -t ed25519 -C "your-github-email@example.com"
```

```output
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/<YOUR_USERNAME>/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/<YOUR_USERNAME>/.ssh/id_ed25519
Your public key has been saved in /Users/<YOUR_USERNAME>/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:qjhN/iO42nnYmlpink2UTzaJpP8084yx6L2iQkVKdHk your-github-email@example.com
The key's randomart image is:
+--[ED25519 256]--+
|.. ..            |
| ..o A           |
|. o..            |
| .o.o .          |
| ..+ =  B        |
| .o = ..         |
|o..X *.          |
|++B=@.X          |
|+*XOoOo+         |
+----[SHA256]-----+
```

Next, you need to copy your public key (**not your private key - this is important!**) over to
your GitHub account. The `ssh-keygen` command above will let you know where your public key is saved (the file should have the
extension ".pub"), and you can get its contents (e.g. on a Mac OS system) as follows:

```bash
$ cat /Users/<YOUR_USERNAME>/.ssh/id_ed25519.pub
```

```output
ssh-ed25519 AABAC3NzaC1lZDI1NTE5AAAAICWGVRsl/pZsxx85QHLwSgJWyfMB1L8RCkEvYNkP4mZC your-github-email@example.com
```

Copy the line of output that starts with "ssh-ed25519" and ends with your email address
(it may start with a different algorithm name based on which one you used to generate the key pair
and it may have gone over multiple lines if your command line window is not wide enough).

Finally, go to your [GitHub Settings -> SSH and GPG keys -> Add New](https://github.com/settings/ssh/new) page to add a new
SSH public key. Give your key a memorable name (e.g. the name of the computer you are working on that contains the
private key counterpart), paste the public key
from your clipboard into the box labelled "Key" (making sure it does not contain any line breaks), then click the "Add SSH key" button.

Now, we can check that the SSH connection is working:

```bash
$ ssh -T git@github.com
```

:::::::::::::::::::::::::::::::::::::::::  callout

## What About Passwords?

While using passwords over HTTPS for authentication is easier to setup and will allow you *read access* to your repository on GitHub from your machine,
it alone is not sufficient any more to allow you to send changes or *write* to your remote repository on GitHub. This is because,
on 13 August 2021, GitHub has [strengthened security requirements for all authenticated Git operations](https://github.blog/changelog/2021-08-12-git-password-authentication-is-shutting-down/). This means you would need to use a
personal access token instead of your password for added security each time you need to authenticate yourself to
GitHub from the command line (e.g. when you want to push your local changes to your code repository on GitHub).
While using
SSH key pair for authentication may seem complex, once set up, it is actually more convenient than keeping track of/caching
your access token.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Python 3 Distribution

To download the latest Python 3 distribution for your operating system,
please head to [Python.org](https://www.python.org/downloads/).

If you are on Linux,
it is likely that the system Python 3 already installed will satisfy the requirements
of this course (the material has been tested using the standard Python distribution version 3.11
but any [supported version](https://devguide.python.org/versions/#versions) should work).

The course uses `venv` for virtual environment management and `pip` for package management.
The material has not been extensively tested with other Python distributions and package managers,
but most sections are expected to work with some modifications.
For example, package installation and virtual environments would need to be managed differently, but Python script
invocations should remain the same regardless of the Python distribution used.

:::::::::::::::::::::::::::::::::::::::::  callout

## Recommended Python Version

We recommend using the latest Python version but any [supported version](https://devguide.python.org/versions/#versions)
should work.
Specifically, we recommend upgrading from Python 2.7 wherever possible;
continuing to use it will likely result in difficulty finding supported dependencies or
syntax errors.


::::::::::::::::::::::::::::::::::::::::::::::::::

You can
test your Python installation from the command line with:

```bash
$ python3 --version # on Mac/Linux
$ python --version # on Windows — Windows installation comes with a python.exe file rather than a python3.exe file 
```

If you are using Windows and invoking `python` command causes your Git Bash terminal to hang with no error message or output, you may
need to create an alias for the python executable `python.exe`, as explained in the [troubleshooting section](learners/common-issues.md#python-hangs-in-git-bash).

If all is well with your installation, you should see something like:

```output
Python 3.11.4
```

To make sure you are using the standard Python distribution and not some other distribution you may have on your system,
type the following in your shell:

```bash
$ python3 # python on Windows
```

This should enter you into a Python console and you should see something like:

```bash
Python 3.11.4 (main, Jun 20 2023, 17:23:00) [Clang 14.0.3 (clang-1403.0.22.14.1)] on darwin
Type "help", "copyright", "credits" or "license" for more information. 
>>> 
```

Press `CONTROL-D` or type `exit()` to exit the Python console.

### `venv` and `pip`

If you are using a Python 3 distribution from [Python.org](https://www.python.org/),
`venv` and `pip` will be automatically installed for you. If not, please make sure you have these
two tools (that correspond to your Python distribution) installed on your machine.

## PyCharm IDE

We use JetBrains's [PyCharm Python Integrated Development Environment](https://www.jetbrains.com/pycharm) for the course.
PyCharm can be downloaded from [the JetBrains website](https://www.jetbrains.com/pycharm/download).
The Community edition is fine, though if you are developing software for the purpose of academic research you may be eligible for a free license for the Professional edition which contains extra features.




