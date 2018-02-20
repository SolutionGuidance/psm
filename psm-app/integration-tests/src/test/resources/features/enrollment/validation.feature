Feature: Form and Field Validations
  To ensure the quality of entered data, the forms should validate field values
  against data quality rules.

  @issue_291
  @psm-FR-1.2
  Scenario: Validate Tax ID Number
    Given I have started an enrollment
    And I am on the organization page
    When when I enter an 8 digit FEIN
    Then It should be rejected

  Scenario: Validate minimum age
    Given I have started an enrollment
    And I am on the personal info page
    When I enter a date of birth less than eighteen years ago
    And I click 'next' on the personal info page
    Then I should get a provider too young error

  @issue_352
  Scenario: Validate individual provider license renewal date
    Given I have started an enrollment
    And I am on the individual provider license info page
    And I indicate I am not a provider at a Public Health Service Indian Hospital
    When I enter license info where renewal date is before issue date
    And I click 'next' on the license info page
    Then I should get a renewal date error

  @issue_352
  Scenario: Validate organizational provider license renewal date
    Given I have started an enrollment
    When I am on the facility credentials page
    When I enter license info where renewal date is before issue date
    And I click 'next' on the license info page
    Then I should get a renewal date error
