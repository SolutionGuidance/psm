@accessibility
Feature: Admin Functions Tab Pages
  Users wish to access accessible pages

  Scenario: Admin Functions Provider Types Page
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    Then I should have no accessibility issues

  Scenario: Admin Functions View Provider Type Page
    Given I am logged in as an admin
    And I am on the Functions View Provider Type page
    Then I should have no accessibility issues

  Scenario: Admin Functions Edit Provider Type Page
    Given I am logged in as an admin
    And I am on the Functions Edit Provider Type page
    Then I should have no accessibility issues

  Scenario: Admin Functions Screening Schedules Page
    Given I am logged in as an admin
    And I am on the Functions Screening Schedules page
    Then I should have no accessibility issues

  Scenario: Admin Functions Edit Screening Schedule Page
    Given I am logged in as an admin
    And I am on the Functions Edit Screening Schedule page
    Then I should have no accessibility issues

  Scenario: Admin Functions Help Topics Page
    Given I am logged in as an admin
    And I am on the Functions Help Topics page
    Then I should have no accessibility issues

  Scenario: Admin Functions Agreements and Addendums Page
    Given I am logged in as an admin
    And I am on the Functions Agreements and Addendums page
    Then I should have no accessibility issues
