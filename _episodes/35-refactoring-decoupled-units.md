---
title: "Using classes to de-couple code."
teaching: 0
exercises: 0
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
>> ...
>>   data = load_inflammation_data(data_dir)
>> ...
>> ```
>> This is now easier to understand, as we don't need to understand the the file loading
>> to read the statistical analysis, and we don't have to understand the statistical analysis
>> when reading the data loading.
> {: .solution}
{: .challenge}

## Using classes to encapsulate data and behaviours

Abstractedly, we can talk about units of code, where we are thinking of the unit doing one "thing".
In practise, in Python there are three ways we can create defined units of code.
The first is functions, which we have used.
The next level up is **classes**.
Finally, there are also modules and packages, which we won't cover.

A class is a way of grouping together data with some specific methods.
In Python, you can declare a class as follows:

```python
class MyClass:
  pass
```

They are typically named using `UpperCase`.

You can then **construct** a class elsewhere in your code by doing the following:

```python
my_class = MyClass()
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

Classes have a number of uses.

* Encapsulating data - such as grouping three numbers together into a Vector class
* Maintaining invariants - perhaps when storing a file path it only makes sense for that to resolve to a valid file - by storing the string in a class with a method for setting it (a **setter**), that method can validate the new value before updating the value.
* Encapsulating behaviour - such as a class representing a UI state, modifying some value will automatically
  force the relevant portion of the UI to be updated.

> ## Maintaining Invariants
> Maintaining invariants can be a really powerful tool in debugging.
> Without invariants, you can find bugs where some data is in an invalid
> state, but the problem only appears when you try to use the data.
> This makes it hard to track down the cause of the bug.
> By using classes to maintain invariants, you can force the issue
> to appear when the invalid data is set, that is, the source of the bug.
{: .callout}

> ## Exercise: Use a class to configure loading
> Put the `load_inflammation_data` function we wrote in the last exercise as a member method
> of a new class called `CSVDataSource`.
> Put the configuration of where to load the files in the classes constructor.
> Once this is done, you can construct this class outside the the statistical analysis
> and pass the instance in to `analyse_data`.
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
>>   ...
>>   data = data_source.load_inflammation_data()
>> ```
>>
>> In the controller, you might have something like:
>>
>> ```python
>> data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>> data_result = analyse_data(data_source)
>> ```
>> Note in all these refactorings the behaviour is unchanged,
>> so we can still run our original tests to ensure we've not
>> broken anything.
> {: .solution}
{: .challenge}

## Interfaces

Another important concept in software design is the idea of **interfaces** between different units in the code.
One kind of interface you might have come across are APIs (Application Programming Interfaces).
These allow separate systems to communicate with each other - such as a making an API request
to Google Maps to find the latitude and longitude of an address.

However, there are internal interfaces within our software that dictate how
different units of the system interact with each other.
Even if these aren't thought out or documented, they still exist!

For example, there is an interface for how the statistical analysis in `analyse_data`
uses the class `CSVDataSource` - the method `load_inflammation_data`, how it should be called
and what it will return.

Interfaces are important to get right - a messy interface will force tighter coupling between
two units in the system.
Unfortunately, it would be an entire course to cover everything to consider in interface design.

In addition to the abstract notion of an interface, many programming languages
support creating interfaces as a special kind of class.
Python doesn't support this explicitly, but we can still use this feature with
regular classes.
An interface class will define some methods, but not provide an implementation:

```python
class Shape:
  def get_area():
    raise NotImplementedError
```

> ## Exercise: Define an interface for your class
> As discussed, there is an interface between the CSVDataSource and the analysis.
> Write an interface(that is, a class that defines some empty methods) called `InflammationDataSource`
> that makes this interface explicit.
> Document the format the data will be returned in.
>> ## Solution
>> ```python
>> class InflammationDataSource:
>>     """
>>     An interface for providing a series of inflammation data.
>>     """
>>
>>     def load_inflammation_data(self):
>>         """
>>         Loads the data and returns it as a list, where each entry corresponds to one file,
>>         and each entry is a 2D array with patients inflammation by day.
>>         :returns: A list where each entry is a 2D array of patient inflammation results by day
>>         """
>>         raise NotImplementedError
>> ```
> {: .solution}
{: .challenge}

An interface on its own is not useful - it cannot be instantiated.
The next step is to create a class that **implements** the interface.
That is, create a class that inherits from the interface and then provide
implementations of all the methods on the interface.
To return to our `Shape` interface, we can write classes that implement this
interface, with different implementations:

```python
class Circle(Shape):
  ...
  def get_area(self):
    return math.pi * self.radius * self.radius

class Rectangle(Shape):
  ...
  def get_area(self):
    return self.width * self.height
```

As you can see, by putting `ShapeInterface`` in brackets after the class
we are saying a `Circle` **is a** `Shape`.

> ## Exercise: Implement the interface
> Modify the existing class to implement the interface.
> Ensure the method matches up exactly to the interface.
>> ## Solution
>> We can create a class that implements `load_inflammation_data`.
>> We can lift the code into this new class.
>>
>> ```python
>> class CSVDataSource(InflammationDataSource):
>> ```
> {: .solution}
{: .challenge}

## Polymorphism

Where this gets useful is by using a concept called **polymorphism**
which is a fancy way of saying we can use an instance of a class and treat
it as a `Shape`, without worrying about whether it is a `Circle` or a `Rectangle`.


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

As we saw with the `Circle` and `Square` examples, we can use interfaces and polymorphism
to provide different implementations of the same interface.

For example, we could replace our `CSVReader` with a class that reads a totally different format,
or reads from an external service.
All of these can be added in without changing the analysis.
Further - if we want to write a new analysis, we can support any of these data sources
for free with no further work.
That is, we have decoupled the job of loading the data from the job of analysing the data.

> ## Exercise: Introduce an alternative implementation of DataSource
> Create another class that repeatedly asks the user for paths to CSVs to analyse.
> It should inherit from the interface and implement the `load_inflammation_data` method.
> Finally, at run time provide an instance of the new implementation if the user hasn't
> put any files on the path.
>> ## Solution
>> You should have created a class that looks something like:
>> ```python
>> class UserProvidSpecificFilesDataSource(InflammationDataSource):
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
>> data_result = analyse_data(data_source)
>>```
>> As you have seen, all these changes were made without modifying
>> the analysis code itself.
> {: .solution}
{: .challenge}

We can use this abstraction to also make testing more straight forward.
Instead of having our tests use real file system data, we can instead provide
a mock or dummy implementation of the `InflammationDataSource` that just returns some example data.
Separately, we can test the file parsing class `CSVReader` without having to understand
the specifics of the statistical analysis.

An convenient way to do this in Python is using Mocks.
These are a whole topic to themselves - but a basic mock can be constructed using a couple of lines of code:

```python
mock_version = Mock()
mock_version.method_to_mock.return_value = 42
```

Here we construct a mock in the same way you'd construct a class.
Then we specify a method that we want to behave a specific way.

Now whenever you call `mock_version.method_to_mock()` the return value will be `42`.


> ## Exercise: Test using a mock or dummy implementation
> Create a mock for the `InflammationDataSource` that returns some fixed data to test
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
to write object oriented programming.
For example, in Python you can create classes, and use polymorphism to call the
correct method on an instance (e.g when we called `get_area` on a shape, the appropriate `get_area` was called.)

Object oriented programming also includes **information hiding**.
In this, certain fields might be marked private to a class,
preventing them from being modified at will.

This can be used to maintain invariants of a class (such as insisting that a circles radius is always non-negative).

There is also inheritance, which allows classes to specialise the behaviour of other classes by **inheriting** from
another class and **overriding** certain methods.

As with functional programming, there are times when object oriented programming is well suited, and times where it is not.

Good uses:

 * Representing real world objects with invariants
 * Providing alternative implementations such as we did with DataSource
 * Representing something that has a state that will change over the programs lifetime (such as elements of a GUI)

One downside of OOP is ending up with very large classes that contain complex methods.
As they are methods on the class, it can be hard to know up front what side effects it causes to the class.
This can make maintenance hard.

Grouping data together into logical structures (such as three numbers into a vector) is a vital step in writing
readable and maintainable code.
However, when using classes in this way it is best for them to be immutable (can't be changed)
It is worth noting that you can use classes to group data together - a very useful feature that you should be using everywhere
 - does not you can't be practising functional programming:

You can still have classes, and these classes might have read-only methods on (such as the `get_area` we defined for shapes)
but then still have your complex logic operate on

Don't use features for the sake of using features.
Code should be as simple as it can be, but not any simpler.
If you know your function only makes sense to operate on circles, then
don't accept shapes just to use polymorphism!
