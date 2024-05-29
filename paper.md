---
title: 'Intermediate Research Software Development Skills (Python)'
tags:
  - software design
  - software engineering
  - research software
  - carpentry
  - intermediate
  - python
authors:
  - name: Stephen Crouch
    email: s.crouch@software.ac.uk
    orcid: 0000-0001-8985-6814
    affiliation: 1
  - name: Aleksandra Nenadic
    email: a.nenadic@software.ac.uk
    orcid: 0000-0002-2269-3894
    affiliation: 1
  - name: James Graham
    email: james.a.graham@kcl.ac.uk
    orcid: 000-0001-5217-3104
    affiliation: 1,2
  - name: Martin Robinson
    email: martin.robinson@cs.ox.ac.uk
    orcid: 0000-0002-1572-6782
    affiliation: 3
  - name:  Sam Mangham
    email: S.Mangham@soton.ac.uk
    orcid: 0000-0001-7511-5652
    affiliation: 1
  - name: Jacalyn Laird
    email: 
    orcid: 000-0002-9048-9393
    affiliation: 1,4
  - name: Thomas Kiley
    email: 
    orcid: 
    affiliation: 
  - name: Matthew Bluteau
    email: matthew.bluteau@ukaea.uk
    orcid: 0000-0001-9498-8475
    affiliation: 5
  - name: Sven van der Burg
    email: s.vanderburg@esciencecenter.nl
    orcid: 0000-0003-1250-6968
    affiliation: 6
  - name: Giulia Crocioni
    email: 
    orcid: 0000-0002-0823-0121
    affiliation: 6
affiliations:
 - name: Software Sustainability Institute
   index: 1
 - name: King's College London
   index: 2
 - name: University of Oxford
   index: 3
 - name: SAC Consulting
   index: 4
 - name: UK Atomic Energy Authority
   index: 5
 - name: 	Netherlands eScience Center
   index: 6
date: 2024-05-28
bibliography: paper.bib


---

# Summary

This course aims to teach a core set of established, intermediate-level software development skills and best practices for working as part of a team in a 
research environment using Python as an example programming language. 
The core set of skills we teach is not a comprehensive set of all-encompassing skills, but a selective set of tried-and-tested collaborative development 
skills that forms a firm foundation for continuing on your learning journey.
The course teaches these skills in a way that mimics a typical software development process working as a part of a team, starting from an existing piece of software. 

# Statement of need

<!-- explain how the submitted artifacts contribute to computationally enabled teaching and learning, and describing how they might be adopted by others. -->

A typical learner for this course may be someone who is working in a research environment, needing to write some code, has gained basic software development skills 
either by self-learning or attending, e.g., a novice Software Carpentry Python course. 
They have been applying those skills in their domain of work by writing code for some time, e.g. half a year or more. 
However, their software development-related projects are now becoming larger and are involving more researchers and other stakeholders (e.g. users), for example:

* Software is becoming more complex and more collaborative development effort is needed to keep the software running
* Software is going further than just the small group developing and/or using the code - there are more users and an increasing need to add new features
* ‘Technical debt’ is increasing with demands to add new functionality while ensuring previous development efforts remain functional and maintainable

They now need intermediate software engineering skills to help them design more robust software code that goes beyond a few thrown-together proof-of-concept scripts, 
taking into consideration the lifecycle of software, writing software for stakeholders, team ethic and applying a process to understanding, 
designing, building, releasing, and maintaining software.

# Learning objectives, design, and experience

<!--  describe the learning objectives, content, instructional design, and experience of use in teaching and learning situations. -->

After going through this course, participants will be able to:

* Set up and use a suitable development environment together with popular source code management infrastructure to develop software collaboratively
* Use a test framework to automate the verification of correct behaviour of code, and employ parameterisation and continuous integration to scale and further automate code testing
* Design robust, extensible software through the application of suitable programming paradigms and design techniques
* Understand the code review process and employ it to improve the quality of code
* Prepare and release software for reuse by others
* Manage software improvement from feedback through agile techniques

The course follows a narrative around a software development team working on an existing software project that is analysing patients’ inflammation data 
(from the novice Software Carpentry's "Programming in Python" course). 
The course is split into 5 sections, each of which can be delivered in approximately half to a full day, in either guided self-learning mode (where helpers provide help 
and answer questions - synchronously or asynchrounously) or in a standard instructor-led mode.
Learners are typically organised in small groups from the outset and initially work individually through the material on their own with the aid of helpers (or follow an instructor). 
In later sections, exercises involve more group work and learners from the same group form a development team and collaborate on a mini software project.

# How the lesson came to be

The Software Sustainability Institute (SSI) conducted an international RSE survey in 2018 as well as a series of internal interviews with the key RSE group leaders and 
[SSI's Open Call research software projects](https://www.software.ac.uk/news/need-free-help-your-research-software-try-institutes-open-call-1) we supported with free 
software development expertise and consultancy, and asked them about the current training needs. 
They all came back to us with a single feedback - what software engineering skills to learn next 
after gaining foudnational computational skills via Software, Data or Library Carpentry and where to find such training resources.
There was also a shift from working on research software development projects in isolation and solo towards working in teams and collaboratively, 
as software is developed in industry, and how to learn those skills.

Original lesson authors Aleksandra Nenadic, James Graham, and Steve Crouch from the Software Sustainability Institute joined up to create this 
course to fill on those gaps and started working on this course in 2019.

# Acknowledgements

Original lesson authors Aleksandra Nenadic, James Graham, and Steve Crouch were supported by the UK's Software Sustainability Institute 
via the EPSRC, BBSRC, ESRC, NERC, AHRC, STFC and MRC grant EP/S021779/1.

Since then, many people have contributed to the course material - see [AUTHORS](https://github.com/carpentries-incubator/python-intermediate-development/blob/gh-pages/AUTHORS).


# References

See [paper.bib](https://github.com/carpentries-incubator/python-intermediate-development/blob/gh-pages/paper.bib) file.
 
