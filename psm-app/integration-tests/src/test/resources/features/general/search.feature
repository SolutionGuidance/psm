@Search
Feature: Provider Search Checks
  Users wish to search or filter applications

  Scenario: Provider Draft Page Filtered
    Given I am logged in as a provider
    And I am on the provider Draft page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Provider Pending Page Filtered
    Given I am logged in as a provider
    And I am on the provider Pending page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Provider Approved Page Filtered
    Given I am logged in as a provider
    And I am on the provider Approved page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Provider Denied Page Filtered
    Given I am logged in as a provider
    And I am on the provider Denied page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Provider Quick Search
    Given I am logged in as a provider
    When I do a quick search for NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Provider Advanced Search
    Given I am logged in as a provider
    And I am on the Advanced Search page
    When I do an advanced search for NPI '1111111112'
    Then I should have no errors
    And I should see search results
