---
title: "Additional Material: GitHub Repo Settings"
layout: episode
teaching: 5
exercises: 5
questions:
- "What are the recommend settings for a GitHub repository?"
- "How can we prevent inadvertent pushes to main that don't go through code review?"
objectives:
- "How to set up branch protection on the main branch"
keypoints:
- "Setting branch protection ensures everyone is following the same process."
---

## Introduction

Here outlines some recommendations for how a GitHub repository should be configured.
These are particularly important when working on a shared repository (as described in
the [code review episode](../41-code-review#collaborative-code-development-models)).

## Protecting the main branch

By default, any collaborator can push to any branch on a shared repository.
It is possible to prevent this by "protecting" the main branch.

This has a number of advantages:

* Avoids someone accidentally pushing work-in-progress changes to the branch
  that everyone else downloads.
* Ensures everyone follows a code review process.
* Ensures all changes are checked by continuous integration.

### How to protect the main branch

To protect the main branch in GitHub, go to the repository settings, select `Branches`.
Click `Add Rule`. Type in the name of your main branch (e.g. `main` and/or `develop`).
Tick the check box saying require pull requests. This will ensure all changes to the
branch are done via a pull request.

![GitHub add a branch protection rule settings screen with recommended settings enabled for a branch called main](../fig/github-branch-protection-settings.png)

It is recommended to also tick `Require approvals`.

This means someone besides the person who raised the pull request will need to approve the change.

It is also recommended to tick `Require status checks before merging`.

This ensures that CI has run successfully before allowing the changes to be made.

Finally, it is recommended to tick `Do not allow bypassing the above settings`.

This means that administrators of the repository will have to follow the same process to.
If there becomes a need to push to the main branch, these settings can be changed
by administrators to allow this, setting this means that administrators cannot push by mistake
during the normal course of their work.

See [GitHubs documentation for more information about protecting branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule).
