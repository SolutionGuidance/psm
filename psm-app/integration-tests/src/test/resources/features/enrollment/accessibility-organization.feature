@accessibility
Feature: Organization Enrollment Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Select Provider Type Page
    Given I have started an enrollment
    Then I should have no accessibility issues

  Scenario: Organization Info Page
    Given I have started an enrollment
    When I am on the organization page
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: Individual Member Info Page
    Given I have started an enrollment
    When I am on the individual member info page
    When I open an individual member panel
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: Ownership Info Page
    Given I have started an enrollment
    When I am on the ownership info page
    And I open individual and business owner panels
    Then I should have no accessibility issues

  Scenario: Summary Page
    Given I have started an enrollment
    When I am on the summary page
    Then I should have no accessibility issues

  Scenario: Provider Statement Page
    Given I have started an enrollment
    When I am on the provider statement page
    Then I should have no accessibility issues
