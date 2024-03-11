---
title: "Additional Material: Continuous Delivery/Continuous Deployment"
layout: episode
teaching: 20
exercises: 30
questions:
- "What are the benefits of Continuous Delivery/Continuous Deployment?"
- "How can I set up Continuous Deployment/Continuous Delivery in Github Actions?"
objectives:
- "Understand the benefits of Continuous Delivery/Continuous Deployment."
- "Understand how to set up Continuous Deployment/Continuous Delivery in Github Actions"

keypoints:
- "Continuous Delivery automates the software release process, which enables you to deliver updates faster"
- "You can configure automated deployment in a Github Action `.yml` file"
---

## Introduction
In this optional section of the course we will learn about Continuous Delivery and Continuous Deployment.

We have learned how we can automate building, linting and testing our application automatically using GitHub Actions.
Remember that certain commits would trigger a workflow defined in a `.yml` file that runs on GitHub's cloud server.

The next step is to also automate the deployment of the application through a GitHub Action. 
This is called Continuous Deployment or Continuous Delivery.

## What is the difference between Continuous Delivery and Continuous Deployment?
With Continuous Delivery we mean that the build, test, and staging environment deployment are all automated.
Also, the production deployment process is automated, but it still requires a human to press a button before a new release is deployed to production.

With Continuous Deployment, there is no human gatekeeper anymore, the whole process is automated. 
For example, when a new merge is made into the main branch, and all builds and tests are successfully completed, 
the application is automatically deployed to production. This allows for an even swifter deployment cycle.

Depending on your needs you can choose one over the other.

> ## Exercise: What are benefits of Continuous Delivery and Continuous Deployment?
>
> What do you think are benefits of Continuous Delivery/Continuous Deployment?
> Discuss with your neighbour.
>
> Time: 5 mins
> 
> > ## Solution
> > Continuous Delivery / Continuous Deployment has the following benefits:
> > * Automated software release process
> > * Improve developer productivity
> > * Address bugs quickly
> > * Reduce human error
> > * Deliver updates fast
> > * Deployments are coupled to your version control system
> {: .solution}
{: .challenge}

## Setting up a GitHub Action to deploy an application
To understand how to set up Continuous Delivery or Continuous Deployment with GitHub Actions we will 
look at a GitHub Actions template for deploying a Python application to Azure Web App. You can imagine that we 
developed a simple web app that allows researchers to have a look at inflammation data through a web browser, 
and we want to automatically deploy it through GitHub Actions.

You do not need to understand the specific details of how to deploy to Azure Web App. It is more important that you understand
the general setup of such a deployment workflow. The same kind of setup can be used for any application written in any 
language deployed to any on-premise or cloud server.
To keep secrets like SSH keys out of public files, they can be stored in [GitHub secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)

> ## Exercise: Deploying a Python application
> Have a look at below `main.yml` file. Read through it and try to understand what is happening at each step.
> 1. Describe what the `build` job does.
> 2. Describe what the `deploy` job does.
> 3. When is this workflow triggered?
> 4. What do you think is ment with `artifacts`? Can you see where the artifact stored by the `build` job is used?
> 5. Is this a Continuous Deployment or Continuous Delivery setup? Why?
> 6. Where do variables such as `${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}` come from?
> 7. Think of a project in which an application is regularly updated and deployed. Could the project benefit from using such a GitHub Action?
> 
>
> ~~~
> {% raw %}
> # This workflow will build and push a Python application to an Azure Web App when a commit is pushed to your default branch.
> #
> # This workflow assumes you have already created the target Azure App Service web app.
> # For instructions see https://docs.microsoft.com/en-us/azure/app-service/quickstart-python?tabs=bash&pivots=python-framework-flask
> #
> # To configure this workflow:
> #
> # 1. Download the Publish Profile for your Azure Web App. You can download this file from the Overview page of your Web App in the Azure Portal.
> #    For more information: https://docs.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=applevel#generate-deployment-credentials
> #
> # 2. Create a secret in your repository named AZURE_WEBAPP_PUBLISH_PROFILE, paste the publish profile contents as the value of the secret.
> #    For instructions on obtaining the publish profile see: https://docs.microsoft.com/azure/app-service/deploy-github-actions#configure-the-github-secret
> #
> # 3. Change the value for the AZURE_WEBAPP_NAME.
> #
> # For more information on GitHub Actions for Azure: https://github.com/Azure/Actions
> # For more information on the Azure Web Apps Deploy action: https://github.com/Azure/webapps-deploy
> # For more samples to get started with GitHub Action workflows to deploy to Azure: https://github.com/Azure/actions-workflow-samples
> 
> name: Build and deploy Python app to Azure Web App
> 
> env:
>   AZURE_WEBAPP_NAME: your-app-name  # set this to the name of your Azure Web App
> 
> on:
>   push:
>     branches: [ "main" ]
>   workflow_dispatch:
> 
> permissions:
>   contents: read
> 
> jobs:
>   build:
>     runs-on: ubuntu-latest
> 
>     steps:
>       - uses: actions/checkout@v3
> 
>       - name: Set up Python 3.9
>         uses: actions/setup-python@v2
>         with:
>           python-version: "3.9"
> 
>       - name: Install Python dependencies
>         run: |
>           python3 -m pip install --upgrade pip
>           pip3 install -r requirements.txt
> 
>       # Optional: Add step to run tests here (PyTest etc.)
> 
>       - name: Upload artifact for deployment jobs
>         uses: actions/upload-artifact@v3
>         with:
>           name: python-app
>           path: |
>             .
> 
>   deploy:
>     permissions:
>       contents: none
>     runs-on: ubuntu-latest
>     needs: build
>     environment:
>       name: 'Development'
>       url: ${{ steps.deploy-to-webapp.outputs.webapp-url }}
> 
>     steps:
>       - name: Download artifact from build job
>         uses: actions/download-artifact@v3
>         with:
>           name: python-app
>           path: .
> 
>       - name: 'Deploy to Azure Web App'
>         id: deploy-to-webapp
>         uses: azure/webapps-deploy@v2
>         with:
>           app-name: ${{ env.AZURE_WEBAPP_NAME }}
>           publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
> {% endraw %}
> ~~~
> {: .language-yml}
> 
> > ## Solution
> > 1. The `build` job sets up the correct python environment, installs dependencies, and stores the whole application as an artifact.
> > 2. The `deploy` job downloads the artifact and triggers the deployment of the application in the artifact on Azure.
> > 3. The workflow is triggered on any push to the main branch.
> > 4. `artifacts` are files stored within one step and used in another step. 
> >    It is used again in the `deploy` job in the `Download artifact from build job` step.
> > 5. This is a Continuous Deployment setup, because the step to deploy to production always happens for every commit to the main branch.
> > 6. These are secrets defined in the settings of your repository or organisation, read more [here](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions).
> > 7. Discuss with other participants!
> >
> {: .solution}
{: .challenge}


{% include links.md %}
