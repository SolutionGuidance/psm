Feature: Editing and Submitting Applications
  Users wish to edit and submit applications

  @issue_1105
  Scenario: Save as draft twice for Speech Language Pathologist application
    Given I have started an application
    And I am on the individual summary page
    And I save the application as a draft
    And I save the application as a draft
    Then I should have no errors

  @issue_1104
  @ignore
  Scenario: Save as draft twice for Head Start application
    Given I have started an application
    And I am on the organization summary page
    And I save the application as a draft
    And I save the application as a draft
    Then I should have no errors

  @issue_1105
  Scenario: Save and then submit Speech Language Pathologist application
    Given I have started an application
    And I am on the individual provider statement page
    And I save the application as a draft
    When I enter my individual provider statement
    And I submit the application
    Then I should have no errors

  @issue_1105
  Scenario: Save and then submit Head Start application
    Given I have started an application
    And I am on the organization provider statement page
    And I save the application as a draft
    When I enter my organization provider statement
    And I submit the application
    Then I should have no errors

  # Approve the application for the next test.
  Scenario: Admin approve Speech Language Pathologist application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0000000006'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  # Approve the application for the next test.
  Scenario: Admin approve Head Start application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1234567893'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Edit, save, and resubmit approved Speech Language Pathologist application
    Given I am logged in as a provider
    When I edit the Individual Application '0000000006'
    And I save the application as a draft
    And I submit the application
    Then I should have no errors
    And The Application should be in the 'Pending' state

  Scenario: Edit, save, and resubmit approved Head Start application
    Given I am logged in as a provider
    When I edit the Organizational Application '1234567893'
    And I save the application as a draft
    And I submit the application
    Then I should have no errors
    And The Application should be in the 'Pending' state
