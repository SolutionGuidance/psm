# Requirements

What's here:

* RTM.xlsx
  Requirements Traceability Matrix: master spreadsheet of all requirements.

* RTM.org
  An initial export to Org Mode format (but missing some hidden rows).

* hidden-RTM-rows.org
  The remainder of the Org Mode export (see above).
  This should probably be unified into RTM.org soon.
  Here's how you know that this file and RTM.org have different reqs:

          $ grep -E "^\* psm-" hidden-RTM-rows.org | cut -c 3- > hidden-reqs
          $ grep -E "^\* psm-" RTM.org | cut -c 3- > non-hidden-reqs
          $ sort hidden-reqs > h.tmp; mv h.tmp hidden-reqs
          $ sort non-hidden-reqs > n.tmp; mv n.tmp non-hidden-reqs
          $ comm -1 -2 hidden-reqs non-hidden-reqs 
          $ diff -u hidden-reqs non-hidden-reqs 
          $ rm hidden-reqs non-hidden-reqs 

* issues-reqs-mapping.org
  The master mapping between issues and requirements.
  Once completed, the mapping is uploaded into the PSM 
  issue tracker using ots-tools/github-tools/gh-sak.

* csv-exports/*.csv
  CSV files for each reqs category (FR, II, IA, etc).
  (Karl's using these to build some helper tools for the mapping work.)

* csv-exports/columns.txt
  Lists the columns (which are the same across all the CSV files).

* reqs2any
  A script that converts requirements from CSV to some other format.

* show-reqs
  A script that drives 'reqs2any' to produce either elisp output or
  human-readable output (pass "elisp" or "human" as arg to choose).

* psm-reqs.el
  Elisp for working with requirements in Emacs.  Start by invoking
  `psm-load-reqs' on a file created by 'show-reqs elisp'.

* issues-2018-03-31.org
  An export of all issues and their labels, for a new reqs sweep.

## Sources of requirements

Requirements documents related to the PSM that have been shared with the
project by various states and agencies.

## Vermont

1. [__Modularity - Provider.pdf__](VT/Modularity%20-%20Provider.pdf): This
is a set of diagrams of the different "nodes" present with the Vermont
MMIS.  The one that corresponds to the PSM is on page 2: "Provider
Eligibility and Enrollment Management Node," which is or will be able to
perform the following activities:

- Determine Provider Applicability to Programs
- Notify Provider of Status Changes
- Notify Provider of Application Information Changes
- Perform Provider Site Visit
- Process Provider Application
- Process Provider Application Documentation
- Schedule Provider Site Visit
- Manage Temporary Provider Application
- Verify Provider Data
- Manage Emergency Provider Application
- Perform Provider Background Check
- Manage OneTime Emergency Provider Application
- Monitor Provider Sanction Reports
- Re-Enroll Provider
- Manage Provider Sanctions
- Revalidate Provider Periodically

However, the "Master Provider Index Node," on page 4, involves many
activities that the PSM is also involved in.

2. [__activity-diagrams__](VT/activity-diagrams): Workflow diagrams
showing the processes by which a provider completes various tasks,
including enrollment and termination.

3. [__Provider Screening
Services.pdf__](VT/Provider%20Screening%20Services.pdf): This is a more
detailed view of the Provider Screening workflow in __Modularity -
Provider.pdf__.  This is useful for the question of "where in the MMIS
does the provider record live."  This also includes some "NHSIA Business
Processes" for comparison (possibly referring to the [National Human
Services Interoperability
Architecture](https://www.acf.hhs.gov/nhsia-definition)).

4. [__Provider Services.xlsx__](VT/Provider%20Services.xlsx): This is an
Excel version of the services shown in __Provider Screening
Services.pdf__.

5. [__Provider Types.xlsx__](VT/Provider%20Types.xlsx): A list of VT's
provider types.  Does not include subspecialties or rules pertaining to
each provider type.
