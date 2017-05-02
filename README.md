Provider Screening Module for Medicare/Medicaid Provider Enrollment
===================================================================

Contents:

1.  Introduction and Current Status
2.  Background
3.  Features and Functionality
4.  Project Resources and Organization of This Repository
5.  Participating in the PSM Project

---------------------------------------------------------------------
SECTION 1: Introduction and Current Status
---------------------------------------------------------------------

This is an open source Provider Screening Module (PSM) designed to
work within a Medicare/Medicaid Information System (MMIS) environment
to provide a portal for screening service providers as part of the
provider enrollment process.  It is released under the
[Apache-2.0](LICENSE.md) open source license.

This code is a **work-in-progress** and is **not yet ready for
production deployment**.  Please see the [INSTALL.md](INSTALL.md) for
details.

Development activity now takes place on the `master` branch, with
short-lived development branches used for specific tasks.  Please feel
free to [file issue
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
code, from which this repository was cloned to continue the project.

More information on the challenge can be found here:
http://www.topcoder.com/cms/medicaid-enrollment-portal/

---------------------------------------------------------------------
SECTION 3: Features and Functionality
---------------------------------------------------------------------

_[Note: This feature list is carried over unchanged from the [original
repository](https://github.com/NASA-Tournament-Lab/coeci-cms-mpsp/blob/master/README.md),
and as of 20 April 2017 has not yet been verified.  It may be out of date
or inaccurate.]_

1. Capability to Conduct Identity Verification
  * Capability to link individuals to their organizations and vice versa
  * Capability to match on multiple variations of an individual's or organization's name to ensure that the correct entity is verified
  * Applies a range of screening rules to cross check data elements within the enrollment application
  * Applies a range of screening rules to cross check data elements against authoritative external sources for consistency
  * Capability to establish and employ a graded screening methodology that escalates the intensity of screening for providers that are flagged as higher risk (i.e., Report Card Methodology)
2. Capability to Build Provider Profiles
  * Capability to retain screening and enrollment information and results and compare against past and future screening results.
  * Capability to create a watch list to ensure that providers that are suspected or known to be fraudulent are flagged at the time of screening\*
  * Capability to track re-enrollment attempts to ensure that slight changes to provider information is not considered a new enrollment
  * Capability to re-screen periodically to ensure that changes in provider profiles are updated on a regular basis
  * Capability to leverage public websites to conduct link analysis through which provider associations could be explored and alerts posted on similar websites could be considered
  * Captures critical attributes.
     * Collection of application fees status\*
     * Exception waiver approved status
     * Incorporates enhanced screening data including the results of site visits, criminal background checks and finger printing
     * Captures licensing information, financial data and any other data attributes which could impact a risk lever
     * Other critical attributes
  * Capability to achieve real time screening, scoring and system outputs (queries/reports)
3.  Capability to Evaluate and Maintain the Integrity of the Results
  * Capability to persist data sources scores to determine the most reliable source for each data element
  * Capability to evaluate data sources for reliability and accuracy
  * Capability to create a learning system to ensure that observed negative trends factor back into screening rules so as to flag suspicious enrollments early in the screening process, ensuring the ability to detect and reduce/eliminate the incidence of false positives\*\*
  * Capability to create system outputs to assign reasons/explanations to each code or score used
  * Capability to build processes to allow for appropriate interpretation and action on screening and scoring results
  * Capability to ensure that each rule is tested and its impact is evaluated prior to implementing
4.  Improves Efficiency
  * Allows search capability to find specific provider information with minimal search attempts
  * Capability to identify applicants including individual providers and owners of institutional providers
  * Capability to verify identity and prior history of problems with Medicaid/CHIP or Medicare programs
  * Identifies and schedules revalidation process
5.  Meets Architectural Guidelines
  * Adheres to the Architectural Guidance and meets the seven conditions and standards detailed in the Guidance for Exchange and Medicaid IT Systems, Version 2.0, located at: http://cciio.cms.gov/resources/files/exchange_medicaid_it_guidance_05312011.pdf
6. Integrates Into the MITA Framework / Is MITA Compliant
  * Information regarding MITA can be found at: http://www.cms.gov/MedicaidInfoTechArch/
7. Accurate, Cost Effective, and Timely
  * Turnaround time for performing automated checks typical for a web based system
  * Comprehensive verification of all data fields for all providers enrolled
  * Efficiency of the Screening Solution in terms of cost and schedule to actually implement
  * Potential extra costs (e.g. licenses, etc) are documented
  * Effectiveness of the risk-screening model in detecting fraud based issues
  * Technical soundness of risk-scoring in flagging potential fraudulent patterns and tendencies

\* Partial support in the final product.

** Structural support for this feature is provided, but an active learning system is not deployed with the final application.

---------------------------------------------------------------------
SECTION 4: Project Resources and Repository Organization
---------------------------------------------------------------------

Please see [INSTALL.md](INSTALL.md) for the latest installation instructions.

See [DESIGN.md](DESIGN.md) for an overview of the PSM's architecture
and design assumptions.

The [psm-app](psm-app) subdirectory holds the source code to the PSM
proper.

The [ext-sources-app](ext-sources-app) subdirectory holds the source
code to the semi-separate middleware application that provides a
service wrapper around external data sources, thereby offering the PSM
a consistent API to those services.

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
  the [repository](https://github.com/OpenTechStrategies/psm/).

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

---------------------------------------------------------------------
SECTION 6: Third-party Libraries
---------------------------------------------------------------------

At times we may use some code from outside open source libraries.  For
example, `documentation/standalone-full.xml.example` is included from
the [Wildfly](http://wildfly.org/) project.  In these cases, we include
the license for that code in LICENSE.md, and describe which files the
secondary license applies to.
