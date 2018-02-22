@accessibility
Feature: Admin Functions Tab Pages
  Users wish to access accessible pages

  Scenario: Admin Functions Provider Types Page
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    Then I should have no accessibility issues
