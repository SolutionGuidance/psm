# Requirements

What's here:

* RTM.xlsx
  Requirements Traceability Matrix: master spreadsheet of all requirements.

# Sources of requirements

The requirements here come from documents related to the PSM that have
been shared with the project by various states and agencies.

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

# Unofficial history of requirements-to-issues mapping

These are instructions Karl Fogel wrote for Paul Morris, before Paul
did the second issues sweep (that is, the sweep where we knew about
the formerly hidden reqs and were now taking them into account).  From
reading these instructions, you can work out roughly what process was
used to get us to the mapping we have today.

Note that the *.org files referred to below now live in
the [PSM Dashboard](https://github.com/solutionguidance/psm-dashboard)
repository, not here.

-----

Everything is organized around the file 'issues-2018-03-31.org'.  It's
an export of the current state of the issue tracker, or at any rate
the state as of March 31st.  Each issue in the file has a top level
"*" header followed by the issue summary.  Then the issue's labels (if
any) are listed under a "**" subheader called "LABELS".

The labels we care about start with "Z-REQ-PSM-".  Lop off the
"Z-REQ-" prefix and you have the requirement ID (e.g., "PSM-FR-7.2").
Each such label is followed by the description of that requirement and
the general area of the requirements that it comes from (e.g.,
something like <<< FR 7. Usability >>>").

(Note that issues 700 and higher don't yet have any req labels.  I
suggest leaving them till the end of the process, since by then you'll
know the requirements list much better and it'll be easier to find the
appropriate labels for those recent issues.)

Now, here's the full story, and instructions for what needs to happen:

Cecilia and I already made one pass over all the issues (at the time
issue 699 was the highest), assigning requirement IDs as appropriate.
Unfortunately, as I explained to you on the phone, at the time we
didn't know that some reqs -- about 60 of them -- were "hidden" and
not visible to us.  So we went blissfully along using just the req IDs
in the file now called 'non-hidden-RTM-rows.org'.  (Obviously that
file had a different name at the time! :-) ) As we were doing that, I
remember thinking to myself that something was odd, that we seemed to
be missing req IDs for things I knew we'd identified as requirements
long ago, such as the PSM having the capability to do full-text
search... Ah well.

Anyway, as we went along, we created a few new requirements.  Some of
them later turned out to be redundant or at least partially redundant
with formerly hidden requirements, while others were genuinely needed
and will be kept as new requirements.  Both kinds of newly-created
reqs are listed in 'added-reqs.org', and there's some more explanation
at the top of that file.

So you need go down the issues in 'issues-2018-03-31.org', starting
from 699, and see if any of the reqs in 'hidden-RTM-rows.org' or
'added-reqs.org' are better matches for that issue than the reqs we
have listed for it currently.  Depending on what you find for a given
issue, the end result could be that you do nothing for that issue, or
that you add some new req IDs, or that you add some new req IDs and
remove some existing req IDs.

The way to express your changes is add a new "**" subheading named
"LABEL CHANGES" in that issue's section.  Under that header, use a "+"
line for each req to add and a "-" line for each req to subtract.
Always do one exactly one req per line.  Here's an example I just did
in issue 691:

  ** LABEL CHANGES
     - fr-7.13
     + iu-2.5

To make things easier, use lower-case and leave off the "Z-REQ-PSM-"
prefix.  I'll take care of adding those back later when I parse the
whole file to update the issue tracker.

Now, in 'added-reqs.org' there were two newly-created reqs that turned
out to be simple duplicates of later-discovered hidden reqs.  I've
already gone through and added "LABEL CHANGES" sections for all the
issues that had one of those now-redundant newly-created reqs, so that
at least the most obvious req replacement is already done.  Of course,
those issues, like any other issues, still require consideration for
the other hitherto hidden reqs, and any of the remaining reqs
currently attached to those issues might still get removed because
some hidden req turns out to be a better fit.

So for example, my "LABEL CHANGES" section for issue 691 above might
be incomplete.  I haven't looked through the rest of the formerly
hidden reqs nor through the rest of the added reqs to determine if any
other changes are necessary -- I  just took care of that one
replacement that I knew was an easy call.

I'll be available for questions as you're working, and the README.md
file in this directory has some more context about what the files
are.  (I've tried to put all the information you need here, but the
README.md is probably worth a skim too.)

By the way, it's not actually 700+ issues that need to be done, don't
worry!  It's only 316.  Remember that issues and pull requests share
the same namespace on GitHub (an interesting design decision on their
part), and we're only labeling issues here, not PRs.
