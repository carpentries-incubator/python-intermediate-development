---
title: "Additional Material: Using Microsoft Visual Studio Code"
---

## Installation

VSCode is available from the project website [here](https://code.visualstudio.com/download).
Users on Ubuntu can install the program via the package manager:

~~~
sudo apt install code
~~~
{: .language-bash}

### Extensions

As an IDE VSCode can be used for many programming languages
provided the appropriate extensions have been installed.
For this workshop we will require the Python extensions,
to install extensions click the icon below in the sidebar:

![extensions_icon](../fig/extensions.png)

Search "python" and select the result for the Intellisense extension created by Microsoft.
Click "Install" to install the extension, you may be asked to also reload the window.

![ext_python](../fig/python_ext.png)

You are now ready to code!

## Using the VSCode IDE

Let's open our project in VSCode now
and familiarise ourselves with some commonly used features.

### Opening a Software Project

Create a directory in a location of your choice which will be your main project folder.

If you don't have VSCode running yet, start it up now.
Select `File` > `Open Folder` and navigate to the directory you created.


### Configuring a Virtual Environment in VSCode

As in the episode
[_Virtual Environments For Software Development_]({{ page.root }}{% link _episodes/12-virtual-environments.md %}),
we now want to create a virtual environment we can work in.
Go to `Terminal` > `New Terminal` to open a new terminal session within the project directory,
and run the command to create a new environment:

~~~
python3 -m venv venv
~~~
{: .language-bash}

this will create a new folder `venv`.
VSCode will notice the new environment
and ask if you want to use it as the default Python interpreter for this project,
click "Yes":

![use_env](../fig/use_env.png)

---

#### Troubleshooting Setting the Interpreter

If the prompt did not appear, you can manually set the interpreter.
Firstly navigate to the location of the `python` binary within the virtual environment
using the file browser side bar (see below),
this will be located at `<virtual environment directory>/bin/python`.
Right click on the binary and select `Copy Path`.

Then using the keyboard shortcut `CTRL-SHIFT-P` to bring up the command palette,
and searching for `Python: Select Interpreter`,
clicking `Enter interpreter path...`
and pasting the address followed by Enter.

---

You can verify the setup has worked correctly by
creating an empty Python script in the project folder.
Right click on the file explorer side bar and select `New File`,
create a name for the file ensuring it ends in `.py`.

![file_browser](../fig/file_explorer.png)

If everything is setup correctly you should see
the interpreter stated in the blue information bar at the bottom of your VSCode window:

![indicator](../fig/virtual_env_indicator.png)

Right click the file you created and select `Delete` to remove it.

Any terminal you now open will start with the virtual environment already activated.

### Adding Dependencies

For this workshop you will need to
install `pytest`, `numpy` and `matplotlib`,
start a new terminal to activate the environment
and run:

~~~
pip install numpy matplotlib pytest
~~~
{: .language-bash}

---

#### Troubleshooting Dependencies

If you are having issues with `pip` it may be your version is too old.
Pip will usually inform you via a warning if a newer version is available,
upgrade pip by running:

~~~
pip install --upgrade pip
~~~
{: .language-bash}

before installing packages.

---

## Running Scripts in VSCode

To run a script in VSCode,
open the script by clicking on it
and then either click the Play icon in the top right corner,
or use the keyboard shortcut `CTRL-ALT-N`.

![run_code](../fig/play.png)

## Adding a Linter in VSCode

In [the episode on coding style]({{ page.root }}{% link _episodes/15-coding-conventions.md %})
and [the subsequent episode on linters]({{ page.root }}{% link _episodes/16-verifying-code-style-linters.md %}),
you are asked to use an automatic feature in PyCharm
that picks up linting issues with the source code.
Because it is language agnostic, VSCode does not have a linter for Python built into it.
Instead, you will need to install an extension to get linting hints.
Get to the "Extensions" side pane by one of these actions:

1. Bring up the command palette with `CTRL-SHFT-P`, search for `View: Show Extensions`
1. Use the direct keyboard shortcut `CTRL-SHFT-X`
1. Click on the "Extensions" logo on the left side panel
   (it looks like three connected blocks with a fourth block floating separately)

Type pylint into the search bar, and then click on `Install` in the result that comes up.
The application window should look something like this:

![VSCode Extensions Installation](../fig/vscode-install-linter-extension-annotated.png)

Once installed, warnings should automatically populate the "Problems" panel
at the bottom of your window.
You can bring up the "Problems" panel with the shortcut `CTRL-SHFT-M`.
Your application window will look something like this:

![VSCode Problems Panel](../fig/vscode-linter-problems-pane-annotated.png)

There are other Python linters available, like `flake8`.
Similarly, there are formatters like `black`.
All are available as extensions which you can get by repeating the steps above
but searching for the different names in the "Extensions" pane.

We also recommend that you install these linters and formatters in your virtual environment,
since then you will be able to run them from the command line as well.
For example, if you want `pylint` and `black`, simply execute this on the command line:

~~~bash
pip3 install pylint black
~~~

They will now each be available to run as command line applications,
and you will find the details of how to run `pylint` in the lesson material.

## Running Tests

In addition VSCode also allows you to run tests from a dedicated test viewer.
Clicking the laboratory flask icon in the sidebar allows you to set up test exploration:

![test_explore](../fig/test_explorer.png)

Click `Configure Python Tests`,
select `pytest` as the test framework,
and the `tests` directory as the directory for searching.

You should now be able to run tests individually
using the test browser and selecting the test of interest.

![test_demo](../fig/run_test.png)

### Running in Debug

When clicking on a test you will see two icons,
the ordinary Play icon, and an icon with a bug.
The latter allows you to run the tests in debug mode
useful for obtaining further information as to why a failure has occurred.
