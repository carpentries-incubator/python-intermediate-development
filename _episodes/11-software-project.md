---
title: "Introduction to Our Software Project"
teaching: 20
exercises: 10
questions:
- "What is the design architecture of our example software project?"
- "Why is splitting code into smaller functional units (modules) good when designing software?"
objectives:
- "Use Git to obtain a working copy of our software project from Bitbucket."
- "Inspect the structure and architecture of our software project."
- "Understand Model-View-Controller (MVC) architecture in software design and its use in our project."

keypoints:
- "Programming interfaces define how individual modules within a software application interact among themselves or
how the application itself interacts with its users."
- "MVC is a software design architecture which divides the application into three interconnected modules: Model (data),
View (user interface), and Controller (input/output and data manipulation)."
- "The software project we use throughout this course is an example of an MVC application that manipulates
patients’ inflammation data and performs basic statistical analysis using Python."
---

## Patient Inflammation Study Project
So, you have joined a software development team that has been working on the [patient inflammation study project](https://github.com/carpentries-incubator/python-intermediate-inflammation) 
developed in Python and stored on GitHub. The project analyses the data to study the effect of a new 
treatment for arthritis by analysing the inflammation levels in patients who have been given this treatment. 
It reuses the inflammation datasets from the 
[Software Carpentry Python novice lesson](https://swcarpentry.github.io/python-novice-inflammation/index.html).

![Snapshot of the inflammation dataset](../fig/inflammation-study-pipeline.png){: .image-with-shadow width="800px" }
<p style="text-align: center;">Inflammation study pipeline from the <a href="https://swcarpentry.github.io/python-novice-inflammation/fig/lesson-overview.svg">Software Carpentry Python novice lesson</a></p>

> ## What Does Patient Inflammation Data Contain?
> 
> Each dataset records inflammation measurements from a separate clinical trial of the drug, and each dataset contains information for 60 patients, who had their inflammation levels recorded for 40 days whilst participating in the trial (a snapshot of one of the data files is shown in diagram above).
> 
> Each of the data files uses the popular [comma-separated (CSV) format](https://en.wikipedia.org/wiki/Comma-separated_values) to represent the data, where:
>
> - Each row holds inflammation measurements for a single patient,
> - Each column represents a successive day in the trial,
> - Each cell represents an inflammation reading on a given day for a patient (in some arbitrary units of inflammation measurement).
{: .callout}

The project is not finished and contains some errors. You will be working on your own and in collaboration with others to fix and build on top of the existing code during the course.

## Downloading Our Software Project

To start working on the project, you will first create a fork of the software project repository from 
Bitbucket within your own Bitbucket account and then obtain a local copy of that project (from your Bitbucket) on your machine.
If you have not forked this repository yet: https://bitbucket.org/svenvanderburg1/python-intermediate-inflammation/src/main/
please do so now!

> ## Exercise: Obtain the Software Project Locally
> Using the command line, clone the copied repository from your Bitbucket account into the home directory on your computer using SSH.
> Which command(s) would you use to get a detailed list of contents of the directory you have just cloned?
> > ## Solution
> > 1. Find the SSH URL of the software project repository to clone from your Bitbucket account. Make sure you do not clone the
original template repository but rather your own copy, as you should be able to push commits to it later on. Also 
make sure you select the **SSH tab** and not the **HTTPS** one - you'll be able to clone with HTTPS, but not to send your changes back to Bitbucket!
> > 2. Make sure you are located in your home directory in the command line with:
> >     ~~~
> >     $ cd ~
> >     ~~~
> >     {: .language-bash}
> > 3. From your home directory in the command line, do:
> >     ~~~
> >     $ git clone <YOUR_REPO_URL>
> >     ~~~
> >     {: .language-bash}
> > Make sure you are cloning your copy of the software project and not the template repository.
> >
> > 4. Navigate into the cloned repository folder in your command line with:
> >     ~~~
> >     $ cd python-intermediate-inflammation
> >     ~~~
> >     {: .language-bash}
> > Note: If you have accidentally copied the **HTTPS** URL of your repository instead of the SSH one, you can easily fix that from
> > your project folder in the command line with:
> >     ~~~ 
> >     $ git remote set-url origin <YOUR_REPO_URL>
> >     ~~~
> >     {: .language-bash}
> {: .solution}
{: .challenge}

### Our Software Project Structure
Let’s inspect the content of the software project from the command line. From the root directory of the project, you can
 use the command `ls -l` to get a more detailed list of the contents. You should see something similar to the following.

~~~
$ cd ~/python-intermediate-inflammation
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
and three directories - `inflammation`, `data` and `tests`.

The Python script `inflammation-analysis.py` provides the main
entry point in the application, and on closer inspection, we can see that the `inflammation` directory contains two more Python scripts -
`views.py` and `models.py`. We will have a more detailed look into these shortly.

~~~
$ ls -l inflammation
total 24
-rw-r--r--  1 alex  staff   71 29 Jun 09:59 __init__.py
-rw-r--r--  1 alex  staff  838 29 Jun 09:59 models.py
-rw-r--r--  1 alex  staff  649 25 Jun 13:13 views.py
~~~
{: .language-bash}

Directory `data` contains several files with patients’ daily inflammation information (along with some other files):

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

As [previously mentioned](#what-is-the-format-of-the-data), each of the inflammation data files contains separate trial data for 60 patients over 40 days.

> ## Exercise: Have a Peek at the Data
> Which command(s) would you use to list the contents or a first few lines of `data/inflammation-01.csv` file?
> > ## Solution
> > 1. To list the entire content of a file from the project root do: `cat data/inflammation-01.csv`.
> > 2. To list the first 5 lines of a file from the project root do: `head -n 5 data/inflammation-01.csv`.
> >
> > ~~~
> 0,0,1,3,2,3,6,4,5,7,2,4,11,11,3,8,8,16,5,13,16,5,8,8,6,9,10,10,9,3,3,5,3,5,4,5,3,3,0,1
> 0,1,1,2,2,5,1,7,4,2,5,5,4,6,6,4,16,11,14,16,14,14,8,17,4,14,13,7,6,3,7,7,5,6,3,4,2,2,1,1
> 0,1,1,1,4,1,6,4,6,3,6,5,6,4,14,13,13,9,12,19,9,10,15,10,9,10,10,7,5,6,8,6,6,4,3,5,2,1,1,1
> 0,0,0,1,4,5,6,3,8,7,9,10,8,6,5,12,15,5,10,5,8,13,18,17,14,9,13,4,10,11,10,8,8,6,5,5,2,0,2,0
> 0,0,1,0,3,2,5,4,8,2,9,3,3,10,12,9,14,11,13,8,6,18,11,9,13,11,8,5,5,2,8,5,3,5,4,1,3,1,1,0
> > ~~~
> >{: .output}
> {: .solution}
{: .challenge}

Directory `tests` contains several tests that have been implemented already. We will be adding more tests
during the course as our code grows.

An important thing to note here is that the structure of the project
is not arbitrary. One of the big differences between novice and intermediate software development is
planning the structure of your code. This structure includes software components and behavioural interactions between
them (including how these components are laid out in a directory and file structure).
A novice will often make up the structure of their code as they go along. However, for more advanced software development,
we need to plan this structure - called a *software architecture* - beforehand.

Let's have a more detailed look
into what a software architecture is and which architecture is used by our software project before we
start adding more code to it.

## Software Architecture
A software architecture is the fundamental structure of a software system that is decided at the beginning of
project development based on its requirements and cannot be changed that easily once implemented. It refers to a "bigger picture" of
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
- [Service-oriented architecture (SOA)](https://en.wikipedia.org/wiki/Service-oriented_architecture), which separates code into distinct services,
accessible over a network by consumers (users or other services) that communicate with each other by passing data in a well-defined, shared format (protocol),
- [Client-server architecture](https://en.wikipedia.org/wiki/Client%E2%80%93server_model), where clients request content or service from a server, initiating communication sessions with servers, which await incoming requests (e.g. email, network printing, the Internet),
- [Multilayer architecture](https://en.wikipedia.org/wiki/Multitier_architecture), is a type of architecture in which presentation, application processing and data management functions are split into distinct layers and may even be physically separated to run on separate machines - some more detail on this later in the course.

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
within a command line (Command Line Interface, CLI) are examples of Views.
They include anything that the user can see from the application. While building GUIs is not the topic of this course,
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
it to the model or view, e.g. command line options, mouse clicks, input files. For example, the diagram below
depicts the use of MVC architecture for the [DNA Guide Graphical User Interface application](https://www.software.ac.uk/developing-scientific-applications-using-model-view-controller-approach).

![MVC example of a DNA Guide Graphical User Interface application](../fig/mvc-DNA-guide-GUI.png){: .image-with-shadow width="400px" }
{% comment %}Image from https://www.software.ac.uk/developing-scientific-applications-using-model-view-controller-approach{% endcomment %}

> ## Exercise: MVC Application Examples From your Work
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
> into Model and View and a clear separation is sometimes difficult to maintain. For example, the Command Line Interface
> provides both the View (what user sees and how they interact with the command line) and the Controller
> (invoking of a command)
> aspects of a CLI application. In Web applications, Controller often manipulates the data (received from the Model)
> before displaying it to the user or passing it from the user to the Model.
>
{: .callout}

#### Our Project's MVC Architecture

Our software project uses the MVC architecture. The file `inflammation-analysis.py` is the **Controller** module that
performs basic statistical analysis over patient data and provides the main
entry point into the application. The **View** and **Model** modules are contained
in the files `views.py` and `models.py`, respectively, and are conveniently named. Data underlying the **Model** is
contained within the directory `data` - as we have seen already it contains several files with patients’ daily inflammation information.

We will revisit the software architecture and MVC topics once again in later episodes
when we talk in more detail about software's [business/user/solution requirements](../31-software-requirements/index.html)
and [software design](../32-software-design/index.html). We now proceed to set up our virtual development environment 
and start working with the code using a more convenient graphical tool - [IDE PyCharm](https://www.jetbrains.com/pycharm/).

{% include links.md %}
