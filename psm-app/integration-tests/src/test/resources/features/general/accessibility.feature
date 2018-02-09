@accessibility
Feature: Accessibility Checks
  Users wish to access accessible pages

  Scenario: Login Page
    Given I have the application open in my browser
    Then I should have no accessibility issues

  Scenario: Dashboard Page
    Given I am logged in
    And I am on the dashboard page
    Then I should have no accessibility issues

  Scenario: My Profile Page
    Given I am logged in
    When I click on My Profile
    Then I should have no accessibility issues

  Scenario: Update Password Page
    Given I am on the Update Password page
    Then I should have no accessibility issues
