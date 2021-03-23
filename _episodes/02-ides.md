---
title: "Integrated Software Development Environments"
start: false
teaching: 20
exercises: 10
questions:
- "What are Integrated Development Environments (IDEs)?"
- "What are the advantages of using IDEs for software development?"
objectives:
- "Set up a development environment in PyCharm IDE"
- "Use PyCharm to run a Python script"

keypoints:
- "An IDE is an application that provides a comprehensive set of facilities for software development, for example
syntax highlighting, code search and completion, version control and debugging."
---
## Integrated Development Environments (IDEs)
An integrated development environment (IDE) is a software application that provides comprehensive facilities for
software development. An IDE normally consists of at least a source code editor, build automation tools and a debugger.
The boundaries between modern IDEs and other aspects of the broader software development process are often blurred as
nowadays IDEs also offer version control support, tools to construct graphical user interfaces (GUI) and web browser
integration for web app development, source code inspection for dependencies and many other useful functionalities. The
following is a list of most commonly seen IDE features:

- Syntax highlighting - to show the language constructs, keywords and the syntax errors with visually distinct colors
and font effects
- Code completion - to speed up programming by offering a set of possible (syntactically correct) code options
- Code search - finding package, class, function and variable declarations, their usages and referencing
- Version control support - to interact with source code repositories
- Debugging - for setting breakpoints in the code editor, step-by-step execution of code and inspection of variables

IDEs are extremely useful and modern software development would be very hard without them. There is a number of IDEs
available for Python development, a good overview is available from the
[Python Project Wiki](https://wiki.python.org/moin/IntegratedDevelopmentEnvironments). In addition to IDEs,
there is also a number of code editors that have
Python support. Code editors can be as simple as a text editor with syntax highlighting and code formatting capabilities
(e.g. GNU EMACS, Vi/Vim, Atom). Most good code editors can also execute code and control a
debugger, and some can also interact with a version control system. Compared to an IDE, a good dedicated code
editor is usually smaller and quicker, but often less feature rich. You will have to decide which one is the best for
you but for the purpose of this workshop we will learn how to use [PyCharm](https://www.jetbrains.com/pycharm/) -
a free, open source Python IDE.

## Using the PyCharm IDE

### Opening a software project in PyCharm
If you have not PyCharm running yet, start it up now. You can skip the initial configuration steps which just go through
selecting a theme and other aspects. You should be presented with a dialog box that asks you what you want to do,
e.g. `Create New Project`, `Open`, or `Check out from Version Control`.

Select `Open` and find the software project repository you cloned earlier, and select the `python-intermediate-inflammation`
directory. This directory is now the current working directory for PyCharm, so when we run scripts from PyCharm,
this is the directory they will run from.

PyCharm will show you a 'Tip of the Day' window which you can safely ignore by selecting `Close`.
You will notice the IDE shows you a project/file navigator window on the left hand side, to traverse and select the files
(and any subdirectories) within the working directory, and an editor window on the right.

### Syntax highlighting
Syntax highlighting is a feature that displays source code terms in different colors and fonts according to the syntax
category the highlighted term belongs to. It also makes syntax errors visually distinct. Highlighting does not affect
the meaning of the code itself - is intended only for human readers and makes reading code and finding errors easier.

![ide-syntax](../fig/ide-syntax.png)

### Code completion
As you start typing code, PyCharm will offer to complete some of the code for you in a form of an auto completion popup.
This is a context-aware code completion feature that speeds up the process of coding (e.g. reducing typos and other
common mistakes) by offering available variable
names, functions from available packages, parameters of functions, hints related to syntax errors, etc.

![ide-code-completion](../fig/ide-code-completion.png)

### Code search
You can search for a text string within a project, use different scopes to narrow your search process, exclude certain
items from your search, find usages and occurrences. To find the search string in a project:

1. From the main menu, select `Edit | Find | Find in Path ...` (or `Edit | Find | Find in Files...` depending on your version of PyCharm).
2. Type your search string in the search field of the popup. Alternatively, in the editor, highlight the string you
want to find and press `Command-Shift-F` (on Mac) or `Control-Shift-F` (on Windows). PyCharm places the highlighted
string into the search field of the popup.
    ![ide-code-search](../fig/ide-code-search.png)
     If you need, specify the additional options in the popup.
     PyCharm will list the search strings and all the files that contain them.
3. Check the results in the preview area of the dialog where you can replace the search string or select another string,
or press `Command-Shift-F` (on Mac) or `Control-Shift-F` (on Windows) again to start a new search.
4. To see the list of occurrences in a separate tool window, click `Open in Find Window` button in the bottom right
corner. Use this window and its options to group the results, preview them, and work with them further.
![ide-find-panel](../fig/ide-find-panel.png)

### Version control
PyCharm supports a directory-based versioning model, which means that each project directory can be
associated with a different version control system. Our project was already under Git version control and PyCharm
recognised it. It is also possible to add an unversioned project directory to version control directly from PyCharm.

For the purposes of this workshop, we will do all our version control commands from the shell terminal but it is worth
noting that PyCharm offers a comprehensive **subset** of Git commands (i.e. it is possible to perform a set of common
Git commands from PyCharm but not all). A very useful version control feature in PyCharm is graphically comparing
changes you made locally with the same repository version, a different commit version or a version in a different
branch - this is something that cannot be done equally well from a text-based shell terminal.

![ide-version-control](../fig/ide-version-control.png)

You can get full
[documentation on PyCharm build-in version control](https://www.jetbrains.com/help/pycharm/version-control-integration.html) online.

### Configuring PyCharm with Anaconda
Our software project already contains some Python code (scripts). However, before we can run it, we need to configure
PyCharm so that it knows where the Python interpreter, which we want to use to run the code, is located.
In our case, this is the Python interpreter that is supplied within the Anaconda distribution. However, you may have
various Python distributions and versions installed on your system so you have to be careful here to select the one you
want to use. To do this:

1. Select either `PyCharm` > `Preferences` (Mac) or `File` > `Settings` (Linux, Windows).
2. Then, in the preferences window that appears, select `Project: python-intermediate-inflammation` >
`Project Interpreter` from the left. You'll
see a number of Python packages displayed as a list, and importantly above that, the current Python interpreter that is
being used. These may be blank or set to `<No interpreter>`, or possibly the default version of Python installed on your system, e.g. `Python 2.7 /usr/bin/python2.7`
or `Python 3.7 /usr/bin/python3.7`, which we do not want to use in this instance - we want to use Anaconda
distribution of Python.
3. Select the cog-like button in the top right, then `Add Local...` (or `Add...` depending on your version). An `Add Local Python Interpreter` window will appear.
4. Select `Conda Environment` from the list on the left so we can configure an Anaconda environment, and ensure that `New environment` is
selected. In the `Location` field, you'll see something like `/Users/<USERNAME>/anaconda/envs/python-intermediate-inflammation`, which will likely look a little different depending on your
   system. Replace the `python-intermediate-inflammation` part of the field with `patient` - which is a name we'll use to refer to this environment later on
5. Select `Make available to all projects` so we can also use this environment with other projects if we wish.
6. Select `OK` in the `Add Python Interpreter` window. Back in the `Preferences` window, you should select
`Python 3.7 (patient)` or similar from the `Project Interpreter` drop-down list.
7. We also need to add the packages `numpy` and `matplotlib` to this environment, since our software uses them. In this window select the `+` icon at the bottom
   of the window. In the window that appears, type in `numpy`, and select the package from the list, then select `Install Package`. Do the same for `matplotlib`, then close the window.
7. Select `OK` in the `Preferences` window.

It may take a few minutes for PyCharm to read and familiarise itself with the Anaconda installation you have configured
(you may see `n processes running` in the bar at the bottom of the PyCharm IDE while it does this).

Now we have told PyCharm about the new Python interpreter, we can configure it for our project:

1. To add a new configuration - select `Run` > `Edit Configurations...` from the top menu.
2. Select `+` button from the top left to add a configuration, selecting `Python` from the drop down list. You should see
`Python 3.7 (patient)` or similar in the `Python interpreter` field in the window. For `Script path`, select the folder
button and find and select `patientdb.py`. This tells PyCharm which script to run.
You can even give this configuration a name at the top of the window if you like - let's name it `patient`.
3. Select `OK` to confirm these settings.

> ## Virtual Environments
>
> By configuring the Python interpreter to use in PyCharm, we have created a new Python configuration within which our
> code will can run. These configurations are commonly known as *virtual environments*, and we will cover them in more detail in the
> [next episode](../03-virtual-environments/index.html).
{: .callout}

Once done, you are ready to run your script!

### Running Scripts From PyCharm
Right-click the `patientdb.py` file in the PyCharm project/file navigator on the left, and select `Run 'patient'`.
The script will run in a terminal window at the bottom of the IDE window and display something like:

~~~
/Users/alex/anaconda/envs/patient/bin/python /Users/alex/python-intermediate-inflammation/patientdb.py
usage: patientdb.py [-h] infiles [infiles ...]
patientdb.py: error: the following arguments are required: infiles

Process finished with exit code 2
~~~
{: .output}

Here, we can see that a new shell has been created that uses the Anaconda interpreter
`/Users/alex/anaconda/envs/patient/bin/python` from the virtual environment `patient` we just created in PyCharm to run our
script located at `/Users/alex/python-intermediate-inflammation/patientdb.py`. The script is currently throwing an error -
`patientdb.py: error: the following arguments are required: infiles`.
Do not worry about it for now, we will learn how to fix the errors and write test
to detect errors in the following episodes.

{% include links.md %}



