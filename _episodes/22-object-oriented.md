---
title: "Object Oriented Programming"
teaching: 30
exercises: 30
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

## Encapsulating Data

One of the main difficulties we encounter when building more complex software is how to structure our data.
So far, we've been processing data from a single source and with a simple tabular structure, but eventually we'll need to combine data from a range of different sources and with a more complex structure.

For our patient record system, we'll need to have a way to hold the data for each patient and have code that helps us display and modify that data.

~~~
data = np.array([1., 2., 3.],
                [4., 5., 6.])
~~~
{: .language-python}

Has advantage of being able to use NumPy operations to process the data and Matplotlib to plot it, but often we need to have more structure in our data than this.
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
> > What might go wrong with this solution?  How could we fix it?
> > A better solution would be to use the `zip` function.
> >
> > ~~~
> > def attach_names(data, names):
> >     """Create datastructure containing patient records."""
> >     output = []
> >
> >     for data_row, name in zip(data, names):
> >         output.append({'name': name,
> >                        'data': data_row})
> >
> >     return output
> > ~~~
> > {: .language-python}
> {: .solution}
{: .challenge}

### Classes in Python

Using nested dictionaries and lists should work for most cases where we need to handle structured data, but they get quite difficult to manage once the structure becomes a bit more complex.

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

Lists, dictionaries and sets are a slightly special type of class, but they behave in much the same way as a class we might define ourselves.
They each contain data, as we have seen before.
They also provide a set of functions, or **methods** which describe the **behaviours** of the data.

The behaviours we may have seen previously include:

- Lists can be appended to
- Lists can be indexed (we’ll get to this later)
- Lists can be sliced (we won’t get to this)
- Key-value pairs can be added to dictionaries
- The value at a key can be looked up in a dictionary
- The union of two sets can be found
- The intersection of two sets can be found

For our example of a class, let us create a model of an academic publishing papers.

~~~
class Academic:
    def __init__(self, name):
        self.name = name
        self.papers = []

alice = Academic('Alice')
print(alice.name)
~~~
{: .language-python}


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
> We'll be using Test Driven Development for most of the work from here.
>
{: .callout}


## Encapsulating Behaviour

Just like the standard Python datastructures, our classes can have behaviour associated with them.

To define the behaviour of a class we can add functions which operate on the data the class contains.
We call these functions member functions or methods.

These functions are the same as normal functions (alternatively known as free functions), but we have an extra first parameter `self`.
The `self` parameter is a normal variable, but when we use a method of an object, the value of `self` is automatically set to the object.
Using the name `self` is a VERY STRONG CONVENTION.

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

The second use of the `write_paper` method in the example above proves that `self` behaves like a normal parameter, but there are very few cases where we should use it like this.

Note also how we used `date=None` in the parameter list of the `write_paper` method, then initialise it if the value is indeed `None`.
This is one of the common ways to handle an optional argument in Python, so we'll see this pattern quite a lot in real projects.


### Dunder Methods

Why is the `__init__` method not called `init`?
There are a few special method names that we can use which Python will use to provide a few common behaviours, each of which begins and ends with two underscores, hence the name **dunder method**.

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
> > {: .output}
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

The `@` syntax means that a function called `property` is being used to modify the behavior of the method - this is called a **decorator**.
In this case the `@property` decorator converts `last_paper` from a normal method into a property.


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
The next step is talking about the relationships between objects.

There are two fundamental types of relationship between objects which we need to be able to describe:
1. Ownership - x **has a** y - **composition**
2. Identity - x **is a** y - **inheritance**

### Composition

Doctor *has* Patients

Composition is about ownership of an object or resource - x **has a** y.

In the case of our academics example, we can say that academics have papers.
We already have an implementation of this using a dictionary to represent a paper, but maybe we should make a `Paper` class as well.

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

### Inheritance

Inheritance is about data and behaviour shared by classes, because they have some shared identity.

If we want to extend the previous example to also manage people who aren't academics we can add another class `Person`.
But `Person` will share some data and behaviour with `Academic` - in this case both have a name and show that name when you print them.

Since we expect all academics to be people (hopefully!), it makes sense to implement the behaviour in `Person` and then reuse it in `Academic`.

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

There's something else we need to add as well - Python doesn't automatically call the `__init__` method on the parent class, so we need to do this manually within the `__init__` method of the subclass.
This makes sure that everything that needs to be initialised on the parent class has been, before we need to use it.

The line `super().__init__(name)` gets the parent class, then calls the `__init__` method, providing the `name` variable that `Person.__init__` requires.

> ## Composition vs Inheritance
>
> When deciding how to implement a model of a particular system, you often have a choice of either composition or inheritance, where there is no obviously correct choice.
> More on this later in the week!
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
{: .callout}


> ## Multiple Inheritance
>
> Exists in Python, doesn't in many other languages.
> Useful, but dangerous.
> "The Deadly Diamond of Death".
> Notice the use of multiple inheritance in the `Copier` model.
>
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

> ## A Model Patient
>
> Use what we have learnt in this episode to extend the model layer our hospital record system.
>
> The core requirements are described by the unit tests in the `test_patient.py` and `test_doctor.py` files.
> These requirements are:
>
> - There must be a `Patient` class to hold the data representing a single patient
>   - Must have a `name` attribute
>   - Must hold a series of inflammation measurements - use any representation you feel is appropriate as long as the tests pass
> - There must be a `Doctor` class to hold the data representing a single doctor
>   - Must have a `name` attribute
>   - Must have a list of patients that this doctor is responsible for
>
> In addition to these, you may add anything else to these models that would be useful for managing a hospital.
> Try using Test Driven Development for any other features you add: write the tests first, then add the feature.
>
> Once you've finished the initial implementation, do you have much duplicated code?
> Is there anywhere you could make better use of composition / inheritance to improve your implementation?
>
> If you've added any extra features, explain them and how you implemented them to your neighbour.
> Would they have implemented that feature in the same way?
>
{: .challenge}

{% include links.md %}
