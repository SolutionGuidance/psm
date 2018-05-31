Feature: Reviewed Documents Report
  Users wish to access the Reviewed Documents report

  Scenario: Can Access Reviewed Documents Page
    Given I am logged in as an admin
    And I am on the reviewed documents page
    Then I should see the reviewed documents page
    Then I should see a reviewed documents row for '2017-05-01' with '2' documents
    Then I should see a reviewed documents row for '2018-01-01' with '0' documents

  Scenario: Download Reviewed Documents CSV
    Given I am logged in as an admin
    And I am on the reviewed documents page
    And I download the reviewed documents report
    Then I should have no errors
