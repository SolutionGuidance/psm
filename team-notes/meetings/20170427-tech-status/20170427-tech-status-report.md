# 2017/04/27 PSM Report
## Executive Summary

### Goals
- Deploy a WildFly + PSQL version of was-core.
- Create up-to-date and complete deployment documentation.
- Get repository into a clean arrangement for active development.

### Steps
1. Karl: delete the JBoss code base (**Due&nbsp;4/27**)

     (Note that we may later separate core and ext projects into two
     repositories.  For now, that idea is filed in
     [github.com/SolutionGuidance/psm/issues/11](https://github.com/SolutionGuidance/psm/issues/11),
     as it is not urgent and does not affect current development.)

2. Jason: convert was-core to WildFly + PSQL and deploy on local or
   dev.  (Active collaboration with Dan; check in on Friday
   afternoon.  **Target&nbsp;Date:&nbsp;5/2**)

3. Dan: support Jason in his goals to deploy (Continuous)

4. Dan: Once Jason has local deployment, deploy on a “production”
   server. (**Target&nbsp;Date:&nbsp;5/3**)

5. Dan + Jason: Write initial deployment documentation 
   (**Target&nbsp;Date:&nbsp;5/4**)

6. Cecilia et al: Format / review deployment documentation (**Target&nbsp;Date:&nbsp;5/5**)

### Risks

- **Risk 1:** We may need to deploy a WildFly version of ext-srcs,
  which would likely add a two days to the timeline.

- **Risk 2:** Conversion to WildFly may be more complex than expected,
  which would likely add several days to the timeline.

### Possible Parallel Tasks

- **Separate Task A:** If someone else has bandwidth and skill set
  to convert migration scripts from Oracle to PSQL, that could be done
  as Jason works on WildFly.  However, it is vital that this be done in
  coordination as it is possible some of the DAOs will need to be
  updated in parallel.

- **Separate Task B:** Others can assist us in the refinement of
  documentation as we write it, identifying areas that need more
  detail.

- **Separate Task C:** Cecilia et al could attempt to do the server deployment
  with Dan + Jason’s help — rather than Dan doing it with Jason’s
  help.  This could be a good way to get “fresh eyes” on the
  deployment steps.

## More Detailed Rambling

### Current status

- This repository is actually three code bases combined into one box.
  This should eventually be refactored so each code base has a home of
  its own.

- The current repository's deployment documentation is out-of-date.
  It should be updated and completed.

- The current WebSphere projects separate functionality into two
  distinct applications (core vs external services).  We should have a
  discussion about the merits of that separation and implementation.

- The current WebSphere projects are not using WebSphere-specific
  features.  During an earlier phase we ran a migration analysis tool
  on the WebSphere projects which suggested that there were no
  meaningful code changes that needed to be migrated.

- The current project’s interaction with SQL comes in two flavors:
  migration scripts (which may use Oracle-specific keywords, but which
  we can convert to generic SQL with some straightforward
  trial-by-running), and Data Access Objects (DAOs) which use Java’s
  persistence interface.  Jason can correct me on this, but my
  understanding is that this means the flavors of SQL can be easily
  changed via config file.

- As we do the migration to WildFly, we should keep close track of
  what changes were needed.  Ideally we would be able to understand
  what architecture improvements would allow for a wider range of
  deployment environments.

- Most of the sources consulted by external sources app are now
  broken, because their APIs or page structures changed.
  `pesp-was8.5-ext-srcs/` is basically a big pile of technical debt
  right now.

### Recommended steps from here

1. Delete the JBoss code (we will continue to have it in history for
   reference, if we ever need it).

2. Evaluate the two WebSphere projects and decide if we want to treat
   them as separate projects.  If so, we should consider separating
   them at a repository level and treating them as separate projects
   with separate deployment scripts and separate sets of documentation.

     _NOTE: The current split of complexity between core and
     ext-sources was not completed.  Complexities aren't abstracted
     away as much as they could be at integration points (e.g., the
     client and server needed to agree on dozens of shared, ad-hoc
     data structures on a per-service level).  Inevitably, we will
     need to address this in the form of a refactor around how data
     from external sources are passed between components of the
     system._

     _ANOTHER NOTE: I strongly recommend that for our short term
     deployment goal or starters we maintain the two project as
     separate code bases.  Consolidation would be potentially
     significant refactor and would be best done after we have learned
     to deploy on WildFly and shown the progress._

     _YET ANOTHER NOTE: This should involve the creation of a separate
     repository and eliminating the use of root-level subdirectories._

3. I do not recommend spending any time trying to spin up WebSphere.
   We know the project can be deployed on WebSphere since we got it
   set up in a previous phase (albeit with help from Venkat Guruvelli,
   one of the original authors).  Instead, I suggest we spend the next
   week and a half immediately attempt to make the changes required to
   deploy the services on WildFly.

### Proposed assignments

- Jason should take the lead on attempting to convert was-core to
  WildFly and PSQL, taking notes along the way.  Dan should be involved
  in this process to provide guidance and understand what hurdles were
  faced.  This will involve code changes and joint problem solving.
  Lots of Java soup will be consumed.

- By Friday afternoon we should be able have a sense of how things
  are looking — it will not be finished, but we will know if this path
  is still a reasonable one.

- By early next week Jason should be able to have a dev (or local)
  deployment of the core code base with no ability to communicate to
  external sources.  From here, Dan should take the lead on doing a
  deployment on a production server with Jason’s guidance and
  documentation.

- Once a production server deployment has occurred, Dan + Jason should
  refine the documentation to a “final” DEPLOY.md file.
