package gov.medicaid.api.transformers

import gov.medicaid.entities.Entity
import gov.medicaid.entities.Organization
import gov.medicaid.entities.Person
import org.hl7.fhir.dstu3.model.Practitioner
import spock.lang.Specification

class EntityToFhirTest extends Specification {
    EntityToFhir transformer
    Person individual
    Organization organization

    def setup() {
        transformer = new EntityToFhir()
        individual = new Person()
        organization = new Organization()
    }

    def "Individual without ID gets ID 0"() {
        when:
        def result = transformer.apply(individual)

        then:
        result.getId() == "#0"
    }

    def "Individual without SSN does not have SSN identifier"() {
        given:
        individual.setNpi("1234567893")

        when:
        def result = transformer.apply(individual) as Practitioner

        then:
        result.getIdentifier().stream().noneMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-ssn"
        })
    }

    def "Individual without NPI does not have NPI identifier"() {
        given:
        individual.setSsn("333224444")

        when:
        def result = transformer.apply(individual) as Practitioner

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
        def result = transformer.apply(individual) as Practitioner

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
        def result = transformer.apply(individual) as Practitioner

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
        def result = transformer.apply(individual) as Practitioner

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
        def result = transformer.apply(individual) as Practitioner

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

    def "Organization without ID gets ID 0"() {
        when:
        def result = transformer.apply(organization)

        then:
        result.getId() == "#0"
    }

    def "Organization has NPI identifier"() {
        given:
        organization.setNpi("1234567893")

        when:
        def result = transformer.apply(organization) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().size() == 1
        result.getIdentifier().first().system == "http://hl7.org/fhir/sid/us-npi"
        result.getIdentifier().first().value == "1234567893"
    }

    def "Organization has FEIN identifier"() {
        given:
        organization.setFein("00-1234567")

        when:
        def result = transformer.apply(organization) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().size() == 1
        result.getIdentifier().first().system == EntityToFhir.EIN_OID
        result.getIdentifier().first().value == "00-1234567"
    }

    def "Organization with NPI and FEIN has both identifiers"() {
        given:
        organization.setNpi("1234567893")
        organization.setFein("00-1234567")

        when:
        def result = transformer.apply(organization) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == "http://hl7.org/fhir/sid/us-npi"
        })
        result.getIdentifier().stream().anyMatch({
            i -> i.getSystem() == EntityToFhir.EIN_OID
        })
        result.getIdentifier().size() == 2
    }

    def "Organization has name"() {
        given:
        organization.setName("Organization Name")

        when:
        def result = transformer.apply(organization) as org.hl7.fhir.dstu3.model.Organization

        then:
        result.getName() == "Organization Name"
    }

    def "Transforming an unexpected class throws"() {
        given:
        Entity entity = new Entity() {}

        when:
        transformer.apply(entity)

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
