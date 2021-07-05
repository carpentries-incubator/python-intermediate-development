---
title: "Continuous Integration for Automated Testing"
teaching: 45
exercises: 0
questions:
- "How can I apply automated repository testing to scale with development activity?"
objectives:
- "Describe the benefits of using Continuous Integration for further automation of testing"
- "Enable GitHub Actions Continuous Integration for public open source repositories"
- "Use continuous integration to automatically run unit tests and code coverage when changes are committed to a version control repository"
keypoints:
- "Continuous Integration can run tests automatically to verify changes as code develops in our repository."
- "CI builds are typically triggered by commits pushed to a repository."
- "We need to write a configuration file to inform a CI service what to do for a build."
- "Builds can be enabled and configured separately for each branch."
- "We can run - and get reports from - different CI infrastructure builds simultaneously."
---

## Introduction

So far we've been manually running our tests as we require. So once we've made a change, or add a new feature with accompanying tests, we can re-run our tests, giving ourselves (and others who wish to run them) increased confidence that everything is working as expected. Now we're going to take further advantage of automation in a way that helps testing scale across a development team with very little overhead, using **Continuous Integration**.


## What is Continuous Integration?

The automated testing we've done so far only takes into account the state of the repository we have on our own machines. In a software project involving multiple developers working and pushing changes on a repository, it would be great to know holistically how all these changes are affecting our codebase without everyone having to pull down all the changes and test them. If we also take into account the testing required on different target user platforms for our software and the changes being made to many repository branches, the effort required to conduct testing at this scale can quickly become intractable for a research project to sustain.

Continuous Integration (CI) aims to reduce this burden by further automation, and automation - wherever possible - helps us to reduce errors and makes predictable processes more efficient. The idea is that when a new change is committed to a repository, CI clones the repository, builds it if necessary, and runs any tests. Once complete, it presents a report to let you see what happened.

There are many CI infrastructures and services, free and paid for, and subject to change as they evolve their features. We'll be looking at GitHub Actions - which unsurprisingly is available as part of GitHub.


## Continuous Integration with GitHub Actions

### YAML - a Deeper Dive

We've seen YAML files before, with our `environment.yml` file which we'll be looking in more detail at shortly, but they're also used to write GitHub Action workflow files. They're also increasingly used for configuration files and storing other types of data, so it's worth taking a bit of time looking into this file format in more detail.

[YAML](https://www.commonwl.org/user_guide/yaml/) (a recursive acronym which stands for "YAML Ain't Markup Language") is a language designed to be human readable. The three basic things you need to know about with YAML to get started with GitHub Actions are key-value pairs, arrays, and maps.

So firstly, YAML files are essentially made up of **key-value** pairs, in the form `key: value`, for example:

~~~
name: Kilimanjaro
height_metres: 5892
first_scaled_by: Hans Meyer
~~~
{: .language-bash}

In general you don't need quotes for strings, but you can use them when you want to explicitly distinguish between numbers and strings, e.g. `height_metres: "5892"` would be a string, but above it is an integer. It turns out Hans Meyer isn't the only first ascender of Kilimanjaro, so one way to add this person as another value to this key is by using YAML **arrays**, like this:

~~~
first_scaled_by:
  - Hans Meyer
  - Ludwig Purtscheller
~~~
{: .language-bash}

An alternative to this format for arrays is the following, which would have the same meaning:

~~~
first_scaled_by: [Hans Meyer, Ludwig Purtscheller]
~~~
{: .language-bash}

If we wanted to express more information for one of these values we could use a feature known as **maps**, which allow us to define nested, hierarchical data structures, e.g.

~~~
...
height:
  value: 5892
  unit: metres
  measured:
    year: 2008
    by: Kilimanjaro 2008 Precise Height Measurement Expedition
...
~~~
{: .language-bash}

So here, `height` itself is made up of three keys `value`, `unit`, and `measured`, with the last of these being another nested key with the keys `year` and `by`. Note the convention of using two spaces for tabs, instead of Python's four.

We can also combine maps and arrays to describe more complex data. Let's say we want to add more detail to our list of initial ascenders:

~~~
...
first_scaled_by:
  - name: Hans Meyer
    date_of_birth: 22-03-1858
    nationality: German
  - name: Ludwig Purtscheller
    date_of_birth: 22-03-1858
    nationality: Austrian
~~~
{: .language-bash}

So here we have a YAML array of our two mountaineers, each with additional keys offering more information. As we'll see shortly, GitHub Actions workflows will use all of these.


### Preparing a Suitable `environment.yml` for CI

Since we're going to be running our tests on a third-party server infrastructure, we first need to consider how well our code will run across other platforms. This is a good mindset to have in any case!

As was mentioned in the [Virtual Environments](../03-virtual-environments/index.html#exporting-a-conda-environment) episode, one problem we can run into with Conda's exported environments is that they tend to include platform-specific packages. This could well cause us issues for running on continuous integration infrastructures, as well as for others who wish to use our software on different operating systems, so we use `--from-history` to export our environment from the commands that were used to build it, which has the useful effect of not including platform-specific packages that could give us trouble. However, in the case of CI we need to go one step further.

Let's look at our `environment.yml`:

~~~
$ cat environment.yml
~~~
{: .language-bash}

~~~
name: patient
channels:
  - defaults
dependencies:
  - python=3.8
  - numpy
  - matplotlib
  - pytest
  - pytest-cov
~~~
{: .language-bash}

For the purposes of using continuous integration and testing our code, there are no version numbers for the Python packages, which is very useful - it means the latest packages will always be tested against. However, you'll notice that the version of Python itself is mentioned explicitly. One of the major benefits of CI that we'll explore is that it allows us to specify the type of plaform(s) we want to test against, which may include the version of Python. To avoid confusion with which version will be used, we should remove the Python version that is specified here. So edit your `environment.yml` file so that line looks like the following and save the file:

~~~
...
  - python
...
~~~
{: .language-bash}

### Defining Our Workflow

With a GitHub repository there's a way we can set up CI to run our tests when we make a change, by adding a new file to our repository whilst on the `test-suite` branch. First, create the new directories `.github/workflows`:

~~~
$ mkdir -p .github/workflows
~~~
{: .language-bash}

This directory is used specifically for GitHub Actions, allowing us to specify any number of workflows that can be run under a variety of conditions, which is also written using YAML. So let's add a new YAML file called `main.yml` within the new `.github/workflows` directory:

~~~
name: CI

# We can specify which Github events will trigger a CI build
on: push

# now define a single job 'build' (but could define more)
jobs:

  build:

    # we can also specify the OS to run tests on
    runs-on: ubuntu-latest

    # a job is a seq of steps
    steps:

    # Next we need to checkout out repository, and set up Python
    # A 'name' is just an optional label shown in the log - helpful to clarify progress - and can be anything
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Conda
      uses: conda-incubator/setup-miniconda@v2
      with:
        auto-update-conda: true
        python-version: 3.8
        activate-environment: patient
        environment-file: environment.yml

    - name: Install conda-build and our inflammation package
      run: |
        conda install -n base --yes conda-build
        conda develop -n patient .

    - name: Test with PyTest
      run: |
        conda run -n patient pytest --cov=inflammation.models tests/test_models.py
~~~
{: .language-bash}

So as well as giving our workflow a name - CI - we indicate with `on` that we want this workflow to run when we `push` commits to our repository. The workflow itself is made of a single `job` named `build`, and we could define any number of jobs after this one if we wanted, and each one would run in parallel.

Next, we define what our build job will do. With `runs-on` we first state which operating systems we want to use, in this case just Ubuntu for now. We'll be looking at ways we can scale this up to testing on more systems later.

Lastly, we define the `step`s that our job will undertake in turn, to set up the job's environment and run our tests. You can think of the job's environment intially as a blank slate: much like a freshly installed machine (albeit virtual) with very little installed on it, we need to prepare it with what it needs to be able to run our tests. Each of these steps are:

- **Checkout repository for the job:** `uses` indicates that want to use a GitHub Action called `checkout` that does this
- **Set up Conda:** here we use the `setup-miniconda` Action, passing some parameters to govern its behaviour: that we want the latest version of Conda for Python version 3.8, and to define a new environment based on our `environment.yml` file which is called `patient`
- **Install conda-build and our inflammation package:** In order to locally install our `inflammation` package we first need to install a package called `conda-build` in the default `base` Conda environment to do this. Once installed, we can use `conda develop` as before, except here we explicitly specify that we want the local `inflammation` package to be installed to the `patient` virtual environment. We use `run` here to run the conda commands
- **Test with PyTest:** Lastly, we run pytest. In order to do this successfully, we use `conda run` to execute a given command explicitly within our `patient` environment, with the same arguments we used manually before


### Triggering a Build on GitHub Actions

Now if we commit and push this change a CI run will be triggered:

~~~
$ git add .github environment.yml
$ git commit -m "Add GitHub Actions configuration"
$ git push
~~~
{: .language-bash}

Since we are only committing the GitHub Actions configuration file to the `test-suite` branch for the moment, only the contents of this branch will be used for CI. We can pass this file upstream into other branches (i.e. via merges) when we're happy it works, which will then allow the process to run automatically on these other branches. This again highlights the usefulness of the feature-branch model - we can work in isolation on a feature until it's ready to be passed upstream without disrupting development on other branches, and in the case of CI, we're starting to see its scaling benefits across a larger scale development team working across potentially many branches.

### Checking Build Progress and Reports

Handily, we can see the progress of the build from our repository on GitHub by selecting the `test-suite` branch from the dropdown menu (which currently says `main`), and then selecting `commits` (located just above the code directory listing on the right, alongside the last commit message and a small image of a timer).

![ci-initial-ga-build](../fig/ci-initial-ga-build.png)

You'll see a list of commits for this branch, and likely see an orange marker next to the latest commit (clicking on it yields `Some checks haven’t completed yet`) meaning the build is still in progress. This is a useful view, as over time, it will give you a history of commits, who did them, and whether the commit resulted in a successful build or not.

Hopefully after a while, the marker will turn green indicating a successful build. Selecting it gives you even more information about the build, and selecting `Details` link takes you to a complete log of the build and its output.

![ci-initial-ga-build-log](../fig/ci-initial-ga-build-log.png)

The logs are actually truncated; selecting the arrows next to the entries - which are the `name` labels we specified in the `main.yml` file - will expand them with more detail, including the output from the actions performed.

![ci-initial-ga-build-details](../fig/ci-initial-ga-build-details.png)

GitHub Actions offers these continuous integration features as a free service with 2000 Actions/minutes a month on as many public repositories that you like, although paid levels are available.


## Scaling Up Testing Using Build Matrices

Now we have our CI configured and building, we can use a feature called **build matrices** which really shows the value of using CI to test at scale.

Suppose the intended users of our software use either Ubuntu, Mac OS, or Windows, and either have Python version 3.7 or 3.8 installed, and we want to support all of these. Assuming we have a suitable test suite, it would take a considerable amount of time to set up testing platforms to run our tests across all these platform combinations. Fortunately, CI can do the hard work for us very easily.

Using a build matrix we can specify testing environments and parameters (such as operating system, Python version, etc.) and new jobs will be created that run our tests for each permutation of these.

Let's see how this is done using GitHub Actions. To support this, change `.github/workflow/main.yml` to the following:

~~~
...
    runs-on: {% raw %}${{ matrix.os }}{% endraw %}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
        python-version: [3.7, 3.8]

    # a job is a seq of steps
    steps:

    # Next we need to checkout out repository, and set up Python
    # A 'name' is just an optional label shown in the log - helpful to clarify progress - and can be anything
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Conda
      uses: conda-incubator/setup-miniconda@v2
      with:
        auto-update-conda: true
        python-version: {% raw %}${{ matrix.python-version }}{% endraw %}
        activate-environment: patient
        environment-file: environment.yml
...
~~~
{: .language-bash}

Here, we are specifying a build strategy as a matrix of operating systems and Python versions, and using `matrix.os` and `matrix.python-version` to reference these configuration possibilities instead of using hardcoded values. The `{% raw %}${{ }}{% endraw %}` are used as a means to reference these configurations. So every possible permutation of Python versions 3.7 and 3.8 with the Ubuntu, Mac OS and Windows operating systems will be tested, so we can expect 6 build jobs in total.

Let's commit and push this change and see what happens:

~~~
$ git add .github/workflows/main.yml
$ git commit -m "Add GA build matrix for os and Python version"
$ git push
~~~
{: .language-bash}

If we go to our GitHub build now, we can see that a new job has been created for each permutation.

![ci-ga-build-matrix](../fig/ci-ga-build-matrix.png)

Note all jobs running in parallel (up to the limit allowed by our account) which potentially saves us a lot of time waiting for testing results. Overall, this approach allows us to massively scale our automated testing across platforms we wish to test.


## Merging Back to `develop` Branch

Now we're happy with our test suite, we can merge this work (which currently only exist on our `test-suite` branch) with our parent `develop` branch. Again, this reflects us working with impunity on a logical unit of work, involving multiple commits, on a separate feature branch until it's ready to be escalated to the `develop` branch:

~~~
$ git checkout develop
$ git merge test-suite
~~~
{: .language-bash}

Then, assuming no conflicts we can push these changes back to the remote repository as we've done before:

~~~
$ git push origin develop
~~~
{: .language-bash}

Now these changes have migrated to our parent `develop` branch, `develop` will also inherit the configuration to run CI builds, so these will run automatically on this branch as well.

This highlights a big benefit of CI when you perform merges (and apply pull requests). As new branch code is merged into upstream branches like `develop` and `main` this newly integrated code changes are automatically tested *together* with existing code - which of course may also have changed in the meantime!


{% include links.md %}
