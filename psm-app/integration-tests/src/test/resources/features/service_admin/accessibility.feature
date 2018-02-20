@accessibility
Feature: General Accessibility Checks for Admins
  Users wish to access accessible pages

  # issue #672
  @ignore
  Scenario: Admin Dashboard Page
    Given I am logged in as an admin
    Then I should have no accessibility issues

  # issue #672
  @ignore
  Scenario: Admin Draft Page
    Given I am logged in as an admin
    And I am on the Draft page
    And I open the filter panel
    Then I should have no accessibility issues

  # issue #672
  @ignore
  Scenario: Admin Pending Page
    Given I am logged in as an admin
    And I am on the Pending page
    And I open the filter panel
    Then I should have no accessibility issues

  # issue #672
  @ignore
  Scenario: Admin Approved Page
    Given I am logged in as an admin
    And I am on the Approved page
    And I open the filter panel
    Then I should have no accessibility issues

  # issue #672
  @ignore
  Scenario: Admin Denied Page
    Given I am logged in as an admin
    And I am on the Denied page
    And I open the filter panel
    Then I should have no accessibility issues

  # fails: duplicate IDs and issue #672
  @ignore
  Scenario: Admin Notes Page
    Given I am logged in as an admin
    And I am on the Notes page
    And I open the filter panel
    Then I should have no accessibility issues
