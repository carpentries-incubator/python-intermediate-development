> [!NOTE]  
> We are currently transitioning the lesson to the new Carpentries lesson format - please put your pull requests on hold and submit issues only.

[![DOI](https://zenodo.org/badge/257930838.svg)](https://zenodo.org/badge/latestdoi/257930838)

## Intermediate Research Software Development Skills (Python)

This is an intermediate-level course in collaborative research software engineering and development skills,
using Python as an example language.
It teaches these skills in a way that mimics a typical software development
process working as a part of a team,
starting from an [existing piece of software](https://github.com/carpentries-incubator/python-intermediate-inflammation).
The lesson is developed using [The Carpentries](https://carpentries.org) Jekyll lesson template.

A typical learner for this course may be someone who has gained basic software development skills either by 
self-learning or attending a foundational course such as the novice [Software Carpentry Python course][swc-lessons]. 
However, their software 
development-related projects are now becoming larger and more complex and they need more 
intermediate software engineering skills to help them design more robust software code, 
automate the process of testing and verifying its correctness and support collaborations with others.

> :warning: The course material can change at any point - if you are planning a workshop using this material, 
either let the maintainers know or make sure you use your own fork of the lesson.

The lesson uses [patient inflammation data](https://swcarpentry.github.io/python-novice-inflammation/#scenario-a-miracle-arthritis-inflammation-cure) for code examples, 
from the [Software Carpentry Python "inflammation" lesson](https://swcarpentry.github.io/python-novice-inflammation/).

Check out the [variant of this lesson](https://github.com/carpentries-incubator/python-intermediate-development-earth-sciences/tree/gh-pages)
that uses river catchment data in code examples (more suited for Earth and environmental scientists).

### Lesson Status

The course is in a stable beta - it has been run over 15 times times with 
different cohorts by the lesson authors as well as independently by people not directly involved in the lesson development
and is in a good state to be reused and taught by others.

## Teaching the Lesson

The lesson is suitable for both instructor-led teaching or guided self-learning where helpers provide help 
and answer questions (synchronously or asynchrounously) as learners go through the course on their own. 
Initially, in sections 1-3 of the lesson, 
learners are working on a software project and going though exercises individually.
In sections 4 and 5, they are grouped and work in teams,
as they would when collaborating on a team software project development.

The lesson has 5 sections; 
each section can be delivered in one day by an instructor or worked through in self-learning mode over a half a day to a day, 
depending on the pace.

If you would like to teach this lesson to your audience and help with more beta testing, 
please let the lesson developers know by opening an [issue](https://github.com/carpentries-incubator/python-intermediate-development/issues/new?assignees=&labels=pilot&template=lesson-pilot-issue-template.md&title=) with your workshop details and a 
label ![pilot](https://shields.io/badge/-pilot-31E930).

## Contributing

We welcome all contributions to improve the lesson! Maintainers will do their best to help you if you have any
questions, concerns, or experience any difficulties along the way.

We would like to ask you to familiarise yourself with our [Contribution Guide](CONTRIBUTING.md) and have a look at
the [more detailed guidelines][lesson-example] on proper formatting, instructions on compiling and rendering the lesson locally, and 
making any changes and adding new content or episodes.

Please see the current list of [issues][issues] for ideas for contributing to this
repository. For making your contribution, we use the GitHub flow, which is
nicely explained in the chapter [Contributing to a Project](http://git-scm.com/book/en/v2/GitHub-Contributing-to-a-Project) in Pro Git
by Scott Chacon.
Look for tags ![good_first_issue](https://img.shields.io/badge/-good%20first%20issue-blueviolet.svg) or
![help_wanted](https://img.shields.io/badge/-help%20wanted-green.svg). 
This indicates that the maintainers will welcome pull requests fixing such issues.

## Maintainer(s)

Current maintainers of this lesson (in alphabetical order) are:

* [Matthew Bluteau][matthew-bluteau] - Lead Maintainer for the period 1 May 2024 - 31 October 2024
* [Steve Crouch][steve-crouch]
* [Kamilla Kopec-Harding][kamilla-kopec-harding]
* [Doug Lowe][doug-lowe]
* [Aleksandra Nenadic][aleksandra-nenadic]

The maintainer team aims to meet at 11:00 UK time (BST or GMT) on the fourth Wednesday each month. The meetings alternate between operations meetings and co-working sprints.
Meeting notes are kept in the [Google doc](https://docs.google.com/document/d/1-SvoY_2GvlQgJnu8zfr6VnU7sev_iWZAIwBUywNSfWE/edit#).

## Authors

A list of all contributors to the lesson can be found in [AUTHORS](AUTHORS).

## Licence

Instructional material from this lesson is made available under the
[Creative Commons Attribution][cc-by-human] ([CC BY 4.0][cc-by-legal]) licence. Except where
otherwise noted, example programs and software included as part of this lesson are made available
under the [MIT licence][mit-license]. For more information, see [LICENSE.md](LICENSE.md).

## Citation

To cite this lesson, please consult with [CITATION](CITATION).

## Contact

To get in touch with the lesson maintainers, send an email to [python-inter-inflammation@lists.carpentries.org](mailto:python-inter-inflammation@lists.carpentries.org).

## Acknowledgements

Original lesson authors Aleksandra Nenadic, James Graham, and Steve Crouch were supported by the [UK's Software Sustainability Institute][ssi] via the [EPSRC, BBSRC, ESRC, NERC, AHRC, STFC and MRC grant EP/S021779/1](https://gow.epsrc.ukri.org/NGBOViewGrant.aspx?GrantRef=EP/S021779/1).

[swc-lessons]: https://software-carpentry.org/lessons/
[best-practices]: http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745
[good-practices]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510
[programming-with-python]: https://swcarpentry.github.io/python-novice-inflammation/
[lesson-example]: https://carpentries.github.io/lesson-example
[issues]: ../../issues
[steve-crouch]: https://github.com/steve-crouch
[james-graham]: https://github.com/jag1g13
[aleksandra-nenadic]: https://github.com/anenadic
[cc-by-human]: https://creativecommons.org/licenses/by/4.0/
[cc-by-legal]: https://creativecommons.org/licenses/by/4.0/legalcode
[mit-license]: https://opensource.org/licenses/MIT
[styles]: https://github.com/carpentries/styles/
[ssi]: https://software.ac.uk/
[matthew-bluteau]: https://github.com/bielsnohr
[doug-lowe]: https://github.com/douglowe
[kamilla-kopec-harding]: https://github.com/kkh451
