Feature: Form and Field Validations
  To ensure the quality of entered data, the forms should validate field values
  against data quality rules.

  @issue_291
  @psm-FR-1.2
  Scenario: Validate Tax ID Number
    Given I have started an application
    And I am on the organization page
    And I enter an 8 digit FEIN
    When I click 'next' on the organization info page
    Then I should get an FEIN error

  Scenario: Validate minimum age
    Given I have started an application
    And I am on the personal info page
    When I enter a date of birth less than eighteen years ago
    And I click 'next' on the personal info page
    Then I should get a provider too young error

  @issue_352
  Scenario: Validate individual provider license renewal date
    Given I have started an application
    And I am on the individual provider license info page
    And I indicate I am not a provider at a Public Health Service Indian Hospital
    When I enter license info where renewal date is before issue date
    And I click 'next' on the license info page
    Then I should get a renewal date error

  @issue_352
  Scenario: Validate organizational provider license renewal date
    Given I have started an application
    When I am on the facility credentials page
    When I enter license info where renewal date is before issue date
    And I click 'next' on the license info page
    Then I should get a renewal date error

  @issue_842
  Scenario: Validate individual provider email address contact
    Given I have started an application
    And I am on the personal info page
    And I enter valid personal information
    When I enter an empty email address on the personal info page
    And I click 'next' on the personal info page
    Then I should get a same as above email error

  @issue_842
  Scenario: Validate individual provider email address is required
    Given I have started an application
    And I am on the personal info page
    And I enter valid personal information
    When I enter an empty email address on the personal info page
    And I click 'next' on the personal info page
    Then I should see email address is required