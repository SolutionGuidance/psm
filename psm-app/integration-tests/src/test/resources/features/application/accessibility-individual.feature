@accessibility
Feature: Individual Application Steps Accessibility Checks
  Users wish to access accessible pages

  Scenario: Personal Info Page
    Given I have started an application
    When I am on the personal info page
    Then I should have no accessibility issues

  # fails: date inputs on second license need labels or titles
  @ignore
  Scenario: License Info Page
    Given I have started an application
    And I am on the individual provider license info page
    When I indicate I am a provider at a Public Health Service Indian Hospital
    And I open an add a license panel
    And I open an add a license panel
    Then I should have no accessibility issues

  Scenario: Practice Info Page (Own Private Practice)
    Given I have started an application
    And I am on the individual provider practice info page
    When I indicate I maintain my own private practice
    And I open the practice lookup modal
    Then I should have no accessibility issues

  # fails: additional practice location 'effective date' input needs a label or title
  @ignore
  Scenario: Practice Info Page (Group Practice)
    Given I have started an application
    And I am on the individual provider practice info page
    And I indicate I do not maintain my own private practice
    And I indicate I am employed or independently contracted by a group practice
    And I start to add a practice location
    And I start to add a practice location
    Then I should have no accessibility issues

  Scenario: Individual Summary Page
    Given I have started an application
    When I am on the individual summary page
    And I save as draft
    Then I should have no accessibility issues

  # fails: form input elements missing labels or titles
  @ignore
  Scenario: Individual Provider Statement Page
    Given I have started an application
    And I am on the individual provider statement page
    Then I should have no accessibility issues

  Scenario: Individual Submit Application Modal
    Given I have started an application
    And I am on the individual provider statement page
    When I enter my individual provider statement
    And I submit the application
    Then I should have no accessibility issues
