@providertype
Feature: Admin Provider Types Editing Pages
  Users wish to change provider types

  Scenario: Admin Provider Type Creation
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I create a Provider Type with Description 'Z - TEST PROVIDER TYPE'
    Then I should see a Provider Type with Description 'Z - TEST PROVIDER TYPE'
    And I should have no errors

  Scenario: Admin Provider Type Creation with No Description
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I create a Provider Type with Description ''
    Then I should see a Provider Type Description error 'Please specify a provider type'

  Scenario: Admin Provider Type Creation with Duplicate Description
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I create a Provider Type with Description 'Acupuncturist'
    Then I should see a Provider Type Description error 'Specified provider type already exists'

  Scenario: Admin Provider Type View
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I am on the Functions View Provider Type page for 'Z - TEST PROVIDER TYPE'
    Then I should see a Provider Type with Description 'Z - TEST PROVIDER TYPE'
    And I should have no errors

  Scenario: Admin Provider Type Edit
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I am on the Functions Edit Provider Type page for 'Z - TEST PROVIDER TYPE'
    And I change the Provider Type Description to 'Z2 - TEST PROVIDER TYPE'
    And I add Provider Type Agreements and Licenses
    And I submit the Provider Type Edit
    Then I should see a Provider Type with Description 'Z2 - TEST PROVIDER TYPE'
    And I should have no accessibility issues
    And I should have no errors

  Scenario: Admin Provider Type Delete
    Given I am logged in as an admin
    And I am on the Functions Provider Types page
    And I delete the Provider Type 'Z2 - TEST PROVIDER TYPE'
    Then I should not see a Provider Type with Description 'Z2 - TEST PROVIDER TYPE'
