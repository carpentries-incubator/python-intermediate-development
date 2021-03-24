---
title: "Software Design"
teaching: 70
exercises: 30
questions:
- "Where do we start when beginning a new software project?"
- "How do people use software?"
- "How can we make sure the components of our software are reusable?"
- "What should we do when our requirements change?"
objectives:
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
keypoints:
- "Planning software projects in advance can save a lot of effort later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change."
- "These components can be as small as a single function, or be a software package in their own right."
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

The answers to these questions will provide us with some **design constraints** which any software we write must satisfy.
For example, a design constraint when writing a mobile app would be that it needs to work with a touch screen interface - we might have some software that works really well from the command line, but on a typical mobile phone there isn't a command line interface that people can access.

> ## Types of Software
>
> Many design choices in a software project depend on the environment in which the software is expected to run.
>
> In small groups, discuss some software you are familiar with (could be software you have written yourself or by someone else) and how the environment it is used in have affected its design or development.
> Here are some examples of questions you can use to get started:
>
> - What environment does the software run in?
> - How do people interact with it?
> - Why do people use it?
> - What features of the software have been affected by these factors?
> - If the software needed to be used in a different environment, what difficulties might there be?
>
> Some examples of design / development choices constrained by environment might be:
> - Mobile Apps
>   - Must have graphical interface suitable for a touch display
>   - Usually distributed via controlled app store
>   - Users will not (usually) modify / compile the software themselves
>   - Should work on a range of hardware specifications with range of Operating System (OS) versions
>     - But OS is unlikely to be anything other than Android or iOS
>   - Documentation probably in the software itself or on web page
>   - Typically written in one of the platform prefered languages (e.g. Java, Kotlin, Swift)
> - Embedded Software
>   - May have no user interface - user interface may be physical buttons
>   - Usually distributed pre-installed on physical device
>   - Often runs on low power device with limited memory and CPU performance - must take care to use these resources efficiently
>   - Exact specification of hardware is known - often not necessary to support multiple devices
>   - Documentation probably in technical manual with separate user manual
>   - May need to run continuously for the lifetime of the device
>   - Typically written in a lower-level language (e.g. C) for better control of resources
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

Architecture patterns are similar, but larger scale templates which operate at the level of whole programs, or collections or programs.
Model-View-Controller is one of the best known architecture patterns.

### MVC Revisted

**Model-View-Controller** (MVC) is just one of the common architectural patterns
We've been developing our software using a Model-View-Controller (MVC) architecture so far, but that's not the only choice we could have made.

In fact, we've not strictly been sticking to a formal MVC pattern and have ended up with something maybe a bit more like **Model-View-Presenter** (MVP).
The difference between these is mostly in the amount of work the Controller/Presenter does.
Since our 'Controller' is responsible for some of the data processing, it's really more like a Presenter.

In many cases, the distinction between some of these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

Lets start with adding a view that allows us to get the data for a single patient.
First, we need to add the code for the view itself and make sure our `Patient` class has the necessary data:

~~~
# file: inflammation/views.py

...

def display_patient(patient):
    """Display data for a single patient."""
    print(patient.name)
    print(patient.observations)
~~~
{: .language-python}

~~~
# file: inflammation/models.py

...

class Patient:
    def __init__(self, name, observations=None):
        self.name = name

        if observations is None:
            self.observations = []

        else:
            self.observations = observations

    def add_observation(self, obs):
        self.observations.append(obs)
~~~
{: .language-python}

Now we need to make sure people can call this view - that means connecting it to the controller and ensuring that there's a way to request this view when running the program.
The changes we need to make here are that the `main` function needs to be able to direct us to the view we've requested - and we need to add to the command line interface the necessary data to drive the new view.

~~~
# file: patientdb.py

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
    infiles = args.infiles
    if not isinstance(infiles, list):
        infiles = [args.infiles]

    for filename in infiles:
        inflammation_data = models.load_csv(filename)

        if args.view == 'visualize':
            view_data = {
                'average': models.daily_mean(inflammation_data),
                'max': models.daily_max(inflammation_data),
                'min': models.daily_min(inflammation_data),
            }

            views.visualize(view_data)

        elif args.view == 'record':
            patient = models.Patient('UNKNOWN', inflammation_data[0])
            views.display_patient_record(patient)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='A basic patient data management system')

    parser.add_argument(
        'infiles',
        nargs='+',
        help='Input CSV(s) containing inflammation series for each patient')

    parser.add_argument(
        '--view',
        default='visualize',
        choices=['visualize', 'record'],
        help='Which view should be used?')

    parser.add_argument(
        '--patient',
        type=int,
        default=-1,
        help='Which patient should be displayed?')

    args = parser.parse_args()

    main(args)
~~~
{: .language-python}

We've added two options to our command line interface here: one to request a specific view and one for the patient id that we want to lookup.
For the full range of features that we have access to with `argparse` see the [Python module documentation](https://docs.python.org/3/library/argparse.html?highlight=argparse#module-argparse).
Allowing the user to request a specific view like this is a similar model to that used by the popular Python library Click - if you find yourself needing to build more complex interfaces than this, Click would be a good choice.
You can find more information in [Click's documentation](https://click.palletsprojects.com/en/7.x/).

For now, we also don't know the names of any of our patients, so we've made it `'UNKNOWN'` until we get more data.

We can now call our program with these extra arguments to see the record for a single patient:

~~~
python patientdb.py --view record --patient 1 data/inflammation-01.csv
~~~
{: .language-bash}

~~~
UNKNOWN
[ 0.  0.  1.  3.  1.  2.  4.  7.  8.  3.  3.  3. 10.  5.  7.  4.  7.  7.
 12. 18.  6. 13. 11. 11.  7.  7.  4.  6.  8.  8.  4.  4.  5.  7.  3.  4.
  2.  3.  0.  0.]
~~~
{: .output}

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

Our patient data system so far can read in some data, process it, and display it to people.
What's missing?

Well, at the moment, if we wanted to add a new patient or perform a new observation, we would have to edit the input CSV file by hand.
We might not want our staff to have to manage their patients by making changes to the data by hand, but rather provide the ability to do this through the software.
That way we can perform any necessary validation or transformation before the data gets accepted.

There's a few ways we could do this, but lets start with extending what we have already - the CSV file.

If we want to bring in this data, modify it somehow, and save it back to a file, we'd need to:

- Add the data import / export (**persistence**) code to our Model
- Write some views we can use to modify the data
- Link it all together in the controller

This new code we're adding to the Model is our **Persistence Layer**.
By adding it to the Model, it's not really a new layer being added, but since we're keeping it separate from the View and Controller code we can still get away with using the name.

### Databases

A **database** is an organised collection of data, usually organised in some way to mimic the structure of the entities it represents.
There are several major families of database model, but the dominant form is the **relational database**.

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

While relational databases are typically accessed using **SQL queries**, we're going to use a library to help us translate between Python and the database.
SQLAlchemy is a popular Python library which contains an **Object Relational Mapping** (ORM) framework.

Our first step is to install SQLAlchemy, then we can create our first **mapping**.

```
conda install sqlalchemy
```
{: .language-bash}

A mapping is the core component of an ORM - it's this that describes how to convert between our Python classes and the contents of our database tables.
Typically, we can take our existing classes and convert them into mappings with a little modification, so we don't have to start from scratch.

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
        if 'observations' in kwargs:
            self.observations = kwargs['observations']
~~~
{: .language-python}

Now that we've defined how to translate between our Python class and a database table, we need to hook our code up to an actual database.

The library we're using, SQLAlchemy, does everything through a database **engine**.
This is essentially a wrapper around the real database, so we don't have to worry about which particular database software is being used - we just need to write code for a generic relational database.

For these lessions we're going to use the SQLite engine as this requires almost no configuration and no external software.
Most relational database software runs as a separate service which we can connect to from our code.
This means that in a large scale environment, we could have the database and our software running on different computers - we could even have the database spread across several servers if we have particularly high demands for performance or reliability.
Some examples of databases which are used like this are PostgreSQL, MySQL and MSSQL.

On the other hand, SQLite runs entirely within our software and uses only a single file to hold its data.
It won't give us the extremely high performance or reliability of a properly configured PostgreSQL database, but it's good enough in many cases and much less work to get running.

Lets write some test code to setup and connect to an SQLite database.
For now we'll store the database in memory rather than an actual file - it won't actually allow us to store data after the program finishes, but it allows us not to worry about **migrations**.

> ## Migrations
>
> When we make changes to our mapping (e.g. adding / removing columns), we need to get the database to update its tables to make sure they match the new format.
> This is what the `Base.metadata.create_all` method does - creates all of these tables from scratch because we're using an in-memory database which we know will be removed between runs.
>
> If we're actually storing data persistently, we need to make sure that when we change the mapping, we update the database tables without damaging any of the data they currently contain.
> We could do this manually, by running SQL queries against the tables to get them into the right format, but this is error-prone and can be a lot of work.
>
> In practice, we generate a migration for each change.
> Tools such as [Alembic](https://alembic.sqlalchemy.org/en/latest/) will compare our mappings to the known state of the database and generate a Python file which updates the database to the necessary state.
>
> Migrations can be quite complex, so we won't be using them here - but you may find it useful to read about them later.
{: .callout}

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
    self.assertEqual(queried_patient.name, 'Alice')
    self.assertEqual(queried_patient.id, 1)

    # Wipe our temporary database
    Base.metadata.drop_all(engine)
~~~
{: .language-python}

For this test, we've imported our models inside the test function, rather than at the top of the file like we normally would.
This is not recommended in normal code, as it means we're paying the performance cost of importing every time we run the function, but can be useful in test code.
Since each test function only runs once per test session, this performance cost isn't as important as a function we were going to call many times.
Additionally, if we try to import something which doesn't exist, it will fail - by imporing inside the test function, we limit this to that specific test failing, rather than the whole file failing to run.

### Relationships

Relational databases don't typically have an 'array of numbers' column type, so how are we going to represent our observations of our patients' inflammation?
Well, our first step is to create a table of observations.
We can then use a **foreign key** to point from the observation to a patient, so we know which patient the data belongs to.
The table also needs a column for the actual measurement - we'll call this `value` - and a column for the day the measurement was taken on.

We can also use the ORM's `relationship` helper function to allow us to go between the observations and patients without having to do any of the complicated table joins manually.

~~~
from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

...

class Observation(Base):
    __tablename__ = 'observations'

    id = Column(Integer, primary_key=True)
    day = Column(Integer)
    value = Column(Integer)
    patient_id = Column(Integer, ForeignKey('patients.id'))

    patient = relationship('Patient', back_populates='observations')


class Patient(Base):
    __tablename__ = 'patients'

    id = Column(Integer, primary_key=True)
    name = Column(String)

    observations = relationship('Observation',
                                order_by=Observation.day,
                                back_populates='patient')

~~~
{: .language-python}

> ## Time is Hard
>
> We're using an integer field to store the day on which a measurement was taken.
> This keeps us consistent with what we had previously as it's essentialy the position of the measurement in the numpy array.
> It also avoids us having to worry about managing actual date / times.
>
> The Python `datetime` module we've used previously in the Academics example would be useful here, and most databases have support for 'date' and 'time' columns, but to reduce the complexity, we'll just use integers here.
{: .callout}

Our test code for this is going to look very similar to our previous test code, so we can copy-paste it and make a few changes.
This time, after setting up the database, we need to add a patient and an observation.
We then test that we can get the observations from a patient we've searched for.

~~~
# file: tests/test_models.py

...

def test_sqlalchemy_observations():
    """Test that we can save and retrieve inflammation observations from a database."""
    from inflammation.models import Base, Observation, Patient

    # Setup a database connection - we're using a database stored in memory here
    engine = create_engine('sqlite:///:memory:', echo=True)
    Session = sessionmaker(bind=engine)
    session = Session()
    Base.metadata.create_all(engine)

    # Save a patient to the database
    test_patient = Patient(name='Alice')
    session.add(test_patient)

    test_observation = Observation(patient=test_patient, day=0, value=1)
    session.add(test_observation)

    queried_patient = session.query(Patient).filter_by(name='Alice').first()
    first_observation = queried_patient.observations[0]
    self.assertEqual(first_observation.patient, queried_patient)
    self.assertEqual(first_observation.day, 0)
    self.assertEqual(first_observation.value, 1)

    # Wipe our temporary database
    Base.metadata.drop_all(engine)
~~~
{: .language-python}

Finally, let's put in a way to convert all of our observations into a numpy array, so we can use our previous analysis code.
We'll use the `property` decorator here again, to create a method that we can use as if it was a normal data attribute.

~~~
# file: inflammation/models.py

...

class Patient(Base):
    __tablename__ = 'patients'

    id = Column(Integer, primary_key=True)
    name = Column(String)

    observations = relationship('Observation',
                                order_by=Observation.day,
                                back_populates='patient')

    @property
    def values(self):
        """Convert inflammation data into numpy array."""
        last_day = self.observations[-1].day
        values = np.zeros(last_day + 1)

        for observation in self.observations:
            values[observation.day] = observation.value

        return values
~~~
{: .language-python}

Once again we'll copy-paste the test code and make some changes.
This time we want to create a few observations for our patient and test that we can turn them into a numpy array.

~~~
# file: tests/test_models.py

def test_sqlalchemy_observations_to_array():
    """Test that we can save and retrieve inflammation observations from a database."""
    from inflammation.models import Base, Observation, Patient

    # Setup a database connection - we're using a database stored in memory here
    engine = create_engine('sqlite:///:memory:')
    Session = sessionmaker(bind=engine)
    session = Session()
    Base.metadata.create_all(engine)

    # Save a patient to the database
    test_patient = Patient(name='Alice')
    session.add(test_patient)

    for i in range(5):
        test_observation = Observation(patient=test_patient, day=i, value=i)
        session.add(test_observation)

    queried_patient = session.query(Patient).filter_by(name='Alice').first()
    npt.assert_array_equal([0, 1, 2, 3, 4], queried_patient.values)

    # Wipe our temporary database
    Base.metadata.drop_all(engine)
~~~
{: .language-python}

> ## Further Array Testing
>
> There's an important feature of the behaviour of our `Patient.values` property that's not currently being tested.
> What is this feature?
> Write one or more extra tests to cover this feature.
>
> > ## Hint
> >
> > The `Patient.values` property creates an array of zeroes, then fills it with data from the table.
> > If a measurement was not taken on a particular day, that day's value will be left as zero.
> >
> > If this is intended behaviour, it would be useful to write a test for it, to ensure that we don't break it in future.
> > Using tests in this way is known as **regression testing**.
> >
> {: .solution}
{: .challenge}

> ## Refactoring for Reduced Redundancy
>
> You've probably noticed that there's a lot of replicated code in our database tests.
> It's fine if some code is replicated a bit, but if you keep needing to copy the same code, that's a sign it should be refactored.
>
> Refactoring is the process of changing the structure of our code, without changing its behaviour, and one of the main benefits of good test coverage is that it makes refactoring easier.
> If we've got a good set of tests, it's much more likely that we'll detect any changes to behaviour - even when these changes might be in the tests themselves.
>
> Try refactoring the database tests to see if you can reduce the amount of replicated code by moving it into one or more functions at the top of the test file.
>
{: .challenge}

> ## Advanced Challenge: Connecting More Views
>
> We've added the ability to store patient records in the database, but not actually connected it to any useful views.
> There's a common pattern in data management software which is often refered to as **CRUD** - Create, Read, Update, Delete.
> These are the four fundamental views that we need to provide to allow people to manage their data effectively.
>
> Each of these applies at the level of a single record, so for both patients and observations we should have a view to: create a new record, show an existing record, update an existing record and delete an existing record.
> It's also sometimes useful to provide a view which lists all existing records for each type - for example, a list of all patients would probably be useful, but a list of all observations might not be.
>
> Pick one (or several) of these views to implement - you may want to refer back to the section where we added our initial patient read view.
{: .challenge}

> ## Advanced Challenge: Managing Dates Properly
>
> Try converting our existing models to use actual dates instead of just a day number.
> The Python [datetime module documentation](https://docs.python.org/3/library/datetime.html) and SQLAlchemy [Column and Data Types page](https://docs.sqlalchemy.org/en/13/core/type_basics.html) will be useful to you here.
>
{: .challenge}

{% include links.md %}
