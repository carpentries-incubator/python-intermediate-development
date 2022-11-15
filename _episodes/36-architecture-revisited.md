---
title: "Architecture Revisited: Extending Software"
teaching: 15
exercises: 0
questions:
- "How can we extend our software within the constraints of the MVC architecture?"
objectives:
- "Extend our software to add a view of a single patient in the study and the software's command line interface to request a specific view."
keypoints:
- "By breaking down our software into components with a single responsibility, we avoid having to rewrite it all when requirements change. 
Such components can be as small as a single function, or be a software package in their own right."
---

## MVC Revisited

We've been developing our software using the **Model-View-Controller** (MVC) architecture so far, but, as we have seen, MVC is just one of the common architectural patterns and is not the only choice we could have made.

There are many variants of an MVC-like pattern (such as [Model-View-Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP), [Model-View-Viewmodel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) (MVVM), etc.), but in most cases, the distinction between these patterns isn't particularly important.
What really matters is that we are making decisions about the architecture of our software that suit the way in which we expect to use it.
We should reuse these established ideas where we can, but we don't need to stick to them exactly.

In this episode we'll be taking our Object Oriented code from the previous episode and integrating it into our existing MVC pattern.

Let's start with adding a view that allows us to see the data for a single site.
First, we need to add the code for the view itself and make sure our `Site` class has the necessary data - including the ability to pass a list of measurements to the `__init__` method.
Note that your Site class may look very different now, so adapt this example to fit what you have.

~~~ python
# file: catchment/views.py

...

def display_measurement_record(site):
    """Display each dataset for a single site."""
    print(site.name)
    for measurement in site.measurements:
        print(site.measurements[measurement].df.rename({0:measurement},axis='columns'))
~~~
{: .language-python}

~~~ python
# file: catchment/models.py

...

class MeasurementSet:
    def __init__(self, df, name, units):
        self.df = df
        self.name = name
        self.units = units
    
    def __str__(self):
        if self.units:
            return f"{self.name} ({self.units})"
        else:
            return self.name

class Location:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

class Site(Location):
    def __init__(self,name):
        super().__init__(name)
        self.measurements = {}
    
    def add_measurement(self, measurement_id, data, units=None):    
        if measurement_id in self.measurements.keys():
            self.measurements[measurement_id].df = pd.concat([self.measurements[measurement_id].df, data])
    
        else:
            self.measurements[measurement_id] = MeasurementSet(data, measurement_id, units)
    
    @property
    def all_measurements(self):
        return pd.concat(
            [self.measurements[key].df.rename({0:key}, axis='columns') 
                               for key in self.measurements.keys()],
            axis=1)


~~~
{: .language-python}

Now we need to make sure people can call this view - that means connecting it to the controller and ensuring that there's a way to request this view when running the program.
The changes we need to make here are that the `main` function needs to be able to direct us to the view we've requested - and we need to add to the command line interface the necessary data to drive the new view.

~~~
# file: catchment-analysis.py

#!/usr/bin/env python3
"""Software for managing measurement data for our catchment project."""

import argparse

from catchment import models, views


def main(args):
    """The MVC Controller of the patient data system.

    The Controller is responsible for:
    - selecting the necessary models and views for the current task
    - passing data between models and views
    """
    infiles = args.infiles
    if not isinstance(infiles, list):
        infiles = [args.infiles]

    for filename in infiles:
        inflammation_data = models.load_csv(filename)

        if args.view == 'visualize':
            view_data = {
                'average': models.daily_mean(inflammation_data),
                'max': models.daily_max(inflammation_data),
                'min': models.daily_min(inflammation_data),
            }

            views.visualize(view_data)

        elif args.view == 'record':
            patient_data = inflammation_data[args.patient]
            observations = [models.Observation(day, value) for day, value in enumerate(patient_data)]
            patient = models.Patient('UNKNOWN', observations)

            views.display_patient_record(patient)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='A basic patient data management system')

    parser.add_argument(
        'infiles',
        nargs='+',
        help='Input CSV(s) containing inflammation series for each patient')

    parser.add_argument(
        '--view',
        default='visualize',
        choices=['visualize', 'record'],
        help='Which view should be used?')

    parser.add_argument(
        '--patient',
        type=int,
        default=0,
        help='Which patient should be displayed?')

    args = parser.parse_args()

    main(args)
~~~
{: .language-python}

We've added two options to our command line interface here: one to request a specific view and one for the patient ID that we want to lookup.
For the full range of features that we have access to with `argparse` see the [Python module documentation](https://docs.python.org/3/library/argparse.html?highlight=argparse#module-argparse).
Allowing the user to request a specific view like this is a similar model to that used by the popular Python library Click - if you find yourself needing to build more complex interfaces than this, Click would be a good choice.
You can find more information in [Click's documentation](https://click.palletsprojects.com/).

For now, we also don't know the names of any of our patients, so we've made it `'UNKNOWN'` until we get more data.

We can now call our program with these extra arguments to see the record for a single patient:

~~~
python3 inflammation-analysis.py --view record --patient 1 data/inflammation-01.csv
~~~
{: .language-bash}

~~~
UNKNOWN
0 0.0
1 0.0
2 1.0
3 3.0
4 1.0
5 2.0
6 4.0
7 7.0
...
~~~
{: .output}

> ## Additional Material
> 
> Now we've covered the basics of multi-layer architectures and Object Oriented Programming, and how we can integrate it into our existing MVC code, there are two optional extra episodes which you may find interesting.
> 
> Both episodes cover the persistence layer of software architectures and methods of persistently storing data, but take different approaches.
> The episode on [persistence with JSON](/persistence) covers some more advanced concepts in Object Oriented Programming, while the episode on [databases](/databases) starts to build towards a true multilayer architecture, which would allow our software to handle much larger quantities of data.
{: .callout}
                    

## Towards Collaborative Software Development

Having looked at some theoretical aspects of software design, we are now circling back to 
implementing our software design and developing our software to satisfy the requirements collaboratively 
in a team. At an intermediate level of software development, there is a wealth of practices that could be used, and applying suitable design and coding practices is what separates an intermediate developer from someone who has just started coding. The key for an intermediate developer is to balance these concerns for each software project appropriately, and employ design and development practices enough so that progress can be made. 

One practice that should always be considered, and has been shown to be very effective in team-based
software development, is that of *code review*. Code reviews help to ensure the 'good' coding standards are achieved
and maintained within a team by having multiple people have a look and comment on key code changes to see how they fit
within the codebase. Such reviews check the correctness of the new code, test coverage, functionality changes,
and confirm that they follow the coding guides and best practices. Let's have look at some code review techniques
available to us.
