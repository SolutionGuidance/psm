Service administrator help documentation
========================================

This is documentation for service administrators for the Provider
Screening Module.

Why do we have this enrollment process?
---------------------------------------

Under Medicaid and similar programs, federal and state governments pay
doctors, pharmacists, and other medical service providers for treating
patients. State and federal regulations require providers to meet
eligibility standards. The enrollment process is where we verify that
eligibility. The Provider Screening Module helps states manage the
enrollment process so that eligible providers can serve Medicaid
clients.

The goal of the PSM is to make it as painless as possible for providers
to enroll (encouraging enrollment and thus improving service to Medicaid
patients), and as painless as possible for administrators to manage
enrollments.

What information do I need to create an enrollment?
---------------------------------------------------

An enrollment includes:

-  provider/organization information, such as provider type, name, NPI,
   and contact information

-  license and certification information, including a scan of the
   license or certification itself

-  contact and billing/reimbursement information about the practice

-  answers to questions about the provider's past exclusions, penalties,
   terminations, and convictions, if any

-  an electronic signature and date attesting to the accuracy of the
   enrollment information

What are the steps in the enrollment process?
---------------------------------------------

-  A provider, service agent, or service admin creates and submits a new
   enrollment for a particular provider. (A user can save a draft
   enrollment and come back later to finish and submit it.)

-  A service admin reviews the enrollment, using links provided by the
   PSM to verify enrollment details, and decides whether to approve or
   reject the submission.

-  After an enrollment has been approved, a service admin can select and
   renew it.

How do I use the enrollment verification process?
-------------------------------------------------

Verification is checking an enrollment with federal or state data
sources and visually inspecting the license(s) or certification(s) in a
submitted enrollment.

Click "Enrollments" in the navigation bar and go to the "Pending" tab.
Click the "Review" link for the enrollment you want to verify. You'll
see a list of things that you want to verify about the pending
enrollment before approving it. Under "Auto Screening", click "View" or
"View Log" to see the "External Source Screening Log," which will tell
you whether the PSM has been able to automatically verify each piece of
enrollment data with an external information source. If you are
satisfied with that result, or if you go to the government database
yourself and manually verify that piece of the enrollment, click the
"Verified" checkbox for that row.

Check the Provider Information:

-  Is this person's National Provider Identifier accurate and valid, as
   listed in `the National Plan and Provider Enumeration System
   registry <http://npiregistry.cms.hhs.gov/>`__? If not, you should
   reject the enrollment.
-  Is this person in the `Social Security Administration's Death Master
   File <https://www.ssa.gov/dataexchange/request_dmf.html>`__ (`how to
   access <https://classic.ntis.gov/products/ssa-dmf/>`__)? If so, SSA
   lists them as dead, in which case you should reject the enrollment.
-  What does `PECOS (the federal Medicare Provider Enrollment, Chain,
   and Ownership System) <https://pecos.cms.hhs.gov/>`__ say about the
   provider's NPI? Is the Provider enrolled? If they are not, you should
   reject the enrollment.
-  Is this provider on the `List of Excluded Individuals and Entities
   provided by the Office of the Inspector General for the US Department
   of Health and Human
   Services <https://oig.hhs.gov/exclusions/exclusions_list.asp>`__? If
   so, you should reject the enrollment.
-  Does this provider have an active exclusion record in the `federal
   System for Award Management <https://www.sam.gov/>`__? (Click "Search
   Records".) If so, you should reject the enrollment.

Check the License Information (more details below). Look at the files to
see whether they are legitimate licenses or certifications, and (if
applicable) check with the issuing board or authority to validate the
license. Go back to the list of pending enrollments and click the
NPI/UMPI number to view the enrollment details, and look at the License
Info tab. Confirm that the issue and renewal end dates in the image are
the same as in the enrollment. If you see any discrepancies, you should
reject the enrollment.

At the bottom of the screen, choose "Reject" or "Approve" as
appropriate.

Future verification processes will be increasingly automated.

How do I view license/certification files?
------------------------------------------

When viewing a pending enrollment, on the "Review Enrollment" screen,
look under the "License Information" heading. Next to a license or
certification number (issued by the licensure or certification
authority), you'll see a "View" link. Click that to access the scanned
image of the provider's license or certification. Your PC will probably
automatically open a program to view the file, such as:

-  PDF files: Adobe Acrobat
-  PNG, JPEG, BMP, GIF and TIF files: built-in image viewer
-  DOC and DOCX files: Microsoft Word
-  PPT and PPTX files: Microsoft PowerPoint

Who can view enrollments?
-------------------------

A provider can view their own enrollments (including draft, rejected,
approved, and pending enrollments).

A service agent or service admin can view all enrollments (including
draft, rejected, approved, and pending enrollments).

A system admin should not be able to view any enrollments. `The PSM
currently allows a system admin to view enrollments, but will remove
that capability in a future
version. <https://github.com/OpenTechStrategies/psm/issues/10>`__

Which enrollment information can a provider, service agent, or service admin modify or delete?
----------------------------------------------------------------------------------------------

A provider can modify a draft enrollment, but can't delete it. A
provider also cannot delete or modify an enrollment after submitting it
(once it is "pending").

A service agent or service admin can modify a draft or pending
enrollment, but cannot delete it.

How do I look at and change the risk assessment rules?
------------------------------------------------------

Right now that's not something you can do in the PSM, but it'll be
possible in a future version. For the moment, speak with your internal
IT team. You can also refer to the Centers for Medicare and Medicaid
Services' rules, and to the
`regulations <https://www.law.cornell.edu/cfr/text/42/424.518>`__ they
implement.

What will the provider see or receive when enrollment is pending, modified, approved, or rejected?
--------------------------------------------------------------------------------------------------

When a provider logs into the PSM, they'll see any enrollments they've
submitted or started drafting via their PSM user account. They'll be
able to see the status of each enrollment.

Right now, the provider does not receive any email notifications about
their enrollment. (A future version of the PSM will send email
notifications to providers when the status of their enrollment changes.)

How do we renew an enrollment or update an enrollment?
------------------------------------------------------

Right now that's not something the PSM can do, but it'll be possible in
a future version.

What's the difference between an agreement and an addendum?
-----------------------------------------------------------

Both agreements and addenda are documents meant for the "Provider
Statement" step in the enrollment process; they are where you place
legal terms and conditions for providers to sign. They are identical in
format: each agreement and each addendum has a title and content. You
can format and style the format of the content.

You should create a few agreements to cover the major types of providers
in your program, and then use special provider-specific addenda for
additional statements that providers need to sign.

Where do I create, edit, or delete agreements and addenda?
----------------------------------------------------------

Click on "Functions" in the navigation bar, and look at the "Agreements
& Addendums" tab. There, you can create or edit agreements and addenda.

You cannot delete an agreement or an addendum.

Where do I create, edit, or delete a provider type?
---------------------------------------------------

Click on "Functions" in the navigation bar, and look at the "Provider
Types" tab. Each provider type has a name and zero or more agreements or
addenda. You can edit a provider type to change its name and to add or
remove an agreement or addendum.

You cannot create or delete a provider type.
