---
layout: episode
title: "Wrap-up"
start: true
type: "wrap-up"
colour: "#FBED65"
teaching: 15
exercises: 0
questions:
- "Looking back at what was covered and how different pieces fit together"
- "Where are some advanced topics and further reading available?"
objectives:
- "Put the course in context with future learning."
keypoints:
- "Collaborative techniques and tools play an important part of research software development in teams."
---
    
{% comment %}
'Good' code best practices (from Steve's slides):
Correct – does what it’s intended to do
Readable – remember WORM (Write Once Read Many)
Testable – “if it’s not tested it’s broken”
Documented – not what/how but why/because
Robust and reliable
Maintainable – by you and others six months from now
Extensible, flexible + reusable
Efficient, performant + scalable
Secure
Discoverable – others can understand quickly + easily
Simple – modular
{% endcomment %}


## Summary
As part of this course we have looked at a core set of established, intermediate-level software development tools and 
best practices for working as part of a team. The course teaches a selected subset of skills 
that have been tried and tested in collaborative research software development environments, although not an
all-encompassing set of every skill you might need (check some [further reading](./#further-resources)). It will 
provide you with a solid basis for writing industry-grade code, which relies on the same best practices taught in this course:

- Collaborative techniques and tools play an important part of research software development in teams, but also have benefits in solo development. We've looked at the benefits of a well-considered development environment, using practices, tools and infrastructure to help us write code more effectively in collaboration with others.
- We've looked at the importance of being able to verify the correctness of software and automation, and how we can leverage techniques and infrastructure to automate and scale tasks such as testing to save us time - but automation has a role beyond simply testing: what else can you automate that would save you even more time? Once found, we've also examined how to locate faults in our software.
- We've gone beyond procedural programming and explored different software design paradigms, such as object-oriented and functional styles of programming. We've contrasted their pros, cons, and the situations in which they work best, and how separation of concerns through modularity and architectural design can help shape good software.
- As an intermediate developer, aspects other than technical skills become important, particularly in development teams. We've looked at the importance of good, consistent practices for team working, and the importance of having a self-critical mindset when developing software,  and ways to manage feedback effectively and efficiently.

Diagram below depicts a [concept map][concept-maps] of tools and techniques covered in the course and a
high-level overview of how they fit together.

![Overview of tools and techniques covered in the course](../fig/course-concept-map.png){: .image-with-shadow width="800px"}

## Further Resources
Below are some additional resources to help you continue learning:

- [Additional episode on databases](../databases)
- [Additional episode on verifying code style using linters](../verifying-code-style-linters)
- [CodeRefinery courses on FAIR (Findable, Accessible, Interoperable, and Reusable) software practices][coderefinery-lessons] 
- [Python documentation][python-documentation]
- [GitHub Actions documentation][github-actions]

{% include links.md %}
