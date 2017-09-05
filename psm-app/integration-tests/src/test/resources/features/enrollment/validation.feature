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
