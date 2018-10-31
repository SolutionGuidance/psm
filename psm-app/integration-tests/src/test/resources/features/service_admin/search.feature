@Search
Feature: Admin Search Checks
  Users wish to search or filter applications

  # Issue 914
  @ignore
  Scenario: Admin All Applications Page Filtered
    Given I am logged in as an admin
    And I am on the admin All Applications page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  # Issue 914
  @ignore
  Scenario: Admin Draft Page Filtered
    Given I am logged in as an admin
    And I am on the admin Draft page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  # Issue 914
  @ignore
  Scenario: Admin Pending Page Filtered
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  # Issue 914
  @ignore
  Scenario: Admin Approved Page Filtered
    Given I am logged in as an admin
    And I am on the admin Approved page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  # Issue 914
  @ignore
  Scenario: Admin Denied Page Filtered
    Given I am logged in as an admin
    And I am on the admin Denied page
    When I open the filter panel
    And I filter by NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Admin Quick Search
    Given I am logged in as an admin
    When I do a quick search for NPI '1111111112'
    Then I should have no errors
    And I should see search results

  Scenario: Admin Advanced Search
    Given I am logged in as an admin
    And I am on the Advanced Search page
    When I do an advanced search for NPI '1111111112'
    Then I should have no errors
    And I should see search results
