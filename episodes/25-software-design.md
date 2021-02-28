---
title: "Software Design"
teaching: 90
exercises: 0
questions:
- "Where do we start when beginning a new software project?"
- "How do people use software?"
- "How can we make sure the components of our software are reusable?"
- "What should we do when our requirements change?"
objectives:
- "Describe some of the different categories of software and explain how the requirements of each category may differ"
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
- "Consider issues which contribute to the usability of a piece of software"
keypoints:
- "Planning software projects in advance can save a lot of effort later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change."
- "When writing software used for research, requirements *always* change."
---

As a piece of software grows, it will reach a point where there's too much code for you to keep in mind at once.
At this point, it becomes particularly important that the software be designed sensibly.

It's not easy come up with a complete definition for the term **software design**, but some of the common aspects are:

- **Algorithm design** - What method are we going to use to solve the core business problem?
- **Software architecture** - What components will the software have and how will they cooperate?
- **System architecture** - What other things will this software have to interact with and how?
- **UI/UX** (User Interface / User Experience) - How will users interact with the software?

As usual, the sooner you adopt a practice in the lifecycle of your project, the easier it will be.
So we should think about the design of our software from the very beginning - ideally even before we start writing code.

## Types of Software

Before we start writing code, we would like to have a reasonable idea of who will be using our software and what they want it to do.

This is often difficult, particularly when developing software for research, because the users and their needs can change with very little warning.
Maybe we have an idea for a new research project that could use our existing code, or maybe a research group at another institution wants to use it to support their work in a slightly different environment.

Despite this potential for change, there are a few characteristics of a piece of software which tend to remain fixed.
Some of the most important questions you should ask when beginning a new software project are:

- Where does it run?
- How do you interact with it?
- Why do you use it?

> ## Types of Software
>
> Many design choices in a software project depend on the environment in which the software is expected to run.
>
> How many different software environments can you think of?
> In small groups, discuss some of these environments and how aspects of each one might impact the design or development choices of the software running there.
>
> Some examples might be:
> - Mobile Apps
>   - Must have graphical interface suitable for a touch display
>   - Usually distributed via controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications with range of Operating System versions
>   - Documentation probably in software itself or on web page
>   - Typically written in one of the platform prefered languages (e.g. Java, Swift)
> - Embedded Software
>   - May have no user interface - user interface may be physical buttons
>   - Usually distributed pre-installed on physical device
>   - Often runs on low power device with limited memory and CPU performance - must take care to use these resources efficiently
>   - Exact specification of hardware is known - often not necessary to support multiple devices
>   - Documentation probably in technical manual with separate user manual
>   - May need to run continuously for the lifetime of the device
>   - Typically written in a lower-level language (e.g. C) for better control of resources
>
> Again in small groups, discuss some software you are familiar with (could be software you have written yourself or by someone else).
> Use the three questions to explain the environment in which the software is intended to be used.
>
> What features of the software have been affected by these factors?
> If the software needed to be used in a different environment, what difficulties might there be?
>
> > ## Some More Examples
> > - Desktop Application
> >   - Has graphical interface for use with mouse and keyboard
> >   - May need to work on multiple, very different Operating Systems
> >   - May be intended for users to modify / compile themselves
> >   - Should work on wide range of hardware configurations
> >   - Documentation probably either in manual or in software itself
> > - Command-line Application - UNIX Tool
> >   - User interface is text based, probably via command-line arguments
> >   - Intended to be modified / compiled by users - though most will choose not to
> >   - Documentation has standard formats - also accessible from command-line
> >   - Should be usable as part of a pipeline
> > - Command-line Application - High Performance Computing
> >   - Similar to UNIX Tool
> >   - Usually supports running across multiple networked machines simultaneously
> >   - Usually operated via scheduler - interface should be scriptable
> >   - May need to run on wide range of hardware (e.g. different CPU architectures)
> >   - May need to process large amounts of data
> >   - Often entirely or partially written in a lower-level language for performance (e.g. C, C++, Fortran)
> > - Web Application
> >   - Usually has components which run on server and components which run on the user's device
> >   - Graphical interface should usually support both Desktop and Mobile devices
> >   - Clientside component should run on range of browsers and Operating Systems
> >   - Documentation probably part of the software itself
> >   - Clientside component typically written in JavaScript
> {: .solution}
{: .challenge}


## Software Architecture

At the beginning of this episode we defined **Software Architecture** with the question, "what components will the software have and how will they cooperate?"
Software engineering borrowed this term, and a few other terms, from architects (of buildings) as many of the processes and techniques have some similarities.

One of the other important terms we borrowed is **'Pattern'**, such as in **Design Patterns** and **Architecture Patterns**.
This term is often attributed to the book 'A Pattern Language' by Christopher Alexander *et al* published in 1977 and refers to a template solution to a problem commonly encountered when building a system.

Design patterns are relatively small-scale templates which we can use to solve problems which affect a small part of our software.
For example, the Adapter pattern may be useful if part of our software needs to consume data from a number of different external data sources.
Using this pattern, we can create a component whose responsibility is transforming the calls for data to the expected format, so the rest of our program doesn't have to worry about it.

Architecture patterns are large-scale templates which operate at the level of whole programs, or collections or programs.
Model-View-Controller is one of the best known architecture patterns.

### MVC Revisted

**Model-View-Controller** (MVC) is just one of the common architectural patterns
We've been developing our software using a Model-View-Controller (MVC) architecture so far, but that's not the only choice we could have made.

In fact, we've not strictly been sticking to a formal MVC pattern and have ended up with something actually a bit more like **Model-View-Presenter** (MVP).
The difference between these is mostly in the amount of work the Controller/Presenter does.
Since our 'Controller' is responsible for some of the data processing, it's really more like a Presenter.

In many cases, the distinction between some of these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

### Multilayer Architecture

Another common architectural pattern is **Multilayer Architecture**.
Software designed using a this architecture pattern is split into layers, each of which is responsible for a different part of the process of manipulating data.

Often, the software is split into three layers:

- **Presentation Layer**
  - This layer is responsible for managing the interaction between our software and the people using it
  - Similar to the **View** component in the MVC pattern
- **Application Layer / Business Logic Layer**
  - This layer performs most of the data processing required by the presentation layer
  - Could be in any part of an MVC-style architecture, but most commonly the **Model**
- **Persistence Layer / Data Access Layer**
  - This layer handles data storage and provides data to the rest of the system
  - Has some overlap with the MVC **Model**

### The Persistence Layer

Our patient management system so far can read in some data, process it, and display it to people.
What's missing?

Well, at the moment, if we wanted to add a new patient or perform a new observation, we would have to edit the input CSV file by hand.
We might not want our staff to have to manage their patients by making changes to the data by hand, but rather provide some the ability to do this through the software.
That way we can perform any necessary validation or transformation before the data gets accepted.

There's a few ways we could do this, but lets start with extending what we have already - the CSV file.

If we want to bring in this data, modify it somehow, and save it back to a file, we'll need to:

- Add the data import / export (**persistence**) code to our Model
- Write some Views we can use to modify the data
- Link it all together in the controller

This new code we're adding to the Model is our **Persistence Layer**.
By adding it to the Model, it's not really a new layer being added, but since we're keeping it separate from the View and Controller code we can still get away with using the name.


### Databases

Now for a real persistence layer

A **database** is an organised collection of data, usually organised in some way to mimic the structure of the entities it represents, and the software which supports
There are several major families of database model, but the dominant model form is the **relational database**.

Relational databases focus on describing the relationships between entities in the data, similar to the object oriented paradigm.
The key concepts in a relational database are:

Tables
: Within a database we can have multiple tables - each table usually represents all entities of a single type.
: e.g. We might have a `patients` table to represent all of our patients.

Columns / Fields
: Each table has columns - each column has a name and holds data of a specific type
: e.g. We might have a `name` column in our `patients` table which holds text data representing the names of our patients.

Rows
: Each table has rows - each row represents a single entity and has a value for each field.
: e.g. Each row in our `patients` table represents a single patient - the value of the `name` field in this row is our patient's name.

Primary Keys
: Each row has a primary key - this is a unique ID that can be used to select this from from the data.
: e.g. Each patient might have a `patient_id` which can be used to distinguish two patients with the same name.

Foreign Keys
: A relationship between two entities is described using a foreign key - this is a field which points to the primary key of another row / table.
: e.g. Each patient might have a foreign key field called `doctor` pointing to a row in a `doctors` table representing the doctor responsible for them - i.e. this doctor *has a* patient.

> ## SQLAlchemy
>
> For more information, see SQLAlchemy's [ORM tutorial](https://docs.sqlalchemy.org/en/13/orm/tutorial.html).
>
{: .callout}

Our first step is to create a **mapping**.
A mapping is the core component of an ORM - it's this that describes how to convert between our Python classes and the contents of our database tables.
Typically, we can take our existing classes and convert the into mappings, so we don't have to start from scratch.

~~~
# file: inflammation/models.py
from sqlalchemy import Column, create_engine, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

...

class Patient(Base):
    __tablename__ = 'patients'

    id = Column(Integer, primary_key=True)
    name = Column(String)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.observations = []
~~~
{: .language-python}

Now that we've defined how to translate between our Python class and a database table, we need to hook our code up to an actual database.

The library we're using, SQLAlchemy, does everything through a database **engine**.
This is essentially a wrapper around the real database, so we don't have to worry about which particular database software we're using - we just need to write code for a generic relational database.

For these lessions we're going to use the SQLite engine as this requires almost no configuration and no external software.
Most relational database software runs as a separate service which we can connect to from our code.
This means that in a large scale environment, we could have the database and our software running on different computers - we could even have the database spread across several servers if we have particularly high demands for performance or reliability.
Some examples of databases which are used like this are PostgreSQL, MySQL and MSSQL.

On the other hand, SQLite runs entirely within our software and uses only a single file to hold its data.
It won't give us the extremely high performance or reliability of a properly configured PostgreSQL database, but it's good enough in many cases and much less work to get running.

Lets write some test code to setup and connect to an SQLite database:

~~~
# file: tests/test_models.py

...

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

...

def test_sqlalchemy_patient_search():
    """Test that we can save and retrieve patient data from a database."""
    from inflammation.models import Base, Patient

    # Setup a database connection - we're using a database stored in memory here
    engine = create_engine('sqlite:///:memory:', echo=True)
    Session = sessionmaker(bind=engine)
    session = Session()
    Base.metadata.create_all(engine)

    # Save a patient to the database
    test_patient = Patient(name='Alice')
    session.add(test_patient)

    # Search for a patient by name
    queried_patient = session.query(Patient).filter_by(name='Alice').first()
    assert queried_patient.name == 'Alice'
    assert queried_patient.id == 1

    # Wipe our temporary database
    Base.metadata.drop_all(engine)
~~~
{: .language-python}

## Software Systems

- How should software interact with users?
- How should software interact with other software?
   - Piping in and out


{% include links.md %}
