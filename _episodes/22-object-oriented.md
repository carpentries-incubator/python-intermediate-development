---
title: "Object Oriented Programming"
teaching: 40
exercises: 20
questions:
- "How can we use code to describe the structure of data?"
- "How should the relationships between structures be described?"
objectives:
- "Describe the core concepts that define the Object Oriented Paradigm"
- "Use classes to encapsulate data within a more complex program"
- "Structure concepts within a program in terms of sets of behaviour"
- "Identify different types of relationship between concepts within a program"
- "Structure data within a program using these relationships"
keypoints:
- "Classes allow us to organise data into distinct concepts."
- "By breaking down our data into classes, we can reason about the behaviour of parts of our data."
- "Relationships between concepts can be described using inheritance (*is a*) and composition (*has a*)."
---

## Introduction

With FizzBuzz, we saw an example of where Object Oriented Programming works badly, so where does it work well?

This paradigm is useful when data is structured, often because it represents an entity which exists in the real world.
This entity has **attributes** which can be measured, and **behaviours** which it can perform.
An obvious example of an entity with attributes and behaviours is a person.

People have names, heights, weights, etc., all of which might be useful for software to know about in some context.
In the context of our clinical trial data system, we might be interested in all three of these, but also in their measurements of inflammation.

Let's continue to develop this system, using Object Oriented Programming to design a more complete model of our patients.


## Encapsulating Data

One of the main difficulties we encounter when building more complex software is how to structure our data.
So far, we've been processing data from a single source and with a simple tabular structure, but it would be useful to be able to to combine data from a range of different sources and with more data than just an array of numbers.

~~~
data = np.array([1., 2., 3.],
                [4., 5., 6.])
~~~
{: .language-python}

Using this data structure has the advantage of being able to use NumPy operations to process the data and Matplotlib to plot it, but often we need to have more structure than this.
For example, we may need to attach more information about the patients and store this alongside our measurements of inflammation.

We can do this using the Python data structures we're already familiar with, dictionaries and lists.
For instance, we could attach a name to each of our patients:

~~~
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
~~~
{: .language-python}

> ## Structuring Data
>
> Write a function, called `attach_names`, which can be used to attach names to our patient dataset.
> When used as below, it should produce the expected output.
>
> If you're not sure where to begin, think about ways you might be able to effectively loop over two collections at once.
> Also, don't worry too much about the data type of the `data` value, it can be a Python list, or a Numpy array - either is fine.
>
> ~~~
> data = np.array([1., 2., 3.],
>                 [4., 5., 6.])
>
> output = attach_names(data, ['Alice', 'Bob'])
> print(output)
> ~~~
> {: .language-python}
>
> ~~~
> [
>     {
>         'name': 'Alice',
>         'data': [1., 2., 3.],
>     },
>     {
>         'name': 'Bob',
>         'data': [4., 5., 6.],
>     },
> ]
> ~~~
> {: .output}
>
> > ## Solution
> >
> > One possible solution, perhaps the most obvious, is to use the `range` function to index into both lists at the same location:
> >
> > ~~~
> > def attach_names(data, names):
> >     """Create datastructure containing patient records."""
> >     output = []
> >
> >     for i in range(len(data)):
> >         output.append({'name': names[i],
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
> > > What would happen if the `data` and `names` inputs were different lengths?
> > >
> > > If `names` is longer, we'll loop through, until we run out of rows in the `data` input, at which point we'll stop processing the last few names.
> > > If `data` is longer, we'll loop through, but at some point we'll run out of names - but this time we try to access part of the list that doesn't exist, so we raise an exception.
> > >
> > > A better solution would be to use the `zip` function, which limits us to whichever of `data` and `names` is shorter.
> > > This way, we shouldn't raise an exception - but, if we really want to avoid errors, we might want to explicitly `assert` that the inputs should be the same length.
> > > Checking that our inputs are valid in this way is known as a **precondition**.
> > >
> > > If you've not previously come across this function, read [this section](https://docs.python.org/3/library/functions.html#zip) of the Python documentation.
> > >
> > > ~~~
> > > def attach_names(data, names):
> > >     """Create datastructure containing patient records."""
> > >     assert len(data) == len(names)
> > >     output = []
> > >
> > >     for data_row, name in zip(data, names):
> > >         output.append({'name': name,
> > >                        'data': data_row})
> > >
> > >     return output
> > > ~~~
> > > {: .language-python}
> > {: .solution}
> {: .solution}
{: .challenge}

### Classes in Python

Using nested dictionaries and lists should work for most cases where we need to handle structured data, but they get quite difficult to manage once the structure becomes a bit more complex.
For this reason, in the Object Oriented paradigm, we use **classes** to help with this data structure.
A class is a **template** for a piece of data, so when we create some data using a class, we can be certain that it has the same structure each time.
In addition to representing a piece of structured data, a class can also provide a set of functions, or **methods** which describe the **behaviours** of the data.

With our list of dictionaries we had in the example above, we have no real guarantee that each dictionary has the same structure, e.g. the same keys (`name` and `data`) unless we check the code ourselves.
With a class, if an object is an **instance** of that class (i.e. it was made using that template), we know it will have the structure defined by that class.

Different programming languages make slightly different guarantees about how strictly the structure will match, but in object oriented programming this is one of the core ideas.

For an example of a class, let's create a model of an academic publishing papers.
We'll add extra functionality to this model as we learn more about Object Oriented Programming in Python.

~~~
class Academic:
    def __init__(self, name):
        self.name = name
        self.papers = []

alice = Academic('Alice')
print(alice.name)
~~~
{: .language-python}

Here we've defined a class with one method: `__init__`.
This method is the **initialiser** method, which is responsible for setting up the initial values and structure of the data inside a new instance of the class - this is very similar to **constructors** in other languages, so the term is often used in Python too.
The `__init__` method is called every time we create a new instance of the class, as in `Academic('Alice')`.
The argument `self` refers to the instance on which we are calling the method and does is filled in automatically by Python - we don't need to provide a value for this when we call the method.

In our `Academic` initialiser method, we set their name to a value provided, and create a list of papers they've published, which is currently empty.

You may not have realised, but you should already be familiar with some of the classes that come bundled as part of Python.

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

- They each contain data, as you will have seen before.
- They also provide a set the set of methods describing the behaviours of the data.

The behaviours we may have seen previously include:

- Lists can be appended to
- Lists can be indexed (we’ll get to this later)
- Lists can be sliced (we won’t get to this)
- Key-value pairs can be added to dictionaries
- The value at a key can be looked up in a dictionary
- The union of two sets can be found
- The intersection of two sets can be found

> ## Test Driven Development
>
> In yesterday's lesson we learnt how to create **unit tests** to make sure our code is behaving as we intended.
> **Test Driven Development** (TDD) is an extension of this.
> If we can define a set of tests for everything our code needs to do, then why not treat those tests as the specification.
>
> When doing Test Driven Development, we write our tests first and only write enough code to make the tests pass.
> We tend to do this at the level of individual features - define the feature, write the tests, write the code.
> The main advantages are:
>   - It forces us to think about how our code will be used before we write it
>   - It prevents us from doing work that we don't need to do, e.g. "I might need this later..."
>
> You may also see this process called **Red, Green, Refactor**: 'Red' for the failing tests, 'Green' for the code that makes them pass, then 'Refactor' (tidy up) the result.
>
> For the challenges from here on, try to first convert the specification into a unit test, then try writing the code to pass the test.
>
{: .callout}


## Encapsulating Behaviour

Just like the standard Python datastructures, our classes can have behaviour associated with them.

To define the behaviour of a class we can add functions which operate on the data the class contains.
These functions are the member functions or methods.

Member functions are the same as normal functions (alternatively known as **free functions**), except that they live inside a class and have an extra first parameter `self`.
Using the name `self` isn't strictly necessary, but is a very strong convention - it's extremely rare to see any other name chosen.
When we call a method on an object, the value of `self` is automatically set to this object - hence the name.
As we saw with the `__init__` method previously, we don't need to explicitly provide a value for the `self` argument, this is done for us by Python.

~~~
from datetime import datetime

class Academic:
    """Model representing an academic."""
    def __init__(self, name):
        self.name = name
        self.papers = []

    def write_paper(self, title, date=None):
        if date is None:
            date = datetime.now().date()

        new_paper = {
            'title': title,
            'date': date
        }

        self.papers.append(new_paper)
        return new_paper

alice = Academic('Alice')
print(alice)

paper = alice.write_paper('A new paper')
print(paper)
print(alice.papers)

paper = Academic.write_paper(alice, 'Another new paper')
print(paper)
print(alice.papers)
~~~
{: .language-python}

~~~
<__main__.Academic object at 0x7fd7e61b73d0>
{'title': 'A new paper', 'date': datetime.date(2020, 5, 27)}
[{'title': 'A new paper', 'date': datetime.date(2020, 5, 27)}]
{'title': 'Another new paper', 'date': datetime.date(2020, 5, 27)}
[{'title': 'A new paper', 'date': datetime.date(2020, 5, 27)}, {'title': 'Another new paper', 'date': datetime.date(2020, 5, 27)}]
~~~
{: .output}

The second use of the `write_paper` method in the example above proves that `self` behaves like a normal parameter, because we call the method from the class, not from an instance of the class.
This is occasionally useful if we want to pass the method itself as an argument to another function, such as when combining the Object Oriented and Functional paradigms, but in general should be avoided.

Note also how we used `date=None` in the parameter list of the `write_paper` method, then initialise it if the value is indeed `None`.
This is one of the common ways to handle an optional argument in Python, so we'll see this pattern quite a lot in real projects.

And finally, we're using Python's built in `datetime` module to handle the publication dates for us.
Properly managing dates and especially times is hard, so we should hand off this responsibility to existing libraries whenever possible.
For more information, see the `datetime` [module documentation](https://docs.python.org/3/library/datetime.html?highlight=datetime#module-datetime).

### Dunder Methods

Why is the `__init__` method not called `init`?
There are a few special method names that we can use which Python will use to provide a few common behaviours, each of which begins and ends with a double-underscore, hence the name **dunder method**.

When writing your own Python classes, you'll almost always want to write an `__init__` method, but there are a few other common ones you might need sometimes.

~~~
from datetime import datetime

class Academic:
    """Model representing an academic."""
    def __init__(self, name):
        self.name = name
        self.papers = []

    def write_paper(self, title, date=None):
        if date is None:
            date = datetime.now().date()

        new_paper = {
            'title': title,
            'date': date
        }

        self.papers.append(new_paper)
        return new_paper

    def __str__(self):
        return self.name

    def __getitem__(self, index):
        return self.papers[index]

    def __len__(self):
        return len(self.papers)

alice = Academic('Alice')
print(alice)

alice.write_paper('A new paper')
paper = alice[0]
print(paper)

print(len(alice))
~~~
{: .language-python}

~~~
Alice
{'title': 'A new paper', 'date': datetime.date(2020, 5, 27)}
1
~~~
{: .output}

In the example above we can see:

- `__str__` - converts an object into its string representation, used when you call `str(object)` or `print(object)`
- `__getitem__` - Accesses an object by key, this is how `list[x]` and `dict[x]` are implemented
- `__len__` - gets the length of an object - usually the number of items it contains

There are many more described in the Python documentation, but it’s also worth experimenting with built in Python objects to see which methods provide which behaviour.

Just because we *can* use these methods, doesn't necessarily mean we *should* though.
By implementing the `__getitem__` and `__len__` methods on `Academic` in the way we did, we're suggesting that an academic *is* a collection of papers, which may not be quite what we intended to say.

If we were to use this class in a real program, it would be better not to implement these methods on the `Academic` class and make people use `len(alice.papers)` instead.

> ## A Basic Class
>
> Implement a class to represent a book.
> Your class should:
>
> - Have a title
> - Have an author
> - When printed, show text in the format "title by author"
>
> ~~~
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
> > ~~~
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

## Properties

The final special type of method we'll introduce is a **property**.
Properties are methods which behave like data - when we want to access them, we don't need to use brackets to call the method manually.

~~~
class Academic:
    ...

    @property
    def last_paper(self):
        return self.papers[-1]

alice = Academic('Alice')

alice.write_paper('First paper')
alice.write_paper('Second paper')

paper = alice.last_paper
print(paper)
~~~
{: .language-python}

~~~
{'title': 'Second paper', 'date': datetime.date(2020, 5, 27)}
~~~
{: .output}

You may recognise the `@` syntax from our lesson on parameterising unit tests - `property` is another example of a **decorator**.
In this case the `property` decorator is taking the `last_paper` function and modifying its behaviour, so it can be accessed as if it were a normal attribute.
We won't be covering how to make our own decorators, but in the Functional Programming section next, we'll see some of the features which make them possible.

> ## Class and Static Methods
>
> Would quite like to have a `Patient.from_record` classmethod if time
>
{: .callout}

> ## Decorators
>
> Might come back to these later in Functional Programming - if time
>
{: .callout}


## Relationships Between Classes

We now have a language construct for grouping data and behaviour related to a single conceptual object.
The next step we need to take is to describe the relationships between the concepts in our code.

There are two fundamental types of relationship between objects which we need to be able to describe:
1. Ownership - x **has a** y - this is **composition**
2. Identity - x **is a** y - this is **inheritance**

### Composition

You should hopefully have come across the term 'composition' already - in the novice Software Carpentry, we use composition of functions to reduce code duplication.
That time, we used a function which converted temperatures in Celsius to Kelvin as a **component** of another function which converted temperatures in Fahrenheit to Kelvin.

In the same way, in object oriented programming, we can make things components of other things.

We often use composition where we can say 'x *has a* y' - for example in our inflammation database, we might want to say that a doctor *has* patients.

In the case of our academics example, we're already saying that academics have papers, so we're already using composition here.
We're currently implementing a paper as a dictionary with a known set of keys though, so maybe we should make a `Paper` class as well.

~~~
from datetime import datetime

class Paper:
    def __init__(self, title, date=None):
        if date is None:
            date = datetime.now().date()

        self.title = title
        self.date = date

    def __str__(self):
        return self.title

class Academic:
    def __init__(self, name):
        self.name = name
        self.papers = []

    def write_paper(title, date=None):
        new_paper = Paper(title, date)

        self.papers.append(new_paper)
        return new_paper

alice = Academic('Alice')
paper = alice.write_paper('A new paper')

print(paper)
~~~
{: .language-python}

~~~
A new paper
~~~
{: .output}

Now we're using a composition of two custom classes to describe the relationship between two types of entity in the system that we're modelling.

### Inheritance

The other type of relationship used in object oriented programming is **inheritance**.
Inheritance is about data and behaviour shared by classes, because they have some shared identity - 'x *is a* y'.
If class `Y` inherits from (*is a*) class `X`, we say that `X` is the **superclass** or **parent class** of `Y`, or `Y` is a **subclass** of `X`.

If we want to extend the previous example to also manage people who aren't academics we can add another class `Person`.
But `Person` will share some data and behaviour with `Academic` - in this case both have a name and show that name when you print them.
Since we expect all academics to be people (hopefully!), it makes sense to implement the behaviour in `Person` and then reuse it in `Academic`.

To write a class in Python, we use the `class` keyword, the name of the class, and then a block of the functions and sometimes attributes that belong to it.
If the class **inherits** from another class, we include the parent class name in brackets.

~~~
from datetime import datetime

class Paper:
    def __init__(self, title, date=None):
        if date is None:
            date = datetime.now().date()

        self.title = title
        self.date = date

    def __str__(self):
        return self.title

class Person:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Academic(Person):
    def __init__(self, name):
        super().__init__(name)
        self.papers = []

    def write_paper(title, date=None):
        new_paper = Paper(title, date)

        self.papers.append(new_paper)
        return new_paper

alice = Acadmic('Alice')
print(alice)

paper = alice.write_paper('A paper')
print(paper)

bob = Person('Bob')
print(bob)

paper = bob.write_paper('A different paper')
print(paper)
~~~
{: .language-python}

~~~
Alice
A paper
Bob
AttributeError: 'Person' object has no attribute 'write_paper'
~~~
{: .output}

We see in the example above that to say that a class inherits from another, we put the **parent class** (or **superclass**) in brackets after the name of the **subclass**.

There's something else we need to add as well - Python doesn't automatically call the `__init__` method on the parent class if we provide a new `__init__` for our subclass, so we'll need to call it ourself.
This makes sure that everything that needs to be initialised on the parent class has been, before we need to use it.
If we don't define a new `__init__` method for our subclass, Python will look for one on the parent class and use it automatically.
This is true of all methods - if we call a method which doesn't exist directly on our class, Python will search for it among the parent classes.
The order in which it does this search is known as the **method resolution order** - a little more on this in the Multiple Inheritance callout below.

The line `super().__init__(name)` gets the parent class, then calls the `__init__` method, providing the `name` variable that `Person.__init__` requires.
This is quite a common pattern, particularly for `__init__` methods, where we need to make sure an object is initialised as a valid `X`, before we can initialise it as a valid `Y` - e.g. a valid `Person` must have a name, before we can properly initialise a `Patient` model with their inflammation data.

> ## A Model Patient
>
> Use what we have learnt in this episode to extend the model layer our hospital record system.
>
> Our core requirements are:
>
> - There must be a `Patient` class to hold the data representing a single patient
>   - Must have a `name` attribute
>   - Must hold a series of inflammation measurements - use any representation you feel is appropriate as long as the tests pass
> - There must be a `Doctor` class to hold the data representing a single doctor
>   - Must have a `name` attribute
>   - Must have a list of patients that this doctor is responsible for
>
> In addition to these, try to think of an extra feature you could add to these models that would be useful for managing a dataset like this - imagine we're running a clinical trial, what else might we want to know?
> Try using Test Driven Development for any features you add: write the tests first, then add the feature.
> The tests have been started for you in `tests/test_patient.py`, but you will probably want to add some more.
>
> Once you've finished the initial implementation, do you have much duplicated code?
> Is there anywhere you could make better use of composition or inheritance to improve your implementation?
>
> For any extra features you've added, explain them and how you implemented them to your neighbour.
> Would they have implemented that feature in the same way?
>
{: .challenge}

> ## Composition vs Inheritance
>
> When deciding how to implement a model of a particular system, you often have a choice of either composition or inheritance, where there is no obviously correct choice.
> For example, it's not obvious whether a photocopier *is a* printer and *is a* scanner, or *has a* printer and *has a* scanner.
>
> ~~~
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
> ~~~
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
> For much more detail on this (which will hopefully make more sense after we've covered software design a bit), see [this page](https://python-patterns.guide/gang-of-four/composition-over-inheritance/) from a Python Design Patterns guide.
{: .callout}


> ## Multiple Inheritance
>
> **Multiple Inheritance** is when a class inherits from more than one direct parent class.
> It exists in Python, but is often not present in other Object Oriented languages.
> Although this might seem useful, like in our inheritance-based model of the photocopier above, it's best to avoid it unless you're sure it's the right thing to do, due to the complexity of the inheritance heirarchy.
> Often using multiple inheritance is a sign you should instead be using composition - again like the photocopier model above.
{: .callout}


> ## Building a Library
>
> Using what we've seen so far, implement two classes: `Book` (you can use the one from the earlier exercise) and `Library` which have the following behaviour:
>
> ~~~
> library = Library()
>
> library.add_book('My First Book', 'Alice')
> library.add_book('My Second Book', 'Alice')
> library.add_book('A Different Book', 'Bob')
>
> print(len(library))
>
> book = library[2]
> print(book)
>
> books = library.by_author('Alice')
> for book in books:
>     print(book)
>
> books = library.by_author('Carol')
> ~~~
> {: .language-python}
>
> ~~~
> 3
> A Different Book by Bob
> My First Book by Alice
> My Second Book by Alice
> KeyError: 'Author does not exist'
> ~~~
> {: .output}
>
> > ## Solution
> > ~~~
> > class Book:
> >     def __init__(self, title, author):
> >         self.title = title
> >         self.author = author
> >
> >     def __str__(self):
> >         return self.title + ' by ' + self.author
> >
> >
> > class Library:
> >     def __init__(self):
> >         self.books = []
> >
> >     def add_book(self, title, author):
> >         self.books.append(Book(title, author))
> >
> >     def __len__(self):
> >         return len(self.books)
> >
> >     def __getitem__(self, key):
> >         return self.books[key]
> >
> >     def by_author(self, author):
> >         matches = []
> >         for book in self.books:
> >             if book.author == author:
> >                 matches.append(book)
> >
> >         if not matches:
> >             raise KeyError('Author does not exist')
> >
> >         return matches
> > ~~~
> > {: .output}
> {: .solution}
>
> Extend the class so that we can get the list of all authors and titles.
> If an author appears multiple times, they should only appear once in the list of authors:
>
> ~~~
> print(library.titles)
> print(library.authors)
> ~~~
> {: .language-python}
>
> ~~~
> ['My First Book', 'My Second Book', 'A Different Book']
> ['Alice', 'Bob']
> ~~~
> {: .output}
>
> > ## Solution
> > ~~~
> > class Book:
> >     def __init__(self, title, author):
> >         self.title = title
> >         self.author = author
> >
> >     def __str__(self):
> >         return self.title + ' by ' + self.author
> >
> >
> > class Library:
> >     def __init__(self):
> >         self.books = []
> >
> >     def add_book(self, title, author):
> >         self.books.append(Book(title, author))
> >
> >     def __len__(self):
> >         return len(self.books)
> >
> >     def __getitem__(self, key):
> >         return self.books[key]
> >
> >     def by_author(self, author):
> >         matches = []
> >         for book in self.books:
> >             if book.author == author:
> >                 matches.append(book)
> >
> >         if not matches:
> >             raise KeyError('Author does not exist')
> >
> >         return matches
> >
> >     @property
> >     def titles(self):
> >         titles = []
> >         for book in self.books:
> >             titles.append(book.title)
> >
> >         return titles
> >
> >     @property
> >     def authors(self):
> >         authors = []
> >         for book in self.books:
> >             if book.author not in authors:
> >                 authors.append(book.author)
> >
> >         return authors
> > ~~~
> > {: .output}
> {: .solution}
>
> The built in `set` class has a `set.union` method which takes two sets (one of which is `self`) and returns a new set containing all of the members of both sets, with no duplicates.
>
> Extend your library model with a `union` method which behaves the same way - it should return a new `Library` containing all the books of the two provided libraries.
>
> To do this you might need to create a `Book.__eq__` method.
> The `__eq__` dunder method should take two objects (one of which is `self`) and return `True` if the two objects should be considered equal - otherwise return `False`.
>
> > ## Solution
> > ~~~
> > class Book:
> >     def __init__(self, title, author):
> >         self.title = title
> >         self.author = author
> >
> >     def __str__(self):
> >         return self.title + ' by ' + self.author
> >
> > def __eq__(self, other):
> >         return self.title == other.title and self.author == other.author
> >
> >
> > class Library:
> >     def __init__(self):
> >         self.books = []
> >
> >     def add_book(self, title, author):
> >         self.books.append(Book(title, author))
> >
> >     def __len__(self):
> >         return len(self.books)
> >
> >     def __getitem__(self, key):
> >         return self.books[key]
> >
> >     def by_author(self, author):
> >         matches = []
> >         for book in self.books:
> >             if book.author == author:
> >                 matches.append(book)
> >
> >         if not matches:
> >             raise KeyError('Author does not exist')
> >
> >         return matches
> >
> >     @property
> >     def titles(self):
> >         titles = []
> >         for book in self.books:
> >             titles.append(book.title)
> >
> >         return titles
> >
> >     @property
> >     def authors(self):
> >         authors = []
> >         for book in self.books:
> >             if book.author not in authors:
> >                 authors.append(book.author)
> >
> >         return authors
> >
> >     def union(self, other):
> >         books = []
> >         for book in self.books:
> >             if book not in books:
> >                 books.append(book)
> >
> >         for book in other.books:
> >             if book not in books:
> >                 books.append(book)
> >
> >         return Library(books)
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

{% include links.md %}