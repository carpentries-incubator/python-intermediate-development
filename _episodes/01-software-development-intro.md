---
title: "Introduction to Software Design and Development"
start: true
teaching: 20
exercises: 10
questions:
- "Why is splitting an application in smaller functional units (modules) good when designing software?"
- "What are programming interfaces in software design?"
- "What is Model-View-Controller design architecture?"
objectives:
- "Understand programming interfaces in software design"
- "Understand Model-View-Controller (MVC) architecture in software design"
- "Use git to obtain a working copy of our template software project"

keypoints:
- "Programming interfaces define how individual modules within a software application interact among themselves (as well as how the application itself interacts with its users as it is simply one big module containing smaller sub-modules)."
- "MVC is a software design architecture commonly used for developing software projects which divides the application into three interconnected modules: Model (data), View (user interface), and Controller (input/output and data manipulation)."
- "Template repository to be used throughout this workshop is an example of an MVC application that manipulates patients’ inflammation data and performs basic statistical analysis using Python."
---
## Programming Modules and Interfaces
In software design and development, large systems or programs are often decomposed into a set of smaller modules each with a subset of functionality. Typical examples of modules in programming are software libraries (such as `numpy` and `matplotlib`) or classes in object-oriented programming languages. 

Although modules are self-contained and independent elements to a large extent (we say to a large extent as they can depend on other modules), there are connections between them and well-defined ways of how they interact with one another. The rules of interaction between software modules are called programming interfaces - they define how other modules or clients can use a particular module. Typically, an interface to a module includes rules on how a module can take input from and how it gives output back to its clients. A client can be a human, in which case we also call these user interfaces. Even smaller functional units such as functions/methods have clearly defined interfaces - a function/method’s definition (also known as a **signature**) states what parameters it can take as input and what it returns as an output.

## Model-View-Controller (MVC) Design Architecture
Model–View–Controller (usually known as MVC) is a software design architecture commonly used for developing user interfaces (think about modern web applications) which divides the related program logic into three interconnected modules:

- **Model** (data)
- **View** (user interface),  and 
- **Controller** (processes that handle input/output and manipulate the data).

The three parts of MVC architecture are interconnected as shown in diagram below. 

**Model** represents the data used by a program. This may be a database, a file, or an object - for example a table representing patients data. 

**View** is the means of displaying data to users/clients within an application. For example, displaying a window with input fields and buttons (Graphical User Interface, GUI) or text within a command line shell (Command Line Interface, CLI) are examples of Views. They include anything that the user can see from the application. While building GUIs is not the topic of this workshop, we will cover building CLIs in Python in later lessons. 

**Controller** manipulates both the Model and the View. It accepts input from the View and performs the corresponding action on the Model and then updates the View accordingly. For example, on user request, Controller updates a picture on a user's GitHub profile and then modifies the View by displaying the updated profile back to the user.
       
> ## MVC application examples
> What other MVC application examples do you know, either computational or in real life? This exercise can be done as a group discussion.
> > ## Solution 
 > > #### Ordering food in a restaurant 
[comment]: <> (People Couple Waiter photo, Public Domain, https://publicdomainvectors.org/en/free-clipart/Restaurant-order-vector-image/9341.html)  
[comment]: <> (Chef food preparation photo, Free for commercial use, DMCA, https://www.pxfuel.com/en/free-photo-emwgt)
 > > When you go to a restaurant, the waiter comes to you to take your food order. The waiter doesn't know who you are 
 > > and what you want, they just write down the detail of your order. Then, the waiter moves to the kitchen where 
 > > the cook prepares your food based on the order passed to them by the waiter. 
 > > The cook needs ingredients, which they source from the refrigerator (storage). When the food is ready, the cook 
 > > hands it over to
 > > the waiter, who brings the food to you. You do not know the details of how the food has been prepared. In this 
 > > scenario, you provide the View, the waiter is the Controller, and the cook is the Model who manipulates the Data 
 > > (food).
 > > ![mvc-restaurant](../fig/mvc-restaurant.png)
 > >
 > > #### Driving a car    
[comment]: <> (1957 Hudson Hornet dashboard photo, CC0 1.0 Universal Public Domain Dedication : https://www.flickr.com/photos/95319912@N03/14839114077/in/photolist-oBhkCr-TrSHTE-55pDDE-tGCbCe-zcC4YS-6FJQFF-HonnVv-214bJ13-4KsQKx-e11jvq-276523m-252ukyr-SN3gS9-22LWSKZ-RzpuEX-8kzbNY-Hqrk9y-YnKk4h-2efuKCZ-BYkAyQ-7BiGkK-7kRexQ-Y2VcyA-M2Qq2-211o3dp-HonreK-8cSUsa-YkiNKG-fBSkyZ-8cWdkh-jNfVW-oVkiU9-FfmjuS-2crUDPH-s28jPU-Mt2211-8XETQb-553L7Q-6Gw3eX-2eiBHJ2-21E8CDN-Gy6ywY-7BztVi-XJUZ2x-9AjS3t-9aha7R-8rPuQy-K88SEr-24UVQMz-27yqHQc)
 [comment]: <> (American Ironhorse photo, CC BY-NC 2.0: https://www.flickr.com/photos/roome/199979254/in/photolist-iEWSb-8RDr8-2Ti66-wWb4X6-qaUFk-gdRm78-axDkBF-9zMU1q-3c4WiV-JpaJRw-hgLRF2-duVjRu-i9p9g-9ep7XY-4BNHXp-8e6BJL-gQTzg-dgR6sq-rcUhFh-jYF82-jxRjAA-7b83ac-nvx4gm-dVFiXb-nvjFfc-85Woju-a6aRRb-HQwZXH-PXjEEy-5sGKFp-ac9rhB-vdQw9U-nw6Gjy-6TNLb-Haam12-afEcuF-K8wsb-4ByJNa-wR7pRF-Brhxug-riqtsR-7aJ4xU-2qCqgn-7b83cv-sy4JFZ-HTHNxQ-cxmsP3-GJv9WG-Hvxrhb-7x1i4B)
 [comment]: <> (Car fuel photo, Free for commercial use, DMCA, https://www.pxfuel.com/en/free-photo-xdzbc)
  > > Car driving mechanism is another example of the MVC architecture. The View is the interface used by a driver to 
  > > operate a car - steering wheel, gear lever, brake, dashboard, etc. The engine mechanism is the Controller. The 
  > > Model/Data is the fuel, stored in a fuel tank, which gets converted into energy that powers the car by the 
  > > Controller.
 > > ![mvc-car](../fig/mvc-car.png)
 > {: .solution}  
>
{: .challenge}       
       
> ## Separation of concerns
> Separation of concerns is important when designing software and there are different ways to achieve it.
> MVC architecture is one way, but other examples include Service-Oriented Architecture (SOA), 
> Client-Server architecture, N-tier architecture, etc. 
> However, there are limits to everything, and MVC architecture is no exception. Controller
> often transcends into Model and View and a clear separation is sometimes difficult to maintain.
>
{: .callout}
## Our Software Project's Template
For the purposes of this lesson and the rest of the workshop, we will be using the following template repository (https://github.com/softwaresaved/swc-intermediate-template) located in GitHub. It contains an unfinished software project in Python that is designed using the MVC principles. The project studies inflammation in patients who have been given a new treatment for arthritis and reuses the inflammation dataset from the novice Software Carpentry Python lesson (https://swcarpentry.github.io/python-novice-inflammation/index.html). We will be building on top of this project during this workshop.

To obtain the template repository:

1. Log into your GitHub account and go to the template repository URL (https://github.com/softwaresaved/swc-intermediate-template).
2. Click ‘Use this template’ button towards the top right of the template repository's GitHub page.
3. This will create a copy (not the fork!) of the repository under your GitHub account.
4. Locate the copied repository under your GitHub account.

> ## Obtain the template repository
> Using a command line shell, clone the copied repository from your GitHub account  into your computer.
> Which command(s) would you use to get a detailed list of contents of the directory you have just cloned?
> > ## Solution
> > 1. Find the URL of the repository to clone from your GitHub account. Make sure you do not clone the template repository itself, as you should be able to push commits to your own copy of the template repo.
> > 2. Do:    
> > `$git clone https://github.com/<YOUR_GITHUB_USERNAME>/swc-intermediate-template` 
> > 3. Navigate into the cloned repository in your command line shell:    
> > `$cd swc-intermediate-template`
> > 4. List the contents of the directory:  
> > `$ls -l`  
> > Remember the `-l` flag of the `ls` command and also how to get help for commands in shell: `$man ls`.
> {: .solution}   
>
{: .challenge}       

Let’s inspect the template repository containing the project in more detail. In the shell from the project directory do `$ls -l`. You should see something similar to the following.
```
    $ pwd
    /Users/alex/work/swc-intermediate-template
    $ls -l
    total 24
    -rw-r--r--   1 alex  staff   253 20 Apr 15:41 Makefile
    -rw-r--r--   1 alex  staff  1055 20 Apr 15:41 README.md
    drwxr-xr-x  18 alex  staff   576 20 Apr 15:41 data
    drwxr-xr-x   5 alex  staff   160 20 Apr 15:41 inflammation
    -rw-r--r--   1 alex  staff  1122 20 Apr 15:41 patientdb.py
    drwxr-xr-x   4 alex  staff   128 20 Apr 15:41 tests
```

As already mentioned, the template software project has the MVC architecture. Directory inflammation contains the View 
and Model modules in files `view.py` and `model.py`, respectively. Data underlying the Model is contained within 
directory called `data` - it contains several files with patients’ daily inflammation info. The data is stored in 
a series of comma-separated values (CSV) format files, where:

- each row holds information (including temperature measurements) for a single patient,
- columns represent successive days.

File `patientdb.py` is the Controller module that performs basic statistical analysis over data and provides the main 
entry point in the application too (as it contains the `main()` function). Directory tests contains several tests that 
have been implemented already, some of which are currently failing. These failing tests set out the requirements for 
the additional code to be implemented during the workshop.

{% include links.md %}
