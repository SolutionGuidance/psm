Provider Screening Module for Medicare/Medicaid Provider Enrollment
===================================================================

Current build status:  ![Build status](https://travis-ci.org/OpenTechStrategies/psm.svg?branch=master)

Contents:

1. **[Introduction and Current Status](#section-1-introduction-and-current-status)**
2. **[Background](#section-2-background)**
3. **[Features and Functionality](#section-3-features-and-functionality)**
4. **[Project Resources and Organization of This Repository](#section-4-project-resources-and-repository-organization)**
5. **[Participating in the PSM Project](#section-5-participating-in-the-psm-project)**

---------------------------------------------------------------------
SECTION 1: Introduction and Current Status
---------------------------------------------------------------------

This is an open source Provider Screening Module (PSM) designed to
work within a Medicare/Medicaid Information System (MMIS) environment
to provide a portal for screening service providers as part of the
provider enrollment process.  It is released under the
[Apache-2.0](LICENSE.md) open source license.

This code is a **work-in-progress** and is **not yet ready for
production deployment**.  Please see [INSTALL.md](INSTALL.md) for
details.

Development activity now takes place on the `master` branch, with
short-lived development branches used for specific tasks.  Code
contribution guidelines are in [CONTRIBUTING.md](CONTRIBUTING.md).
Please feel free to [file issue
tickets](https://github.com/OpenTechStrategies/psm/issues/new) in this
repository to ask questions.

See the "Background" section for the provenance of this project.

We made some replay branches to clarify development history, and to
help us organize legacy code for eventual landing or rearrangement on
`master`.  These replay branches show the history of the JBoss side
(soon to be WildFly), the WebSphere side (which is divided into two
subtrees in the original repository), and the documentation changes:

* [jboss-core](https://github.com/OpenTechStrategies/coeci-cms-mpsp/tree/jboss-core)
* [was-core](https://github.com/OpenTechStrategies/coeci-cms-mpsp/tree/was-core)
* [was-ext](https://github.com/OpenTechStrategies/coeci-cms-mpsp/tree/was-ext)
* [documentation](https://github.com/OpenTechStrategies/coeci-cms-mpsp/tree/documentation)

The point of the replay branches is to give us a clean, disentangled
view of the changes that happened in each line of development.  They
all start off with a virtually empty commit (just a .gitignore file),
and then each has the appropriate selected commits from upstream
replayed in sequence.  The replay commits get their own commit IDs, of
course, and their author is always @slifty (Dan Schultz) because he
did the replaying, but in the commit message for each replay commit he
includes the corresponding original commit ID from upstream.

---------------------------------------------------------------------
SECTION 2: Background
---------------------------------------------------------------------

The NASA Center of Excellence for Collaborative Innovation (CoECI)
through an Interagency Agreement with the Centers for Medicare and
Medicaid Services (CMS) administered a crowd-sourced application
development challenge for the Medicare and Medicaid Services, Center
for Medicaid and CHIP Services (CMCS).  The challenge was to build a
multi-state, multi-program provider screening application capable of
risk scoring, credentialing validation, identify authentication, and
sanction checks, that lowered the burden on providers and reduced
administrative and infrastructure expenses for states and federal
programs.
 
The application was built using NASA's contract with Harvard Business
School in association with the Institute of Quantitative Social
Sciences and their subcontract with TopCoder.  The Application
Development Challenge was sponsored by CMS as part of the Partnership
for Program Integrity Innovation program with the specific intent of
developing an application to improve capabilities for streamlining
operations and screening providers to reduce fraud and abuse.
 
The challenge was comprised of an omnibus of 120 contests launched
between June 2012 and April 2013, to cover all phases of the software
development life cycle.  The code and documentation resulting from
that challenge are hosted in an [original
repository](https://github.com/NASA-Tournament-Lab/coeci-cms-mpsp)
code, from which this repository was cloned to continue the
project. Work restarted in April 2017.

More information on the challenge can be found here:
http://www.topcoder.com/cms/medicaid-enrollment-portal/

---------------------------------------------------------------------
SECTION 3: Features and Functionality
---------------------------------------------------------------------

As of 21 June 2017, the PSM offers the following functionality:

1. Any user
* Self-register and create a new account
* Receive new password via email
* Log in
* View homepage
* Log out
* Receive password reminder via email
* Change password in profile

2. User at "System administrator" privilege level
* View other user accounts
* Edit other user accounts
* Create other user accounts and send email notifications to new users
* Delete other user accounts

3. User at "service admin" privilege level
* View list of provider types
* View list of help topics
* View, create, edit, and delete agreements & addendums
* Change agreement and addendum assignments for provider types
* View, create, edit, and delete service agents

4. User at "provider" privilege level
* Make a new enrollment
* While creating an enrollment, save a draft and then come back to it later
* View existing enrollments (draft, pending, approved, and denied)
* Print enrollments or export as PDF

5. User at "service agent" privilege level
* View existing draft and pending enrollments
* Create a new provider enrollment
* While creating an enrollment, save a draft and then come back to it later

6. System
* Issue risk score for an enrollment
* Record logs in `standalone/log/`
* Record changes for auditing in database tables `audit_details` and `audit_records`

_[Note: As the developer team conducts initial improvement work on the PSM in June 2017, we anticipate recovering many of the features listed in the [original
repository](https://github.com/NASA-Tournament-Lab/coeci-cms-mpsp/blob/master/README.md), such as identity verification, building provider profiles, and MITA integration.]_

---------------------------------------------------------------------
SECTION 4: Project Resources and Repository Organization
---------------------------------------------------------------------

Please see [INSTALL.md](INSTALL.md) for the latest installation instructions.

See [DESIGN.md](DESIGN.md) for an overview of the PSM's architecture
and design assumptions.

The [psm-app](psm-app) subdirectory holds the source code to the PSM
proper.

[opentechstrategies.github.io](https://opentechstrategies.github.io/psm/javadoc/)
is our GitHub Pages site, where we publish documentation for the PSM's
web API.

The ext-sources-app subdirectory has been removed.  It held the source
code to the semi-separate middleware application that provided a service
wrapper around external data sources.  This will be replaced as
discussed on [the mailing
list](https://groups.google.com/forum/#!topic/psm-dev/bOVQeUjoaB0).

The [team-notes](team-notes) directory has agendas and meeting notes
from various team and sub-team meetings.

See also the section "Participating in the PSM Project" below.

---------------------------------------------------------------------
SECTION 5: Participating in the PSM Project
---------------------------------------------------------------------

We welcome questions and contributions.  You can:

* Post in the `psm-dev` discussion group at
  https://groups.google.com/forum/#!forum/psm-dev.  The forum archives
  are public, and anyone can post.  The posting guidelines are fairly
  loose -- as long as your question is about the PSM, it's on-topic.

* File a new issue ticket at https://github.com/OpenTechStrategies/psm/issues.

* Submit a [pull
  request](https://help.github.com/articles/about-pull-requests/) to
  the [repository](https://github.com/OpenTechStrategies/psm/). Here's
  [our guide for code contributors](CONTRIBUTING.md).

* Use [IRC](http://www.irchelp.org/) to talk to us in real time.  Most
  of the dedicated team hangs out in `#OpenTechStrategies` on the
  `irc.freenode.net` server network.  If you don't have IRC client
  software, you can use the [Freenode webchat
  interface](http://webchat.freenode.net?channels=%23OpenTechStrategies&uio=d4)
  in your browser.

* We hold team meetings by conference call sometimes.  The agendas and
  notes from these meetings can be found in
  [team-notes/meetings/](team-notes/meetings/).  The current core
  developers are all based in the U.S., and these meetings are
  arranged around U.S. time zones.  Eventually, when the PSM project
  has regular participants beyond the current core team, we may change
  how we schedule real-time meetings.  For now, however, we schedule
  meetings on an _ad hoc_ basis and just put the agendas and notes
  here, so that they are visible along with all the other project
  resources.

Note that submitting issues or pull requests requires a
[GitHub](https://github.com/) account, which anyone can create (there
is no charge).
