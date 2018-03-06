@accessibility
Feature: View Enrollment Accessibility Checks for Admins
  Users wish to access accessible pages
    
  Scenario: Admin View Enrollment Organization Info Page
    Given I am logged in as an admin
    And I am on the View Enrollment Organization Info page
    Then I should have no accessibility issues

  Scenario: Admin View Enrollment Facility Credentials Page
    Given I am logged in as an admin
    And I am on the View Enrollment Facility Credentials page
    Then I should have no accessibility issues

  Scenario: Admin View Enrollment Individual Member Info Page
    Given I am logged in as an admin
    And I am on the View Enrollment Individual Member Info page
    Then I should have no accessibility issues

  Scenario: Admin View Enrollment Ownership Info Page
    Given I am logged in as an admin
    And I am on the View Enrollment Ownership Info page
    Then I should have no accessibility issues

  Scenario: Admin View Enrollment Provider Statement Page
    Given I am logged in as an admin
    And I am on the View Enrollment Provider Statement page
    Then I should have no accessibility issues
