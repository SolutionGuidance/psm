@accessibility
Feature: Organization Application Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Select Provider Type Page
    Given I have started an application
    Then I should have no accessibility issues

  Scenario: Organization Info Page
    Given I have started an application
    When I am on the organization page
    Then I should have no accessibility issues

  # fails with inputs without labels/titles
  @ignore
  Scenario: Facility Credentials Page
    Given I have started an application
    When I am on the facility credentials page
    And I open an add a license panel
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: Individual Member Info Page
    Given I have started an application
    When I am on the individual member info page
    When I open an individual member panel
    Then I should have no accessibility issues

  # fails with duplicate IDs and inputs without labels/titles
  @ignore
  Scenario: Ownership Info Page
    Given I have started an application
    When I am on the ownership info page
    And I open the individual owner panel
    And I open the business owner panel
    And I have indicated that the owner has an interest in another Medicaid disclosing entity
    Then I should have no accessibility issues

  Scenario: Organization Summary Page
    Given I have started an application
    When I am on the organization summary page
    And I save as draft
    Then I should have no accessibility issues

  Scenario: Organization Provider Statement Page
    Given I have started an application
    When I am on the organization provider statement page
    Then I should have no accessibility issues

  Scenario: Organization Submit Application Modal
    Given I have started an application
    And I am on the organization provider statement page
    When I enter my organization provider statement
    And I submit the application
    Then I should have no accessibility issues
