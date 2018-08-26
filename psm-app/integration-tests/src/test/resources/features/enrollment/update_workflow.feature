@update
Feature: Enrollment Update Workflow
  Users wish to execute workflow functions

  Scenario: Provider Create Individual Workflow Enrollment
    Given I have started an enrollment
    And I am on the individual provider statement page
    And I enter my individual provider statement
    And I submit the enrollment
    Then I should have no errors

  Scenario: Provider Create Organization Workflow Enrollment
    Given I have started an enrollment
    And I am on the organization provider statement page
    And I enter my organization provider statement
    And I submit the enrollment
    Then I should have no errors

  Scenario: Admin Approve Organizational Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '1234567893'
    And I Approve the Enrollment
    And I view the Reviewed Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state

  Scenario: Admin Approve Individual Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '0000000006'
    And I Approve the Enrollment
    And I view the Reviewed Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state

  Scenario: Provider Update Individual Enrollment
    Given I am logged in as a provider
    And I click on My Profile
    When I update Individual Enrollment '0000000006'
    Then I should have no errors
    And The Enrollment should be in the 'Pending' state

  Scenario: Admin Approve Updated Individual Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '0000000006'
    And I Approve the Enrollment
    And I view the Reviewed Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state

  Scenario: Provider Update Organizational Enrollment
    Given I am logged in as a provider
    And I click on My Profile
    When I update Organizational Enrollment '1234567893'
    Then I should have no errors
    And The Enrollment should be in the 'Pending' state

  Scenario: Admin Approve Updated Organizational Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '1234567893'
    And I Approve the Enrollment
    And I view the Reviewed Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state
