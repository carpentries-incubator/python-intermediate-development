---
title: "Object Oriented Programming"
teaching: 30
exercises: 20
questions:
- "How can we use code to describe the structure of data?"
- "How should the relationships between structures be described?"
objectives:
- "Describe the core concepts that define the object oriented paradigm"
- "Use classes to encapsulate data within a more complex program"
- "Structure concepts within a program in terms of sets of behaviour"
- "Identify different types of relationship between concepts within a program"
- "Structure data within a program using these relationships"
keypoints:
- "Object oriented programming is a programming paradigm based on the concept of classes, which encapsulate data and code."
- "Classes allow us to organise data into distinct concepts."
- "By breaking down our data into classes, we can reason about the behaviour of parts of our data."
- "Relationships between concepts can be described using inheritance (*is a*) and composition (*has a*)."
---
   
## Introduction

Object oriented programming is a programming paradigm based on the concept of objects, which are data structures that 
contain (encapsulate) data and code. Data is encapsulated in the form of fields (attributes) of objects, 
while code is encapsulated in the form of procedures (methods) that manipulate objects' attributes and define "behaviour"
of objects. So, in object oriented programming, we first think about the data and the things that we’re modelling - and represent these by objects - rather than define the logic of the program, and code becomes a series of interactions 
between objects. 

## Structuring Data

One of the main difficulties we encounter when building more complex software is how to structure our data.
So far, we've been processing data from a single source and with a simple tabular structure, but it would be useful to be able to combine data from a range of different sources and with more data than just an array of numbers.

~~~
data = pd.DataFrame([[1., 2., 3.], [4., 5., 6.]],
                     index=['FP35','FP56'])
~~~
{: .language-python}

Using this data structure has the advantage of being able to use Pandas and NumPy operations to process the data, and Matplotlib to plot it, but often we need to have more structure than this.

For example, the measurement data we are interested in has a hierarchy of situational information: each data set is recorded by a particular instrument, in a particular measurement site, in a particular catchment area. This structure can be captured using Pandas MultiIndexes, for example:
~~~
location_measurement = [
    ("FP", "FP35", "Rainfall"),
    ("FP", "FP56", "River Level"),
    ("PL", "PL23", "River Level"),
    ("PL", "PL23", "Water pH")
]
index_names = ["Catchment", "Site", "Measurement"]
index = pd.MultiIndex.from_tuples(location_measurement,names=index_names)

data = [
    [0., 2., 1.],
    [30., 29., 34.],
    [34., 32., 33.],
    [7.8, 8., 7.9]
]

pd.DataFrame(data,index=index)
~~~
{: .language-python}
~~~
                               0     1     2
Catchment Site Measurement                  
FP        FP35 Rainfall      0.0   2.0   1.0
          FP56 River Level  30.0  29.0  34.0
PL        PL23 River Level  34.0  32.0  33.0
               Water pH      7.8   8.0   7.9
~~~
{: .output}

However, we may need to attach more information about the sites and store this alongside our measurement data. Or we might want to store the data from different sites or instruments at different frequencies. These requirements are more difficult to accomodate within a Pandas DataFrame, and would require the use of extra data structures, or lead to messy data frames. 

Instead, we can do this using the Python data structures we're already familiar with, dictionaries and lists. For instance, we could attach an identifier to the measurements from each site:

~~~
measurement_data = [
    {
        'site': 'FP35',
        'measurement': 'Rainfall'
        'data': [0.0, 2.0, 1.0],
    },
    {
        'site': 'FP56',
        'measurement': 'River level'
        'data': [30.0, 29.0, 34.0],
    },
]
~~~
{: .language-python}

> ## Exercise: Structuring Data
>
> Write a function, called `attach_sites`, which can be used to attach IDs to our measurement dataset.
> When used as below, it should produce the expected output.
>
> If you're not sure where to begin, think about ways you might be able to effectively loop over two collections at once.
> Also, don't worry too much about the data type of the `data` value, it can be a Python list, a NumPy array, or a Pandas DataFrame - any is fine.
>
> ~~~
> data = np.array([[34., 32., 33.],
>                  [7.8, 8.0, 7.9]])
>
> output = attach_information(data, ['PL23', 'PL23'], ['River Level', 'pH'])
> print(output)
> ~~~
> {: .language-python}
>
> ~~~
> [
>     {
>         'site': 'PL23',
>         'measurement': 'River Level',
>         'data': [34., 32., 33.],
>     },
>     {
>         'site': 'PL23',
>         'measurement': 'pH',
>         'data': [7.8, 8.0, 7.9],
>     },
> ]
> ~~~
> {: .output}
>
> > ## Solution
> >
> > One possible solution, perhaps the most obvious, is to use the `range` function to index into all three lists at the same location:
> >
> > ~~~
> > def attach_information(data, sites, measurements):
> >     """Create datastructure containing data from a range of sites
> >        and instruments."""
> >     output = []
> >
> >     for i in range(len(data)):
> >         output.append({'site': sites[i],
> >                        'measurement': measurements[i],
> >                        'data': data[i]})
> >
> >     return output
> > ~~~
> > {: .language-python}
> >
> > However, this solution has a potential problem that can occur sometimes, depending on the input.
> > What might go wrong with this solution?  How could we fix it?
> >
> > > ## A Better Solution
> > >
> > > What would happen if the `data`, `measurements`, and/or `sites` inputs were different lengths?
> > >
> > > If `sites` or `measurements` is longer, we'll loop through, until we run out of rows in the `data` input, at which point we'll stop processing the last few names.
> > > If `data` is longer, we'll loop through, but at some point we'll run out of sites or measurements - but this time we try to access part of the list that doesn't exist, so we'll get an exception.
> > >
> > > A better solution would be to use the `zip` function, which allows us to iterate over multiple iterables without needing an index variable.
> > > The `zip` function also limits the iteration to whichever of the iterables is smaller, so we won't raise an exception here, but this might not quite be the behaviour we want, so we'll also explicitly `assert` that the inputs should be the same length.
> > > Checking that our inputs are valid in this way is an example of a precondition, which we introduced conceptually in an earlier episode.
> > >
> > > If you've not previously come across the `zip` function, read [this section](https://docs.python.org/3/library/functions.html#zip) of the Python documentation.
> > >
> > > ~~~ python
> > > def attach_names(data, sites, measurements):
> > >     """Create datastructure containing measurement data from a range of sites."""
> > >     assert len(data) == len(names)
> > >     assert len(data) == len(measurements)
> > >     output = []
> > >
> > >     for data_row, measurement, site in zip(data, measurements, sites):
> > >         output.append({'site': site,
> > >                        'measurement': measurement,
> > >                        'data': data_row})
> > >
> > >     return output
> > > ~~~
> > > {: .language-python}
> > {: .solution}
> {: .solution}
{: .challenge}

## Classes in Python

Using nested dictionaries and lists should work for some of the simpler cases where we need to handle structured data, but they get quite difficult to manage once the structure becomes a bit more complex.
For this reason, in the object oriented paradigm, we use **classes** to help with managing this data and the operations we would want to perform on it.
A class is a **template** (blueprint) for a structured piece of data, so when we create some data using a class, we can be certain that it has the same structure each time.

With our list of dictionaries we had in the example above, we have no real guarantee that each dictionary has the same structure, e.g. the same keys (`site` and `data`) unless we check it manually.
With a class, if an object is an **instance** of that class (i.e. it was made using that template), we know it will have the structure defined by that class.

Different programming languages make slightly different guarantees about how strictly the structure will match, but in object oriented programming this is one of the core ideas - all objects derived from the same class must follow the same behaviour.

You may not have realised, but you should already be familiar with some of the classes that come bundled as part of Python, for example:

~~~
my_list = [1, 2, 3]
my_dict = {1: '1', 2: '2', 3: '3'}
my_set = {1, 2, 3}

print(type(my_list))
print(type(my_dict))
print(type(my_set))
~~~
{: .language-python}

~~~
<class 'list'>
<class 'dict'>
<class 'set'>
~~~
{: .output}

Lists, dictionaries and sets are a slightly special type of class, but they behave in much the same way as a class we might define ourselves:

- They each hold some data (**attributes** or **state**).
- They also provide some methods describing the behaviours of the data - what can the data do and what can we do to the data?

The behaviours we may have seen previously include:

- Lists can be appended to
- Lists can be indexed 
- Lists can be sliced 
- Key-value pairs can be added to dictionaries
- The value at a key can be looked up in a dictionary
- The union of two sets can be found (the set of values present in any of the sets)
- The intersection of two sets can be found (the set of values present in all of the sets)

## Encapsulating Data

Let's start with a minimal example of a class representing a measurement site.

~~~ python
# file: catchment/models.py

class Site:
    def __init__(self, name):
        self.name = name
        self.measurements = {}
~~~
{: .language-python}
        
~~~
from catchment.models import Site

FP35 = Site('FP35')
print(FP35.name)
~~~
{: .language-python}

~~~
FP35
~~~
{: .output}

Here we've defined a class with one method: `__init__`.
This method is the **initialiser** method, which is responsible for setting up the initial values and structure of the data inside a new instance of the class - this is very similar to **constructors** in other languages, so the term is often used in Python too.
The `__init__` method is called every time we create a new instance of the class, as in `Site('FP35')`.
The argument `self` refers to the instance on which we are calling the method and gets filled in automatically by Python - we don't need to provide a value for this when we call the method.

Data encapsulated within our Site class includes the name of the site and a dictionary of measurement datasets. In 
the initialiser method, we set a site's name to the value provided, and create a dictionary of measurement datasets for
the site (initially empty). Such data is also referred to
as the attributes of a class and holds the current state of an instance of the class. Attributes are typically
hidden (encapsulated) internal object details ensuring that access to data is protected from unintended changes. They
are manipulated internally by the class, which, in addition, can expose certain functionality as public behavior of the class to
allow other objects to interact with this class' instances.

## Encapsulating Behaviour

In addition to representing a piece of structured data (e.g. a site which has a name and a dictionary of measurement data), a class can also provide a set of functions, or **methods**, which describe the **behaviours** of the data encapsulated in the instances of that class. To define the behaviour of a class we add functions which operate on the data the class contains. These functions are the member functions or methods.

Methods on classes are the same as normal functions, except that they live inside a class and have an extra first parameter `self`.
Using the name `self` is not strictly necessary, but is a very strong convention - it is extremely rare to see any other name chosen.
When we call a method on an object, the value of `self` is automatically set to this object - hence the name.
As we saw with the `__init__` method previously, we do not need to explicitly provide a value for the `self` argument, this is done for us by Python.

Let's add another method on our Site class that adds a new measurement dataset to a Site instance.

~~~
# file: catchment/models.py

class Site:
    """A measurement site in the study."""
    def __init__(self, name):
        self.name = name
        self.measurements = {}

    def add_measurement(self, measurement_id, data):
        if measurement_id in self.measurements.keys():
            self.measurements[measurement_id] = \
                    pd.concat([self.measurements[measurement_id], data])
        
        else:
            self.measurements[measurement_id] = data
            self.measurements[measurement_id].name = measurement_id

~~~
{: .language-python}

~~~
from catchment.models import Site
import pandas as pd
import datetime

FP35 = Site('FP35')
print(FP35)

rainfall_data = pd.Series(
    [0.0,2.0,1.0],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3)
        ]
    )

FP35.add_measurement('Rainfall',rainfall_data)

print(FP35.measurements.keys())
print(FP35.measurements['Rainfall'])

~~~
{: .language-python}

~~~
<__main__.Site object at 0x7fada93d0820>
dict_keys(['Rainfall'])
2000-01-01  0.0
2000-01-02  2.0
2000-01-03  1.0
Name: Rainfall, dtype: float64
~~~
{: .output}

Note here that we have created a `pandas.Series` object, rather than a `pandas.DataFrame` 
object, to contain our measurement data, and that we are setting the `name` of each series to match the `measurement_id`. DataFrames can be considered to be a collection of series, each containing separate data. Our `Site` object replaces the dataframe for this purpose, later we will show you how to combine the series objects into dataframes again, using the series `name` that we set here.


> ## Class and Static Methods
>
> Sometimes, the function we're writing doesn't need access to any data belonging to a particular object.
> For these situations, we can instead use a **class method** or a **static method**.
> Class methods have access to the class that they're a part of, and can access data on that class - but do not belong to a specific instance of that class, whereas static methods have access to neither the class nor its instances.
>
> By convention, class methods use `cls` as their first argument instead of `self` - this is how we access the class and its data, just like `self` allows us to access the instance and its data.
> Static methods have neither `self` nor `cls` so the arguments look like a typical free function.
> These are the only common exceptions to using `self` for a method's first argument.
>
> Both of these method types are created using **decorators** - for more information see the [classmethod](https://docs.python.org/3/library/functions.html#classmethod) and [staticmethod](https://docs.python.org/3/library/functions.html#staticmethod) decorator sections of the Python documentation.
{: .callout}

### Dunder Methods

Why is the `__init__` method not called `init`?
There are a few special method names that we can use which Python will use to provide a few common behaviours, each of which begins and ends with a **d**ouble-**under**score, hence the name **dunder method**.

When writing your own Python classes, you'll almost always want to write an `__init__` method, but there are a few other common ones you might need sometimes. You may have noticed in the code above that the method `print(FP35)` returned `<__main__.Site object at 0x7fada93d0820>`, which is the string represenation of the `FP35` object. We 
may want the print statement to display the object's name instead. We can achieve this by overriding the `__str__` method of our class.

~~~
# file: catchment/models.py

class Site:
    """A measurement site in the study."""
    def __init__(self, name):
        self.name = name
        self.measurements = {}

    def add_measurement(self, measurement_id, data):
        if measurement_id in self.measurements.keys():
            self.measurements[measurement_id] = \
                    pd.concat([self.measurements[measurement_id], data])
        
        else:
            self.measurements[measurement_id] = data
            self.measurements[measurement_id].name = measurement_id

    def __str__(self):
        return self.name

~~~
{: .language-python}

~~~
from catchment.models import Site

FP35 = Site('FP35')
print(FP35)
~~~
{: .language-python}

~~~
FP35
~~~
{: .output}

These dunder methods are not usually called directly, but rather provide the implementation of some functionality we can use - we didn't call `FP35.__str__()`, but it was called for us when we did `print(FP35)`.
Some we see quite commonly are:

- `__str__` - converts an object into its string representation, used when you call `str(object)` or `print(object)`
- `__getitem__` - Accesses an object by key, this is how `list[x]` and `dict[x]` are implemented
- `__len__` - gets the length of an object when we use `len(object)` - usually the number of items it contains

There are many more described in the Python documentation, but it’s also worth experimenting with built in Python objects to see which methods provide which behaviour.
For a more complete list of these special methods, see the [Special Method Names](https://docs.python.org/3/reference/datamodel.html#special-method-names) section of the Python documentation.

> ## Exercise: A Basic Class
>
> Implement a class to represent a book.
> Your class should:
>
> - Have a title
> - Have an author
> - When printed using `print(book)`, show text in the format "title by author"
>
> ~~~ python
> book = Book('A Book', 'Me')
>
> print(book)
> ~~~
> {: .language-python}
>
> ~~~
> A Book by Me
> ~~~
> {: .output}
>
> > ## Solution
> >
> > ~~~ python
> > class Book:
> >     def __init__(self, title, author):
> >         self.title = title
> >         self.author = author
> >
> >     def __str__(self):
> >         return self.title + ' by ' + self.author
> > ~~~
> > {: .language-python}
> {: .solution}
{: .challenge}

### Properties

The final special type of method we will introduce is a **property**.
Properties are methods which behave like data - when we want to access them, we do not need to use brackets to call the method manually.

For example, we will add a method which will return the last data point in each 
measurement series, combined into a single dataframe:
~~~
# file: catchment/models.py

class Site:
    ...

    @property
    def last_measurements(self):
        return pd.concat(
            [self.measurements[key].series[-1:] for key in self.measurements.keys()],
            axis=1).sort_index()

~~~
{: .language-python}

~~~
from catchment.models import Site
import pandas as pd
import datetime

PL23 = Site('PL23')

riverlevel_data = pd.Series(
    [34.0,32.0,33.0,31.0],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3),
        datetime.date(2000,1,4),
        ]
    )

waterph_data = pd.Series(
    [7.8,8.0,7.9],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3)
        ]
    )

PL23.add_measurement('River Level', riverlevel_data)
PL23.add_measurement('Water pH', waterph_data)

lastdata = PL23.last_measurements
print(lastdata)
~~~
{: .language-python}

~~~
            River Level  Water pH
2000-01-03          NaN       7.9
2000-01-04         31.0       NaN
~~~
{: .output}

You may recognise the `@` syntax from episodes on parameterising unit tests and functional programming - `property` is another example of a **decorator**.
In this case the `property` decorator is taking the `last_measurements` function and modifying its behaviour, so it can be accessed as if it were a normal attribute.
It is also possible to make your own decorators, but we won't cover it here.

## Relationships Between Classes

We now have a language construct for grouping data and behaviour related to a single conceptual object.
The next step we need to take is to describe the relationships between the concepts in our code.

There are two fundamental types of relationship between objects which we need to be able to describe:

1. Ownership - x **has a** y - this is **composition**
2. Identity - x **is a** y - this is **inheritance**

### Composition

You should hopefully have come across the term **composition** already - in the novice Software Carpentry, we use composition of functions to reduce code duplication.
That time, we used a function which converted temperatures in Celsius to Kelvin as a **component** of another function which converted temperatures in Fahrenheit to Kelvin.

In the same way, in object oriented programming, we can make things components of other things.

We often use composition where we can say 'x *has a* y' - for example in our catchment study project, we might want to say that a catchment area *has* measurement sites or that a measurement site *has* a collection of measurement sets.

In the case of our example, we have said any given measurement site has a collection of measurement sets, so we're already using composition here.
We're currently implementing the collection of measurement sets as a dictionary with a known set of keys though, so maybe we should make a `MeasurementSeries` class as well. This class will contain the Pandas Series it replaces, but enable us to now associate extra information and methods with that dataset.

~~~ 
# file: catchment/models.py

class MeasurementSeries:
    def __init__(self, series, name, units):
        self.series = series
        self.name = name
        self.units = units
        self.series.name = self.name
    
    def add_measurement(self, data):
        self.series = pd.concat([self.series,data])
        self.series.name = self.name
    
    def __str__(self):
        if self.units:
            return f"{self.name} ({self.units})"
        else:
            return self.name


class Site:
    def __init__(self,name):
        self.name = name
        self.measurements = {}
    
    def add_measurement(self, measurement_id, data, units=None):    
        if measurement_id in self.measurements.keys():
            self.measurements[measurement_id].add_measurement(data)
        
        else:
            self.measurements[measurement_id] = MeasurementSeries(data, measurement_id, units)
    
    @property
    def last_measurements(self):
        return pd.concat(
            [self.measurements[key].series[-1:] for key in self.measurements.keys()],
            axis=1).sort_index()
    
    def __str__(self):
        return self.name

~~~
{: .language-python}


~~~
from catchment.models import Site
import pandas as pd

PL23 = Site('PL23')

riverlevel_data = pd.Series(
    [34.0,32.0,33.0,31.0],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3),
        datetime.date(2000,1,4),
        ]
    )

waterph_data = pd.Series(
    [7.8,8.0,7.9],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3)
        ]
    )

PL23.add_measurement('River Level', riverlevel_data, 'mm')
PL23.add_measurement('Water pH', waterph_data)


print(PL23.measurements['River Level'])
print(PL23.measurements['Water pH'])

lastdata = PL23.last_measurements
print(lastdata)

~~~
{: .language-python}

~~~
River Level (mm)
Water pH
            River Level  Water pH
2000-01-03          NaN       7.9
2000-01-04         31.0       NaN
~~~
{: .output}
Note that, within the `Site` class, we now access the measurement series by adding `.series` to the end of the `self.measurements[measurement_id]` object. 

Note also how we used `units=None` in the parameter list of the `add_measurement` method, enabling us to still initialise the `MeasurementSet` class even if the end user doesn't supply the measurement unit information. This is one of the common ways to handle an optional argument in Python, so we’ll see this pattern quite a lot in real projects.


Now we're using a composition of two custom classes to describe the relationship between two types of entity in the system that we're modelling.

### Inheritance

The other type of relationship used in object oriented programming is **inheritance**.
Inheritance is about data and behaviour shared by classes, because they have some shared identity - 'x *is a* y'.
If class `X` inherits from (*is a*) class `Y`, we say that `Y` is the **superclass** or **parent class** of `X`, or `X` is a **subclass** of `Y`.

If we want to extend the previous example to also manage locations which aren't measurement sites we can add another class `Location`.
But `Location` will share some data and behaviour with `Site` - in this case both have a name and show that name when you print them.
Since we expect all sites to be locations, it makes sense to implement the behaviour in `Location` and then reuse it in `Site`.

To write our class in Python, we used the `class` keyword, the name of the class, and then a block of the functions that belong to it.
If the class **inherits** from another class, we include the parent class name in brackets.

~~~ python
# file: catchment/models.py

class MeasurementSeries:
    def __init__(self, series, name, units):
        self.series = series
        self.name = name
        self.units = units
        self.series.name = self.name
    
    def add_measurement(self, data):
        self.series = pd.concat([self.series,data])
        self.series.name = self.name
    
    def __str__(self):
        if self.units:
            return f"{self.name} ({self.units})"
        else:
            return self.name

class Location:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Site(Location):
    def __init__(self,name):
        super().__init__(name)
        self.measurements = {}
    
    def add_measurement(self, measurement_id, data, units=None):    
        if measurement_id in self.measurements.keys():
            self.measurements[measurement_id].add_measurement(data)
    
        else:
            self.measurements[measurement_id] = MeasurementSeries(data, measurement_id, units)
    
    @property
    def last_measurements(self):
        return pd.concat(
            [self.measurements[key].series[-1:] for key in self.measurements.keys()],
            axis=1).sort_index()

~~~
{: .language-python}

~~~
from catchment.models import Site
import pandas as pd
import datetime

FP23 = Site('FP23')

print(FP23)

riverlevel_data = pd.Series(
    [34.0,32.0,33.0,31.0],
    index=[
        datetime.date(2000,1,1),
        datetime.date(2000,1,2),
        datetime.date(2000,1,3),
        datetime.date(2000,1,4),
        ]
    )

FP23.add_measurement('River Level',riverlevel_data,'mm')

print(FP23.measurements['River Level'].series)

PL12 = Location('PL12')
print(PL12)

PL12.add_measurement('River Level',riverlevel_data,'mm')
~~~
{: .language-python}

~~~
FP23
2000-01-01  34.0
2000-01-02  32.0
2000-01-03  33.0
2000-01-04  31.0
name: River Level, dtype: float 64 
PL12
...
AttributeError: 'Location' object has no attribute 'add_measurement'
~~~
{: .output}

As expected, an error is thrown because we cannot add measurement data to `PL12`, which is a Location but not a Site.

We see in the example above that to say that a class inherits from another, we put the **parent class** (or **superclass**) in brackets after the name of the **subclass**.

There's something else we need to add as well - Python doesn't automatically call the `__init__` method on the parent class if we provide a new `__init__` for our subclass, so we'll need to call it ourselves.
This makes sure that everything that needs to be initialised on the parent class has been, before we need to use it.
If we don't define a new `__init__` method for our subclass, Python will look for one on the parent class and use it automatically.
This is true of all methods - if we call a method which doesn't exist directly on our class, Python will search for it among the parent classes.
The order in which it does this search is known as the **method resolution order** - a little more on this in the Multiple Inheritance callout below.

The line `super().__init__(name)` gets the parent class, then calls the `__init__` method, providing the `name` variable that `Location.__init__` requires.
This is quite a common pattern, particularly for `__init__` methods, where we need to make sure an object is initialised as a valid `X`, before we can initialise it as a valid `Y` - e.g. a valid `Location` must have a name, before we can properly initialise a `Site` model with the corresponding measurement data.



> ## Composition vs Inheritance
>
> When deciding how to implement a model of a particular system, you often have a choice of either composition or inheritance, where there is no obviously correct choice.
> For example, it's not obvious whether a photocopier *is a* printer and *is a* scanner, or *has a* printer and *has a* scanner.
>
> ~~~ python
> class Machine:
>     pass
>
> class Printer(Machine):
>     pass
>
> class Scanner(Machine):
>     pass
>
> class Copier(Printer, Scanner):
>     # Copier `is a` Printer and `is a` Scanner
>     pass
> ~~~
> {: .language-python}
>
> ~~~ python
> class Machine:
>     pass
>
> class Printer(Machine):
>     pass
>
> class Scanner(Machine):
>     pass
>
> class Copier(Machine):
>     def __init__(self):
>         # Copier `has a` Printer and `has a` Scanner
>         self.printer = Printer()
>         self.scanner = Scanner()
> ~~~
> {: .language-python}
>
> Both of these would be perfectly valid models and would work for most purposes.
> However, unless there's something about how you need to use the model which would benefit from using a model based on inheritance, it's usually recommended to opt for **composition over inheritance**.
> This is a common design principle in the object oriented paradigm and is worth remembering, as it's very common for people to overuse inheritance once they've been introduced to it.
>
> For much more detail on this see the [Python Design Patterns guide](https://python-patterns.guide/gang-of-four/composition-over-inheritance/).
{: .callout}

> ## Multiple Inheritance
>
> **Multiple Inheritance** is when a class inherits from more than one direct parent class.
> It exists in Python, but is often not present in other Object Oriented languages.
> Although this might seem useful, like in our inheritance-based model of the photocopier above, it's best to avoid it unless you're sure it's the right thing to do, due to the complexity of the inheritance heirarchy.
> Often using multiple inheritance is a sign you should instead be using composition - again like the photocopier model above.
{: .callout}


> ## Exercise: A Model Site
>
> Let's use what we have learnt in this episode and combine it with what we have learnt on 
> [software requirements](../31-software-requirements/index.html) to formulate and implement a 
> [few new solution requirements](../31-software-requirements/index.html#exercise-new-solution-requirements)
> to extend the model layer of our measurement campaign system.
>
> Let's can start with extending the system such that there must be a `Catchment` class to hold the data representing a single catchment, which:
>   - must have a `name` attribute
>   - must have a dictionary of sites that are within this catchment area.
>
> In addition to these, try to think of an extra feature you could add to the models which would be useful for managing a dataset like this - imagine we're running a field measurement campaign, what else might we want to know?
> Try using Test Driven Development for any features you add: write the tests first, then add the feature.
> The tests have been started for you in `tests/test_sites.py`, but you will probably want to add some more.
>
> Once you've finished the initial implementation, do you have much duplicated code?
> Is there anywhere you could make better use of composition or inheritance to improve your implementation?
>
> For any extra features you've added, explain them and how you implemented them to your neighbour.
> Would they have implemented that feature in the same way?
> > ## Solution
> > One example solution is shown below. You may start by writing some tests (that will initially fail), and then 
> > develop the code to satisfy the new requirements and pass the tests.
> > ~~~ python
> > # file: tests/test_sites.py   
> > """Tests for the Site model."""    
> >
> > def test_create_site():
> >     """Check a site is created correctly given a name."""
> >     from catchment.models import Site
> >     name = 'PL23'
> >     p = Site(name=name,longitude=None,latitude=None)
> >     assert p.name == name
> >
> > def test_create_catchment():
> >     """Check a catchment is created correctly given a name."""
> >     from catchment.models import Catchment
> >     name = 'Spain'
> >     catchment = Catchment(name=name)
> >     assert catchment.name == name
> > 
> > def test_catchment_is_location():
> >     """Check if a catchment is a location."""
> >     from catchment.models import Catchment, Location
> >     catchment = Catchment("Spain")
> >     assert isinstance(catchment, Location)
> >
> > def test_site_is_location():
> >     """Check if a site is a location."""
> >     from catchment.models import Site, Location
> >     PL23 = Site("PL23")
> >     assert isinstance(PL23, Location)
> >
> > def test_sites_added_correctly():
> >     """Check sites are being added correctly by a catchment. """
> >     from catchment.models import Catchment, Site
> >     catchment = Catchment("Spain")
> >     PL23 = Site("PL23")
> >     catchment.add_site(PL23)
> >     assert catchment.sites is not None
> >     assert len(catchment.sites) == 1
> >
> > def test_no_duplicate_sites():
> >     """Check adding the same site to the same catchment twice does not result in duplicates. """
> >     from catchment.models import Catchment, Site
> >     catchment = Catchment("Sheila Wheels")
> >     PL23 = Site("PL23")
> >     catchment.add_site(PL23)
> >     catchment.add_site(PL23)
> >     assert len(catchment.sites) == 1   
> > ...
> > ~~~    
> > {: .language-python} 
> > 
> > ~~~ python
> > # file: catchment/models.py
> > import geopandas as gpd
> > ...
> > class Location:
> >     """A Location."""
> >     def __init__(self, name):
> >         self.name = name
> >
> >     def __str__(self):
> >         return self.name
> >
> > class Site(Location):
> >     """A measurement site in the study."""
> >     def __init__(self, name):
> >         super().__init__(name)
> >         self.measurements = {}
> >
> >    def add_measurement(self, measurement_id, data, units=None):    
> >        if measurement_id in self.measurements.keys():
> >            self.measurements[measurement_id].add_measurement(data)
> >     
> >        else:
> >             self.measurements[measurement_id] = MeasurementSeries(data, measurement_id, units)
> >    
> >    @property
> >    def last_measurements(self):
> >        return pd.concat(
> >            [self.measurements[key].series[-1:] for key in self.measurements.keys()],
> >            axis=1).sort_index()
> >
> >
> > class Catchment(Location):
> >     """A catchment area in the study."""
> >     def __init__(self, name):
> >         super().__init__(name)
> >         self.sites = {}
> >
> >
> >     def add_site(self, new_site):
> >         # Basic check to see if the site has already been added to the catchment area 
> >         for site in self.sites:
> >             if site == new_site:
> >                 print(f'{new_site} has already been added to site list')
> >                 return
> >
> >         self.sites[new_site.name] = Site(new_site)
> > ...
> > ~~~    
> {: .language-python} 
> {: .solution}
{: .challenge}

> ## Geospatial Data
> 
> Once we have objects for both Sites and Catchments we can make use of the Geopandas
> library and geospatial data for each Site and Catchment to check the relationships 
> between these. This is covered in the extra episode on 
> [Geospatial data with Geopandas](../geopandas/index.html).
{: .callout}

{% include links.md %}
