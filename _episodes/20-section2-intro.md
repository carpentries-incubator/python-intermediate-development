---
title: "Section 2: Ensuring Correctness of Software at Scale"
colour: "#fafac8"
start: true
teaching: 5
exercises: 0
questions:
- "What should we do to ensure our code is correct?"
objectives:
- "Introduce the testing tools, techniques, and infrastructure that will be used in this section."
keypoints:
- "Using testing requires us to change our practice of code development, but saves time in the long run by
allowing us to more comprehensively and rapidly find faults in code, as well as giving us greater confidence in the correctness of our code."
- "The use of test techniques and infrastructures such as **parameterisation** and **Continuous Integration** can help scale and further automate our testing process."
---

We have just set up a suitable environment for the development of our software project
and are ready to start coding.
However, we want to make sure that the new code we contribute to the project
is actually correct and is not breaking any of the existing code.
So, in this section,
we will look at testing approaches that can help us ensure
that the software we write is behaving as intended,
and how we can diagnose and fix issues once faults are found.
Using such approaches requires us to change our practice of development.
This can take time, but potentially saves us considerable time
in the medium to long term
by allowing us to more comprehensively and rapidly find such faults,
as well as giving us greater confidence in the correctness of our code -
so we should try and employ such practices early on.
We will also make use of techniques and infrastructure that allow us to do this
in a scalable, automated and more performant way as our codebase grows.

{% comment %}
![Tools for scaled software testing](../fig/section2-overview.png){: .image-with-shadow width="800px" }
{% endcomment %}

![Tools for scaled software testing](../fig/section2-overview.svg){: .image-with-shadow width="1000px" }

{% comment %}
flowchart LR
A(1. Setting up
software environment)
--> B(2. Verifying
software correctness

    - Test frameworks
    - Automate and scale testing: CI and GitHub Actions
    - Debug code)
--> C(3. Software development
as a process)
--> D(4. Collaborative
development for reuse)
--> E(5. Managing software
over its lifetime)

https://mermaid.live/edit#pako:eNpNUctqwzAQ_JVFJweSQF8XHwppEtpCc2lKD0WXjbx2RO1dI60dQsi_V07jUp3E7MwyM3syTgoyuSlrObg9BoW3d8uL7GYOW1L1XEHXWo5S6gEDAXHvg3BDrBPLs9kjPGW3c_ik4MtjYv-jOgmBnDLFaNkypDeDD4oKZcCGDhK-4wgvOpUGlQC5gOiwJtDETAtzWL5e0GevL90OFk698J9wRbuugiHE1c4yu0vWRw8F9VRLO9i1jBEQ2iAuObqyV9n9HJZS17iTgOp7svxPA6UECNTFcfs6e5jDBhmroZkxqmXpKYDXCLUvSX1DEzM1DYUGfZHaPQ12rdE9NWRNnr4FldjVao3lc6Jiyr89sjO5ho6mpmuL1MbKY5WqMnmJdUwoFV4lbH4vdjncyFxfJqO6Rf4SGXXnH1UppyA

{% endcomment %}

In this section we will:

- Make use of a **test framework** called Pytest,
  a free and open source Python library to help us structure and run automated tests.
- Design, write and run **unit tests** using Pytest
  to verify the correct behaviour of code and identify faults,
  making use of test **parameterisation**
  to increase the number of different test cases we can run.
- Automatically run a set of unit tests using **GitHub Actions** -
  a **Continuous Integration** infrastructure that allows us to
  automate tasks when things happen to our code,
  such as running those tests when a new commit is made to a code repository.
- Use PyCharm's integrated **debugger** to
  help us locate a fault in our code while it is running, and then fix it.

{% include links.md %}
