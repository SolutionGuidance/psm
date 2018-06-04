@accessibility
Feature: General Accessibility Checks for Admins
  Users wish to access accessible pages

  # issue #672
  @ignore
  Scenario: Admin Dashboard Page
    Given I am logged in as an admin
    Then I should have no accessibility issues

  Scenario: Admin Draft Page
    Given I am logged in as an admin
    And I am on the Draft page
    And I open the filter panel
    Then I should have no accessibility issues

  Scenario: Admin Pending Page
    Given I am logged in as an admin
    And I am on the Pending page
    And I open the filter panel
    Then I should have no accessibility issues

  Scenario: Admin Approved Page
    Given I am logged in as an admin
    And I am on the Approved page
    And I open the filter panel
    Then I should have no accessibility issues

  Scenario: Admin Denied Page
    Given I am logged in as an admin
    And I am on the Denied page
    And I open the filter panel
    Then I should have no accessibility issues

  # fails: duplicate IDs
  @ignore
  Scenario: Admin Notes Page
    Given I am logged in as an admin
    And I am on the Notes page
    And I open the filter panel
    And I open the Write Note modal
    Then I should have no accessibility issues

  # fails: COS input field needs label or title
  @ignore
  Scenario: Admin COS Page
    Given I am logged in as an admin
    And I am on the COS page
    Then I should have no accessibility issues

  # fails: print page is opened in a new window
  @ignore
  Scenario: Admin Print Enrollment Page
    Given I am logged in as an admin
    And I am on the Print Enrollment page
    Then I should have no accessibility issues

  Scenario: Admin Review Enrollment Page
    Given I am logged in as an admin
    And I am on the Review Enrollment page
    Then I should have no accessibility issues

  # fails: page is opened in a separate tab
  @ignore
  Scenario: Admin Screening Log Page
    Given I am logged in as an admin
    And I am on the Screening Log page
    Then I should have no accessibility issues

  Scenario: Admin Screenings Page
    Given I am logged in as an admin
    And I am on the Screenings page
    Then I should have no accessibility issues
