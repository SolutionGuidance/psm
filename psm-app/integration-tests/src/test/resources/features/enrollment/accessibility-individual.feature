@accessibility
Feature: Individual Enrollment Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Personal Info Page
    Given I have started an enrollment
    When I am on the personal info page
    Then I should have no accessibility issues

  # fails: date inputs on second license need labels or titles
  @ignore
  Scenario: License Info Page
    Given I have started an enrollment
    And I am on the individual provider license info page
    When I indicate I am a provider at a Public Health Service Indian Hospital
    And I open an add a license panel
    And I open an add a license panel
    Then I should have no accessibility issues
