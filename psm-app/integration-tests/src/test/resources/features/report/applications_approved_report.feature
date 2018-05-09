Feature: Applications Approved and Denied
  Users wish to access the enrollment approval report

  Scenario: Can Access Reports
    Given I am logged in as an admin
    And I am on the reports page
    Then I should see the reports page

  Scenario: Applications Approved and Denied Download
    Given I am logged in as an admin
    And I am on the reports page
    And I download the approval report
