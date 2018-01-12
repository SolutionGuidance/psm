Feature: Provider changes their own Password
  A provider wishes to change their password to prevent unauthorized access.

@pull_568
Scenario: Change Password Option
  Given I am logged in
  And I am on the dashboard page
  When I click on My Profile
  Then I should see the Change Password link

@ignore
Scenario: Visit Change Provider Page
  Given I am on the My Profile page
  When I click on Change Password
  Then I should see the Update Password page

@ignore 
Scenario: Change Provider Password
  Given I am on the Update Password page
  When I enter a new password
  And the correct old password
  Then I should get a confirmation message
