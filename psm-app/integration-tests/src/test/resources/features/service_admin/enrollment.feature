Feature: Enrollment Functions for Admins
  Users wish to execute functions for Admins

  Scenario: Admin Approve Organizational Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '1234567893'
    And I Approve the Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state

  Scenario: Admin Approve Individual Enrollment
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Enrollment Page for '0000000006'
    And I Approve the Enrollment
    Then I should have no errors
    And The Enrollment should be in the 'Approved' state
