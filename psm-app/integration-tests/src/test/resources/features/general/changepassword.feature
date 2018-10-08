Feature: Provider changes their own Password
  A provider wishes to change their password to prevent unauthorized access.

@pull_568
Scenario: Change Password Option
  Given I am logged in as a provider
  And I am on the All Applications page
  When I click on My Profile
  Then I should see the Change Password link

Scenario: Visit Update Password Page
  Given I am logged in as a provider
  And I click on My Profile
  When I click on Change Password
  Then I should see the Update Password page

@ignore 
Scenario: Change Provider Password
  Given I am logged in as a provider
  And I am on the Update Password page
  When I enter a new password
  And the correct old password
  Then I should get a confirmation message
