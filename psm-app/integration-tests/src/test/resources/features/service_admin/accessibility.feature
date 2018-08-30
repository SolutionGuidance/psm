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
  Scenario: Admin All Enrollments Page
    Given I am logged in as an admin
    And I am on the admin All Enrollments page
    And I open the filter panel
    And I open the Write Note modal
    Then I should have no accessibility issues
    And I should see enrollments

  Scenario: Admin Draft Page
    Given I am logged in as an admin
    And I am on the admin Draft page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see enrollments

  Scenario: Admin Pending Page
    Given I am logged in as an admin
    And I am on the admin Pending page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see enrollments

  Scenario: Admin Approved Page
    Given I am logged in as an admin
    And I am on the admin Approved page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see enrollments

  Scenario: Admin Denied Page
    Given I am logged in as an admin
    And I am on the admin Denied page
    And I open the filter panel
    Then I should have no accessibility issues
    And I should see enrollments

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

  # This depends implicitly on the individual enrollment submission tests
  Scenario: Admin Review Enrollment DMF Page
    Given I am logged in as an admin
    And I am on the Pending page
    And I open the Review Enrollment page for NPI '0000000006'
    And I open the DMF Details page
    Then I should have no accessibility issues
