package gov.medicaid.api.transformers

import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import org.hl7.fhir.dstu3.model.Task
import spock.lang.Specification

class EnrollmentToFhirTest extends Specification {
    EnrollmentToFhir transformer
    Enrollment enrollment

    def setup() {
        transformer = new EnrollmentToFhir()

        enrollment = new Enrollment()
        enrollment.ticketId = 123
        enrollment.status = new EnrollmentStatus()
        enrollment.status.description = "Pending"
        enrollment.details = new ProviderProfile()
        enrollment.details.entity = new Person()
        enrollment.details.entity.id = 456
        enrollment.details.entity.providerType = new ProviderType()
        enrollment.details.entity.providerType.description = "Audiologist"
    }

    def "Entity is included as a contained resource"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasContained()
        result.getContained().size() == 1
        result.getContained().first().id == "#456"
    }

    def "Status is set"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasStatus()
        result.getStatus() == Task.TaskStatus.REQUESTED
    }

    def "Intent is set"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasIntent()
        result.getIntent() == Task.TaskIntent.PROPOSAL
    }

    def "Provider type is set as input"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasInput()
        result.input.size() == 1
        result.input.first().value.toString() == "Audiologist"
    }

    def "Enrollment ID is set as identifier"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasIdentifier()
        result.identifier.size() == 1
        result.identifier.first().value == "123"
    }
}
