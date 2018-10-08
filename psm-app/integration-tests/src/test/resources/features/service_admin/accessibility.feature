@accessibility
Feature: General Accessibility Checks for Admins
  Users wish to access accessible pages

  # issue #672
  @ignore
  Scenario: Admin Dashboard Page
    Given I am logged in as an admin
    Then I should have no accessibility issues

  # fails: <textarea> form input in the notes modal needs a label
  @ignore
  Scenario: Admin All Applications Page
    Given I am logged in as an admin
    And I am on the admin All Applications page
    And I open the filter panel
    And I open the Write Note modal
    Then I should have no accessibility issues
    And I should see applications

  Scenario: Admin Draft Page
    Given I am logged in as an admin
    And I am on the admin Draft page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see applications

  Scenario: Admin Pending Page
    Given I am logged in as an admin
    And I am on the admin Pending page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see applications

  Scenario: Admin Approved Page
    Given I am logged in as an admin
    And I am on the admin Approved page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see applications

  Scenario: Admin Denied Page
    Given I am logged in as an admin
    And I am on the admin Denied page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see applications

  Scenario: Admin Review Application Page
    Given I am logged in as an admin
    And I am on the Review Application page
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

  # This depends implicitly on the individual application submission tests
  Scenario: Admin Review Application DMF Page - Individual
    Given I am logged in as an admin
    And I am on the Pending page
    And I open the Review Application page for NPI '0000000006'
    And I open the DMF Details page
    Then I should have no accessibility issues

  # This depends implicitly on the group application submission tests
  Scenario: Admin Review Application DMF Page - Group
    Given I am logged in as an admin
    And I am on the Pending page
    And I open the Review Application page for NPI '1234567893'
    And I open the DMF Details page
    Then I should have no accessibility issues
