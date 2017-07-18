Feature: Log into the Application as Provider
  A provider wishes to gain access to the application so they can enroll to
  receive reimbursements for medicaid patients.

  Scenario: Should Log in
    Given I have the application open in my browser
    And I enter my username and password
    When I click on Login
    Then I should see my dashboard page

