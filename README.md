Provider Screening Module for Medicare/Medicaid Provider Enrollment
===================================================================

Contents:

1. **[Introduction and Current Status](#section-1-introduction-and-current-status)**
2. **[Development and Installation](#section-2-development-and-installation)**
3. **[Project Resources and Organization of This Repository](#section-3-project-resources-and-repository-organization)**
4. **[Participating in the PSM Project](#section-4-participating-in-the-psm-project)**
5. **[Background](#section-5-background)**

---------------------------------------------------------------------
SECTION 1: Introduction and Current Status
---------------------------------------------------------------------

This is an open source Provider Screening Module (PSM) designed to
work within a U.S. state Medicare/Medicaid Information System (MMIS)
environment to provide a portal for screening service providers as
part of the provider enrollment process.  It is released under the
[Apache-2.0](LICENSE.md) open source license.  Please see the project
home page at [ProjectPSM.org](http://projectpsm.org/) for an overview.

This code is a **work-in-progress** and is **not yet ready for
production deployment**.  

See the "Background" section below for more about the provenance of
this project.

---------------------------------------------------------------------
SECTION 2: Development and Installation
---------------------------------------------------------------------

Development activity takes place on the `master` branch, with
short-lived development branches used for specific tasks.  Code
contribution guidelines are in [CONTRIBUTING.md](CONTRIBUTING.md).

Please feel free to [file issue
tickets](https://github.com/SolutionGuidance/psm/issues/new) in this
repository to ask questions.

Please see [INSTALL.md](INSTALL.md) for how to install an instance for
development or demonstration.

Note that the PSM depends a separate application, [CAV
ETL](https://github.com/solutionguidance/cavetl), to communicate with
certain external data sources, e.g., federal databases such as LEIE,
Social Security DMF, PECOS, etc.  CAV ETL used to be a semi-separate
middleware application contained within the PSM (in the old
`ext-sources-app` subdirectory code), providing a service wrapper
around external data sources.  Now it is a standalone middleware
application, meant to be accessible not only to the PSM but to other
MMIS modules as well.

---------------------------------------------------------------------
SECTION 3: Project Resources and Repository Organization
---------------------------------------------------------------------

Please see [INSTALL.md](INSTALL.md) for the latest installation instructions.

See [DESIGN.md](docs/DESIGN.md) for an overview of the PSM's architecture
and design assumptions.

The [psm-app](psm-app) subdirectory holds the source code to the PSM
proper.

[ProjectPSM.org](http://projectpsm.org/) is the project home site,
where we publish the user manual as well as documentation for the
PSM's web API.

See also the section "Participating in the PSM Project" below.

---------------------------------------------------------------------
SECTION 4: Participating in the PSM Project
---------------------------------------------------------------------

Please see [CONTRIBUTING.md](CONTRIBUTING.md), in particular the
section "Communicating with the PSM Project" at the top.

---------------------------------------------------------------------
SECTION 5: Background
---------------------------------------------------------------------

The NASA Center of Excellence for Collaborative Innovation (CoECI)
through an Interagency Agreement with the Centers for Medicare and
Medicaid Services (CMS) administered a crowd-sourced application
development challenge for the Medicare and Medicaid Services, Center
for Medicaid and CHIP Services (CMCS).  The challenge was to build a
multi-state, multi-program provider screening application capable of
risk scoring, credentialing validation, identity authentication, and
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

More information on the challenge can be found
[here](https://web.archive.org/web/20141111041442/http://www.topcoder.com:80/cms/medicaid-enrollment-portal/).
