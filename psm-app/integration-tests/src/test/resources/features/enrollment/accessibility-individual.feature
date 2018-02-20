@accessibility
Feature: Individual Enrollment Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Personal Info Page
    Given I have started an enrollment
    When I am on the personal info page
    Then I should have no accessibility issues
