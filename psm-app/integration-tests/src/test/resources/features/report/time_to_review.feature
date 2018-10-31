Feature: Time to Review Report
  Users wish to access the Time to Review report

  Scenario: Can Access Time to Review Page
    Given I am logged in as an admin
    And I am on the time to review page
    Then I should see the time to review page
    Then I should see a time to review row for '2017-05-01' with 2 applications
    Then I should see a N/A time to review row for '2018-01-01'

  Scenario: Download Time to Review CSV
    Given I am logged in as an admin
    And I am on the time to review page
    And I download the time to review report
    Then I should have no errors
