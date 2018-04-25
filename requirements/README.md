# Requirements

What's here:

* RTM.xlsx
  Requirements Traceability Matrix: master spreadsheet of all requirements.

* csv-exports/*.csv
  CSV files for each reqs category (FR, II, IA, etc).

  These CSV exports were made by manually running LibreOffice Calc on
  RTML.xlsx multiple times, once for each sheet (tab) in the file,
  which is a somewhat cumbersome process.  The CSV files should be
  carefully kept up-to-date with changes to RTM.xlsx so that the CSV
  remains a reliable data source (other programs rely on this).

* csv-exports/columns.txt
  Lists the columns (which are the same across all the CSV files).

* non-hidden-RTM-rows.org
  An initial export of requirements to Org Mode format (done manually,
  I believe, rather than from the CSV files).  This export turned out
  to be missing some hidden rows; see the next entry about that.

* hidden-RTM-rows.org
  The remainder of the Org Mode export (see above).  Here's how you
  know that this file and non-hidden-RTM-rows.org have different reqs:

          $ grep -E "^\* psm-" hidden-RTM-rows.org | cut -c 3- > hidden-reqs
          $ grep -E "^\* psm-" RTM.org | cut -c 3- > non-hidden-reqs
          $ sort hidden-reqs > h.tmp; mv h.tmp hidden-reqs
          $ sort non-hidden-reqs > n.tmp; mv n.tmp non-hidden-reqs
          $ comm -1 -2 hidden-reqs non-hidden-reqs 
          $ diff -u hidden-reqs non-hidden-reqs 
          $ rm hidden-reqs non-hidden-reqs 

* added-reqs.org
  Requirements we created during the first issues/reqs sweep, which
  used only the non-hidden rows, as we didn't know about the hidden
  rows at the time.  Therefore, some of the newly created reqs in
  added-reqs.orq are redundant with existing reqs; there is more
  detail about this in the file.  Others are not redundant -- they
  represent genuinely new requirements that we came up with during
  our requirements sweep.  All of the added reqs are, I believe, also
  present in non-hidden-RTM-rows.org, since the added reqs were
  created during the initial issues/reqs sweep.

  What we should do with redundant new reqs now:

  Once we're sure we've identified every one of them, we should make
  sure none of them are attached to any issues, and then remove all
  the redundant reqs from any file that has them (RTM.xlx,
  added-reqs.org, and let's check *-RTM-rows.org too to be safe).

  What we should do with non-redundant new reqs now:

  They should stay, of course, but note that the removal of some of
  the redundant ones might lead to the downward renumbering of some
  non-redundant ones.

* issues-2018-03-31.org
  An export of all issues and their labels, up to issue 740, plus some
  information about which issues should get which req-related labels.

* labels-to-issues.json
  The original mapping of labels to issues.  The tool used for this
  was ots-tools/github-tools/gh-sak.

* label-changes.json
  The changes we made to the above mapping, after we discovered the
  hidden reqs and re-swept the issues to account for those reqs (as
  with the above, the tool used for this was gh-sak).

* reqs2any
  A script to convert requirements from CSV to some other format.

* show-reqs
  A script that drives `reqs2any` to produce either elisp output or
  human-readable output (pass "elisp" or "human" as arg to choose).

* psm-reqs.el
  Elisp for working with requirements in Emacs.  Start by invoking
  `psm-load-reqs` on a file created by `./show-reqs elisp`, to load
  all the requirements information into Emacs.  After that, the
  interactive entry point is `psm-show-req`.  I suggest binding it to
  a key.  Invoke it while in a req ID to display information about
  that req.

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
