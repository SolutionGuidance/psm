Feature: Data Coverage Checks
  To ensure that the app accepts data that is required by the agencies to perform
  their jobs.

  @psm-2.9
  Scenario: Captures Contact Info for Organization
    Given I have started an enrollment
    When  I move to the organization page
    Then I should be asked to enter Applicant Name, Contact Person, Contact phone

  @psm-2.9
  Scenario: Captures Additional Contact Info for Organization
    Given I have started an enrollment
    When  I move to the organization page
    Then I should be asked to enter Medicaid number

  @psm-2.9
  Scenario: Captures Contact Info for Individual
    Given I have started an enrollment
    When  I move to the personal info page
    Then I should be asked to enter Applicant Name, Contact Person

  @psm-2.9
  Scenario: Captures Additional Contact Info for Individual
    Given I have started an enrollment
    When  I move to the personal info page
    Then I should be asked to enter Contact phone, Medicaid number

