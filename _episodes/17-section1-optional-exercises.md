---
title: "Optional exercises for section 1"
start: false
teaching: 0
exercises: 45
questions:
- "How can I further finetune my coding environment?"
objectives:
- "Explore different options for your coding environment."
keypoints:
---

This episode holds some optional exercises for section 1. 
The exercises have an explorative nature, so see what you like to explore.
For the remainder of the lesson we recommend sticking with the tools that were introduced in this section.

> ## Exercise: Try out different Integrated Development Environments
> Install different Integrated Development Environments (IDEs) and thest them out.
> Which one do you like the most and why?
> You can try: 
> - [Visual Studio Code](https://code.visualstudio.com/)
> - [Atom](https://atom-editor.cc/)
> - [Sublime Text](https://www.sublimetext.com/)
> 
{: .challenge}

> ## Exercise: Customize the command line
> You can customize the command line to make yourself more productive.
> - Try out [z](https://github.com/rupa/z), a simple tool to more quickly move around directories.
> - Try out [Oh My ZSH](https://ohmyz.sh/), customize the look and feel of your terminal.
> 
{: .challenge}

> ## Exercise: Try out different virtual environment managers
> So far we used `venv`, but there are other virtual environment managers for Python:
> - [Poetry](https://python-poetry.org/).
> - [conda (part of Anaconda Distribution)](https://www.anaconda.com/download)
> 
{: .challenge}

> ## Exercise: Customize `pylint`
> You decide to change the max line length of your project to 100 instead of the default 80. 
> Find out how you can configure pylint. You can first try to use the pylint command line interface, 
> but also play with adding a configuration file that pylint reads in.
>
>> ## Solution
>> ### By passing an argument to `pylint` in the command line
>> Specify the max line length as an argument: `pylint --max-line-length=100
>>
>> ### Using a configuration file
>> You can create .pylintrc file in your python script to overwrite pylint settings and put inside
>> ```
>> [FORMAT]
>> max-line-length=100
>> ```
> {: .solution}
{: .challenge}




{% include links.md %}
