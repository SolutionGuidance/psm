@accessibility
Feature: General Accessibility Checks for Admins
  Users wish to access accessible pages

  # issue #672
  @ignore
  Scenario: Admin Dashboard Page
    Given I am logged in as an admin
    Then I should have no accessibility issues
