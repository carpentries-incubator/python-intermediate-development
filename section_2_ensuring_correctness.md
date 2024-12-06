---
jupyter:
  celltoolbar: Slideshow
  jupytext:
    notebook_metadata_filter: -kernelspec,-jupytext.text_representation.jupytext_version,rise,celltoolbar
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
  rise:
    theme: solarized
---

<!-- #region slideshow={"slide_type": "slide"} -->
# Section 2: Ensuring Correctness of Software at Scale

</br>
</br>
<center><img src="../fig/section2-overview.png" width="70%"></center>
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- Probably the most important thing to take away from this course
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Automatically Testing your Software

- Big questions: how can we be sure the code we have written is correct, produces accurate results, and is of good quality?
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "fragment"} -->
> **testing:** The process of operating a system or component under specified conditions, observing or recording the results, and making an evaluation of some aspect of the system or component
> — IEEE Standard Glossary of Software Engineering
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- Big questions: how can we be sure the code we have written is correct, produces accurate results, and is of good quality?
  - This is the domain of Verification and Validation (V&V), in which testing plays an important role
  
> **testing:** The process of operating a system or component under specified conditions, observing or recording the results, and making an evaluation of some aspect of the system or component
> — IEEE Standard Glossary of Software Engineering
- i.e. inferring the _behaviour_ of our code through artifacts and making sure that matches what we expect or is required
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "subslide"} -->
### Types of Testing

- Types of testing
  - Manual testing
  - Automated testing
    - Unit tests
    - Functional or integration tests
    - End-to-end
    - Regression tests
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- Types of (dynamic) testing
  - Manual testing: an important part of exploratory research
  - Automated testing: codify the expected behaviour of our software such that verification can happen repeatedly without user inspection
    - Unit tests: tests for small function units of our code (i.e functions, class methods, class objects)
    - Functional or integration tests: work at a higher level, and test functional paths through your code, e.g. given some specific inputs, a set of interconnected functions across a number of modules (or the entire code) produce the expected result.
    - Regression tests: compare the current output of your code (usually an end-to-end result) to make sure it matches previous output that you do not want to change
- there was a question that came in about drift in regression tests, and the short answer with how to deal with this is first determining whether the output you are tracking is actually an invariant (or something close to an invariant)
  - If not, then you will necessarily need to allow for relative proximity, but then you might question whether this is a good long term output to base your regression test on.
  - In our area and science broadly, invariants tend to be some observable or experimental physical results, so if you test is not based on that, you are probably going to have a tough time.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "subslide"} -->
### Breakout Exercise: 🖉 Set Up a New Feature Branch for Writing Tests

Start from this section heading and go to the end of the page.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- Breakout rooms from the page section "Set Up a New Feature Branch for Writing Tests" (~45 minutes) until the end of the page
- status check and any questions
- potential quiz questions: 
  - what is the correct order of these different types of tests if they should be in ascending order of scope (i.e. the amount of the codebase they cover) (answer: 3)
    1. end-to-end, functional/integration, unit
    2. functional/integration, unit, end-to-end
    3. unit, functional/integration, end-to-end
    4. unit, end-to-end, functional/integration
  - automated testing of our code is important because (select all that apply, answer: 4)
    1. it can quickly help anyone verify that the code is working the way that the developer intended it to
    2. it provides an harness in which we can make changes to the code and be more sure that these changes do not alter behaviour of the code that shouldn't change
    3. it reduces the overhead of new developers trying to determine if the code works on their machine
    4. all of the above
    5. none of the above
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## ☕ 5 Minute Break ☕
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## Scaling Up Unit Testing

1. Parameterise our tests to reduce repetition
2. Check the test coverage of our code
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
1. Parameterise our tests
  - from the previous example, you may have noticed that if you want to run a test with the same logic but different input data, you will need to create a new test function that is mostly the same
  - there is a convenient way to avoid this in pytest called _parameterisation_, allowing a single test function to run through a variety of test input cases
  - very powerful to improve the coverage of the parameter space that you code might be dealing with
2. Check the test coverage
  - on a related note, it is important to see how much of our code is "covered" (i.e. verified) by our tests so that we can get at least a relative idea of how the quality of our code is faring overtime, and where we should focus testing efforts
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "subslide"} -->
### Breakout Exercise: 🖉 Parameterising Our Unit Tests

Go through this page to the end, starting from this section heading. In the last 5-7 minutes, please think about the question:

_Where can and might the input data and corresponding expected results come from for code you use in your usual work?_

Please discuss with your peers. Record answers in the shared document if you can.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- send learners into breakout rooms for ~ 20 minutes
  - before sending, make sure they are clear on the discussion question
  - with about 5 minutes left, remind the groups to have a little discussion about their test data
  - status check
- check answers to question in shared document and briefly summarise
  - example answer: You are working on an old plasma magnetohydrodynamics code that has been extensively tested against experiments. You have been tasked with adding some functionality to that code, but you want to make sure that you do not change the key results of the code. You take some inputs for well known runs of the code that have been verified against experiment and save the outputs. You then use the outputs to compare against when you run the code in a test suite with those original inputs. This is basically creating some regression tests for the code, using results that you know are correct because of extensive experimental validation of the code in the past.
- comments about the limits of testing:
  - there are some good points there about getting value from testing
  - what most researchers think: 
    - "Peer review of my paper will be the test"
    - "Looking at a graph is enough"
    - "I do not have time to implement a clunky testing framework"
  - it hints that there is a spectrum between throwaway code that does not need to be tested and library code used by hundreds in a community that requires extensive testing suites with more than just unit tests
  - where your particular code lies is a tricky question to answer sometimes, but a good rule of thumb is that if there is a chance that someone else will be using it, then you should give some thought to tests
    - some further thoughts here: https://bielsnohr.github.io/2021/11/29/iccs-part2-and-testing.html
  - testing has a demonstrably positive impact upon the design on your code
  - it must of course also be acknowledged that testing is not the answer to everything, and that it cannot substitute for good manual and acceptance testing
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## ☕ 5 Minute Break ☕
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
# Continuous Integration for Automated Testing

</br>
</br>

_How do we know our tests—and code in general—will work on other people's machines?_
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- How do we know our tests—and code in general—will work on other people's machines?
  - the main answer these days is to use Continuous Integration.
- What is Continuous Integration?
  - very loosely, it is an automated system that is triggered upon certain actions to your repository (like pushing or merging) and performs quality checks on your code (and nearly anything else you like too!)
  - the key part is that this all happens on a remote "virtual" machine that is set up and torn down each time the tasks need to be performed, thus ensuring there are no idiosyncracies that arise because of our particular development environment
  - in our case, we will be setting up CI to run our tests on the remote service provided by GitHub called GitHub Actions
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "subslide"} -->
### Breakout Exercise: 🖉 Continuous Integration with GitHub Actions

Follow along from this section heading to the bottom of the page.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- breakout rooms (for ~ 45 mins) from this section heading to the bottom of the page
- status check: consider using a poll to see how many people have a green check on their repo
- comments
  - GitLab has very similar functionality and it is common for institutions to host their own GitLab instance internally. These instances will have their own documentation, and it is worthwhile to check if the RSE group or IT services have any guides to using these resources.
  - Because the supported Python versions are constantly changing, the numbers above might be a little out of date, or inconsistent.
    - do not worry about this too much, but if you want to show the current supported Python versions, this site is very useful: https://devguide.python.org/versions/
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## ☕ 15 Minute Break ☕
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
# Diagnosing Issues and Improving Robustness
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- already while you have been creating tests, you might have encountered errors while you are trying to write those tests, and it is not immediately obvious what is going on
  - debugging offers a powerful technique for investigating in these situations, and more generally
- there will also be some content about defensive programming
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "subslide"} -->
### Breakout Exercise: 🖉 Setting the Scene (for Debugging)

Follow along from this section heading to the bottom of the page.
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "notes"} -->
- split learners into breakout rooms (~50 mins although likely less, so take a status check early) starting from this section heading and going to the end of the page
  - if learners are using different editors, then encourage them to try and replicate the technique of debugging that is explained here
- status check
<!-- #endregion -->

<!-- #region slideshow={"slide_type": "slide"} -->
## 🕓 End of Section 2 🕓

Please fill out the end-of-section survey!
<!-- #endregion -->
