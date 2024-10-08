---
title: "Integrated Software Development Environments"
start: false
teaching: 25
exercises: 15
questions:
- "What are Integrated Development Environments (IDEs)?"
- "What are the advantages of using IDEs for software development?"
objectives:
- "Set up a (virtual) development environment in VSCode"
- "Use PyCharm to run a Python script"

keypoints:
- "An IDE is an application that provides a comprehensive set of facilities for software development, including
syntax highlighting, code search and completion, version control, testing and debugging."
- "PyCharm recognises virtual environments configured from the command line using `venv` and `pip`."
---

## Introduction
As we have seen in the previous episode -
even a simple software project is typically split into smaller functional units and modules,
which are kept in separate files and subdirectories.
As your code starts to grow and becomes more complex,
it will involve many different files and various external libraries.
You will need an application to help you manage all the complexities of,
and provide you with some useful (visual) facilities for,
the software development process.
Such clever and useful graphical software development applications are called
Integrated Development Environments (IDEs).

## Integrated Development Environments
An IDE normally consists of at least a source code editor,
build automation tools
and a debugger.
The boundaries between modern IDEs and other aspects of the broader software development process
are often blurred.
Nowadays IDEs also offer version control support,
tools to construct graphical user interfaces (GUI)
and web browser integration for web app development,
source code inspection for dependencies and many other useful functionalities.
The following is a list of the most commonly seen IDE features:

- syntax highlighting -
  to show the language constructs, keywords and the syntax errors
  with visually distinct colours and font effects
- code completion -
  to speed up programming by offering a set of possible (syntactically correct) code options
- code search -
  finding package, class, function and variable declarations, their usages and referencing
- version control support -
  to interact with source code repositories
- debugging -
  for setting breakpoints in the code editor,
  step-by-step execution of code and inspection of variables

IDEs are extremely useful and modern software development would be very hard without them.
There are a number of IDEs available for Python development;
a good overview is available from the
[Python Project Wiki](https://wiki.python.org/moin/IntegratedDevelopmentEnvironments).
In addition to IDEs, there are also a number of code editors that have Python support.
Code editors can be as simple as a text editor
with syntax highlighting and code formatting capabilities
(e.g. GNU EMACS, Vi/Vim).
Most good code editors can also execute code and control a debugger,
and some can also interact with a version control system.
Compared to an IDE, a good dedicated code editor is usually smaller and quicker,
but often less feature-rich.
You will have to decide which one is the best for you -
in this course we will learn how to use Microsoft's free [Visual Studio Code](https://code.visualstudio.com/).
Some popular alternatives include
free and open source IDE [Spyder](https://www.spyder-ide.org/)
and [PyCharm](https://www.jetbrains.com/pycharm/) an alternative open source Python IDE.

## Using the VSCode IDE

Let's open our project in VSCode now and familiarise ourselves with some commonly used features.

### Opening a Software Project
If you don't have VSCode running yet, start it up now.
You can skip the initial configuration steps which just go through
selecting a theme and other aspects.

From the `File` menu, select `Open Folder` and find the software project directory
`python-intermediate-inflammation` you cloned earlier.
This directory is now the current working directory for VSCode,
so when we run scripts from VSCode, this is the directory they will run from.

We will first familiarise ourselves with the VSCode environment.
You will notice the IDE shows you a project/file navigator window on the left hand side,
to traverse and select the files (and any subdirectories) within the working directory,
and an editor window on the right. There are also additional buttons arranged vertically on the
far right, including the search window, a panel for version control, running the debugger and installation of extensions.

![View of an opened project in VSCode](../fig/vscode-readme.png){: .image-with-shadow width="1000px" }

VSCode is designed to be universal IDE across a multitude of programming languages, as we will be working in Python we will need to install the Python extension. Click the extensions icon and search for "Python" selecting Microsoft's official Python entry and clicking `Install`:

![Installation of Python extension](../fig/vscode_python_install.png){: .image-with-shadow width="500x" }

Next search for the Microsoft `Pylint` extension and install the same way. We will use `pylint` later in this module to set the styling and formatting for our code.

Select the `inflammation-analysis.py` file in the project navigator on the left
so that its contents are displayed in the editor window.
You may notice a warning in yellow about the missing Python interpreter
in the bottom right of the editor -
this is one of the first things you will have to configure for your project
before you can do any work.

![Missing Python Interpreter Warning in VSCode](../fig/vscode-missing-interpreter.png){: .image-with-shadow width="800px" }

### Configuring a Virtual Environment in VSCode
Before you can run the code from VSCode,
you need to explicitly specify the path to the Python interpreter on your system.
The same goes for any dependencies your code may have -
you need to tell VSCode where to find them -
much like we did from the command line in the previous episode.
Luckily for us, we have already set up a virtual environment for our project
from the command line
and VSCode is clever enough to understand it.

VSCode detect this environment itself and ask if you wish to use it, if not, click the warning in the lower information bar as shown above, and from the options select the location of the virtual enviroment:

![Select Python interpreter in VSCode](../fig/vscode-select-interpreter.png){: .image-with-shadow width="800px" }

> ## Exercise: Compare External Libraries in the Command Line and PyCharm
> Can you recall two places where information about our project's dependencies
> can be found from the command line?
>
> Hint: We can use an argument to `pip`,
> or find the packages directly in a subdirectory of our virtual environment directory "venv".
>
>> ## Solution
>> From the previous episode,
>> you may remember that we can get the list of packages in the current virtual environment
>> using the `pip3 list` command:
>> ~~~
>> (venv) $ pip3 list
>> ~~~
>> {: .language-bash}
>> ~~~
>> Package         Version
>> --------------- -------
>> cycler          0.11.0
>> fonttools       4.28.1
>> kiwisolver      1.3.2
>> matplotlib      3.5.0
>> numpy           1.21.4
>> packaging       21.2
>> Pillow          8.4.0
>> pip             21.1.3
>> pyparsing       2.4.7
>> python-dateutil 2.8.2
>> setuptools      57.0.0
>> setuptools-scm  6.3.2
>> six             1.16.0
>> tomli           1.2.2
>> ~~~
>> {: .output}
>> However, `pip3 list` shows all the packages in the virtual environment -
>> if we want to see only the list of packages that we installed,
>> we can use the `pip3 freeze` command instead:
>> ~~~
>> (venv) $ pip3 freeze
>> ~~~
>> {: .language-bash}
>> ~~~
>> cycler==0.11.0
>> fonttools==4.28.1
>> kiwisolver==1.3.2
>> matplotlib==3.5.0
>> numpy==1.21.4
>> packaging==21.2
>> Pillow==8.4.0
>> pyparsing==2.4.7
>> python-dateutil==2.8.2
>> setuptools-scm==6.3.2
>> six==1.16.0
>> tomli==1.2.2
>> ~~~
>> {: .output}
>> We see `pip` in `pip3 list` but not in `pip3 freeze` as we did not install it using `pip`.
>> Remember that we use `pip3 freeze` to update our `requirements.txt` file,
>> to keep a list of the packages our virtual environment includes.
>> Python will not do this automatically;
>> we have to manually update the file when our requirements change using:
>> ~~~
>> pip3 freeze > requirements.txt
>> ~~~
>> {: .language-bash}
>>
>> If we want, we can also see the list of packages directly in the following subdirectory of `venv`:
>> ~~~
>> (venv) $ ls -l venv/lib/python3.9/site-packages
>> ~~~
>> {: .language-bash}
>>
>> ~~~
>> total 1088
>> drwxr-xr-x  103 alex  staff    3296 17 Nov 11:55 PIL
>> drwxr-xr-x    9 alex  staff     288 17 Nov 11:55 Pillow-8.4.0.dist-info
>> drwxr-xr-x    6 alex  staff     192 17 Nov 11:55 __pycache__
>> drwxr-xr-x    5 alex  staff     160 17 Nov 11:53 _distutils_hack
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:55 cycler-0.11.0.dist-info
>> -rw-r--r--    1 alex  staff   14519 17 Nov 11:55 cycler.py
>> drwxr-xr-x   14 alex  staff     448 17 Nov 11:55 dateutil
>> -rw-r--r--    1 alex  staff     152 17 Nov 11:53 distutils-precedence.pth
>> drwxr-xr-x   31 alex  staff     992 17 Nov 11:55 fontTools
>> drwxr-xr-x    9 alex  staff     288 17 Nov 11:55 fonttools-4.28.1.dist-info
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:55 kiwisolver-1.3.2.dist-info
>> -rwxr-xr-x    1 alex  staff  216968 17 Nov 11:55 kiwisolver.cpython-39-darwin.so
>> drwxr-xr-x   92 alex  staff    2944 17 Nov 11:55 matplotlib
>> -rw-r--r--    1 alex  staff     569 17 Nov 11:55 matplotlib-3.5.0-py3.9-nspkg.pth
>> drwxr-xr-x   20 alex  staff     640 17 Nov 11:55 matplotlib-3.5.0.dist-info
>> drwxr-xr-x    7 alex  staff     224 17 Nov 11:55 mpl_toolkits
>> drwxr-xr-x   39 alex  staff    1248 17 Nov 11:55 numpy
>> drwxr-xr-x   11 alex  staff     352 17 Nov 11:55 numpy-1.21.4.dist-info
>> drwxr-xr-x   15 alex  staff     480 17 Nov 11:55 packaging
>> drwxr-xr-x   10 alex  staff     320 17 Nov 11:55 packaging-21.2.dist-info
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:53 pip
>> drwxr-xr-x   10 alex  staff     320 17 Nov 11:53 pip-21.1.3.dist-info
>> drwxr-xr-x    7 alex  staff     224 17 Nov 11:53 pkg_resources
>> -rw-r--r--    1 alex  staff      90 17 Nov 11:55 pylab.py
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:55 pyparsing-2.4.7.dist-info
>> -rw-r--r--    1 alex  staff  273365 17 Nov 11:55 pyparsing.py
>> drwxr-xr-x    9 alex  staff     288 17 Nov 11:55 python_dateutil-2.8.2.dist-info
>> drwxr-xr-x   41 alex  staff    1312 17 Nov 11:53 setuptools
>> drwxr-xr-x   11 alex  staff     352 17 Nov 11:53 setuptools-57.0.0.dist-info
>> drwxr-xr-x   19 alex  staff     608 17 Nov 11:55 setuptools_scm
>> drwxr-xr-x   10 alex  staff     320 17 Nov 11:55 setuptools_scm-6.3.2.dist-info
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:55 six-1.16.0.dist-info
>> -rw-r--r--    1 alex  staff   34549 17 Nov 11:55 six.py
>> drwxr-xr-x    8 alex  staff     256 17 Nov 11:55 tomli
>> drwxr-xr-x    7 alex  staff     224 17 Nov 11:55 tomli-1.2.2.dist-info
>> ~~~
>> {: .output}
> {: .solution}
{: .challenge}

#### Adding an External Library
We have already added packages `numpy` and `matplotlib` to our virtual environment
from the command line in the previous episode,
so we are up-to-date with all external libraries we require at the moment.
However, we will need library `pytest` soon to implement tests for our code.
We will use this opportunity to install it from PyCharm in order to see
an alternative way of doing this and how it propagates to the command line.

1. Open a new terminal by going to `Terminal` > `New Terminal`, VSCode will automatically load the virtual environment in this terminal session so we do not need to do this manually.
2. Install `pytest` using `pip` by running:
   ~~~
   $ pip install pytest
   ~~~
   {: .language-bash}

It may take a few minutes for it to be installed.
After it is done, the `pytest` library is added to our virtual environment.
You can also verify this from the command line by
listing the `venv/lib/<python-version>/site-packages` subdirectory.
Note, however, that `requirements.txt` is not updated -
as we mentioned earlier this is something you have to do manually.
Let's do this as an exercise.

> ## Exercise: Update `requirements.txt` After Adding a New Dependency
> Export the newly updated virtual environment into `requirements.txt` file.
>> ## Solution
>> Let's verify first that the newly installed library `pytest` is appearing in our virtual environment
>> but not in `requirements.txt`. First, let's check the list of installed packages:
>> ~~~
>> (venv) $ pip3 list
>> ~~~
>> {: .language-bash}
>> ~~~
>> Package         Version
>> --------------- -------
>> attrs           21.4.0
>> cycler          0.11.0
>> fonttools       4.28.5
>> iniconfig       1.1.1
>> kiwisolver      1.3.2
>> matplotlib      3.5.1
>> numpy           1.22.0
>> packaging       21.3
>> Pillow          9.0.0
>> pip             20.0.2
>> pluggy          1.0.0
>> py              1.11.0
>> pyparsing       3.0.7
>> pytest          6.2.5
>> python-dateutil 2.8.2
>> setuptools      44.0.0
>> six             1.16.0
>> toml            0.10.2
>> tomli           2.0.0
>> ~~~
>> {: .output}
>> We can see the `pytest` library appearing in the listing above. However, if we do:
>> ~~~
>> (venv) $ cat requirements.txt
>> ~~~
>> {: .language-bash}
>> ~~~
>> cycler==0.11.0
>> fonttools==4.28.1
>> kiwisolver==1.3.2
>> matplotlib==3.5.0
>> numpy==1.21.4
>> packaging==21.2
>> Pillow==8.4.0
>> pyparsing==2.4.7
>> python-dateutil==2.8.2
>> setuptools-scm==6.3.2
>> six==1.16.0
>> tomli==1.2.2
>> ~~~
>> {: .output}
>> `pytest` is missing from `requirements.txt`. To add it, we need to update the file by repeating the command:
>> ~~~
>> (venv) $ pip3 freeze > requirements.txt
>> ~~~
>> {: .language-bash}
>> `pytest` is now present in `requirements.txt`:
>> ~~~
>> attrs==21.2.0
>> cycler==0.11.0
>> fonttools==4.28.1
>> iniconfig==1.1.1
>> kiwisolver==1.3.2
>> matplotlib==3.5.0
>> numpy==1.21.4
>> packaging==21.2
>> Pillow==8.4.0
>> pluggy==1.0.0
>> py==1.11.0
>> pyparsing==2.4.7
>> pytest==6.2.5
>> python-dateutil==2.8.2
>> setuptools-scm==6.3.2
>> six==1.16.0
>> toml==0.10.2
>> tomli==1.2.2
>> ~~~
> {: .solution}
{: .challenge}

> ## Virtual Environments & Run Configurations in VSCode
>
> We configured the Python interpreter to use for our project by pointing VSCode
> to the virtual environment we created from the command line
> (which also includes external libraries our code needs to run).
> Recall that you can create several virtual environments based on the same Python interpreter
> but with different external libraries -
> this is helpful when you need to develop different types of applications.
> For example, you can create one virtual environment
> based on Python 3.9 to develop Django Web applications
> and another virtual environment
> based on the same Python 3.9 to work with scientific libraries.
{: .callout}

Now you know how to configure and manipulate your environment in both tools
(command line and PyCharm),
which is a useful parallel to be aware of.
Let's have a look at some other features afforded to us by PyCharm.

### Syntax Highlighting
The first thing you may notice is that code is displayed using different colours.
Syntax highlighting is a feature that displays source code terms
in different colours and fonts according to the syntax category the highlighted term belongs to.
It also makes syntax errors visually distinct.
Highlighting does not affect the meaning of the code itself -
it's intended only for humans to make reading code and finding errors easier.

![Syntax Highlighting Functionality in PyCharm](../fig/vscode-syntax-highlighting.png){: .image-with-shadow width="1000px" }

### Code Completion
As you start typing code,
VSCode will offer to complete some of the code for you in the form of an auto completion popup.
This is a context-aware code completion feature
that speeds up the process of coding
(e.g. reducing typos and other common mistakes)
by offering available variable names,
functions from available packages,
parameters of functions,
hints related to syntax errors,
etc. You can accept these suggestions by hitting the `Tab` key.

![Code Completion Functionality in VSCode](../fig/vscode-autocomplete.png){: .image-with-shadow width="600px" }

### Code Definition & Documentation References
You will often need code reference information to help you code.
VSCode shows this useful information,
such as definitions of symbols
(e.g. functions, parameters, classes, fields, and methods)
and documentation references by means of quick popups and inline tooltips.

For a selected piece of code,
you can access various code reference information by hovering over the function definition,
this includes:

- Type definition of variables, fields or any other symbols
- Inline documentation ([*docstrings*](../15-coding-conventions/index.html#documentation-strings-aka-docstrings)
  for any symbol created in accordance with [PEP-257](https://peps.python.org/pep-0257/)
- Parameter information the names and expected types of parameters in method and function calls.

![Code References Functionality in PyCharm](../fig/vscode-docstring-display.png){: .image-with-shadow width="600px" }

### Code Search
You can search for a text string within a project,
use different scopes to narrow your search process,
use regular expressions for complex searches,
include/exclude certain files from your search, find usages and occurrences.
To find a search string in the whole project:

1. Click on the search icon within the left vertical navigation bar.
2. Type your search string in the search field.
   Alternatively, in the editor, highlight the string you want to find
   and press `Command-Shift-F` (on Mac) or `Control-Shift-F` (on Windows).
   VSCode places the highlighted string into the search field of the search panel.

    ![Code Search Functionality in PyCharm](../fig/vscode-search.png){: .image-with-shadow width="600px" }
    If you need, specify the additional options in the panel.
    VSCode will list the search strings and all the files that contain them.
3. Check the results in the preview area of the dialog where you can replace the search string
   or select another string,
   or press `Command-Shift-F` (on Mac) or `Control-Shift-F` (on Windows) again
   to start a new search.

    ![Code Search Functionality in PyCharm](../fig/vscode-search-example.png){: .image-with-shadow width="1000px" }

### Version Control
VSCode supports a directory-based versioning model,
which means that each project directory can be associated with a different version control system.
Our project was already under Git version control and VSCode recognised it.
It is also possible to add an unversioned project directory to version control directly from VSCode.

During this course,
we will do all our version control commands from the command line
but it is worth noting that VSCode supports a comprehensive subset of Git commands
(i.e. it is possible to perform a set of common Git commands from VSCode but not all).
A very useful version control feature in VSCode is
graphically comparing changes you made locally to a file
with the version of the file in a repository,
a different commit version
or a version in a different branch -
this is something that cannot be done equally well from the text-based command line.

By clicking on the Git icon on the navigation bar you can view any unstaged changes and a complete graph of branches and commits.

You can get a full
[documentation on PyCharm's built-in version control support](https://www.jetbrains.com/help/pycharm/version-control-integration.html)
online.

![Version Control Functionality in PyCharm](../fig/vscode-git.png){: .image-with-shadow width="300px" }

### Running Scripts in VSCode
We have configured our environment and explored some of the most commonly used VSCode features
and are now ready to run our script from VSCode!
To do so, click the `inflammation-analysis.py` file
in the VSCode project/file navigator on the left,
and click the run button at the top right of the screen:

![Running a script from PyCharm](../fig/vscode-run-code.png){: .image-with-shadow width="200px" }

The script will run in a terminal window at the bottom of the IDE window and display something like:

~~~
/Users/alex/work/python-intermediate-inflammation/venv/bin/python /Users/alex/work/python-intermediate-inflammation/inflammation-analysis.py
usage: inflammation-analysis.py [-h] infiles [infiles ...]
inflammation-analysis.py: error: the following arguments are required: infiles

Process finished with exit code 2
~~~
{: .output}

This is the same error we got when running the script from the command line.
We will get back to this error shortly -
for now, the good thing is that we managed to set up our project for development
both from the command line and VSCode and are getting the same outputs.
Before we move on to fixing errors and writing more code,
let's have a look at the last set of tools for collaborative code development
which we will be using in this course - Git and GitHub.

{% include links.md %}
