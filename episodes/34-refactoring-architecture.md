---
title: "Architecting code to separate responsibilities"
teaching: 0
exercises: 0
questions:
- "What is the point of the MVC architecture"
- "How should code be structured"
objectives:
- "Understand the use of common design patterns to improve the extensibility, reusability and overall quality of software."
- "Understand the MVC pattern and how to apply it."
- "Understand the benefits of using patterns"
keypoints:
- "By splitting up the \"view\" code from \"model\" code, you allow easier re-use of code."
- "Using coding patterns can be useful inspirations for how to structure your code."
---


## Introduction

Model-View-Controller (MVC) is a way of separating out different portions of a typical
application. Specifically we have:

* The **model** which contains the internal data representations for the program, and the valid
  operations that can be performed on it.
* The **view** is responsible for how this data is presented to the user (e.g. through a GUI or
  by writing out to a file)
* The **controller** defines how the model can be interacted with.

Separating out these different sections into different parts of the code will make
the code much more maintainable.
For example, if the view code is kept away from the model code, then testing the model code
can be done without having to worry about how it will be presented.

It helps with readability, as it makes it easier to have each function doing
just one thing.

It also helps with maintainability - if the UI requirements change, these changes
are easily isolated from the more complex logic.

## Separating out considerations

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
> Refactor the code to have the model code separated from
> the view code.
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
>>     data_file_paths = glob.glob(os.path.join(data_dir, 'inflammation*.csv'))
>>     if len(data_file_paths) == 0:
>>         raise ValueError(f"No inflammation csv's found in path {data_dir}")
>>     data = map(models.load_csv, data_file_paths)
>>     daily_standard_deviation = compute_standard_deviation_by_data(data)
>>
>>     return daily_standard_deviation
>> ```
>> There can be a separate bit of code that chooses how that should be presented, e.g. as a graph:
>>
>> ```python
>> if args.full_data_analysis:
>>     data_result = analyse_data(os.path.dirname(InFiles[0]))
>>     graph_data = {
>>         'standard deviation by day': data_result,
>>     }
>>     views.visualize(graph_data)
>>     return
>> ```
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/97fd04b747a6491c2590f34384eed44e83a8e73c
> {: .solution}
{: .challenge}

## Programming patterns

MVC is a **programming pattern**, which is a template for structuring code.
Patterns are useful starting point for how to design your software.
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

{% include links.md %}
