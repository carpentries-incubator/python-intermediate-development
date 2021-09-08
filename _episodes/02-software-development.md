---
title: "Introduction to Software Design and Development"
teaching: 20
exercises: 10
questions:
- "Why is splitting code into smaller functional units (modules) good when designing software?"
- "What is Model-View-Controller design architecture?"
objectives:
- "Use Git to obtain a working copy of our template software project from GitHub"
- "Understand Model-View-Controller (MVC) architecture in software design and its use in our project"

keypoints:
- "Programming interfaces define how individual modules within a software application interact among themselves or
how the application itself interacts with its users."
- "MVC is a software design architecture which divides the application into three interconnected modules: Model (data),
View (user interface), and Controller (input/output and data manipulation)."
- "The software project template we use throughout this workshop is an example of an MVC application that manipulates
patients’ inflammation data and performs basic statistical analysis using Python."
---

## Our Software Project
So, you have joined a software development team that has been working on the [patient inflammation project](https://github.com/softwaresaved/python-intermediate-inflammation) developed in Python and stored on GitHub. 
The software project studies inflammation in patients 
who have been given a new treatment for arthritis and reuses the inflammation dataset from the [novice Software Carpentry Python lesson](https://swcarpentry.github.io/python-novice-inflammation/index.html). The project is not finished - you will be working on in 
collaboration with others and building on top of the existing code during the workshop. 
The first thing to do is to obtain a local copy of the project on 
your machine and inspect it. 

To create your own copy of the software project repository from GitHub:

1. Log into your GitHub account and go to the [template repository URL](https://github.com/softwaresaved/python-intermediate-inflammation).
![template-repository](../fig/template-repository.png)
2. Click `Use this template` button towards the top right of the template repository's GitHub page to create a **copy** of
the repository under your GitHub account. Note that each participant is creating their own copy to work on. Also,
we are not forking the directory but creating a copy (remember - you can fork only once but can have multiple copies in GitHub).
3. Make sure to select your personal account and set the name of the project to `python-intermediate-inflammation` (you can call it
anything you like, but it may be easier if everyone uses the same name). Also set the new repository's visibility to
'Public' - so it can be seen by other attendees  of the workshop and by third-party Continuous Integration (CI) services (to be covered later on in the lesson).
![copy-template-repository](../fig/copy-template-repository.png)
4. Click the `Create repository from template` button and wait for GitHub to import the copy of the repository under your account.
5. At this point GitHub may ask you to authenticate. If this happens and
you do not have 2-Factor-Authentication (2FA) enabled in your
GitHub account, you can just enter your password to proceed. If you are using 2FA, you may get a message:
"Your old project requires credentials for read-only access. We will only temporarily store them for importing." and
should use a pre-generated personal access token as your password here.
6. Locate the copied repository under your own GitHub account.
![github-template-repository](../fig/own-template-repository.png)

> ## Obtain the Software Project Locally
> Using a command line shell, clone the copied repository from your GitHub account  into your computer.
> Which command(s) would you use to get a detailed list of contents of the directory you have just cloned?
> > ## Solution
> > 1. Find the URL of the software project repository to clone from your GitHub account. Make sure you do not clone the
>original template repository but rather your own copy, as you should be able to push commits to it later on.
> > 2. Do:
> > `git clone https://github.com/<YOUR_GITHUB_USERNAME>/python-intermediate-inflammation`
> > 3. Navigate into the cloned repository in your command line shell:
> > `cd python-intermediate-inflammation`
> > 4. List the contents of the directory:
> > `ls -l`
> > Remember the `-l` flag of the `ls` command and also how to get help for commands in shell: `man ls`.
> {: .solution}
>
{: .challenge}

### Our Software Project Structure
Let’s inspect the content of the software project from the command line. From the root directory of the project, you can
 use the command `ls -l` to get a more detailed list of the contents. You should see something similar to the following.

~~~
$ ls -l
total 24
-rw-r--r--   1 carpentry  users  1055 20 Apr 15:41 README.md
drwxr-xr-x  18 carpentry  users   576 20 Apr 15:41 data
drwxr-xr-x   5 carpentry  users   160 20 Apr 15:41 inflammation
-rw-r--r--   1 carpentry  users  1122 20 Apr 15:41 inflammation-analysis.py
drwxr-xr-x   4 carpentry  users   128 20 Apr 15:41 tests
~~~
{: .language-bash}

As can be seen from the above, our software project contains the `README` file (that typically describes the project, 
its usage, installation, authors and how to contribute), Python script `inflammation-analysis.py`, 
and three directories - `inflammation`, `data` and `tests`. The Python script `inflammation-analysis.py` provides the main
entry point in the application - we will have a more detailed look into it shortly. 
On closer inspection, we can see that the `inflammation` directory contains two more Python scripts - 
`view.py` and `model.py`.

~~~
$ ls -l inflammation
total 24
-rw-r--r--  1 alex  staff  838 29 Jun 09:59 models.py
-rw-r--r--  1 alex  staff  649 25 Jun 13:13 views.py
~~~
{: .language-bash}

Directory `data` contains several files with patients’ daily inflammation information. 

~~~
$ ls -l data  
total 264
-rw-r--r--  1 alex  staff   5365 25 Jun 13:13 inflammation-01.csv
-rw-r--r--  1 alex  staff   5314 25 Jun 13:13 inflammation-02.csv
-rw-r--r--  1 alex  staff   5127 25 Jun 13:13 inflammation-03.csv
-rw-r--r--  1 alex  staff   5367 25 Jun 13:13 inflammation-04.csv
-rw-r--r--  1 alex  staff   5345 25 Jun 13:13 inflammation-05.csv
-rw-r--r--  1 alex  staff   5330 25 Jun 13:13 inflammation-06.csv
-rw-r--r--  1 alex  staff   5342 25 Jun 13:13 inflammation-07.csv
-rw-r--r--  1 alex  staff   5127 25 Jun 13:13 inflammation-08.csv
-rw-r--r--  1 alex  staff   5327 25 Jun 13:13 inflammation-09.csv
-rw-r--r--  1 alex  staff   5342 25 Jun 13:13 inflammation-10.csv
-rw-r--r--  1 alex  staff   5127 25 Jun 13:13 inflammation-11.csv
-rw-r--r--  1 alex  staff   5340 25 Jun 13:13 inflammation-12.csv
-rw-r--r--  1 alex  staff  22554 25 Jun 13:13 python-novice-inflammation-data.zip
-rw-r--r--  1 alex  staff     12 25 Jun 13:13 small-01.csv
-rw-r--r--  1 alex  staff     15 25 Jun 13:13 small-02.csv
-rw-r--r--  1 alex  staff     12 25 Jun 13:13 small-03.csv
~~~
{: .language-bash}

The data is stored in
a series of comma-separated values (CSV) format files, where:

- each row holds temperature measurements for a single patient (in some arbitrary units of inflammation),
- columns represent successive days.

You can inspect the data files from the command line by issuing command `cat`, e.g. do `cat data/inflammation-01.csv` 
from the project root to check the contents of the first inflammation file.

Directory `tests` contains several tests that have been implemented already. We will be adding more tests 
during the workshop as our code grows.

An important thing to note here is that the structure of the project is not arbitrary. 
One of the big differences between novice and intermediate software development is planning the structure of your code.
A novice will often make up the structure of their code as they go along. However, for more advanced software development,
we need to plan this structure - called a *software architecture* - beforehand. Let's have a more detailed look
into what a software architecture is and which architecture is used by our software project before we 
start adding more code to it.

## Software Architecture
A software architecture is the fundamental structure of a software system that is decided at the beginning of
project development and cannot be changed that easily once implemented. It refers to a "bigger picture" of
a software system that describes high-level components (modules) of the system and how they interact.

In software design and development, large systems or programs are often decomposed into a set of smaller
modules each with a subset of functionality. Typical examples of modules in programming are software libraries;
some software libraries, such as `numpy` and `matplotlib` in Python, are bigger modules that contain several
smaller sub-modules. Another example of modules are classes in object-oriented programming languages.

> ## Programming Modules and Interfaces
> Although modules are self-contained and independent elements to a large extent (they can depend on other modules),
> there are well-defined ways of how they interact with one another. These rules of
> interaction are called **programming interfaces** - they define how other modules (clients)
> can use a particular module. Typically, an interface to a module includes rules on how a module can take input from
> and how it gives output back to its clients. A client can be a human, in which case we also call these user
> interfaces. Even smaller functional units such as functions/methods have clearly defined interfaces - a
> function/method’s definition (also known as a *signature*) states what parameters it can take as input and what
> it returns as an output.
>
{: .callout}

There are various software architectures around defining different ways of dividing the code into smaller modules
with well defined roles, for example:

- [Model–View–Controller (MVC) architecture](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller), which we will look into in detail and use for our software project,
- [Service-Oriented Architecture (SOA)](https://en.wikipedia.org/wiki/Service-oriented_architecture), which separates code into distinct services,
accessible over a network by consumers (users or other services) that communicate with each other by passing data in a well-defined, shared format (protocol),
- [Client-Server architecture](https://en.wikipedia.org/wiki/Client%E2%80%93server_model), where clients request content or service from a server, initiating communication sessions with servers, which await incoming requests (e.g. email, network printing, the Internet),
- [Multilayer architecture](https://en.wikipedia.org/wiki/Multitier_architecture), is a type of architecture in which presentation, application processing and data management functions are split into distinct layers and may event be physically separated to run on separate machines - some more detail on this later in the course.

### Model-View-Controller (MVC) Architecture
MVC architecture divides the related program
logic into three interconnected modules:

- **Model** (data)
- **View** (client interface),  and
- **Controller** (processes that handle input/output and manipulate the data).

**Model** represents the data used by a program and also contains operations/rules for manipulating and changing the data
in the model.
This may be a database, a file, a single data object or a series of objects - for example a table representing
patients' data.

**View** is the means of displaying data to users/clients within an application (i.e. provides visualisation of the
state of the model).
For example, displaying a window with input fields and buttons (Graphical User Interface, GUI) or textual options
within a command line shell (Command Line Interface, CLI) are examples of Views.
They include anything that the user can see from the application. While building GUIs is not the topic of this workshop,
we will cover building CLIs in Python in later episodes.

**Controller** manipulates both the **Model** and the **View**. It accepts input from the **View** and performs the corresponding
action on the **Model** (changing the state of the model) and then updates the **View** accordingly. For example, on user
request, **Controller** updates a picture on a user's GitHub profile and then modifies the **View** by displaying the
updated profile back to the user.

#### MVC Examples

MVC architecture can be applied in scientific applications in the following manner. Model comprises those parts of the application that deal with some type of
scientific processing or manipulation of the data, e.g. numerical algorithm, simulation, DNA. View is
a visualisation, or format, of the output, e.g. graphical plot, diagram, chart, data table, file.
Controller is the part that ties the scientific processing and output parts together, mediating input and passing
it to the model or view, e.g. command line options, mouse clicks, input files. For example, diagram below 
depicts the use of MVC architecture for the [DNA Guide Graphical User Interface application](https://www.software.ac.uk/developing-scientific-applications-using-model-view-controller-approach).
 
![MVC example of a DNA Guide Graphical User Interface application](../fig/mvc-DNA-guide-GUI.png){: width="400px"}
{% comment %}Image from https://www.software.ac.uk/developing-scientific-applications-using-model-view-controller-approach{% endcomment %}

> ## MVC Application Examples From your Work
> Think of some other examples from your work or life where MVC architecture may be suitable or have a discussion
> with your fellow learners. 
> > ## Solution 
> > MVC architecture is a popular choice when designing web and mobile applications.
> > Users interact with a web/mobile application by sending various requests to it.
> > Forms to collect users inputs/requests together with the info returned and displayed to the user as a 
> > result represent the View. Requests are processed by the Controller, which interacts with the Model to retrieve or 
> > update the underlying data.
> > For example, a user may request to view its profile. 
> > The Controller retrieves the account information for the user from the Model and passes it to
> > the View for rendering. The user may further interact with the application by asking it to update its personal information. 
> > Controller verifies the correctness of the information (e.g. the password satisfies certain criteria,
> > postal address and phone number are in the correct format, etc.) and
> > passes it to the Model for permanent storage. The View is then updated accordingly and the user sees its updated profile details.
> >         
> > Note that not everything fits into the MVC architecture but it is still good to think 
> > about how things could be split into smaller units. 
> > For a few more examples, have a look at this short [article on MVC from CodeAcademy](https://www.codecademy.com/articles/mvc).
> {: .solution}
{: .challenge}

> ## Separation of Concerns
> Separation of concerns is important when designing software architectures in order to reduce the code's complexity.
> Note, however, there are limits to everything - and MVC architecture is no exception. Controller often transcends
> into Model and View and a clear separation is sometimes difficult to maintain. For example, Command Line Interface
> provides both the View (what user sees and how they interact with the shell) and the Controller (invoking of a command)
> aspects of a CLI application. In Web applications, Controller often manipulates the data (received from the Model)
> before displaying it to the user or passing it from the user to the Model.
>
{: .callout}

#### Our Project's MVC Architecture 

Our software project uses the MVC architecture. The file `inflammation-analysis.py` is the **Controller** module that performs 
basic statistical analysis over data and provides the main
entry point into the application through the function called `main()` (as you can see from its listing below). 

~~~
#!/usr/bin/env python3
"""Software for managing patient data in our imaginary hospital."""

import argparse

from inflammation import models, views


def main(args):
    """The MVC Controller of the patient data system.

    The Controller is responsible for:
    - selecting the necessary models and views for the current task
    - passing data between models and views
    """
    InFiles = args.infiles
    if not isinstance(InFiles, list):
        InFiles = [args.infiles]


    for filename in InFiles:
        inflammation_data = models.load_csv(filename)

        view_data = {'average': models.daily_mean(inflammation_data), 
                    'max': models.daily_max(inflammation_data), 
                    'min': models.daily_min(inflammation_data)}

        views.visualize(view_data)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='A basic patient data management system')

    parser.add_argument(
        'infiles',
        nargs='+',
        help='Input CSV(s) containing inflammation series for each patient')

    args = parser.parse_args()

    main(args)
~~~          
{: .language-python}

The **View** and **Model** modules are contained 
in the files `view.py` and `model.py`, respectively, and are conveniently named. Data underlying the **Model** is contained within
the directory `data` - as we have seen already it contains several files with patients’ daily inflammation information. 

We will revisit the software architecture topic once again in a [later episode](../index/25-software-design) when we talk in more detail 
about software design. We now proceed to set up our virtual development environment and start working with the code using 
a more convenient graphical tool - IDE PyCharm.

{% include links.md %}
