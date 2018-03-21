package gov.medicaid.api.transformers

import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException
import spock.lang.Specification
import spock.lang.Unroll

class EnrollmentStatusToPsmNameTest extends Specification {
    private EnrollmentStatusToPsmName function

    def setup() {
        function = new EnrollmentStatusToPsmName()
    }

    @Unroll
    def "#fhirName maps to #psmName"(fhirName, psmName) {
        expect:
        function.apply(fhirName) == psmName

        where:
        fhirName    | psmName
        "draft"     | "Draft"
        "requested" | "Pending"
        "rejected"  | "Rejected"
        "accepted"  | "Approved"
    }

    @Unroll
    def "Conversion is not case sensitive"(fhirName, psmName) {
        expect:
        function.apply(fhirName) == psmName

        where:
        fhirName    | psmName
        "DRAFT"     | "Draft"
        "Requested" | "Pending"
        "ReJeCtEd"  | "Rejected"
        "accepted"  | "Approved"
    }

    def "Invalid status is rejected"() {
        when:
        function.apply("not a valid status")

        then:
        thrown(InvalidRequestException)
    }
}
