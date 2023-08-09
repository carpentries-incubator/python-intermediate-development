---
title: "Architecting code to separate responsibilities"
teaching: 0
exercises: 0
questions:
- "What is the point of the MVC architecture"
- "How should code be structured"
objectives:
- "Understand the MVC pattern and how to apply it."
- "Understand the benefits of using patterns"
keypoints:
- "By splitting up the "view" code from "model" code, you allow easier re-use of code."
- "Using coding patterns can be useful inspirations for how to structure your code."
---

## Introduction

* Refamiliarise with MVC

## Separating out considerations

* Talk about model and view as distinct parts of the code

> ## Exercise: Identify model and view parts of the code
> Looking at the code as it is, what parts should be considered "model" code
> and what parts should be considered "view" code?
>> ## Solution
>> The computation of the standard deviation is model code
>> The display of the output as a graph is the view code.
> {: .solution}
{: .challenge}

* Model should be made up of pure functions as discussed
TODO: Reading files is model code, but not pure

> ## Exercise: Split out the model code from the view code
> Refactor the code to have the model code separated from
> the view code.
>> ## Solution
>> See commit: https://github.com/thomaskileyukaea/python-intermediate-inflammation/commit/97fd04b747a6491c2590f34384eed44e83a8e73c
> {: .solution}
{: .challenge}

TODO: did originally intend to add a new view - but I think it isn't necessary, isn't a great
example and the time could be better used.

## Programming patterns

* Talk about how MVC is one pattern
* Mention a couple of others than might be useful
* Talk about how patterns can be useful for designing architecture

{% include links.md %}
