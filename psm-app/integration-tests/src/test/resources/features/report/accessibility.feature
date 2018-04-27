@accessibility
Feature: Accessibility Checks for Report Pages
  Users wish to access accessible pages
    
  Scenario: Reports Page Accessible
    Given I am logged in as an admin
    And I am on the reports page
    Then I should have no accessibility issues

  Scenario: Applications by Reviewer Page
    Given I am logged in as an admin
    And I am on the applications by reviewer page
    Then I should have no accessibility issues

  Scenario: Draft Applications Page
    Given I am logged in as an admin
    And I am on the draft applications page
    Then I should have no accessibility issues
