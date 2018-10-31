Feature: Data Coverage Checks
  To ensure that the app accepts data that is required by the agencies to perform
  their jobs.

  @psm-FR-2.9
  Scenario: Captures Contact Info for Organization
    Given I have started an application
    When  I am on the organization page
    Then I should be asked to enter Applicant Name, Contact Person, Contact phone, Contact email

  @psm-FR-2.9
  Scenario: Captures Medicaid number for Organization's contact
    Given I have started an application
    When  I am on the organization page
    Then I should be asked to enter Medicaid number

  @psm-FR-2.9
  Scenario: Captures Contact Info for Individual
    Given I have started an application
    When I am on the personal info page
    Then I should be asked to enter Applicant Name, Contact Person

  @psm-FR-2.9
  Scenario: Captures Phone number and Medicaid number for Individual
    Given I have started an application
    When I am on the personal info page
    Then I should be asked to enter Contact phone, Medicaid number

  @issue-362
  Scenario: Captures Individual Beneficial Owner's City
    Given I have started an application
    And I am entering ownership information
    And I have indicated that the owner has an interest in another Medicaid disclosing entity
    And I have entered a city for that other entity
    When I click 'next' on the Ownership Info Page
    Then the city should be accepted

  @psm-FR-2.6
  Scenario: Accepts valid individual provider personal information
    Given I have started an application
    When I am on the personal info page
    When I enter valid personal information
    Then I can move on from the personal info page with no errors

  @psm-FR-2.4
  Scenario: Accepts license
    Given I have started an application
    And I am on the individual provider license info page
    And I indicate I am not a provider at a Public Health Service Indian Hospital
    When I enter valid license information
    And I upload a valid license
    Then the license is accepted

  Scenario: Accepts practice information
    Given I have started an application
    And I am on the individual provider practice info page
    When I enter a valid private practice
    Then the practice information is accepted
    And the summary page shows expected information

  Scenario: Completes an application
    Given I have started an application
    And I am on the individual provider statement page
    When I enter my individual provider statement
    And I submit the application
    Then the application is successfully submitted
