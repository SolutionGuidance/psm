@reject
Feature: Application Reject Workflow
  Users wish to execute reject workflow functions

  Scenario: Provider Create Individual Workflow Application
    Given I have started an application
    And I am on the individual provider statement page
    And I enter my individual provider statement
    And I submit the application
    Then I should have no errors

  Scenario: Admin Reject Individual Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Reject the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Denied' state
