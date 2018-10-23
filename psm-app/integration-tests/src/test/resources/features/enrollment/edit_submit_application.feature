Feature: Editing and Submitting Applications
  Users wish to edit and submit applications

  @issue_1105
  @ignore
  Scenario: Save and then submit Speech Language Pathologist application
    Given I have started an enrollment
    And I am on the individual provider statement page
    And I save the application as a draft
    When I enter my individual provider statement
    And I submit the enrollment
    Then I should have no errors

  @issue_1105
  @ignore
  Scenario: Save and then submit Head Start application
    Given I have started an enrollment
    And I am on the organization provider statement page
    And I save the application as a draft
    When I enter my organization provider statement
    And I submit the enrollment
    Then I should have no errors
