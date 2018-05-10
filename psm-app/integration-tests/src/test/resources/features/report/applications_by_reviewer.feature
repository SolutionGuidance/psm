Feature: Applications by Reviewer Report
  Users wish to access the Applications by Reviewer report

  Scenario: Can Access Reports Page
    Given I am logged in as an admin
    And I am on the reports page
    Then I should see the reports page

  Scenario: Download Applications by Reviewer CSV
    Given I am logged in as an admin
    And I am on the applications by reviewer page
    And I download the applications by reviewer report
