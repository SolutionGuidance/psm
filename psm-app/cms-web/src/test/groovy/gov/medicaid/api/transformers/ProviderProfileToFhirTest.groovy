package gov.medicaid.api.transformers

import gov.medicaid.entities.Entity
import gov.medicaid.entities.Organization
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import org.hl7.fhir.dstu3.model.Practitioner
import spock.lang.Specification

class ProviderProfileToFhirTest extends Specification {
    ProviderProfileToFhir transformer
    Person individual
    ProviderProfile individualProfile
    Organization organization
    ProviderProfile organizationProfile

    def setup() {
        transformer = new ProviderProfileToFhir()
        individual = new Person()
        individualProfile = new ProviderProfile([
            entity: individual
        ])
        organization = new Organization()
        organizationProfile = new ProviderProfile([
            entity: organization
        ])
    }

    def "Individual without ID gets ID 0"() {
        when:
        def result = transformer.apply(individualProfile)

        then:
        result.getId() == "#0"
    }

    def "Individual without SSN does not have SSN identifier"() {
        given:
        individual.setNpi("1234567893")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getIdentifier().stream().noneMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-ssn"
        })
    }

    def "Individual without NPI does not have NPI identifier"() {
        given:
        individual.setSsn("333224444")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getIdentifier().stream().noneMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-npi"
        })
    }

    def "Individual with both NPI and SSN has both identifiers"() {
        given:
        individual.setNpi("1234567893")
        individual.setSsn("333224444")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-npi"
        })
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-ssn"
        })
        result.getIdentifier().size() == 2
    }

    def "Individual's first + last name is transformed correctly"() {
        given:
        individual.setFirstName("First")
        individual.setLastName("Last")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getName().size() == 1
        def name = result.getName().first()

        !name.hasPrefix()

        name.hasGiven()
        name.getGiven().size() == 1
        name.getGiven().first().value == "First"

        name.hasFamily()
        name.getFamily() == "Last"

        !name.hasSuffix()

        !name.hasPeriod()
    }

    def "Individual's first, middle, last name is transformed correctly"() {
        given:
        individual.setFirstName("First")
        individual.setMiddleName("Middle")
        individual.setLastName("Last")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getName().size() == 1
        def name = result.getName().first()

        !name.hasPrefix()

        name.hasGiven()
        name.getGiven().size() == 2
        name.getGiven().first().value == "First"
        name.getGiven().last().value == "Middle"

        name.hasFamily()
        name.getFamily() == "Last"

        !name.hasSuffix()

        !name.hasPeriod()
    }

    def "Individual's full name is transformed correctly"() {
        given:
        individual.setPrefix("Dr.")
        individual.setFirstName("First")
        individual.setMiddleName("Middle")
        individual.setLastName("Last")
        individual.setSuffix("I")

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.getName().size() == 1
        def name = result.getName().first()

        name.hasPrefix()
        name.getPrefix().size() == 1
        name.getPrefix().first().value == "Dr."

        name.hasGiven()
        name.getGiven().size() == 2
        name.getGiven().first().value == "First"
        name.getGiven().last().value == "Middle"

        name.hasFamily()
        name.getFamily() == "Last"

        name.hasSuffix()
        name.getSuffix().size() == 1
        name.getSuffix().first().value == "I"

        !name.hasPeriod()
    }

    def "Individual's date of birth is set correctly"() {
        given:
        individual.setDob(new Date(1985, 6, 25))

        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        result.hasBirthDate()
        result.getBirthDate() == new Date(1985, 6, 25)
    }

    def "Individual's date of birth is not set"() {
        when:
        def result = transformer.apply(individualProfile) as Practitioner

        then:
        !result.hasBirthDate()
    }

    def "Organization without ID gets ID 0"() {
        when:
        def result = transformer.apply(organizationProfile)

        then:
        result.getId() == "#0"
    }

    def "Organization has NPI identifier"() {
        given:
        organization.setNpi("1234567893")

        when:
        def result = transformer.apply(organizationProfile) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().size() == 1
        result.getIdentifier().first().system == "http://hl7.org/fhir/sid/us-npi"
        result.getIdentifier().first().value == "1234567893"
    }

    def "Organization has FEIN identifier"() {
        given:
        organization.setFein("00-1234567")

        when:
        def result = transformer.apply(organizationProfile) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().size() == 1
        result.getIdentifier().first().system == ProviderProfileToFhir.EIN_OID
        result.getIdentifier().first().value == "00-1234567"
    }

    def "Organization with NPI and FEIN has both identifiers"() {
        given:
        organization.setNpi("1234567893")
        organization.setFein("00-1234567")

        when:
        def result = transformer.apply(organizationProfile) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-npi"
        })
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == ProviderProfileToFhir.EIN_OID
        })
        result.getIdentifier().size() == 2
    }

    def "Organization has name"() {
        given:
        organization.setName("Organization Name")

        when:
        def result = transformer.apply(organizationProfile) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getName() == "Organization Name"
    }

    def "Transforming an unexpected class throws"() {
        given:
        ProviderProfile entityProfile = new ProviderProfile([
            entity: new Entity() {}
        ])

        when:
        transformer.apply(entityProfile)

        then:
        thrown(IllegalArgumentException)
    }

    def "Transforming null throws"() {
        when:
        transformer.apply(null)

        then:
        thrown(NullPointerException)
    }
}
