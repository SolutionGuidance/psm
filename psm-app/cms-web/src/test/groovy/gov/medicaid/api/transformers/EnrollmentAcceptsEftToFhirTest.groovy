package gov.medicaid.api.transformers

import gov.medicaid.entities.Affiliation
import gov.medicaid.entities.Entity
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.Organization
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import org.hl7.fhir.dstu3.model.Practitioner
import spock.lang.Specification
import java.util.ArrayList;

class EnrollmentAcceptsEftToFhirTest extends Specification {
    EnrollmentAcceptsEftToFhir transformer
    Enrollment enrollment

    def setup() {
        transformer = new EnrollmentAcceptsEftToFhir()
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

    def addAffiliationToEnrollment(Enrollment enrollment, boolean eftAccepted, boolean isPrimary) {
      def organization = new Organization()
      organization.setEftAccepted(eftAccepted)

      def affiliation = new Affiliation()
      affiliation.setEntity(organization)
      if (isPrimary) {
        affiliation.setPrimaryInd("Y")
      }

      def affiliations = enrollment.details.getAffiliations()
      if (affiliations == null) {
        affiliations = new ArrayList<Affiliation>()
      }

      affiliations.add(affiliation)
      enrollment.details.setAffiliations(affiliations)
      return enrollment
    }

    def "No primary affiliation does not accept EFT"() {
        given:
        enrollment = addAffiliationToEnrollment(enrollment, false, false)
        enrollment = addAffiliationToEnrollment(enrollment, true, false)

        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == false
    }

    def "Enrollment without affiliations does not accept EFT"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == false
    }

    def "Primary affiliation without EFT does not accept EFT"() {
        given:
        enrollment = addAffiliationToEnrollment(enrollment, false, true)

        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == false
    }

    def "Primary affiliation with EFT does accept EFT"() {
        given:
        enrollment = addAffiliationToEnrollment(enrollment, true, true)

        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == true
    }

    def "Transforming null throws"() {
        when:
        transformer.apply(null)

        then:
        thrown(NullPointerException)
    }
}
