---
title: "Using classes to de-couple code."
teaching: 30
exercises: 45
questions:
- "What is de-coupled code?"
- "When is it useful to use classes to structure code?"
- "How can we make sure the components of our software are reusable?"
objectives:
- "Understand the object-oriented principle of polymorphism and interfaces."
- "Be able to introduce appropriate abstractions to simplify code."
- "Understand what decoupled code is, and why you would want it."
- "Be able to use mocks to replace a class in test code."
keypoints:
- "Classes can help separate code so it is easier to understand."
- "By using interfaces, code can become more decoupled."
- "Decoupled code is easier to test, and easier to maintain."
---

## Introduction

When we're thinking about units of code, one important thing to consider is
whether the code is **decoupled** (as opposed to **coupled**).
Two units of code can be considered decoupled if changes in one don't
necessitate changes in the other.
While two connected units can't be totally decoupled, loose coupling
allows for more maintainable code:

* Loosely coupled code is easier to read as you don't need to understand the
  detail of the other unit.
* Loosely coupled code is easier to test, as one of the units can be replaced
  by a test or mock version of it.
* Loose coupled code tends to be easier to maintain, as changes can be isolated
  from other parts of the code.

Introducing **abstractions** is a way to decouple code.
If one part of the code only uses another part through an appropriate abstraction
then it becomes easier for these parts to change independently.

> ## Exercise: Decouple the file loading from the computation
> Currently the function is hard coded to load all the files in a directory
> Decouple this into a separate function that returns all the files to load
>> ## Solution
>> You should have written a new function that reads all the data into the format needed
>> for the analysis:
>> ```python
>> def load_inflammation_data(dir_path):
>>   data_file_paths = glob.glob(os.path.join(dir_path, 'inflammation*.csv'))
>>   if len(data_file_paths) == 0:
>>       raise ValueError(f"No inflammation csv's found in path {dir_path}")
>>   data = map(models.load_csv, data_file_paths)
>>   return list(data)
>> ```
>> This can then be used in the analysis.
>> ```python
>> def analyse_data(data_dir):
>>   data = load_inflammation_data(data_dir)
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>> ...
>> ```
>> This is now easier to understand, as we don't need to understand the the file loading
>> to read the statistical analysis, and we don't have to understand the statistical analysis
>> when reading the data loading.
> {: .solution}
{: .challenge}

Even with this change, the file loading is coupled with the data analysis.
For example, if we wave to support reading JSON files or CSV files
we would have to pass into `analyse_data` some kind of flag indicating what we want.

Instead, we would like to decouple the consideration of what data to load
from the `analyse_data`` function entirely.

One way we can do this is to use a language feature called a **class**.

## Using Python Classes

A class is a way of grouping together data with some specific methods.
In Python, you can declare a class as follows:

```python
class Circle:
  pass
```

They are typically named using `UpperCase`.

You can then **construct** a class elsewhere in your code by doing the following:

```python
my_circle = Circle()
```

When you construct a class in this ways, the classes **construtor** is called.
It is possible to pass in values to the constructor that configure the class:

```python
class Circle:
  def __init__(self, radius):
    self.radius = radius

my_circle = Circle(10)
```

The constructor has the special name `__init__` (one of the so called "dunder methods").
Notice it also has a special first parameter called `self` (called this by convention).
This parameter can be used to access the current **instance** of the object being created.

A class can be thought of as a cookie cutter template,
and the instances are the cookies themselves.
That is, one class can have many instances.

Classes can also have methods defined on them.
Like constructors, they have an special `self` parameter that must come first.

```python
import math

class Circle:
  ...
  def get_area(self):
    return math.pi * self.radius * self.radius
...
print(my_circle.get_area())
```

Here the instance of the class, `my_circle` will be automatically
passed in as the first parameter when calling `get_area`.
Then the method can access the **member variable** `radius`.

> ## Exercise: Use a class to configure loading
> Put the `load_inflammation_data` function we wrote in the last exercise as a member method
> of a new class called `CSVDataSource`.
> Put the configuration of where to load the files in the classes constructor.
> Once this is done, you can construct this class outside the the statistical analysis
> and pass the instance in to `analyse_data`.
>> ## Hint
>> When we have completed the refactoring, the code in the `analyse_data` function
>> should look like:
>> ```python
>> def analyse_data(data_source):
>>   data = data_source.load_inflammation_data()
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>>   ...
>> ```
>> The controller code should look like:
>> ```python
>> data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> analyse_data(data_source)
>> ```
> {: .solution}
>> ## Solution
>> You should have created a class that looks something like this:
>>
>> ```python
>> class CSVDataSource:
>>   """
>>   Loads all the inflammation csvs within a specified folder.
>>   """
>>   def __init__(self, dir_path):
>>     self.dir_path = dir_path
>>
>>   def load_inflammation_data(self):
>>     data_file_paths = glob.glob(os.path.join(self.dir_path, 'inflammation*.csv'))
>>     if len(data_file_paths) == 0:
>>       raise ValueError(f"No inflammation csv's found in path {self.dir_path}")
>>     data = map(models.load_csv, data_file_paths)
>>     return list(data)
>> ```
>> We can now pass an instance of this class into the the statistical analysis function.
>> This means that should we want to re-use the analysis it wouldn't be fixed to reading
>> from a directory of CSVs.
>> We have "decoupled" the reading of the data from the statistical analysis.
>> ```python
>> def analyse_data(data_source):
>>   data = data_source.load_inflammation_data()
>>   daily_standard_deviation = compute_standard_deviation_by_data(data)
>>   ...
>> ```
>>
>> In the controller, you might have something like:
>>
>> ```python
>> data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> analyse_data(data_source)
>> ```
>> While the behaviour is unchanged, how we call `analyse_data` has changed.
>> We must update our regression test to match this, to ensure we haven't broken the code:
>> ```python
>> ...
>> def test_compute_data():
>>     from inflammation.compute_data import analyse_data
>>     path = Path.cwd() / "../data"
>>     data_source = CSVDataSource(path)
>>     result = analyse_data(data_source)
>>     expected_output = [0.,0.22510286,0.18157299,0.1264423,0.9495481,0.27118211
>>     ...
>> ```
> {: .solution}
{: .challenge}

## Interfaces

Another important concept in software design is the idea of **interfaces** between different units in the code.
One kind of interface you might have come across are APIs (Application Programming Interfaces).
These allow separate systems to communicate with each other - such as a making an API request
to Google Maps to find the latitude and longitude of an address.

However, there are internal interfaces within our software that dictate how
different parts of the system interact with each other.
Even if these aren't thought out or documented, they still exist!

For example, our `Circle` class implicitly has an interface:
you can call `get_area` on it and it will return a number representing its area.

> ## Exercise: Identify the interface between `CSVDataSource` and `analyse_data`
> What is the interface that CSVDataSource has with `analyse_data`.
> Think about what functions `analyse_data` needs to be able to call,
> what parameters they need and what it will return.
>> ## Solution
>> The interface is the `load_inflammation_data` method.
>>
>> It takes no parameters.
>>
>> It returns a list where each entry is a 2D array of patient inflammation results by day
>> Any object we pass into `analyse_data` must conform to this interface.
> {: .solution}
{: .challenge}

## Polymorphism

It is possible to design multiple classes that each conform to the same interface.

For example, we could provide a `Rectangle` class:

```python
class Rectangle(Shape):
  def __init__(self, width, height):
    self.width = width
    self.height = height
  def get_area(self):
    return self.width * self.height
```

Like `Circle`, this class provides a `get_area` method.
The method takes the same number of parameters (none), and returns a number.
However, the implementation is different.

When classes share an interface, then we can use an instance of a class without
knowing what specific class is being used.
When we do this, it is called **polymorphism**.

Here is an example where we create a list of shapes (either Circles or Rectangles)
and can then find the total area.
Note how we call `get_area` and Python is able to call the appropriate `get_area`
for each of the shapes.

```python
my_circle = Circle(radius=10)
my_rectangle = Rectangle(width=5, height=3)
my_shapes = [my_circle, my_rectangle]
total_area = sum(shape.get_area() for shape in my_shapes)
```

This is an example of **abstraction** - when we are calculating the total
area, the method for calculating the area of each shape is abstracted away
to the relevant class.

### How polymorphism is useful

As we saw with the `Circle` and `Square` examples, we can use common interfaces and polymorphism
to abstract away the details of the implementation from the caller.

For example, we could replace our `CSVDataSource` with a class that reads a totally different format,
or reads from an external service.
All of these can be added in without changing the analysis.
Further - if we want to write a new analysis, we can support any of these data sources
for free with no further work.
That is, we have decoupled the job of loading the data from the job of analysing the data.

> ## Exercise: Introduce an alternative implementation of DataSource
> Create another class that repeatedly asks the user for paths to CSVs to analyse.
> It should implement the `load_inflammation_data` method.
> Finally, at run time provide an instance of the new implementation if the user hasn't
> put any files on the path.
>> ## Solution
>> You should have created a class that looks something like:
>> ```python
>> class UserProvidSpecificFilesDataSource:
>>   def load_inflammation_data(self):
>>     paths = []
>>     while(True):
>>       input_string = input('Enter path to CSV or press enter to process paths collected: ')
>>       if(len(input_string) == 0):
>>         print(f'Finished entering input - will process {len(paths)} CSVs')
>>         break
>>       if os.path.exists(input_string):
>>         paths.append(input_string)
>>       else:
>>         print(f'Path {input_string} does not exist, please enter a valid path')
>>
>>     data = map(models.load_csv, paths)
>>     return list(data)
>> ```
>> Additionally, in the controller will need to select the appropriate DataSource to
>> provide to the analysis:
>>```python
>> if len(InFiles) == 0:
>>   data_source = UserProvidSpecificFilesDataSource()
>> else:
>>   data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> analyse_data(data_source)
>>```
>> As you have seen, all these changes were made without modifying
>> the analysis code itself.
> {: .solution}
{: .challenge}

We can use this abstraction to also make testing more straight forward.
Instead of having our tests use real file system data, we can instead provide
a mock or dummy implementation instead of one of the DataSource classes.
This dummy implementation could just returns some fixed example data.
Separately, we can test the file parsing class `CSVDataSource` without having to understand
the specifics of the statistical analysis.

An convenient way to do this in Python is using Python's [mock object library](https://docs.python.org/3/library/unittest.mock.html).
These are a whole topic to themselves -
but a basic mock can be constructed using a couple of lines of code:

```python
from unittest.mock import Mock

mock_version = Mock()
mock_version.method_to_mock.return_value = 42
```

Here we construct a mock in the same way you'd construct a class.
Then we specify a method that we want to behave a specific way.

Now whenever you call `mock_version.method_to_mock()` the return value will be `42`.


> ## Exercise: Test using a mock or dummy implementation
> Create a mock for to provide as the `data_source` that returns some fixed data to test
> the `analyse_data` method.
> Use this mock in a test.
>> ## Solution
>> ```python
>> def test_compute_data_mock_source():
>>   from inflammation.compute_data import analyse_data
>>   data_source = Mock()
>>   data_source.load_inflammation_data.return_value = [[[0, 2, 0]],
>>                                                      [[0, 1, 0]]]
>>
>>   result = analyse_data(data_source)
>>   npt.assert_array_almost_equal(result, [0, math.sqrt(0.25) ,0])
>> ```
> {: .solution}
{: .challenge}

## Object Oriented Programming

Using classes, particularly when using polymorphism, are techniques that come from
**object oriented programming** (frequently abbreviated to OOP).
As with functional programming different programming languages will provide features to enable you
to write object oriented code.
For example, in Python you can create classes, and use polymorphism to call the
correct method on an instance (e.g when we called `get_area` on a shape, the appropriate `get_area` was called).

Object oriented programming also includes **information hiding**.
In this, certain fields might be marked private to a class,
preventing them from being modified at will.

This can be used to maintain invariants of a class (such as insisting that a circles radius is always non-negative).

There is also inheritance, which allows classes to specialise
the behaviour of other classes by **inheriting** from
another class and **overriding** certain methods.

As with functional programming, there are times when
object oriented programming is well suited, and times where it is not.

Good uses:

 * Representing real world objects with invariants
 * Providing alternative implementations such as we did with DataSource
 * Representing something that has a state that will change over the programs lifetime (such as elements of a GUI)

One downside of OOP is ending up with very large classes that contain complex methods.
As they are methods on the class, it can be hard to know up front what side effects it causes to the class.
This can make maintenance hard.

> ## Classes and functional programming
> Using classes is compatible with functional programming.
> In fact, grouping data into logical structures (such as three numbers into a vector)
> is a vital step in writing readable and maintainable code with any approach.
> However, when writing in a functional style, classes should be immutable.
> That is, the methods they provide are read-only.
> If you require the class to be different, you'd create a new instance
> with the new values.
> (that is, the functions should not modify the state of the class).
{: .callout}


Don't use features for the sake of using features.
Code should be as simple as it can be, but not any simpler.
If you know your function only makes sense to operate on circles, then
don't accept shapes just to use polymorphism!
