@accessibility
Feature: Organization Enrollment Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Select Provider Type Page
    Given I have started an enrollment
    Then I should have no accessibility issues

  # fails with color contrast issue
  @ignore
  Scenario: 1. Organization Info Page
    Given I have started an enrollment
    When I move to the organization page
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: 2. Individual Member Info Page
    Given I have started an enrollment
    When I move to the individual member info page
    When I open an individual member panel
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: 3. Ownership Info Page
    Given I have started an enrollment
    When I move to the ownership info page
    And I open individual and business owner panels
    Then I should have no accessibility issues

  Scenario: 4. Summary Page
    Given I have started an enrollment
    When I move to the summary page
    Then I should have no accessibility issues

  Scenario: 5. Provider Statement Page
    Given I have started an enrollment
    When I move to the provider statement page
    Then I should have no accessibility issues
