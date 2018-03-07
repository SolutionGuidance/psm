package gov.medicaid.api.transformers

import gov.medicaid.entities.EnrollmentStatus
import org.hl7.fhir.dstu3.model.Task
import spock.lang.Specification
import spock.lang.Unroll

class EnrollmentStatusToFhirTest extends Specification {
    @Unroll
    def "Transforms status #statusDescription to #expectedTaskStatusCode"(
            String statusCode,
            String statusDescription,
            String expectedTaskStatusCode
    ) {
        given:
        def transformer = new EnrollmentStatusToFhir()
        EnrollmentStatus input = new EnrollmentStatus()
        input.setCode(statusCode)
        input.setDescription(statusDescription)

        when:
        def result = transformer.apply(input)

        then:
        result == Task.TaskStatus.fromCode(expectedTaskStatusCode)

        where:
        statusCode | statusDescription || expectedTaskStatusCode
        "01"       | "Draft"           || "draft"
        "02"       | "Pending"         || "requested"
        "03"       | "Rejected"        || "rejected"
        "04"       | "Approved"        || "accepted"
    }

    def "Transforms null status to null data"() {
        given:
        def transformer = new EnrollmentStatusToFhir()

        when:
        def result = transformer.apply(null)

        then:
        result == Task.TaskStatus.NULL
    }
}
