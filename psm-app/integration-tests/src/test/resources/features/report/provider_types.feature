Feature: Provider Types Report
  Users wish to access the Provider Types report

  Scenario: Can Access Provider Types Page
    Given I am logged in as an admin
    And I am on the provider types page
    Then I should see the provider types page
    Then I should see a provider types table with '2' applications for 'Licensed Professional Clinical Counselor' in month '2017-05-01'
    Then I should see no results for month '2018-01-01'

  Scenario: Can Filter Provider Types Page
    Given I am logged in as an admin
    And I am on the provider types page
    And I select the provider type 'Speech Language Pathologist'
    And I select the provider type 'Licensed Professional Clinical Counselor'
    And I filter for provider types
    Then I should see the provider types page
    Then I should see provider type 'Speech Language Pathologist' selected
    Then I should see a provider types table with '2' applications for 'Licensed Professional Clinical Counselor' in month '2017-05-01'
    Then I should see no results for month '2017-07-01'

  Scenario: Download Provider Types CSV
    Given I am logged in as an admin
    And I am on the provider types page
    And I download the provider types report
    Then I should have no errors
