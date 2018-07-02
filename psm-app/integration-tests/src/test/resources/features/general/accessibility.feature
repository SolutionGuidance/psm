@accessibility
Feature: General Accessibility Checks
  Users wish to access accessible pages

  Scenario: Login Page
    Given I have the application open in my browser
    Then I should have no accessibility issues

  Scenario: Register New Account Page
    Given I am on the Register New Account page
    Then I should have no accessibility issues

  Scenario: Forgot Password Page
    Given I am on the Forgot Password page
    Then I should have no accessibility issues

  Scenario: Provider Dashboard Page
    Given I am logged in as a provider
    When I open the filter panel
    Then I should have no accessibility issues

  Scenario: Provider Draft Page
    Given I am logged in as a provider
    And I am on the Draft page
    When I open the filter panel
    Then I should have no accessibility issues

  Scenario: Provider Pending Page
    Given I am logged in as a provider
    And I am on the Pending page
    When I open the filter panel
    Then I should have no accessibility issues

  Scenario: Provider Approved Page
    Given I am logged in as a provider
    And I am on the Approved page
    When I open the filter panel
    Then I should have no accessibility issues

  Scenario: Provider Denied Page
    Given I am logged in as a provider
    And I am on the Denied page
    When I open the filter panel
    Then I should have no accessibility issues

  Scenario: My Profile Page
    Given I am logged in as a provider
    When I click on My Profile
    Then I should have no accessibility issues

  Scenario: Update Password Page
    Given I am logged in as a provider
    And I am on the Update Password page
    Then I should have no accessibility issues

  Scenario: Account Setup Page
    Given I am logged in as a provider
    And I am on the Account Setup page
    Then I should have no accessibility issues

  Scenario: Advanced Search Page
    Given I am logged in as a provider
    And I am on the Advanced Search page
    Then I should have no accessibility issues
