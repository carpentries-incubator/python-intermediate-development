---
title: "Extra Content: Object Oriented Programming"
teaching: 30
exercises: 35
---

::: questions:
- How can we use code to describe the structure of data?
- How should the relationships between structures be described?
:::

::: objectives
- Describe the core concepts that define the object oriented paradigm
- Use classes to encapsulate data within a more complex program
- Structure concepts within a program in terms of sets of behaviour
- Identify different types of relationship between concepts within a program
- Structure data within a program using these relationships
:::

Object oriented programming is a programming paradigm based on the concept of objects,
which are data structures that contain (encapsulate) data and code.
Data is encapsulated in the form of fields (attributes) of objects,
while code is encapsulated in the form of procedures (methods)
that manipulate objects' attributes and define "behaviour" of objects.
So, in object oriented programming,
we first think about the data and the things that we are modelling -
and represent these by objects -
rather than define the logic of the program,
and code becomes a series of interactions between objects.

## Structuring Data

One of the main difficulties we encounter when building more complex software is
how to structure our data.
So far, we have been processing data from a single source and with a simple tabular structure,
but it would be useful to be able to combine data from a range of different sources
and with more data than just an array of numbers.

```python
data = np.array([[1., 2., 3.],
                 [4., 5., 6.]])
```

Using this data structure has the advantage of
being able to use NumPy operations to process the data
and Matplotlib to plot it,
but often we need to have more structure than this.
For example, we may need to attach more information about the patients
and store this alongside our measurements of inflammation.

We can do this using the Python data structures we are already familiar with,
dictionaries and lists.
For instance, we could attach a name to each of our patients:

```python
patients = [
    {
        'name': 'Alice',
        'data': [1., 2., 3.],
    },
    {
        'name': 'Bob',
        'data': [4., 5., 6.],
    },
]
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: Structuring Data

Write a function, called `attach_names`,
which can be used to attach names to our patient dataset.
When used as below, it should produce the expected output.

If you are not sure where to begin,
think about ways you might be able to effectively loop over two collections at once.
Also, do not worry too much about the data type of the `data` value,
it can be a Python list, or a NumPy array - either is fine.

```python
data = np.array([[1., 2., 3.],
                 [4., 5., 6.]])

output = attach_names(data, ['Alice', 'Bob'])
print(output)
```

```output
[
    {
        'name': 'Alice',
        'data': [1., 2., 3.],
    },
    {
        'name': 'Bob',
        'data': [4., 5., 6.],
    },
]
```

:::::::::::::::  solution

## Solution

One possible solution, perhaps the most obvious,
is to use the `range` function to index into both lists at the same location:

```python
def attach_names(data, names):
    """Create datastructure containing patient records."""
    output = []

    for i in range(len(data)):
        output.append({'name': names[i],
                       'data': data[i]})

    return output
```

However, this solution has a potential problem that can occur sometimes,
depending on the input.
What might go wrong with this solution?
How could we fix it?

:::::::::::::::  solution

## A Better Solution

What would happen if the `data` and `names` inputs were different lengths?

If `names` is longer, we will loop through, until we run out of rows in the `data` input,
at which point we will stop processing the last few names.
If `data` is longer, we will loop through, but at some point we will run out of names -
but this time we try to access part of the list that does not exist,
so we will get an exception.

A better solution would be to use the `zip` function,
which allows us to iterate over multiple iterables without needing an index variable.
The `zip` function also limits the iteration to whichever of the iterables is smaller,
so we will not raise an exception here,
but this might not quite be the behaviour we want,
so we will also explicitly `assert` that the inputs should be the same length.
Checking that our inputs are valid in this way is an example of a precondition,
which we introduced conceptually in an earlier episode.

If you have not previously come across the `zip` function,
read [this section](https://docs.python.org/3/library/functions.html#zip)
of the Python documentation.

```python
def attach_names(data, names):
    """Create datastructure containing patient records."""
    assert len(data) == len(names)
    output = []

    for data_row, name in zip(data, names):
        output.append({'name': name,
                       'data': data_row})

    return output
```

:::::::::::::::::::::::::

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Classes in Python

Using nested dictionaries and lists should work for some of the simpler cases
where we need to handle structured data,
but they get quite difficult to manage once the structure becomes a bit more complex.
For this reason, in the object oriented paradigm,
we use **classes** to help with managing this data
and the operations we would want to perform on it.
A class is a **template** (blueprint) for a structured piece of data,
so when we create some data using a class,
we can be certain that it has the same structure each time.

With our list of dictionaries we had in the example above,
we have no real guarantee that each dictionary has the same structure,
e.g. the same keys (`name` and `data`) unless we check it manually.
With a class, if an object is an **instance** of that class
(i.e. it was made using that template),
we know it will have the structure defined by that class.
Different programming languages make slightly different guarantees
about how strictly the structure will match,
but in object oriented programming this is one of the core ideas -
all objects derived from the same class must follow the same behaviour.

You may not have realised, but you should already be familiar with
some of the classes that come bundled as part of Python, for example:

```python
my_list = [1, 2, 3]
my_dict = {1: '1', 2: '2', 3: '3'}
my_set = {1, 2, 3}

print(type(my_list))
print(type(my_dict))
print(type(my_set))
```

```output
<class 'list'>
<class 'dict'>
<class 'set'>
```

Lists, dictionaries and sets are a slightly special type of class,
but they behave in much the same way as a class we might define ourselves:

- They each hold some data (**attributes** or **state**).
- They also provide some methods describing the behaviours of the data -
  what can the data do and what can we do to the data?

The behaviours we may have seen previously include:

- Lists can be appended to
- Lists can be indexed
- Lists can be sliced
- Key-value pairs can be added to dictionaries
- The value at a key can be looked up in a dictionary
- The union of two sets can be found (the set of values present in any of the sets)
- The intersection of two sets can be found (the set of values present in all of the sets)

## Encapsulating Data

Let us start with a minimal example of a class representing our patients.

```python
# file: inflammation/models.py

class Patient:
    def __init__(self, name):
        self.name = name
        self.observations = []

alice = Patient('Alice')
print(alice.name)
```

```output
Alice
```

Here we have defined a class with one method: `__init__`.
This method is the **initialiser** method,
which is responsible for setting up the initial values and structure of the data
inside a new instance of the class -
this is very similar to **constructors** in other languages,
so the term is often used in Python too.
The `__init__` method is called every time we create a new instance of the class,
as in `Patient('Alice')`.
The argument `self` refers to the instance on which we are calling the method
and gets filled in automatically by Python -
we do not need to provide a value for this when we call the method.

Data encapsulated within our Patient class includes
the patient's name and a list of inflammation observations.
In the initialiser method,
we set a patient's name to the value provided,
and create a list of inflammation observations for the patient (initially empty).
Such data is also referred to as the attributes of a class
and holds the current state of an instance of the class.
Attributes are typically hidden (encapsulated) internal object details
ensuring that access to data is protected from unintended changes.
They are manipulated internally by the class,
which, in addition, can expose certain functionality as public behavior of the class
to allow other objects to interact with this class' instances.

## Encapsulating Behaviour

In addition to representing a piece of structured data
(e.g. a patient who has a name and a list of inflammation observations),
a class can also provide a set of functions, or **methods**,
which describe the **behaviours** of the data encapsulated in the instances of that class.
To define the behaviour of a class we add functions which operate on the data the class contains.
These functions are the member functions or methods.

Methods on classes are the same as normal functions,
except that they live inside a class and have an extra first parameter `self`.
Using the name `self` is not strictly necessary, but is a very strong convention -
it is extremely rare to see any other name chosen.
When we call a method on an object,
the value of `self` is automatically set to this object - hence the name.
As we saw with the `__init__` method previously,
we do not need to explicitly provide a value for the `self` argument,
this is done for us by Python.

Let us add another method on our Patient class that adds a new observation to a Patient instance.

```python
# file: inflammation/models.py

class Patient:
    """A patient in an inflammation study."""
    def __init__(self, name):
        self.name = name
        self.observations = []

    def add_observation(self, value, day=None):
        if day is None:
            if self.observations:
                day = self.observations[-1]['day'] + 1
            else:
                day = 0

        new_observation = {
            'day': day,
            'value': value,
        }

        self.observations.append(new_observation)
        return new_observation

alice = Patient('Alice')
print(alice)

observation = alice.add_observation(3)
print(observation)
print(alice.observations)
```

```output
<__main__.Patient object at 0x7fd7e61b73d0>
{'day': 0, 'value': 3}
[{'day': 0, 'value': 3}]
```

Note also how we used `day=None` in the parameter list of the `add_observation` method,
then initialise it if the value is indeed `None`.
This is one of the common ways to handle an optional argument in Python,
so we will see this pattern quite a lot in real projects.

:::::::::::::::::::::::::::::::::::::::::  callout

## Class and Static Methods

Sometimes, the function we are writing does not need access to
any data belonging to a particular object.
For these situations, we can instead use a **class method** or a **static method**.
Class methods have access to the class that they are a part of,
and can access data on that class -
but do not belong to a specific instance of that class,
whereas static methods have access to neither the class nor its instances.

By convention, class methods use `cls` as their first argument instead of `self` -
this is how we access the class and its data,
just like `self` allows us to access the instance and its data.
Static methods have neither `self` nor `cls`
so the arguments look like a typical free function.
These are the only common exceptions to using `self` for a method's first argument.

Both of these method types are created using **decorators** -
for more information see
the [classmethod](https://docs.python.org/3/library/functions.html#classmethod)
and [staticmethod](https://docs.python.org/3/library/functions.html#staticmethod)
decorator sections of the Python documentation.


::::::::::::::::::::::::::::::::::::::::::::::::::

### Dunder Methods

Why is the `__init__` method not called `init`?
There are a few special method names that we can use
which Python will use to provide a few common behaviours,
each of which begins and ends with a **d**ouble-**under**score,
hence the name **dunder method**.

When writing your own Python classes,
you'll almost always want to write an `__init__` method,
but there are a few other common ones you might need sometimes.
You may have noticed in the code above that the method `print(alice)`
returned `<__main__.Patient object at 0x7fd7e61b73d0>`,
which is the string representation of the `alice` object.
We may want the print statement to display the object's name instead.
We can achieve this by overriding the `__str__` method of our class.

```python
# file: inflammation/models.py

class Patient:
    """A patient in an inflammation study."""
    def __init__(self, name):
        self.name = name
        self.observations = []

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1]['day'] + 1

            except IndexError:
                day = 0


        new_observation = {
            'day': day,
            'value': value,
        }

        self.observations.append(new_observation)
        return new_observation

    def __str__(self):
        return self.name


alice = Patient('Alice')
print(alice)
```

```output
Alice
```

These dunder methods are not usually called directly,
but rather provide the implementation of some functionality we can use -
we didn't call `alice.__str__()`,
but it was called for us when we did `print(alice)`.
Some we see quite commonly are:

- `__str__` - converts an object into its string representation, used when you call `str(object)` or `print(object)`
- `__getitem__` - Accesses an object by key, this is how `list[x]` and `dict[x]` are implemented
- `__len__` - gets the length of an object when we use `len(object)` - usually the number of items it contains

There are many more described in the Python documentation,
but it's also worth experimenting with built in Python objects to
see which methods provide which behaviour.
For a more complete list of these special methods,
see the [Special Method Names](https://docs.python.org/3/reference/datamodel.html#special-method-names)
section of the Python documentation.

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: A Basic Class

Implement a class to represent a book.
Your class should:

- Have a title
- Have an author
- When printed using `print(book)`, show text in the format "title by author"

```python
book = Book('A Book', 'Me')

print(book)
```

```output
A Book by Me
```

:::::::::::::::  solution

## Solution

```python
class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author

    def __str__(self):
        return self.title + ' by ' + self.author
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

### Properties

The final special type of method we will introduce is a **property**.
Properties are methods which behave like data -
when we want to access them, we do not need to use brackets to call the method manually.

```python
# file: inflammation/models.py

class Patient:
    ...

    @property
    def last_observation(self):
        return self.observations[-1]

alice = Patient('Alice')

alice.add_observation(3)
alice.add_observation(4)

obs = alice.last_observation
print(obs)
```

```output
{'day': 1, 'value': 4}
```

You may recognise the `@` syntax from episodes on
parameterising unit tests and functional programming -
`property` is another example of a **decorator**.
In this case the `property` decorator is taking the `last_observation` function
and modifying its behaviour,
so it can be accessed as if it were a normal attribute.
It is also possible to make your own decorators, but we will not cover it here.

## Relationships Between Classes

We now have a language construct for grouping data and behaviour
related to a single conceptual object.
The next step we need to take is to describe the relationships between the concepts in our code.

There are two fundamental types of relationship between objects
which we need to be able to describe:

1. Ownership - x **has a** y - this is **composition**
2. Identity - x **is a** y - this is **inheritance**

### Composition

You should hopefully have come across the term **composition** already -
in the novice Software Carpentry, we use composition of functions to reduce code duplication.
That time, we used a function which converted temperatures in Celsius to Kelvin
as a **component** of another function which converted temperatures in Fahrenheit to Kelvin.

In the same way, in object oriented programming, we can make things components of other things.

We often use composition where we can say 'x *has a* y' -
for example in our inflammation project,
we might want to say that a doctor *has* patients
or that a patient *has* observations.

In the case of our example, we are already saying that patients have observations,
so we are already using composition here.
We are currently implementing an observation as a dictionary with a known set of keys though,
so maybe we should make an `Observation` class as well.

```python
# file: inflammation/models.py

class Observation:
    def __init__(self, day, value):
        self.day = day
        self.value = value

    def __str__(self):
        return str(self.value)

class Patient:
    """A patient in an inflammation study."""
    def __init__(self, name):
        self.name = name
        self.observations = []

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1].day + 1

            except IndexError:
                day = 0

        new_observation = Observation(day, value)

        self.observations.append(new_observation)
        return new_observation

    def __str__(self):
        return self.name


alice = Patient('Alice')
obs = alice.add_observation(3)

print(obs)
```

```output
3
```

Now we are using a composition of two custom classes to
describe the relationship between two types of entity in the system that we are modelling.

### Inheritance

The other type of relationship used in object oriented programming is **inheritance**.
Inheritance is about data and behaviour shared by classes,
because they have some shared identity - 'x *is a* y'.
If class `X` inherits from (*is a*) class `Y`,
we say that `Y` is the **superclass** or **parent class** of `X`,
or `X` is a **subclass** of `Y`.

If we want to extend the previous example to also manage people who aren't patients
we can add another class `Person`.
But `Person` will share some data and behaviour with `Patient` -
in this case both have a name and show that name when you print them.
Since we expect all patients to be people (hopefully!),
it makes sense to implement the behaviour in `Person` and then reuse it in `Patient`.

To write our class in Python,
we used the `class` keyword, the name of the class,
and then a block of the functions that belong to it.
If the class **inherits** from another class,
we include the parent class name in brackets.

```python
# file: inflammation/models.py

class Observation:
    def __init__(self, day, value):
        self.day = day
        self.value = value

    def __str__(self):
        return str(self.value)

class Person:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Patient(Person):
    """A patient in an inflammation study."""
    def __init__(self, name):
        super().__init__(name)
        self.observations = []

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1].day + 1

            except IndexError:
                day = 0

        new_observation = Observation(day, value)

        self.observations.append(new_observation)
        return new_observation

alice = Patient('Alice')
print(alice)

obs = alice.add_observation(3)
print(obs)

bob = Person('Bob')
print(bob)

obs = bob.add_observation(4)
print(obs)
```

```output
Alice
3
Bob
AttributeError: 'Person' object has no attribute 'add_observation'
```

As expected, an error is thrown because we cannot add an observation to `bob`,
who is a Person but not a Patient.

We see in the example above that to say that a class inherits from another,
we put the **parent class** (or **superclass**) in brackets after the name of the **subclass**.

There is something else we need to add as well -
Python does not automatically call the `__init__` method on the parent class
if we provide a new `__init__` for our subclass,
so we will need to call it ourselves.
This makes sure that everything that needs to be initialised on the parent class has been,
before we need to use it.
If we do not define a new `__init__` method for our subclass,
Python will look for one on the parent class and use it automatically.
This is true of all methods -
if we call a method which does not exist directly on our class,
Python will search for it among the parent classes.
The order in which it does this search is known as the **method resolution order** -
a little more on this in the Multiple Inheritance callout below.

The line `super().__init__(name)` gets the parent class,
then calls the `__init__` method,
providing the `name` variable that `Person.__init__` requires.
This is quite a common pattern, particularly for `__init__` methods,
where we need to make sure an object is initialised as a valid `X`,
before we can initialise it as a valid `Y` -
e.g. a valid `Person` must have a name,
before we can properly initialise a `Patient` model with their inflammation data.

:::::::::::::::::::::::::::::::::::::::::  callout

## Composition vs Inheritance

When deciding how to implement a model of a particular system,
you often have a choice of either composition or inheritance,
where there is no obviously correct choice.
For example, it is not obvious whether a photocopier *is a* printer and *is a* scanner,
or *has a* printer and *has a* scanner.

```python
class Machine:
    pass

class Printer(Machine):
    pass

class Scanner(Machine):
    pass

class Copier(Printer, Scanner):
    # Copier `is a` Printer and `is a` Scanner
    pass
```

```python
class Machine:
    pass

class Printer(Machine):
    pass

class Scanner(Machine):
    pass

class Copier(Machine):
    def __init__(self):
        # Copier `has a` Printer and `has a` Scanner
        self.printer = Printer()
        self.scanner = Scanner()
```

Both of these would be perfectly valid models and would work for most purposes.
However, unless there is something about how you need to use the model
which would benefit from using a model based on inheritance,
it is usually recommended to opt for **composition over inheritance**.
This is a common design principle in the object oriented paradigm and is worth remembering,
as it is very common for people to overuse inheritance once they have been introduced to it.

For much more detail on this see the
[Python Design Patterns guide](https://python-patterns.guide/gang-of-four/composition-over-inheritance/).


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Multiple Inheritance

**Multiple Inheritance** is when a class inherits from more than one direct parent class.
It exists in Python, but is often not present in other Object Oriented languages.
Although this might seem useful, like in our inheritance-based model of the photocopier above,
it is best to avoid it unless you are sure it is the right thing to do,
due to the complexity of the inheritance heirarchy.
Often using multiple inheritance is a sign you should instead be using composition -
again like the photocopier model above.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Exercise: A Model Patient

Let us use what we have learnt in this episode and combine it with what we have learnt on
[software requirements](../episodes/31-software-requirements.md)
to formulate and implement a
[few new solution requirements](../episodes/31-software-requirements.md#exercise-new-solution-requirements)
to extend the model layer of our clinical trial system.

Let us start with extending the system such that there must be
a `Doctor` class to hold the data representing a single doctor, which:

- must have a `name` attribute
- must have a list of patients that this doctor is responsible for.

In addition to these, try to think of an extra feature you could add to the models
which would be useful for managing a dataset like this -
imagine we are running a clinical trial, what else might we want to know?
Try using Test Driven Development for any features you add:
write the tests first, then add the feature.
The tests have been started for you in `tests/test_patient.py`,
but you will probably want to add some more.

Once you have finished the initial implementation, do you have much duplicated code?
Is there anywhere you could make better use of composition or inheritance
to improve your implementation?

For any extra features you have added,
explain them and how you implemented them to your neighbour.
Would they have implemented that feature in the same way?

:::::::::::::::  solution

## Solution

One example solution is shown below.
You may start by writing some tests (that will initially fail),
and then develop the code to satisfy the new requirements and pass the tests.

```python
# file: tests/test_patient.py
"""Tests for the Patient model."""
from inflammation.models import Doctor, Patient, Person

def test_create_patient():
    """Check a patient is created correctly given a name."""
    name = 'Alice'
    p = Patient(name=name)
    assert p.name == name

def test_create_doctor():
    """Check a doctor is created correctly given a name."""
    name = 'Sheila Wheels'
    doc = Doctor(name=name)
    assert doc.name == name

def test_doctor_is_person():
    """Check if a doctor is a person."""
    doc = Doctor("Sheila Wheels")
    assert isinstance(doc, Person)

def test_patient_is_person():
    """Check if a patient is a person. """
    alice = Patient("Alice")
    assert isinstance(alice, Person)

def test_patients_added_correctly():
    """Check patients are being added correctly by a doctor. """
    doc = Doctor("Sheila Wheels")
    alice = Patient("Alice")
    doc.add_patient(alice)
    assert doc.patients is not None
    assert len(doc.patients) == 1

def test_no_duplicate_patients():
    """Check adding the same patient to the same doctor twice does not result in duplicates. """
    doc = Doctor("Sheila Wheels")
    alice = Patient("Alice")
    doc.add_patient(alice)
    doc.add_patient(alice)
    assert len(doc.patients) == 1
...
```

```
# file: inflammation/models.py
...
class Person:
    """A person."""
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Patient(Person):
    """A patient in an inflammation study."""
    def __init__(self, name):
        super().__init__(name)
        self.observations = []

    def add_observation(self, value, day=None):
        if day is None:
            try:
                day = self.observations[-1].day + 1
            except IndexError:
                day = 0
        new_observation = Observation(day, value)
        self.observations.append(new_observation)
```

:::::::::::::::::::::::::

```python
    return new_observation
```

> class Doctor(Person):
> """A doctor in an inflammation study."""
> def **init**(self, name):
> super().**init**(name)
> self.patients = []
> 
> ```
> def add_patient(self, new_patient):
>     # A crude check by name if this patient is already looked after
>     # by this doctor before adding them
>     for patient in self.patients:
>         if patient.name == new_patient.name:
>             return
>     self.patients.append(new_patient)
> ```
> 
> ...
> 
> ```
> ```

::::::::::::::::::::::::::::::::::::::::::::::::::


::: keypoints
- Object oriented programming is a programming paradigm based on the concept of classes,
  which encapsulate data and code.
- Classes allow us to organise data into distinct concepts.
- By breaking down our data into classes, we can reason about the behaviour of parts
  of our data.
- Relationships between concepts can be described using inheritance (*is a*) and composition
  (*has a*).
:::

