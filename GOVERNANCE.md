# Project Governance
This document describes the roles and responsibilities of people who manage the
python-intermediate-development curriculum in this repository
and the way they make decisions about how the project develops.
For information about how to contribute to the project, see [CONTRIBUTING.md](./CONTRIBUTING.md).
For information about the project's Code of Conduct
and its reporting and enforcement mechanisms, see [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).

## Roles

### Maintainers
A team of 3-5 Maintainers is responsible for the lesson repository
and makes decisions about changes to be incorporated into the default branch.
Changes to the default branch can only be made by pull request,
and all pull requests to the default branch require
review and approval from at least one Maintainer before merging.

Responsibilities of Maintainers include:

* Reviewing and responding to new issues and pull requests in a timely manner
* Attending [Maintainer meetings](#maintainer-meetings) where availability allows
* Voting asynchronously on decisions where needed

#### Lead Maintainer
The Maintainer team includes one person in a Lead role,
who is responsible for coordinating the activity of the group.
In addition to the responsibilities listed for all Maintainers above,
the Lead Maintainer:

* schedules Maintainer meetings
* prepares [the agenda for Maintainer meetings](#meeting-agenda)
* shares the agenda with all Maintainers at least 24 hours before the meeting
* [assigns roles at the start of each meeting](#meeting-roles)
* schedules official releases of the lesson
* acts as a point of contact for the Maintainer team
* invites other community members to Maintainer meetings as non-voting participants

Where needed e.g. due to absence,
the Lead Maintainer may defer any of these responsibilities to another member of the Maintainer team.

The Lead Maintainer has a term length of 6 months,
and it is expected that the role will rotate among members of the Maintainer team.
If a Maintainer is up next in the rotation and wishes to decline the role of Lead 
e.g. due to a lack of capacity,
they should communicate that with the other Maintainers at the earliest opportunity
to help the team plan accordingly.

#### Current Maintainers
See [README.md](./README.md) for a list of the current project Maintainers.

#### Joining/Leaving the Maintainer Team
Maintainers volunteer to take on the role, and other members of the community may 
volunteer to join the Maintainer team at any time,
or be invited by the existing Maintainers.
Additions to the Maintainer team will be discussed and approved by the current membership.
No formal onboarding exists for new Maintainers,
but some informal onboarding can be expected from the existing Maintainers.

Maintainers may step away from the role at any time,
but are expected to communicate the decision to the whole Maintainer team
and to coordinate with other Maintainers to transfer responsibilities, e.g.
re-assign issues, resolve outstanding pull requests, etc.

### Contributors
Anyone who opens or comments on an issue or pull request,
or who provides feedback on the curriculum through another means,
is considered to be a Contributor to the project.

Maintainers are responsible for ensuring that all such contributions are credited,
e.g. on the curriculum site and/or when (and if) a release of the curriculum is made to Zenodo.

Contributors of more significant changes to the lesson may be invited by the Maintainers to add themselves to the 
Authors list.

## Maintainer Meetings
The Maintainer team meets frequently,
at minimum for at least 30 minutes four times per year.
Meetings provide an opportunity for Maintainers to
discuss outstanding issues and pull requests
and co-work on the project where necessary.

### Meeting schedule
The maintainer team aims to meet at 11:00 UK time (BST or GMT) on the fourth Wednesday each month. The meetings alternate between operations meetings and co-working sprints.

### Meeting agenda
The [agenda for Maintainer meetings](https://docs.google.com/document/d/1-SvoY_2GvlQgJnu8zfr6VnU7sev_iWZAIwBUywNSfWE/edit#) will be prepared as a collaborative document,
with (at least) sections to record the following information:

* lists of Maintainers attending and absent from the meeting
* a list of items for discussion and, if necessary, amount of time assigned to each item
  * wherever possible, the list should include a link to the relevant issue/pull request/discussion

### Meeting roles
Each meeting will have a Facilitator, a Notetaker, and (if needed) a Timekeeper:

* Facilitator:
  introduces agenda items (or delegates this responsibility to another participant)
  and controls the flow of discussion by keeping track of who wishes to speak
  and calling on them to do so.
  The meeting Facilitator is responsible for keeping discussion on-topic,
  ensuring decisions are made and recorded where appropriate,
  and giving every attendee an equal opportunity to participate in the meeting.
  They also act as backup Notetaker, taking over when the Notetaker is speaking.
* Notetaker:
  ensures that the main points of discussion are recorded throughout the meeting.
  Although a full transcript of the discussion is not required,
  the Notetaker is responsible for ensuring that the main points are captured
  and any decisions made and actions required are noted prominently.
* Timekeeper (if needed):
  the Maintainer Lead or meeting Facilitator may choose to assign a Timekeeper,
  whose responsibility is to note the time alloted for each item on the agenda
  and communicate to the Facilitator where that time has run out.
  The decision to move from one agenda item to the next belongs to the meeting Facilitator.

### Decision-making
Decisions within the Maintainer Team will be made by [lazy consensus](https://medlabboulder.gitlab.io/democraticmediums/mediums/lazy_consensus/)
among all Team members,
with fallback to simple majority vote only in cases
where a decision must be made urgently and no consensus can be found.

Decisions will preferably be made during Maintainer meetings with every
member of the team present.
Where this is not possible, decision-making will happen asynchronously via
an issue on the curriculum repository.
Decisions made asynchronously must allow at least one week for Maintainers to respond and vote/abstain.
