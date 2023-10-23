---
title: "Architecting code to separate responsibilities"
teaching: 15
exercises: 50
questions:
- "What is the point of the MVC architecture"
- "How to design larger solutions."
- "How to tell what is and isn't an appropriate abstraction."
objectives:
- "Understand the use of common design patterns to improve the extensibility, reusability and overall quality of software."
- "How to design large changes to the codebase."
- "Understand how to determine correct abstractions. "
keypoints:
- "By splitting up the \"view\" code from \"model\" code, you allow easier re-use of code."
- "YAGNI - you ain't gonna need it - don't create abstractions that aren't useful."
- "Sketching a diagram of the code can clarify how it is supposed to work, and troubleshoot problems early."
---


## Introduction

Model-View-Controller (MVC) is a way of separating out different responsibilities of a typical
application. Specifically we have:

* The **model** which is responsible for the internal data representations for the program,
  and the valid operations that can be performed on it.
* The **view** is responsible for how this data is presented to the user (e.g. through a GUI or
  by writing out to a file)
* The **controller** is responsible for how the model can be interacted with.

Separating out these different responsibilities into different parts of the code will make
the code much more maintainable.
For example, if the view code is kept away from the model code, then testing the model code
can be done without having to worry about how it will be presented.

It helps with readability, as it makes it easier to have each function doing
just one thing.

It also helps with maintainability - if the UI requirements change, these changes
are easily isolated from the more complex logic.

## Separating out responsibilities

The key thing to take away from MVC is the distinction between model code and view code.

> ## What about the controller
> The view and the controller tend to be more tightly coupled and it isn't always sensible
> to draw a thick line dividing these two. Depending on how the user interacts with the software
> this distinction may not be possible (the code that specifies there is a button on the screen,
> might be the same code that specifies what that button does). In fact, the original proposer
> of MVC groups the views and the controller into a single element, called the tool. Other modern
> architectures like Model-View-Presenter do away with the controller and instead separate out the
> layout code from a programmable view of the UI.
{: .callout}

The view code might be hard to test, or use libraries to draw the UI, but should
not contain any complex logic, and is really just a presentation layer on top of the model.

The model, conversely, should not really care how the data is displayed.
For example, perhaps the UI always presents dates as "Monday 24th July 2023", but the model
would still store this using a `Date` rather than just that string.

> ## Exercise: Identify model and view parts of the code
> Looking at the code inside `compute_data.py`,
>
> * What parts should be considered **model** code
> * What parts should be considered **view** code?
> * What parts should be considered **controller** code?
>
>> ## Solution
>> * The computation of the standard deviation is **model** code
>> * Reading the data from the CSV is also **model** code.
>> * The display of the output as a graph is the **view** code.
>> * The logic that processes the supplied flats is the **controller**.
> {: .solution}
{: .challenge}

Within the model there is further separation that makes sense.
For example, as we did in the last episode, separating out the impure code that interacts with file systems from
the pure calculations is helps with readability and testability.
Nevertheless, the MVC approach is a great starting point when thinking about how you should structure your code.

> ## Exercise: Split out the model code from the view code
> Refactor `analyse_data` such the *view* code we identified in the last
> exercise is removed from the function, so the function contains only
> *model* code, and the *view* code is moved elsewhere.
>> ## Solution
>> The idea here is to have `analyse_data` to not have any "view" considerations.
>> That is, it should just compute and return the data.
>>
>> ```python
>> def analyse_data(data_dir):
>>     """Calculate the standard deviation by day between datasets
>>     Gets all the inflammation csvs within a directory, works out the mean
>>     inflammation value for each day across all datasets, then graphs the
>>     standard deviation of these means."""
>>     data = data_source.load_inflammation_data()
>>     daily_standard_deviation = compute_standard_deviation_by_data(data)
>>
>>     return daily_standard_deviation
>> ```
>> There can be a separate bit of code that chooses how that should be presented, e.g. as a graph:
>>
>> ```python
>> if args.full_data_analysis:
>>   _, extension = os.path.splitext(InFiles[0])
>>   if extension == '.json':
>>     data_source = JSONDataSource(os.path.dirname(InFiles[0]))
>>   elif extension == '.csv':
>>     data_source = CSVDataSource(os.path.dirname(InFiles[0]))
>>   else:
>>     raise ValueError(f'Unsupported file format: {extension}')
>>   analyse_data(data_source)
>>   graph_data = {
>>     'standard deviation by day': data_result,
>>   }
>>   views.visualize(graph_data)
>>   return
>> ```
>> You might notice this is more-or-less the change we did to write our
>> regression test.
>> This demonstrates that splitting up model code from view code can
>> immediately make your code much more testable.
>> Ensure you re-run our regression test to check this refactoring has not
>> changed the output of `analyse_data`.
> {: .solution}
{: .challenge}

## Programming patterns

MVC is a **programming pattern**. Programming patterns are templates for structuring code.
Patterns are a useful starting point for how to design your software.
They also work as a common vocabulary for discussing software designs with
other developers.

The Refactoring Guru website has a [list of programming patterns](https://refactoring.guru/design-patterns/catalog).
They aren't all good design decisions, and can certainly be over-applied, but learning about them can be helpful
for thinking at a big picture level about software design.

For example, the [visitor pattern](https://refactoring.guru/design-patterns/visitor) is
a good way of separating the problem of how to move through the data
from a specific action you want to perform on the data.

By having a terminology for these approaches can facilitate discussions
where everyone is familiar with them.
However, they cannot replace a full design as most problems will require
a bespoke design that maps cleanly on to the specific problem you are
trying to solve.

## Architecting larger changes

When creating a new application, or creating a substantial change to an existing one,
it can be really helpful to sketch out the intended architecture on a whiteboard
(pen and paper works too, though of course it might get messy as you iterate on the design!).

The basic idea is you draw boxes that will represent different units of code, as well as
other components of the system (such as users, databases etc).
Then connect these boxes with lines where information or control will be exchanged.
These lines represent the interfaces in your system.

As well as helping to visualise the work, doing this sketch can troubleshoot potential issues.
For example, if there is a circular dependency between two sections of the design.
It can also help with estimating how long the work will take, as it forces you to consider all the components that
need to be made.

Diagrams aren't foolproof, and often the stuff we haven't considered won't make it on to the diagram
but they are a great starting point to break down the different responsibilities and think about
the kinds of information different parts of the system will need.


> ## Exercise: Design a high-level architecture
> Sketch out a design for a new feature requested by a user
>
> *"I want there to be a Google Drive folder that when I upload new inflammation data to
> the software automatically pulls it down and updates the analysis.
> The new result should be added to a database with a timestamp.
> An email should then be sent to a group email notifying them of the change."*
>> ## Solution
>>
>> ![Diagram showing proposed architecture of the problem](../fig/example-architecture-diagram.svg)
> {: .solution}
{: .challenge}

## An abstraction too far

So far we have seen how abstractions are good for making code easier to read, maintain and test.
However, it is possible to introduce too many abstractions.

> All problems in computer science can be solved by another level of indirection except the problem of too many levels of indirection

When you introduce an abstraction, if the reader of the code needs to understand what is happening inside the abstraction,
it has actually made the code *harder* to read.
When code is just in the function, it can be clear to see what it is doing.
When the code is calling out to an instance of a class that, thanks to polymorphism, could be a range of possible implementations,
the only way to find out what is *actually* being called is to run the  code and see.
This is much slower to understand, and actually obfuscates meaning.

It is a judgement as to whether you have make the code too abstract.
If you have to jump around a lot when reading the code that is a clue that is too abstract.
Similarly, if there are two parts of the code that always need updating together, that is
again an indication of an incorrect or over-zealous abstraction.


## You Ain't Gonna Need It

There are different approaches to designing software.
One principle that is popular is called You Ain't Gonna Need it - "YAGNI" for short.
The idea is that, since it is hard to predict the future needs of a piece of software,
it is always best to design the simplest solution that solves the problem at hand.
This is opposed to trying to imagine how you might want to adapt the software in future
and designing the code with that in mind.

Then, since you know the problem you are trying to solve, you can avoid making your solution unnecessarily complex or abstracted.

In our example, it might be tempting to abstract how the `CSVDataSource` walks the file tree into a class.
However, since we only have one strategy for exploring the file tree, this would just create indirection for the sake of it
- now a reader of CSVDataSource would have to read a different class to find out how the tree is walked.
Maybe in the future this is something that needs to be customised, but we haven't really made it any harder to do by *not* doing this prematurely
and once we have the concrete feature request, it will be easier to design it appropriately.

> All of this is a judgement.
> For example, in this case, perhaps it *would* make sense to at least pull the file parsing out into a separate
> class, but not have the CSVDataSource be configurable.
> That way, it is clear to see how the file tree is being walked (there's no polymorphism going on)
> without mixing the *parsing* code in with the file finding code.
> There are no right answers, just guidelines.
{: .callout}

> ## Exercise: Applying to real world examples
> Thinking about the examples of good and bad code you identified at the start of the episode.
> Identify what kind of principles were and weren't being followed
> Identify some refactorings that could be performed that would improve the code
> Discuss the ideas as a group.
{: .challenge}

## Conclusion

Good architecture is not about applying any rules blindly, but instead practise and taking care around important things:

* Avoid duplication of code or data.
* Keeping how much a person has to understand at once to a minimum.
* Think about how interfaces will work.
* Separate different considerations into different sections of the code.
* Don't try and design a future proof solution, focus on the problem at hand.

Practise makes perfect.
One way to practise is to consider code that you already have and think how it might be redesigned.
Another way is to always try to leave code in a better state that you found it.
So when you're working on a less well structured part of the code, start by refactoring it so that your change fits in cleanly.
Doing this, over time, with your colleagues, will improve your skills as software architecture as well as improving the code.


{% include links.md %}
