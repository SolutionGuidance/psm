System administrator help documentation
=======================================

This is documentation for system administrators for the Provider
Screening Module.

What's the difference among the different user roles?
-----------------------------------------------------

See the "User types" section of `the design overview
<https://github.com/SolutionGuidance/psm/blob/master/docs/DESIGN.md#user-content-user-types>`__
for the differences between providers, service agents, service admins,
and system admins.

Why can't users register for their accounts?
--------------------------------------------

If a user can't self-register, here are some things to troubleshoot:

1. Has the user turned JavaScript off? The PSM's registration page
   requires JavaScript.
2. Ask the user: did they receive an email confirming a successful
   account registration? If not:

   a. Has the user included a valid email address?

   b. Ask IT: is the PSM's email working? If the PSM can't reach an
      email server, it will create a new account but won't email the
      user their password. Once the PSM's email is working again, ask
      the user to click "Forgot Password?" to get a password reset
      email.


Why can't users log in?
-----------------------

If a user can't log into the PSM, here are some things to troubleshoot:

1. Is the user using the correct username and password?
2. Has the user turned JavaScript off? The PSM's login page requires
   JavaScript.
3. Is the user choosing the correct "Domain" (for authentication) on the
   login page?

Which user information is required or optional?
-----------------------------------------------

A new account needs a username, first and last name, a user role, and an
email address. If you (the system admin) are creating it, you'll also
need to add a password. If the user is self-registering, the PSM will
create a random password and email it to them, and will assume that the
account is for a provider.

If a service administrator is creating a service agent account, the PSM
also requires a business phone number.

Provider accounts can also have a middle name (this is optional).

The PSM does not enforce any limits on the number or type of characters
in the user's first name, last name, username or password.

Who can modify or delete user information?
------------------------------------------

After account creation, which user information can a user modify or
delete themselves, and which user information can a service admin or
system admin modify or delete?

After a PSM account is created:

-  A provider can change their password, but not change anything else,
   nor delete their account.

-  A service agent or service admin can go to "My Profile" to update
   their first, middle, and last names, business phone number and email
   address. But they can't change their own username, and they can't
   delete their own account.

-  A service admin can view the list of service agents, and can delete a
   service agent's account. (The service agent will not receive any
   notification of this deletion.) A service admin can edit a service
   agent's first, middle, and last name, email address, and business
   phone number, but not their username.

-  A system administrator can view, delete, and change all aspects of
   all PSM user accounts, including their own. In particular, a system
   administrator can delete other system administrators' accounts, can
   change any other account's role (e.g., turning a service agent into a
   service administrator), and can change their own or others'
   usernames.

Can I connect PSM login to another authentication system?
---------------------------------------------------------

This functionality is not yet implemented.
