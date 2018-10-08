Feature: Application Renew Workflow
  Users wish to execute workflow functions

  Scenario: Provider Create Individual Workflow Application For Review
    Given I have started an application
    And I am on the individual provider statement page
    And I enter my individual provider statement
    And I submit the application
    Then I should have no errors

  Scenario: Provider Create Organization Workflow Application For Review
    Given I have started an application
    And I am on the organization provider statement page
    And I enter my organization provider statement
    And I submit the application
    Then I should have no errors

  Scenario: Admin Approve Organizational Application For Review
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1234567893'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Admin Approve Individual Application For Review
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Provider Renew Individual Application
    Given I am logged in as a provider
    When I renew Individual Application '0000000006'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Admin Approve Individual Reviewed Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Provider Renew Organizational Application
    Given I am logged in as a provider
    When I renew Organizational Application '1234567893'
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Admin Approve Organizational Reviewed Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1234567893'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Provider Renew, Save, and Submit Individual Application
    Given I am logged in as a provider
    When I start to renew Individual Application '0000000006'
    And I save the application as a draft
    And I enter my individual provider statement
    And I submit the application
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Provider Renew, Save, and Submit Organizational Application
    Given I am logged in as a provider
    When I start to renew Organizational Application '1234567893'
    And I save the application as a draft
    And I enter my organization provider statement
    And I submit the application
    Then I should have no errors
    And The Application should be in the 'Pending' state
