@accessibility
Feature: Accessibility Checks
  Users wish to access accessible pages

  @ignore
  Scenario: Login Page Accessibility
    Given I have the application open in my browser
    Then I should have no accessibility issues
