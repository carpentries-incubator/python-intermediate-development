---
title: 1.7 Optional Exercises for Section 1
start: no
teaching: 0
exercises: 45
---

::::::::::::::::::::::::::::::::::::::: objectives

- Explore different options for your coding environment.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I further finetune my coding environment?

::::::::::::::::::::::::::::::::::::::::::::::::::

This episode holds some optional exercises for section 1.
The exercises have an explorative nature, so feel free to go off in any direction that interests you.
You will be looking at some tools that either complement or are alternatives to those already introduced.
Even if you find something that you really like,
we still recommend sticking with the tools that were introduced prior to this episode when you move onto other sections of the course.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Apply to your own project(s)

Apply what you learned in this section to your own project(s).
This is the time to ask any questions to your instructors or helpers.
Everyone has different preferences for tooling, so getting the input of experienced developers is a great opportunity.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Try out different Integrated Development Environments

Install different Integrated Development Environments (IDEs) and test them out.
Which one do you like the most and why?

You can try:

- [Visual Studio Code](https://code.visualstudio.com/), with setup instructions [in the Extras of this course](../learners/vscode.md)
- [Atom](https://atom-editor.cc/)
- [Sublime Text](https://www.sublimetext.com/)
- [RStudio](https://posit.co/download/rstudio-desktop/)

Technically, compared to PyCharm, the 'IDEs' listed above are source code editors capable of functioning as an IDE
(with RStudio as an example).
To function as an IDE, you have to manually install plugins for more powerful features
such as support for a specific programming language or unit testing.
What do you prefer, a lot of tooling out of the box or a lightweight editor with optional extensions?

If you want an even more lightweight setup you can try out these configurable source code editors:

- [Emacs](https://www.gnu.org/software/emacs/)
- [Vim](https://www.vim.org/)

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Customize the command line

You can customize the command line or use alternatives to `bash` to make yourself more productive.

- Try out [Bash Prompt Generator](https://bash-prompt-generator.org/), it lets you try out different prompts,
  depending on the information you want displayed.
- Try out [z, a simple tool to more quickly move around directories](https://github.com/rupa/z).
- Try out [Z shell (zsh)](https://zsh.sourceforge.io/), a shell designed for interactive use.
- Try out [Oh My ZSH](https://ohmyz.sh/), which is a theming and package manager of the `zsh` terminal.
- Try out [fish](https://fishshell.com/), a smart and user-friendly command line shell.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Try out different virtual environment managers

So far we used `venv`, but there are other virtual environment managers for Python:

- [Poetry](https://python-poetry.org/), which we will explore using in
  [Section 4](43-software-release.md).
- conda, which is part of [Anaconda Distribution)](https://www.anaconda.com/download).

Anaconda is widely used in academia, but the current license does not allow use for research in most circumstances.
An open-source alternative is [mini-forge](https://github.com/conda-forge/miniforge).

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Customize `pylint`

You decide to change the max line length of your project to 100 instead of the default 80.
Find out how you can configure pylint. You can first try to use the pylint command line interface,
but also play with adding a configuration file that pylint reads in.

:::::::::::::::  solution

## Solution

### By passing an argument to `pylint` in the command line

Specify the max line length as an argument: `pylint --max-line-length=100`

### Using a configuration file

You can create a file `.pylintrc` in the root of your project folder to overwrite pylint settings:

```
[FORMAT]
max-line-length=100
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::




