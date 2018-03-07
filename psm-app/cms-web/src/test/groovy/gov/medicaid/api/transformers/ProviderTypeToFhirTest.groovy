package gov.medicaid.api.transformers

import gov.medicaid.domain.model.ApplicantType
import gov.medicaid.entities.ProviderType
import spock.lang.Specification

class ProviderTypeToFhirTest extends Specification {
    def "Transforms provider type to expected structure"() {
        given:
        def transformer = new ProviderTypeToFhir()
        def input = new ProviderType()
        input.setCode("01")
        input.setDescription("Audiologist")
        input.setApplicantType(ApplicantType.INDIVIDUAL)

        when:
        def result = transformer.apply(input)

        then:
        result.type.text == "Provider Type"
        result.value.toString() == "Audiologist"
    }

    def "Throws on null"() {
        given:
        def transformer = new ProviderTypeToFhir()

        when:
        transformer.apply(null)

        then:
        thrown(NullPointerException)
    }
}
