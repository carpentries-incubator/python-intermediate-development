---
title: "Persistence"
teaching: 30
exercises: 20
questions:
- "How can we store and transfer structured data?"
- "How can we make it easier to substitute new components into our software?"
objectives:
- "Describe some of the different kinds of software and explain how the environment in which software is used constrains its design."
- "Identify common components of multi-layer software projects"
- "Store structured data using an Object Relational Mapping library"
- "Define serialization and deserialization"
- "Store and retrieve structured data using an appropriate format"
- "Define what is meant by a contract in the context of Object Oriented design"
- "Explain the benefits of contracts and implement modules which fulfill them"
keypoints:
- "Planning software projects in advance can save a lot of effort later - even a partial plan is better than no plan at all."
- "The environment in which users run our software has an effect on many design choices we might make."
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change."
- "These components can be as small as a single function, or be a software package in their own right."
- "When writing software used for research, requirements *always* change."
---

## Introduction

Our patient data system so far can read in some data, process it, and display it to people.
What's missing?

Well, at the moment, if we wanted to add a new patient or perform a new observation, we would have to edit the input CSV file by hand.
We might not want our staff to have to manage their patients by making changes to the data by hand, but rather provide the ability to do this through the software.
That way we can perform any necessary validation (e.g. inflamation measurements must be a number) or transformation before the data gets accepted.

If we want to bring in this data, modify it somehow, and save it back to a file, we'd need to:

- Write some code to perform data import / export (**persistence**)
- Add some views we can use to modify the data
- Link it all together in the controller

## Tasks

The process of converting data from an object to and from storable formats is often called **serialization** and **deserialization** and is handled by a **serializer**, so let's start by creating a base class to represent the concept of a serializer for our patient data - then we can specialise this to make serializers for different formats by inheriting from this base class.

By creating a base class we provide a contract that any kind of patient serializer must stick to.
If we create multiple different patient serializers, for example to serialize using different formats, we know that we will be able to use them all in exactly the same way.
This technique is part of an approach called **design by contract**.
Some languages provide tools to help us enforce this, such as **interfaces** in Java and C# - in Python **Abstract Base Classes** (ABCs) can help with this, but ABCs are out of the core scope of this course.

We'll call our base class `PatientSerializer`.

~~~ python
from inflammation.models import Patient


class PatientSerializer:
    model = Patient

    @classmethod
    def save(cls, instances, path):
        raise NotImplementedError

    @classmethod
    def load(cls, path):
        raise NotImplementedError
~~~
{: .language-python}

Our serializer base class has two classmethods, one to serialize (save) the data and one to deserialize (load) it.
We're not actually going to implement either of them here as this is just a template for how our real serializers should look, so we'll raise `NotImplementedError` to make this clear if anyone tries to use this class directly.
The reason we've used classmethods is that we don't need to be able to pass any data in using the `__init__` method, as we'll be passing the data to be serialized directly to the `save` function.

There's many different formats we could use to store our data, but a common one is JSON (JavaScript Object Notation).
This format comes originally from JavaScript, but is now one of the most commonly used serialization formats for exchange or storage of structured data.

Data in JSON format is structured using nested **arrays** (very similar to Python lists) and **objects** (very similar to Python dictionaries).
For example, we might use the following structure to hold data about publications:

~~~ python
[
    {
        "name": "Alice",
        "papers": [
            {
                "title": "Alice's First Paper",
                "citations": 5
            },
            {
                "title": "Alice's Second Paper",
                "citations": 100
            }
        ]
    },
    {
        "name": "Bob",
        "papers": [
            {
                "title": "A Paper by Bob",
                "citations": 20
            }
        ]
    }
]
~~~
{: .language-python}

One of the main advantages of JSON is that it's relatively human-readable, so it's a bit easier to check the structure of some new JSON data than it can be with some of the other common formats.

Now if we're going to follow TDD (Test Driven Development), we should write some test code.

Our JSON serializer should be able to save and load our patient data to and from a JSON file, so for our test we could try these save-load steps and check that the result is the same as the data we started with.

~~~ python
# file: tests/test_serializers.py

from inflammation.models import Patient
from inflammation.serializers import PatientJSONSerializer

def test_patients_json_serializer():
    patients = [
        Patient('Alice', observations=[1, 2, 3]),
        Patient('Bob', observations=[3, 4, 5]),
    ]

    output_file = 'patients.json'
    PatientJSONSerializer.save(patients, output_file)

    patients_new = PatientJSONSerializer.load(output_file)

    assert patients_new[0].name == 'Alice'
    assert patients_new[1].observations == [3, 4, 5]
~~~
{: .language-python}

Here we set up some patient data, which we save to a file named `patients.json`.
We then load the data from this file and check that the results match the input.

With our test, we know what the correct behaviour looks like - now it's time to implement it.
For this, we'll use one of Python's built-in libraries.
Among other more complex features, the `json` library provides functions for converting between Python data structures and JSON formatted text files.
Our test also didn't specify what the structure of our output data should be, so we need to make that decision here.

~~~ python
# file: inflammation/serializers.py

...

class PatientJSONSerializer(PatientSerializer):
    @classmethod
    def save(cls, instances, path):
        data = [{
            'name': instance.name,
            'observations': instance.observations,
        } for instance in instances]

        with open(path, 'w') as jsonfile:
            json.dump(data, jsonfile)

    @classmethod
    def load(cls, path):
        with open(path) as jsonfile:
            data = json.load(jsonfile)

        return [cls.model(**d) for d in data]
~~~
{: .language-python}

For our `save` method, since the JSON format is similar to nested Python lists and dictionaries, it makes sense as a first step to convert the data from our `Patient` class into a dictionary - we do this for each patient using a list comprehension.
Then we can pass this to the `json.dump` function to save it to a file.

As we might expect, the `load` method is the opposite of this.
Here we need to first read the data from our input file, then convert it to instances of our `Patient` class.
The `**` syntax here may be unfamiliar to you - this is the **dictionary unpacking operator**.
The dictionary unpacking operator can be used when calling a function (like a class `__init__` method) and passes the items in the dictionary as named arguments to the function.
The name of each argument passed is the dictionary key, the value of the argument is the dictionary value.

> ## Equality Testing
>
> When we wrote our serializer test, we said we wanted to check that the data coming out was the same as our input data, but we actually compared just parts of the data, rather than just using `assert patients_new == patients`.
>
> The reason for this is that, by default, `==` comparing two instances of a class tests whether they're stored at the same location in memory, rather than just whether they contain the same data.
>
> Add some code to the `Patient` class, so that we get the expected result when we do `assert patients_new == patients`.
> When you have this comparison working, update the serializer test to use this instead.
>
> **Hint:** The method Python uses to check for equality of two instances of a class is called `__eq__` and takes the arguments `self` (as all normal methods do) and `other`.
{: .challenge}

> ## Advanced Challenge: Abstract Base Classes
>
> Since our `PatientSerializer` class is designed not to be directly usable and its methods raise `NotImplementedError`, it ideally should be an abstract base class.
> An abstract base class is one which is intended to be used only by creating subclasses of it and can mark some or all of its methods as requiring implementation in the new subclass.
>
> Using Python's documentation on the [abc module](https://docs.python.org/3/library/abc.html), convert the `PatientSerializer` class into an ABC.
>
> **Hint:** The only component that needs to be changed is `PatientSerializer` - this should not require any changes to `PatientJSONSerializer`.
>
> **Hint:** The abc module documentation refers to metaclasses - don't worry about these.
> A metaclass is a template for creating a class (classes are instances of a metaclass), just like a class is a template for creating objects (objects are instances of a class), but this isn't necessary to understand if you're just using them to create your own abstract base classes.
{: .challenge}

> ## Advanced Challenge: CSV Serialization
>
> Try implementing an alternative serializer, using the CSV format instead of JSON.
>
> **Hint:** Python also has a module for handling CSVs - see the documentation for the [csv module](https://docs.python.org/3/library/csv.html).
> This module provides a CSV reader and writer which are a bit more flexible, but slower for purely numeric data, than the ones we've seen previously as part of numpy.
>
> Can you think of any cases when a CSV might not be a suitable format to hold our patient data?
{: .challenge}

{% include links.md %}
