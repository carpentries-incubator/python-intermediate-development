---
title: 1.7 Optional Exercises
start: no
teaching: 0
exercises: 45
---

::::::::::::::::::::::::::::::::::::::: objectives

- Explore different options for your coding environment.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I further fine-tune my coding environment?

::::::::::::::::::::::::::::::::::::::::::::::::::

This episode has some optional exercises for Section 1.
The exercises have an explorative nature, so feel free to go off in any direction that interests you.
You will be looking at some tools that either complement or are alternatives to those already introduced.
Even if you find something that you really like,
for the sake of following through with the course, we still recommend sticking with the tools that we introduced prior to this episode
and then switching to something else afterwards.

:::::::::::::::::::::::::::::::::::::::  discussion

## Exercise: Apply to your own project(s)

Apply what you learned in this section to your own project(s).
This is the time to ask any questions of your instructors, helpers or fellow learners.
Everyone has different preferences for tooling, so getting input from experienced developers is a great opportunity to learn new things
or different perspectives.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Try out different Integrated Development Environments

Install different Integrated Development Environments (IDEs) and test them out.
Which one do you like the most and why?

Some suggestions to try:

- [Atom](https://atom-editor.cc/)
- [Sublime Text](https://www.sublimetext.com/)
- [RStudio](https://posit.co/download/rstudio-desktop/)

The IDEs listed above are advanced source code editors capable of functioning as IDEs by manually installing plugins 
and add-ons for these tools to obtain more advanced features - such as support for a specific programming language or unit testing.

What do you prefer, a lot of tooling out of the box or a lightweight editor with optional extensions?

If you want an even more lightweight setup you can try out these configurable source code editors:

- [Emacs](https://www.gnu.org/software/emacs/)
- [Vim](https://www.vim.org/)

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Customise the command line tool

You can customise the command line tool or use alternatives to `bash`, such as:

- [Bash Prompt Generator](https://bash-prompt-generator.org/) - it lets you try out different prompts,
  depending on the information you want displayed.
- [z, a simple tool to more quickly move around directories](https://github.com/rupa/z).
- [Z shell (zsh)](https://zsh.sourceforge.io/), a shell designed for interactive use.
- [Oh My ZSH](https://ohmyz.sh/), which is a theming and package manager of the `zsh` terminal.
- [fish](https://fishshell.com/), a smart and user-friendly command line shell.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Try out different virtual environment managers

So far we have used `venv`, but there are other virtual environment managers for Python:

- [Poetry](https://python-poetry.org/), which we will explore using in [Section 4](43-software-release.md).
- `conda`, which is part of [Anaconda Distribution](https://www.anaconda.com/download).

Anaconda is widely used in academia, but the current license does not allow use for research in most circumstances.
An open-source alternative is [mini-forge](https://github.com/conda-forge/miniforge).

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Customise `pylint`

Tell `pylint` to accept the maximum line length of 100 characters instead of the default 80.

Hint: find out different ways in which you can configure `pylint` (e.g. via `pylint` command line interface or its configuration file).

:::::::::::::::  solution

## Solution

### By passing an argument to `pylint` in the command line

Specify the max line length as an argument: `pylint --max-line-length=100`

### Using a configuration file

You can create a file `.pylintrc` in the root of your project folder to overwrite `pylint` settings:

```
[FORMAT]
max-line-length=100
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::




