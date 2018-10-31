@update
Feature: Application Update Workflow
  Users wish to execute workflow functions

  Scenario: Provider Create Individual Workflow Application
    Given I have started an application
    And I am on the individual provider statement page
    And I enter my individual provider statement
    And I submit the application
    Then I should have no errors

  Scenario: Provider Create Organization Workflow Application
    Given I have started an application
    And I am on the organization provider statement page
    And I enter my organization provider statement
    And I submit the application
    Then I should have no errors

  Scenario: Provider Edit Pending Individual Application
    Given I am logged in as a provider
    When I update Individual Application '0000000006'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Provider Edit Pending Organizational Application
    Given I am logged in as a provider
    When I update Organizational Application '1234567893'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Admin Approve Organizational Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1234567893'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Admin Approve Individual Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Provider Update Individual Application
    Given I am logged in as a provider
    When I update Individual Application '0000000006'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Admin Approve Updated Individual Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Provider Update Organizational Application
    Given I am logged in as a provider
    When I update Organizational Application '1234567893'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Admin Approve Updated Organizational Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1234567893'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state
