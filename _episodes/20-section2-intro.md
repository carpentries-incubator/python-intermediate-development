---
title: "Section 2: Ensuring Correctness of Software at Scale"
colour: "#fafac8"
start: true
teaching: 5
exercises: 0
questions:
- "What should we do to ensure our code is correct?"
objectives:
- "Explain the testing tools, techniques, and infrastructure that will be used in this section."
keypoints:
- "Automated testing can help determine if our code is running correctly, as well as save us time in the future."
- "Parameterisation and Continuous Integration can help scale and further automate our testing process."
---

We've previously looked at building a suitable environment for collaboratively developing software. In this section we'll look at testing approaches that help us ensure that the software we write is actually correct, and how we can diagnose and fix issues once faults are found. Using such approaches requires us to change our practice of development. This can take time, but potentially saves us considerable time in the medium to long term by allowing us to more comprehensively and rapidly find such faults, as well as giving us greater confidence in the correctness of our code. We will also make use of techniques and infrastructure that allow us to do this in a scalable and more performant way.

![Tools for scaled software testing](../fig/section2-overview.png){: .image-with-shadow width="800px" }

In this section we will:

- Make use of a **test framework** called Pytest, a free and open source Python library to help us structure and run automated tests.
- Design, write and run **unit tests** using pytest to verify the correct behaviour of code and identify faults, making use of test **parameterisation** to increase the number of different test cases we can run.
- Automatically run a set of unit tests using **GitHub Actions** - a **Continuous Integration** infrastructure that allows us to automate tasks when things happen to our code, such as running those tests when a new commit is made to a code repository.
- Use PyCharm's integrated **debugger** to help us locate a fault in our code while it is running.

{% include links.md %}
