@providertypes
Feature: Applications for different Provider Types
  Users wish to be able to enroll in different provider types

  #issue 968
  @ignore
  Scenario: Personal Care Assistant Application
    Given I am going to enroll as a Personal Care Assistant
    When I create and submit an application using the PCA workflow
    Then I should have no errors

  Scenario: Durable Medical Equipment Application
    Given I am going to enroll as a Durable Medical Equipment provider
    And I am going to use NPI '0762668180'
    When I create and submit an application using the generic organization workflow
    Then I should have no errors

  Scenario: Child and Teen Checkup Clinic Application
    Given I am going to enroll as a Child and Teen Checkup Clinic
    And I am going to use NPI '1747598328'
    When I create and submit an application using the organization with healthboard workflow
    Then I should have no errors

  Scenario: County Contracted Mental Health Rehab Application
    Given I am going to enroll as a County Contracted Mental Health Rehab
    And I am going to use NPI '1906926187'
    When I create and submit an application using the county contracted mental health rehab workflow
    Then I should have no errors

  Scenario: Approve Durable Medical Equipment Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '0762668180'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Approve Child and Teen Checkup Clinic Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1747598328'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state

  Scenario: Approve County Contracted Mental Health Rehab Application
    Given I am logged in as an admin
    And I am on the admin Pending page
    When I am on the Review Application Page for '1906926187'
    And I Approve the Application
    And I view the Reviewed Application
    Then I should have no errors
    And The Application should be in the 'Approved' state
