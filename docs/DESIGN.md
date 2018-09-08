# DESIGN.md

***NOTE: 2017-07-03: This document is still very much a work in
   progress.  We welcome suggestions on improving it.***

## Overall architecture

The Provider Screening Module is a Java EE Enterprise Application
using [Gradle](https://gradle.org/) to manage builds, [the Spring
framework](http://projects.spring.io/spring-framework/) for core web
application functionality (including providing an API),
[Hibernate](http://hibernate.org/) for Object Relational Mapping
(interacting with the database), and [jBPM](http://www.jbpm.org/) and
[Drools](http://drools.org/) for business rules management. See
[`DEPENDENCIES.md`](DEPENDENCIES.md) and [`INSTALL.md`](INSTALL.md)
for more details on component versions and installation requirements.

Within the PSM codebase are several "projects" within the `psm-app`
directory. The major ones are:

* `cms-business-model` 

   Contains XML-defined Java data types, e.g., license type, and
   JAXB-generated code that Drools rules are set up to work with.

* `cms-business-process` 

   Includes callbacks into Java from jBPM.

* `cms-services` 
 
   This subproject is a service layer which communicates to database
   and frontend.  It includes Hibernate entities, binders that map
   frontend elements to Java handles, and definitions of EE services
   that `cms-business-process` implements.

* `cms-web` 

   MVC, web controller, UI, HTML, CSS.

   * See [`REPORTS.md`](REPORTS.md) for design related to PSM reports

* `cms-portal-services` 
 
   Generates EAR file, and is where TopCoder JAR
   files live.

* `frontend`

   This subproject Manages JavaScript used on the front end
   (see [frontend/README.md](../psm-app/frontend/README.md)).  It
   contains PSM-specific JavaScript code, and uses node.js to specify
   and download the JavaScript libraries it depends on.

* `userhelp` 

   Contains prose documents for end user help.

A diagram of the components mentioned above is available at
[`docs/psm-architecture-for-stakeholders.pdf`](psm-architecture-for-stakeholders.pdf).

## Workflow for processing submissions

See
[`psm-app/cms-business-process/src/main/resources/EnrollmentProcess.png`](../psm-app/cms-business-process/src/main/resources/EnrollmentProcess.png)
for a diagrammatic representation of the jBPM workflow defined in
`psm-app/cms-business-process/src/main/resources/EnrollmentProcess.bpmn`.


## UI Templates

Originally, the PSM used
[JSP](http://www.caucho.com/resin-3.1/doc/jsp-templates.xtp) templates,
as detailed in [issue
#238](https://github.com/OpenTechStrategies/psm/issues/238#issuecomment-313217566).
We have converted some of these JSP templates to
[Handlebars](http://handlebarsjs.com/), for easier reuse.  Handlebars
templates can be used with code written in any number of languages, not
just Java.  For this reason, they are not as exactly tuned to Java
development.  JSPs are able to hold more complex logic than Handlebars,
and work well for the PSM's screens, which are so specific that they are
unlikely to be reused.  The framing templates of the PSM (the headers,
footers, and navigation bar) have been converted to Handlebars, since they
are the most likely to be reused in other applications or in pieces of
the PSM that might be written in another language.

As part of this conversion, we deduplicated many of the templates.  When
you are editing a piece of UI functionality, it should appear in either
a JSP template or a Handlebars template.  Use the correct formatting for
whichever style applies.

See [handlebars.md](handlebars.md) for more detail about this conversion
process.

## User types

The PSM has four types of users, each with their own permission level:

1. __Service agent__
    
    Service agents should be able to create, view, and edit enrollments
    for their provider clients.

    - Can view: provider dashboard, enrollments, profile
    - Can create an enrollment
    - Can edit draft enrollments
    - Can view submitted enrollments
    
2. __Service admin__
    
    This user type can edit and view enrollments just as a service agent
    can, but it can also edit provider types and the screening schedule.
    This user type is most likely appropriate for someone working for a
    state and overseeing enrollment and service agents.
    
    - Can view: provider dashboard and enrollments
    
    - Functions:
        - View and edit provider types
        - Edit screening schedule
        - Add and edit agreements/addendums
        - View, create, edit, and delete other service agents

3. __System admin__
    
    This user type is purely for managing users, which none of the other
    user types can do.
    
    - Can only view "user account" screen
    - Functions
        - Create, edit, and delete users
        - Edit the abilities of user roles, but doesn't seem to be able
          to create new roles

4. __Providers__
    
    The user type with the lowest level of permissions, a provider
    should only be able to create, view, and edit their own enrollments.

    - View own enrollments
    - Create and edit enrollments


 ## TBD: Screening vs. Management

_Note: the following is one possible way for the PSM to handle screening
and management.  It is included here as a start for discussion, not as a
conclusive decision._

The PSM is a screening module, meaning that it focuses on determining
whether providers are eligible to participate in Medicaid.  However, the
information that providers enter into the PSM is subsequently used by
the state to manage those providers, and by the providers to manage
their own enrollment in Medicaid and other state programs.  For this
reason, screening and management modules can be difficult to
disentangle.  A provider should have one front page to use to both apply
for enrollment (be screened) and manage their enrollment.

One approach is to present these two tasks through the same portal for
the provider, but to separate them from a technical perspective.  To do
this, the screening application would essentially just be a form that
takes information from a provider, runs automated checks on it, allows
an administrator to review the information, and returns a status of
either "enrolled" or "not enrolled."  The screening module would send
the bundle of entered data to the management module, which would use the
same SSO solution, so that from the provider's perspective the two
modules feel like part of the same application.

The homepage for providers could look something like this:

```
------------------------------------------------------
|                                         | Logout | |
|                                                    |
| +-----------------+    +------------------------+  |
| |  Click here to  |    |     Click here to      |  |
| | apply to enroll |    | manage your enrollment |  |
| +-----------------+    +------------------------+  |
|                                                    |
|                                                    |
|                                                    |
|                                                    |
------------------------------------------------------
```

"Apply to enroll" would be the screening module, and "manage your
enrollment" would be the management module.  The latter would include
"update your information," "renew your enrollment," and "terminate your
enrollment."  In a fully-fledged management module, providers would also
be able to see and track the status of their claims in that area.  It
might be worth adding another button to the homepage for a separate
billing module.

```
------------------------------------------------------
|                                         | Logout | |
|                                                    |
| +-----------------+    +------------------------+  |
| |  Click here to  |    |     Click here to      |  |
| | apply to enroll |    | manage your enrollment |  |
| +-----------------+    +------------------------+  |
|                                                    |
| +-------------------+                              |
| | Track your claims |                              |
| +-------------------+                              |
------------------------------------------------------
```

For state reviewers/administrators, there'd be two kinds of action:
reviewing the information provided for screening purposes and
reviewing/paying claims.  Their portal would reflect these two kinds of
task.  When a provider updates information or renews or terminates their
enrollment, that new set of information would go into the "screening"
queue for state reviewers.  The management module would need to have
some way of bundling that information up and sending it back to the
screening module, perhaps with some metadata about what changed,
e.g. "the only piece of information that changed is the address."

