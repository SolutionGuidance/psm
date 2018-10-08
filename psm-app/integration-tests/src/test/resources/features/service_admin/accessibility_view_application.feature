@accessibility
Feature: View Application Accessibility Checks for Admins
  Users wish to access accessible pages
    
  Scenario: Admin View Application Organization Info Page
    Given I am logged in as an admin
    And I am on the View Application Organization Info page
    Then I should have no accessibility issues

  Scenario: Admin View Application Facility Credentials Page
    Given I am logged in as an admin
    And I am on the View Application Facility Credentials page
    Then I should have no accessibility issues

  Scenario: Admin View Application Individual Member Info Page
    Given I am logged in as an admin
    And I am on the View Application Individual Member Info page
    Then I should have no accessibility issues

  Scenario: Admin View Application Ownership Info Page
    Given I am logged in as an admin
    And I am on the View Application Ownership Info page
    Then I should have no accessibility issues

  Scenario: Admin View Application Provider Statement Page
    Given I am logged in as an admin
    And I am on the View Application Provider Statement page
    Then I should have no accessibility issues
