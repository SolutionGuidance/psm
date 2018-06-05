Feature: Risk Levels Report
  Users wish to access the Risk Levels report

  Scenario: Can Access Risk Levels Page
    Given I am logged in as an admin
    And I am on the risk levels page
    Then I should see the risk levels page
    Then I should see a risk levels row for '2017-05-01' with '2' in the 'Limited' column
    Then I should see a risk levels row for '2017-06-01' with '1' in the 'Moderate' column
    Then I should see a risk levels row for '2018-01-01' with '0' in the 'High' column

  Scenario: Download Risk levels CSV
    Given I am logged in as an admin
    And I am on the risk levels page
    And I download the risk levels report
    Then I should have no errors
