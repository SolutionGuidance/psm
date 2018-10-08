@reject
Feature: Enrollment Reject Workflow
  Users wish to execute reject workflow functions

  Scenario: Provider Create Individual Workflow Enrollment
    Given I have started an enrollment
    And I am on the individual provider statement page
    And I enter my individual provider statement
    And I submit the enrollment
    Then I should have no errors

  Scenario: Admin Reject Individual Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '0000000006'
    And I Reject the Enrollment
    And I view the Reviewed Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Denied' state
