Feature: Create a new enrollment as a provider
  As a provider I wish to create an enrollment to be reimbursed for the
  work I am doing serving Medicaid applicants

  Scenario Outline: Successful Enrollment after filling out the required information
    Given I am logged in as a provider
    And I click on Create a new enrollment to start enrollment
    When I select <individual> as provider type
    Then I will see Personal Information in the title

  Examples: Providers
    | individual                                |
    | Acupuncturist                             |
#    | Allied Dental Professional                |
#    | Audiologist                               |
#    | Certified Mental Health Rehab Prof - CPRP |
#    | Dentist                                   |

