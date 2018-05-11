Feature: Base Reports
  Users wish to access the reports page

  Scenario: Can Access Reports Page
    Given I am logged in as an admin
    And I am on the reports page
    Then I should see the reports page
