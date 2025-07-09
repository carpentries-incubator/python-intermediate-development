---
title: 3.3 Code Decoupling & Abstractions
teaching: 30
exercises: 45
---

::::::::::::::::::::::::::::::::::::::: objectives

- Understand the benefits of code decoupling.
- Introduce appropriate abstractions to simplify code.
- Understand the principles of encapsulation, polymorphism and interfaces.
- Use mocks to replace a class in test code.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What is decoupled code?
- What are commonly used code abstractions?
- When is it useful to use classes to structure code?
- How can we make sure the components of our software are reusable?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Introduction

**Code decoupling** refers to breaking up the software into smaller components and reducing the
interdependence between these components so that they can be tested and maintained independently.
Two components of code can be considered *decoupled* if a change in one does not
necessitate a change in the other.
While two connected units cannot always be totally decoupled, *loose coupling*
is something we should aim for.

**Code abstraction** is the process of hiding the implementation details of a piece of
code behind an interface - i.e. the details of *how* something works are hidden away,
leaving us to deal only with *what* it does.
This allows developers to work with the code at a higher level
of abstraction, without needing to understand fully (or keep in mind) all the underlying
details and thereby reducing the cognitive load when programming.

Abstractions can aid decoupling of code.
If one part of the code only uses another part through an appropriate abstraction
then it becomes easier for these parts to change independently.
Benefits of using these techniques include having the codebase that is:

- easier to read as you only need to understand the
  details of the (smaller) component you are looking at and not the whole monolithic codebase.
- easier to test, as one of the components can be replaced
  by a test or a mock version of it.
- easier to maintain, as changes can be isolated
  from other parts of the code.

Let us start redesigning our code by introducing some of the abstraction techniques
to incrementally decouple it into smaller components to improve its overall design.

In the code from our current branch `full-data-analysis`,
you may have noticed that loading data from CSV files from a `data` directory is "hardcoded" into
the `analyse_data()` function.
Data loading is a functionality separate from data analysis, so firstly
let us decouple the data loading part into a separate component (function).

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Decouple Data Loading from Data Analysis

Modify `compute_data.py` to separate out the data loading functionality from `analyse_data()` into a new function
`load_inflammation_data()`, that returns a list of 2D NumPy arrays with inflammation data
loaded from all inflammation CSV files found in a specified directory path.
Then, change your `analyse_data()` function to make use of this new function instead.

:::::::::::::::  solution

## Solution

The new function `load_inflammation_data()` that reads all the inflammation data into the
format needed for the analysis could look something like:
.

```python
def load_inflammation_data(dir_path):
    data_file_paths = glob.glob(os.path.join(dir_path, 'inflammation*.csv'))
    if len(data_file_paths) == 0:
        raise ValueError(f"No inflammation CSV files found in path {dir_path}")
    data = map(models.load_csv, data_file_paths) # Load inflammation data from each CSV file
    return list(data) # Return the list of 2D NumPy arrays with inflammation data
```

The new function `analyse_data()` could then look like:

```python
def analyse_data(data_dir):
    data = load_inflammation_data(data_dir)

    means_by_day = map(models.daily_mean, data)
    means_by_day_matrix = np.stack(list(means_by_day))

    daily_standard_deviation = np.std(means_by_day_matrix, axis=0)

    graph_data = {
        'standard deviation by day': daily_standard_deviation,
    }
    views.visualize(graph_data)
```

The code is now easier to follow since we do not need to understand the data loading part
to understand the statistical analysis part, and vice versa.
In most cases, functions work best when they are short!



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

However, even with this change, the data loading is still coupled with the data analysis to a
large extent.
For example, if we have to support loading data from different sources
(e.g. JSON files or an SQL database), we would have to pass some kind of a flag into `analyse_data()`
indicating the type of data we want to read from. Instead, we would like to decouple the
consideration of data source from the `analyse_data()` function entirely.
One way we can do this is by using *encapsulation* and *classes*.

## Encapsulation \& Classes

**Encapsulation** is the process of packing the "data" and "functions operating on that data" into a
single component/object.
It is also provides a mechanism for restricting the access to that data.
Encapsulation means that the internal representation of a component is generally hidden
from view outside of the component's definition.

Encapsulation allows developers to present a consistent interface to the component/object
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

:::::::::::::::::::::::::::::::::::::::::  callout

## Encapsulation \& Abstraction

Encapsulation provides **information hiding**. Abstraction provides **implementation hiding**.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Use Classes to Abstract out Data Loading

Inside `compute_data.py`, declare a new class `CSVDataSource` that contains the
`load_inflammation_data()` function we wrote in the previous exercise as a method of this class.
The directory path where to load the files from should be passed in the class' constructor method.
Finally, construct an instance of the class `CSVDataSource` outside the statistical
analysis and pass it to `analyse_data()` function.

> ## Hint
> 
> At the end of this exercise, the code in the `analyse_data()` function should look like:
> 
> ```python
> def analyse_data(data_source):
>     data = data_source.load_inflammation_data()
>     ...
> ```
> 
> The controller code should look like:
> 
> ```python
> data_source = CSVDataSource(os.path.dirname(infiles[0]))
> analyse_data(data_source)
> ```

:::::::::::::::  solution

## Solution

For example, we can declare class `CSVDataSource` like this:

```python
class CSVDataSource:
    """
    Loads all the inflammation CSV files within a specified directory.
    """
    def __init__(self, dir_path):
        self.dir_path = dir_path

    def load_inflammation_data(self):
        data_file_paths = glob.glob(os.path.join(self.dir_path, 'inflammation*.csv'))
        if len(data_file_paths) == 0:
            raise ValueError(f"No inflammation CSV files found in path {self.dir_path}")
        data = map(models.load_csv, data_file_paths)
        return list(data)
```

In the controller, we create an instance of CSVDataSource and pass it
into the the statistical analysis function.

```python
data_source = CSVDataSource(os.path.dirname(infiles[0]))
analyse_data(data_source)
```

The `analyse_data()` function is modified to receive any data source object (that implements
the `load_inflammation_data()` method) as a parameter.

```python
def analyse_data(data_source):
    data = data_source.load_inflammation_data()
    ...
```

We have now fully decoupled the reading of the data from the statistical analysis and
the analysis is not fixed to reading from a directory of CSV files. Indeed, we can pass various
data sources to this function now, as long as they implement the `load_inflammation_data()`
method.

While the overall behaviour of the code and its results are unchanged,
the way we invoke data analysis has changed.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Interfaces

An **interface** is another important concept in software design related to abstraction and
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
Even when these are not explicitly documented - they still exist.

For example, our `Circle` class implicitly has an interface - you can call `get_area()` method
on it and it will return a number representing its surface area.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Identify an Interface Between `CSVDataSource` and `analyse_data`

What would you say is the interface between the CSVDataSource class
and `analyse_data()` function?
Think about what functions `analyse_data()` needs to be able to call to perform its duty,
what parameters they need and what they return.

:::::::::::::::  solution

## Solution

The interface is the `load_inflammation_data()` method, which takes no parameters and
returns a list where each entry is a 2D NumPy array of patient inflammation data (read from some
data source).

Any object passed into `analyse_data()` should conform to this interface.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Polymorphism

In general, **polymorphism** is the idea of having multiple implementations/forms/shapes
of the same abstract concept.
It is the provision of a single interface to entities of different types,
or the use of a single symbol to represent multiple different types.

There are [different versions of polymorphism](https://www.bmc.com/blogs/polymorphism-programming/).
For example, method or operator overloading is one
type of polymorphism enabling methods and operators to take parameters of different types.

We will have a look at the *interface-based polymorphism*.
In OOP, it is possible to have different object classes that conform to the same interface.
For example, let us have a look at the following class representing a `Rectangle`:

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
However, the implementation is different. This is interface-based polymorphism.

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
different file format (e.g. JSON), or reads from an external service or a database.
All of these changes can be now be made without changing the analysis function as we have decoupled
the process of data loading from the data analysis earlier.
Conversely, if we wanted to write a new analysis function, we could support any of these
data sources with no extra work.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Add an Additional DataSource

Create another class that supports loading patient data from JSON files, with the
appropriate `load_inflammation_data()` method.
Here is an example function that you can add to your `models.py` file to load observations from a JSON file:
```python
def load_json(filename):
    """Load a numpy array from a JSON document.
    
    Expected format:
    [
      {
        "observations": [0, 1]
      },
      {
        "observations": [0, 2]
      }    
    ]
    :param filename: Filename of CSV to load
    """
    with open(filename, 'r', encoding='utf-8') as file:
        data_as_json = json.load(file)
        return [np.array(entry['observations']) for entry in data_as_json]
```

Finally, at run-time, construct an appropriate data source instance based on the file extension.

:::::::::::::::  solution

## Solution

The class that reads inflammation data from JSON files could look something like:

```python
class JSONDataSource:
  """
  Loads patient data with inflammation values from JSON files within a specified folder.
  """
  def __init__(self, dir_path):
    self.dir_path = dir_path

  def load_inflammation_data(self):
    data_file_paths = glob.glob(os.path.join(self.dir_path, 'inflammation*.json'))
    if len(data_file_paths) == 0:
      raise ValueError(f"No inflammation JSON files found in path {self.dir_path}")
    data = map(models.load_json, data_file_paths)
    return list(data)
```

Additionally, in the controller we will need to select an appropriate DataSource instance to
provide to the analysis:

```python
_, extension = os.path.splitext(infiles[0])
if extension == '.json':
  data_source = JSONDataSource(os.path.dirname(infiles[0]))
elif extension == '.csv':
  data_source = CSVDataSource(os.path.dirname(infiles[0]))
else:
  raise ValueError(f'Unsupported data file format: {extension}')
analyse_data(data_source)
```

As you can seen, all the above changes have been made made without modifying
the analysis code itself.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Testing Using Mock Objects

We can use a **mock object** abstraction to make testing more straightforward.
Instead of having our tests use real data stored on a file system, we can provide
a mock or dummy implementation instead of one of the real classes.
Providing that what we use as a substitute conforms to the same interface,
the code we are testing should work just the same.
Such mock/dummy implementation could just return some fixed example data.

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

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Test Using a Mock Implementation
Add a new test file called `test_compute_data.py` in the tests folder and add a test to verify 
whether we can successfully run `analyse_data()` when passing it a data source.

Complete this test for `analyse_data()`, using a mock object in place of the `data_source`:

```python
from unittest.mock import Mock

def test_analyse_data_mock_source():
  from inflammation.compute_data import analyse_data
  data_source = Mock()

  # TODO: configure data_source mock

  analyse_data(data_source)

```

Create a mock that returns some fixed data and to use as the `data_source` in order to test
the `analyse_data` method.

Use this mock in the test.

Do not forget to import `Mock` from the `unittest.mock` package.

Note that the `analyse_data()` function visualizes the data with `views.visualize(graph_data)`.
You do not have to assert that this is done correctly. For now, it is fine to just check that 
the call to `analyse_data()` can proceed successfully. 

In the next episode we will adapt the `analyse_data()` function 
so that we can write a test that asserts whether standard deviation calculations are correct.

:::::::::::::::  solution

## Solution

```python
from unittest.mock import Mock

def test_analyse_data_mock_source():
  from inflammation.compute_data import analyse_data
  data_source = Mock()
  mock_data = [[[0, 2, 0]],
              [[0, 1, 0]]]
  data_source.load_inflammation_data.return_value = mock_data

  analyse_data(data_source)
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Safe Code Structure Changes

With the changes to the code structure we have done using code decoupling and abstractions we have
already refactored our code to a certain extent, 
but we have not fully tested that the changes work as intended.
We will now look into how to properly refactor code to guarantee that the code still works
as before any modifications.



:::::::::::::::::::::::::::::::::::::::: keypoints

- Code decoupling is separating code into smaller components and reducing the interdependence between them so that the code is easier to understand, test and maintain.
- Abstractions can hide certain details of the code behind classes and interfaces.
- Encapsulation bundles data into a structured component along with methods that operate on the data, and provides a mechanism for restricting access to that data, hiding the internal representation of the component.
- Polymorphism describes the provision of a single interface to entities of different types, or the use of a single symbol to represent different types.

::::::::::::::::::::::::::::::::::::::::::::::::::


