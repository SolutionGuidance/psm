Enrollment
==========

What information do I need to apply to enroll?
----------------------------------------------

First, you'll need to register for an account (see `"how do I register
for an account on this
site?" <account-help.html#how-do-i-register-for-an-account-on-this-site>`__).
Then you'll need to click the button to create a new enrollment.

An application includes:

-  provider/organization information, such as provider type, name, NPI,
   and contact information

-  license and certification information, including a scan of the
   license or certification itself

-  contact and billing/reimbursement addresses for the practice

-  answers to questions about the provider's past exclusions, penalties,
   terminations, and convictions, if any

-  information about ownership and potential conflicts (e.g. ownership
   over other entities billing Medicaid)

-  an electronic signature and date attesting to the accuracy of the
   enrollment information

What is an NPI?
---------------
An *NPI* is a National Provider Identifier number.
You can search for an NPI, register for an NPI, and check whether an NPI's
status is active at |nppes_link| (link opens in a new tab).

.. |nppes_link| raw:: html

   <a href="https://nppes.cms.hhs.gov" target="_blank">NPPES (the National Plan
   and Provider Enumeration System)</a>

What are the steps in the enrollment process?
---------------------------------------------

-  A provider, a service agent, or a state Medicaid agency staffer
   creates and submits a new enrollment application for a particular
   provider. (A user can save a draft application and come back later to
   finish and submit it.)

-  A state Medicaid agency staffer reviews the enrollment, using links
   provided by the PSM to verify enrollment details, and decides whether
   to approve or reject the submission.

-  After an enrollment has been approved, a state Medicaid agency
   staffer can select and renew it.

Who can view enrollments?
-------------------------

A provider can view their own enrollments (including draft, rejected,
approved, and pending enrollments).

A service agent or state Medicaid agency staffer can view all
enrollments (including draft, rejected, approved, and pending
enrollments). (`The PSM may limit this ability in a future
version. <https://github.com/SolutionGuidance/psm/issues/10>`__)

A system admin should not be able to view any enrollments. `The PSM
currently allows a system admin to view enrollments, but will remove
that capability in a future
version. <https://github.com/SolutionGuidance/psm/issues/10>`__

Which enrollment information can a provider, service agent, or state Medicaid agency staffer modify or delete?
--------------------------------------------------------------------------------------------------------------

A provider can modify a draft enrollment, but can't delete it. A
provider also cannot delete or modify an enrollment after submitting it
(once it is "pending", "approved", or "denied").

A service agent or state Medicaid agency staffer can modify a draft or
pending enrollment, but cannot delete any enrollments.

How will a provider learn when their enrollment changes status?
---------------------------------------------------------------

When you log into the PSM, you'll see any enrollments you've submitted
or started drafting via your PSM user account. You'll be able to see the
status of each enrollment.

Right now, a provider does not receive any email notifications about
their enrollment. (`A future version of the PSM will send email
notifications to providers when the status of your enrollment
changes. <https://github.com/SolutionGuidance/psm/issues/341>`__)

Can I create an enrollment for someone else?
--------------------------------------------

A service agent or a state Medicaid agency staffer can create an
enrollment for someone else.

Can I start an enrollment now and finish it later, or do I have to start and submit it all in one session?
----------------------------------------------------------------------------------------------------------

This site lets you save a "draft" at any point while you are creating a
new enrollment. Click the "Save as draft" button. Even if you log out
and then log back in, that draft enrollment will still be available for
you to work on -- you will see it in your Dashboard and in the Draft tab
under Enrollments.

Can I start a draft enrollment and then have someone else finish it for me?
---------------------------------------------------------------------------

Service agents and state Medicaid agency staffers can finish draft
enrollments started by other people. A provider can save a draft
enrollment and then phone or otherwise contact a service agent or the
state Medicaid agency to ask them to help finish it for you. One
provider cannot access, and therefore cannot finish and submit, a draft
enrollment started by another provider.

How do I renew an enrollment or update an enrollment?
-----------------------------------------------------

Right now that's not something the PSM can do, but `it'll be possible in
a future
version. <https://github.com/SolutionGuidance/psm/issues/401>`__

Why can I edit some enrollments but not others?
-----------------------------------------------

You can only edit an enrollment if its status is still "Draft"
(it hasn't been submitted yet).  If its status is "Pending",
"Approved", or "Denied" then you can view but not edit it.

Can I change something in a pending enrollment after I submit it?
-----------------------------------------------------------------

You'll need to directly contact the state Medicaid office; once you've
submitted an enrollment, you can't update it in the PSM.

How will I find out when my enrollment is accepted or rejected?
---------------------------------------------------------------

Right now, this site does not notify you via email or paper mail when
the state accepts or rejects an enrollment you have submitted. `This
will change in a future version of the Provider Screening
Module. <https://github.com/SolutionGuidance/psm/issues/341>`__

When you log into the PSM, you'll see any enrollments you've submitted
or saved as a draft. You'll be able to see the status of each
enrollment.

What can I do to reduce the risk of delay or rejection for an enrollment?
-------------------------------------------------------------------------

You should:

-  Include clear, accurate scans of your licenses/certifications

-  Make sure your NPI number, address, and other details in the
   application are correct

-  Check the |nppes_link| (link opens in a new tab) to ensure your NPI
   status is active

-  Check the state Medicaid provider guidelines

.. |nppes_link| raw:: html

   <a href="https://nppes.cms.hhs.gov" target="_blank">NPPES (the National Plan
   and Provider Enumeration System) website</a>

Do I maintain my own private practice?
--------------------------------------

If you have an Individual NPI number (Entity Type 1) then you maintain
your own private practice and should answer "yes" for this question.
`The Center for Medicare and Medicaid Services website has more guidance
on your NPI
number. <https://questions.cms.gov/faq.php?id=5005&rtopic=1851&rsubtopic=8605>`__

Am I employed and/or independently contracted by a group practice?
------------------------------------------------------------------

If you are employed and/or independently contracted by an organization
health care provider that has an Organization NPI number (Entity Type 2),
then you should answer "yes" for this question.
`The Center for Medicare and Medicaid Services website has more
information on Type 2 NPI numbers and what kinds of business structures
should have them <https://questions.cms.gov/faq.php?id=5005&faqId=1965>`__.


What are the types for "Individual Person(s) Ownership or Control Interest"?
----------------------------------------------------------------------------

**Agent** - anyone who has been delegated the authority to obligate or
act on behalf of the provider.

**Managing Employee** - someone who exercises operational or managerial
control over, or who directly or indirectly conducts or manages the day-to-day
operations of an institution, organization, agency or school, such as a general
manager, business manager, administrator, director.

**Owner - 5% or more of Ownership Interest** - any person, business or
organization to which any one or more of the following apply:

* Direct ownership of 5% or more in the disclosing entity.

* Indirect ownership interest equal to 5% or more in a disclosing entity
  (meaning ownership in another entity that has an ownership interest in the
  disclosing entity). Determine the amount of indirect ownership interest by
  multiplying the percentages of ownership in each entity. For example, if A owns
  10% of the stock in a corporation which owns 80% of the stock of the disclosing
  entity, A's interest equals an 8% indirect ownership interest in the disclosing
  entity and must be reported. Conversely, if B owns 80% of the stock of a
  corporation which owns 5% of the stock of the disclosing entity, B's interest
  equals a 4% indirect ownership interest in the disclosing entity and need not
  be reported.

* A combination of direct and indirect ownership interest equal to 5% or more
  in the disclosing entity.

* Owns an interest of 5% or more in any mortgage, deed of trust, note or other
  obligation secured by the disclosing entity if that interest equals at least 5%
  of the value of the property or assets of the disclosing entity. Determine the
  percentage of ownership, mortgage, deed of trust, note, or other obligation by
  multiplying the percentage of interest owned in the obligation by the
  percentage of the disclosing entity's assets used to secure the obligation.
  For example: If A owns 10% of a note secured by 60% of the provider's assets,
  A's interest in the provider's assets equals 6% and must be reported. If B owns
  40% of a note secured by 10% of the provider's assets, B's interest in the
  provider's assets equals 4% and need not be reported.

* Is an officer or director of a disclosing entity that is organized as a
  corporation (for profit or non-profit).

* Is a partner in a disclosing entity that is organized as a partnership.

**Subcontractor** - an individual, agency, or organization to which a
disclosing entity has contracted or delegated some of its management functions
or responsibilities of providing medical care to its patients.

What do "Title V", "Title XX", etc. refer to?
---------------------------------------------

**Title V** - Maternal and Child Health Services Block Grant.

**Title XVIII** - Health Insurance for the Aged and Disabled (Medicare).

**Title XX** - Block Grants to States for Social Services and Elder Justice.

**Title XXI** - State Children's Health Insurance Program.

Can I create multiple enrollments for one person (e.g., if a person is licensed as two or more kinds of provider)?
------------------------------------------------------------------------------------------------------------------

Yes.

Why would a provider have multiple enrollments?
-----------------------------------------------

An individual person might be licensed as two or more kinds of provider.

How do I input an enrollment for an individual provider who is affiliated with multiple organizations (e.g., a psychologist who works for two clinics)?
-------------------------------------------------------------------------------------------------------------------------------------------------------

You can choose to "Add Another Practice Location" on the "Practice Info"
screen of the enrollment application. This is a way to indicate that a
provider works with multiple group practices.

How do I input an enrollment for an organization with several individual providers (e.g., a clinic employing several physicians)?
---------------------------------------------------------------------------------------------------------------------------------

Choose the correct organizational provider type during the first step of
enrollment. On the member entry screen, click the link to add an
additional member. Repeat as necessary to add all the individuals who
will provide services under the umbrella of the organization.

When an organizational provider owns a number of separately located facilities in the state, does each facility need to enroll separately?
------------------------------------------------------------------------------------------------------------------------------------------

If the organizational provider (often a corporation) owns multiple
locations, each one must be enrolled separately.

What do I do if none of the provider types seem to describe what I do (what this provider does)?
------------------------------------------------------------------------------------------------

Contact your state Medicaid office directly.

How can I update an existing organizational enrollment to add a new provider (e.g., if a clinic hires a new physician)?
-----------------------------------------------------------------------------------------------------------------------

If an enrollment is a draft (you haven't submitted it yet), then yes,
you can click on the draft enrollment and edit the member list.

If you have already submitted the enrollment, then you should have the
individual, or a service agent, create a new enrollment for an
individual provider. On the "Practice Info" screen, the user should say
"Yes" to the question "Are you employed and/or independently contracted
by a group practice?" and enter the organization's information.

How can I update an existing organizational enrollment to remove a provider (e.g., if a physician retires from a clinic)?
-------------------------------------------------------------------------------------------------------------------------

If an enrollment is a draft (you haven't submitted it yet), then yes,
you can click on the draft enrollment and edit the member list. If you
have already submitted the enrollment, then it is not possible to remove
an individual member via the PSM, and you will need to directly contact
your state Medicaid office.

How do I view license/certification files?
------------------------------------------

When viewing a pending enrollment, on the "Review Enrollment" screen,
look under the "License Information" heading. Next to a license or
certification number (issued by the licensure or certification
authority), you'll see a "View" link. Click that to access the scanned
image of the provider's license or certification. Your computer will
probably automatically open a program to view the file, such as:

-  PDF files: Adobe Acrobat
-  PNG, JPEG, BMP, GIF and TIF files: built-in image viewer
-  DOC and DOCX files: Microsoft Word
-  PPT and PPTX files: Microsoft PowerPoint

What if I know from past experience that someone else with the same name, address, or NPI has previously been excluded from Medicaid and that automatic checks are likely to flag this enrollment as a result?
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Contact your state Medicaid office directly.

How do I end (terminate) my own active enrollment?
--------------------------------------------------

Currently the PSM does not give you a way to terminate an approved
enrollment, but `a future version of the PSM
will <https://github.com/SolutionGuidance/psm/issues/407>`__. Please
contact the state Medicaid office directly to terminate an enrollment.
