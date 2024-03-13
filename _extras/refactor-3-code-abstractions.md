---
title: "Refactor 3: Code Abstractions"
teaching: 30
exercises: 45
questions:
- "When is it useful to use classes to structure code?"
- "How can we make sure the components of our software are reusable?"
objectives:
- "Introduce appropriate abstractions to simplify code."
- "Understand the principles of encapsulation, polymorphism and interfaces."
- "Use mocks to replace a class in test code."
keypoints:
- "Classes and interfaces can help decouple code so it is easier to understand, test and maintain."
- "Encapsulation is bundling related data into a structured component, 
along with the methods that operate on the data. It is also provides a mechanism for restricting 
the access to that data, hiding the internal representation of the component."
- "Polymorphism describes the provision of a single interface to entities of different types, 
or the use of a single symbol to represent different types."
---

## Introduction

*Code abstraction* is the process of hiding the implementation details of a piece of
code behind an interface - i.e. the details of *how* something works are hidden away,
leaving us to deal only with *what* it does.
This allows developers to work with the code at a higher level
of abstraction, without needing to understand fully (or keep in mind) all the underlying 
details and thereby reducing the cognitive load when programming.

Abstractions can aid decoupling of code.
If one part of the code only uses another part through an appropriate abstraction
then it becomes easier for these parts to change independently.

Let's start redesigning our code by introducing some of the abstraction techniques 
to incrementally improve its design.

You may have noticed that loading data from CSV files in a directory is "baked" into 
(i.e. is part of) the `analyse_data()` function. 
This is not strictly a functionality of the data analysis function, so firstly 
let's decouple the data loading into a separate function.

> ## Exercise: Decouple Data Loading from Data Analysis
> Separate out the data loading functionality from `analyse_data()` into a new function 
> `load_catchment_data()` that returns all the files to load.
>> ## Solution
>> The new function `load_catchment_data()` that reads all the data into the format needed
>> for the analysis should look something like:
>> ```python
>> def load_inflammation_data(dir_path):
>>   data_file_paths = glob.glob(os.path.join(dir_path, 'rain_data_2015*.csv'))
>>   if len(data_file_paths) == 0:
>>       raise ValueError('No CSV files found in the data directory')
>>   data = map(models.load_csv, data_file_paths)
>>   return list(data)
>> ```
>> This function can now be used in the analysis as follows:
>> ```python
>> def analyse_data(data_dir):
>>   data = load_catchment_data(data_dir)
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>>   ...
>> ```
>> The code is now easier to follow since we do not need to understand the the data loading from
>> files to read the statistical analysis, and vice versa - we do not have to understand the 
>> statistical analysis when looking at data loading.
>> Ensure you re-run the regression tests to check this refactoring has not
>> changed the output of `analyse_data()`.
> {: .solution}
{: .challenge}

However, even with this change, the data loading is still coupled with the data analysis.
For example, if we have to support loading data from different sources 
(e.g. JSON files and CSV files), we would have to pass some kind of a flag indicating 
what we want into `analyse_data()`. Instead, we would like to decouple the 
consideration of what data to load from the `analyse_data()` function entirely.
One way we can do this is by using *encapsulation* and *classes*.

## Encapsulation & Classes

*Encapsulation* is the packing of "data" and "functions operating on that data" into a 
single component/object. 
It also provides a mechanism for restricting the access to that data. 
Encapsulation means that the internal representation of a component is generally hidden 
from view outside of the component's definition.

Encapsulation allows developers to present a consistent interface to an object/component
that is independent of its internal implementation. 
For example, encapsulation can be used to hide the values or 
state of a structured data object inside a **class**, preventing direct access to them 
that could violate the object's state maintained by the class' methods. 
Note that object-oriented programming (OOP) languages support encapsulation, 
but encapsulation is not unique to OOP.

So, a class is a way of grouping together data with some methods that manipulate that data.
In Python, you can *declare* a class as follows:

```python
class Circle:
  pass
```

Classes are typically named using "CapitalisedWords" naming convention - e.g. FileReader, 
OutputStream, Rectangle.

You can *construct* an *instance* of a class elsewhere in the code by doing the following:

```python
my_circle = Circle()
```

When you construct a class in this ways, the class' *constructor* method is called.
It is also possible to pass values to the constructor in order to configure the class instance:

```python
class Circle:
  def __init__(self, radius):
    self.radius = radius

my_circle = Circle(10)
```

The constructor has the special name `__init__`.
Note it has a special first parameter called `self` by convention - it is 
used to access the current *instance* of the object being created.

A class can be thought of as a cookie cutter template, and instances as the cookies themselves.
That is, one class can have many instances.

Classes can also have other methods defined on them.
Like constructors, they have the special parameter `self` that must come first.

```python
import math

class Circle:
  ...
  def get_area(self):
    return math.pi * self.radius * self.radius
...
print(my_circle.get_area())
```

On the last line of the code above, the instance of the class, `my_circle`, will be automatically
passed as the first parameter (`self`) when calling the `get_area()` method.
The `get_area()` method can then access the variable `radius` encapsulated within the object, which 
is otherwise invisible to the world outside of the object. 
The method `get_area()` itself can also be accessed via the object/instance only.

As we can see, internal representation of any instance of class `Circle` is hidden 
outside of this class (encapsulation). 
In addition, implementation of the method `get_area()` is hidden too (abstraction).

> ## Encapsulation & Abstraction
> Encapsulation provides **information hiding**. Abstraction provides **implementation hiding**.
{: .callout}

> ## Exercise: Use Classes to Abstract out Data Loading
> Declare a new class `CSVDataSource` that contains the `load_catchment_data` function 
> we wrote in the previous exercise as a method of this class.
> The directory path where to load the files from should be passed in the class' constructor method.
> Finally, construct an instance of the class `CSVDataSource` outside the statistical 
> analysis and pass it to `analyse_data()` function.
>> ## Hint
>> At the end of this exercise, the code in the `analyse_data()` function should look like:
>> ```python
>> def analyse_data(data_source):
>>   data = data_source.load_catchment_data()
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>>   ...
>> ```
>> The controller code should look like:
>> ```python
>> data_source = compute_data.CSVDataSource(os.path.dirname(InFiles[0]))
>> compute_data.analyse_data(data_source)
>> ```
> {: .solution}
>> ## Solution
>> For example, we can declare class `CSVDataSource` like this:
>>
>> ```python
>> class CSVDataSource:
>>   """
>>   Loads all the catchment CSV files within a specified directory.
>>   """
>>   def __init__(self, dir_path):
>>     self.dir_path = dir_path
>>
>>   def load_catchment_data(self):
>>     data_file_paths = glob.glob(os.path.join(self.dir_path, 'rain_data_2015*.csv'))
>>     if len(data_file_paths) == 0:
>>       raise ValueError('No CSV files found in the data directory')
>>     data = map(models.read_variable_from_csv, data_file_paths)
>>     return list(data)
>> ```
>> In the controller, we create an instance of CSVDataSource and pass it 
>> into the the statistical analysis function.
>>
>> ```python
>> data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> analyse_data(data_source)
>> ```
>> The `analyse_data()` function is modified to receive any data source object (that implements 
>> the `load_catchment_data()` method) as a parameter.
>> ```python
>> def analyse_data(data_source):
>>   data = data_source.load_catchment_data()
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>>   ...
>> ```
>> We have now fully decoupled the reading of the data from the statistical analysis and 
>> the analysis is not fixed to reading from a directory of CSV files. Indeed, we can pass various 
>> data sources to this function now, as long as they implement the `load_catchment_data()` 
>> method. 
>> 
>> While the overall behaviour of the code and its results are unchanged, 
>> the way we invoke data analysis has changed. 
>> We must update our regression test to match this, to ensure we have not broken anything:
>> ```python
>> ...
>> def test_compute_data():
>>     from catchment.compute_data import analyse_data, CSVDataSource
>>     path = Path.cwd() / "../data"
>>     data_source = CSVDataSource(path)
>>     result = analyse_data(data_source)
>>     expected_output = [ [0.        , 0.18801829],
>>     ...
>> ```
> {: .solution}
{: .challenge}


## Interfaces

An interface is another important concept in software design related to abstraction and 
encapsulation. For a software component, it declares the operations that can be invoked on 
that component, along with input arguments and what it returns. By knowing these details, 
we can communicate with this component without the need to know how it implements this interface. 

API (Application Programming Interface) is one example of an interface that allows separate 
systems (external to one another) to communicate with each other. 
For example, a request to Google Maps service API may get 
you the latitude and longitude for a given address. 
Twitter API may return all tweets that contain 
a given keyword that have been posted within a certain date range.

Internal interfaces within software dictate how
different parts of the system interact with each other.
Even when these are not explicitly documented or thought out, they still exist.

For example, our `Circle` class implicitly has an interface - you can call `get_area()` method
on it and it will return a number representing its surface area.

> ## Exercise: Identify an Interface Between `CSVDataSource` and `analyse_data`
> What is the interface between CSVDataSource class and `analyse_data()` function.
> Think about what functions `analyse_data()` needs to be able to call to perform its duty,
> what parameters they need and what they return.
>> ## Solution
>> The interface is the `load_catchment_data()` method, which takes no parameters and 
>> returns a list where each entry is a 2D array of catchment measurement data (read from some 
>> data source).
>> 
>> Any object passed into `analyse_data()` should conform to this interface.
> {: .solution}
{: .challenge}


## Polymorphism

In general, polymorphism is the idea of having multiple implementations/forms/shapes 
of the same abstract concept. 
It is the provision of a single interface to entities of different types, 
or the use of a single symbol to represent multiple different types.

There are [different versions of polymorphism](https://www.bmc.com/blogs/polymorphism-programming/). 
For example, method or operator overloading is one 
type of polymorphism enabling methods and operators to take parameters of different types. 

We will have a look at the interface-based polymorphism. 
In OOP, it is possible to have different object classes that conform to the same interface. 
For example, let's have a look at the following class representing a `Rectangle`:

```python
class Rectangle:
  def __init__(self, width, height):
    self.width = width
    self.height = height
  def get_area(self):
    return self.width * self.height
```

Like `Circle`, this class provides the `get_area()` method.
The method takes the same number of parameters (none), and returns a number.
However, the implementation is different. This is one type of *polymorphism*.

The word "polymorphism" means "many forms", and in programming it refers to 
methods/functions/operators with the same name that can be executed on many objects or classes.

Using our `Circle` and `Rectangle` classes, we can create a list of different shapes and iterate 
through the list to find their total surface area as follows:

```python
my_circle = Circle(radius=10)
my_rectangle = Rectangle(width=5, height=3)
my_shapes = [my_circle, my_rectangle]
total_area = sum(shape.get_area() for shape in my_shapes)
```

Note that we have not created a common superclass or linked the classes `Circle` and `Rectangle` 
together in any way. It is possible due to polymorphism. 
You could also say that, when we are calculating the total surface area, 
the method for calculating the area of each shape is abstracted away to the relevant class.

How can polymorphism be useful in our software project? 
For example, we can replace our `CSVDataSource` with another class that reads a totally 
different file format (e.g. JSON instead of CSV), or reads from an external service or database
All of these changes can be now be made without changing the analysis function as we have decoupled 
the process of data loading from the data analysis earlier.
Conversely, if we wanted to write a new analysis function, we could support any of these 
data sources with no extra work.

> ## Exercise: Add an Additional DataSource
> Create another class that supports loading catchment data from JSON files, with the 
> appropriate `load_catchment_data()` method.
> There is a function in `models.py` that loads from JSON in the following format:
> ```json
>[
>    {
>        "Site": "FP35",
>        "Site Name": "Lower Wraxall Farm",
>        "Date": "01/12/2008 23:00",
>        "Rainfall (mm)": 0.0
>    },
>    {
>        "Site": "FP35",
>        "Site Name": "Lower Wraxall Farm",
>        "Date": "01/12/2008 23:15",
>        "Rainfall (mm)": 0.0
>    }
> ]
> ```
> Finally, at run time construct an appropriate instance based on the file extension.
>> ## Solution
>> The new class could look something like:
>> ```python
>> class JSONDataSource:
>>     """
>>     Loads patient data with catchment values from JSON files within a specified folder.
>>     """
>>     def __init__(self, dir_path):
>>         self.dir_path = dir_path
>>
>>     def load_catchment_data(self):
>>         data_file_paths = glob.glob(os.path.join(self.dir_path, 'rain_data_2015*.json'))
>>         if len(data_file_paths) == 0:
>>             raise ValueError('No JSON files found in the data directory')
>>         data = map(models.load_json, data_file_paths)
>>         return list(data)
>> ```
>> Additionally, in the controller will need to select the appropriate DataSource to
>> provide to the analysis:
>>```python
>> _, extension = os.path.splitext(InFiles[0])
>> if extension == '.json':
>>   data_source = JSONDataSource(os.path.dirname(InFiles[0]))
>> elif extension == '.csv':
>>   data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> else:
>>   raise ValueError(f'Unsupported file format: {extension}')
>> analyse_data(data_source)
>>```
>> As you can seen, all the above changes have been made made without modifying
>> the analysis code itself.
> {: .solution}
{: .challenge}

## Testing Using Mock Objects

We can use this abstraction to also make testing more straight forward.
Instead of having our tests use real file system data, we can instead provide
a mock or dummy implementation instead of one of the real classes.
Providing that what we use as a substitute conforms to the same interface, 
the code we are testing should work just the same.
Such mock/dummy implementation could just returns some fixed example data.

An convenient way to do this in Python is using Python's [mock object library](https://docs.python.org/3/library/unittest.mock.html).
This is a whole topic in itself -
but a basic mock can be constructed using a couple of lines of code:

```python
from unittest.mock import Mock

mock_version = Mock()
mock_version.method_to_mock.return_value = 42
```

Here we construct a mock in the same way you would construct a class.
Then we specify a method that we want to behave a specific way.

Now whenever you call `mock_version.method_to_mock()` the return value will be `42`.


> ## Exercise: Test Using a Mock Implementation
> Complete this test for `analyse_data()`, using a mock object in place of the
> `data_source`:
> ```python
> from unittest.mock import Mock
>
> def test_compute_data_mock_source():
>   from catchment.compute_data import analyse_data
>   data_source = Mock()
>
>   # TODO: configure data_source mock
>
>   result = analyse_data(data_source)
>
>   # TODO: add assert on the contents of result
> ```
> Create a mock that returns some fixed data and to use as the `data_source` in order to test
> the `analyse_data` method.
> Use this mock in a test.
>
> Do not forget to import `Mock` from the `unittest.mock` package.
>> ## Solution
>> ```python
>> from unittest.mock import Mock
>>
>> def test_compute_data_mock_source():
>>    from catchment.compute_data import analyse_data
>>    data_source = Mock()
>>
>>    data_source.load_catchment_data.return_value = [pd.DataFrame(
>>                     data=[[1.0, 1.0],
>>                           [2.0, 1.0],
>>                           [4.0, 2.0]],
>>                     index=[pd.to_datetime('2000-01-01 01:00'),
>>                            pd.to_datetime('2000-01-01 02:00'),
>>                            pd.to_datetime('2000-01-01 03:00')],
>>                     columns=['A', 'B']
>>    )]
>>
>>    result = analyse_data(data_source)
>>    npt.assert_array_almost_equal(result, [[1.527525, 0.57735 ]])
>> ```
> {: .solution}
{: .challenge}

## Programming Paradigms

Until now, we have mainly been writing procedural code. 
In the previous episode, we mentioned [pure functions](/33-code-refactoring/index.html#pure-functions) 
and Functional Programming.
In this episode, we have touched a bit upon classes, encapsulation and polymorphism, 
which are characteristics of (but not limited to) the Object Oriented Programming (OOP).
All these different programming paradigms provide varied approaches to structuring your code - 
each with certain strengths and weaknesses when used to solve particular types of problems. 
In many cases, particularly with modern languages, a single language can allow many different 
structural approaches and mixing programming paradigms within your code.
Once your software begins to get more complex - it is common to use aspects of [different paradigm](/programming-paradigms/index.html) 
to handle different subtasks. 
Because of this, it is useful to know about the [major paradigms](/programming-paradigms/index.html), 
so you can recognise where it might be useful to switch. 
This is outside of scope of this course - we have some extra episodes on the topics of 
[Procedural Programming](/programming-paradigms/index.html#procedural-programming), 
[Functional Programming](/functional-programming/index.html) and 
[Object Oriented Programming](/object-oriented-programming/index.html) if you want to know more.

> ## So Which One is Python?
> Python is a multi-paradigm and multi-purpose programming language.
> You can use it as a procedural language and you can use it in a more object oriented way.
> It does tend to land more on the object oriented side as all its core data types
> (strings, integers, floats, booleans, lists,
> sets, arrays, tuples, dictionaries, files)
> as well as functions, modules and classes are objects.
>
> Since functions in Python are also objects that can be passed around like any other object,
> Python is also well suited to functional programming.
> One of the most popular Python libraries for data manipulation,
> [Pandas](https://pandas.pydata.org/) (built on top of NumPy),
> supports a functional programming style
> as most of its functions on data are not changing the data (no side effects)
> but producing a new data to reflect the result of the function.
{: .callout}
