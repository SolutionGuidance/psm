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

  Scenario: Applications by Reviewer Page with No Results
    Given I am logged in as an admin
    And I am on the applications by reviewer page
    And I search for applications by reviewer between '01/01/2001' and '01/02/2001'
    Then I should have no accessibility issues

  Scenario: Applications by Reviewer Page with Results
    Given I am logged in as an admin
    And I am on the applications by reviewer page
    And I search for applications by reviewer between '01/01/2017' and '12/01/2017'
    Then I should have no accessibility issues

  Scenario: Draft Applications Page
    Given I am logged in as an admin
    And I am on the draft applications page
    Then I should have no accessibility issues

  Scenario: Time to Review Page
    Given I am logged in as an admin
    And I am on the time to review page
    Then I should have no accessibility issues

  Scenario: Provider Types Page
    Given I am logged in as an admin
    And I am on the provider types page
    Then I should have no accessibility issues

  Scenario: Reviewed Documents Page
    Given I am logged in as an admin
    And I am on the reviewed documents page
    Then I should have no accessibility issues

  Scenario: Risk Levels Page
    Given I am logged in as an admin
    And I am on the risk levels page
    Then I should have no accessibility issues
