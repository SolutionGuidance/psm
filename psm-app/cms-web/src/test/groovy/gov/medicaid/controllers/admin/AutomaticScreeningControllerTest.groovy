package gov.medicaid.controllers.admin

import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.LeieAutomaticScreening
import gov.medicaid.entities.dto.ViewStatics
import gov.medicaid.services.PortalServiceRuntimeException
import gov.medicaid.services.ScreeningService
import spock.lang.Specification

import java.time.LocalDateTime

class AutomaticScreeningControllerTest extends Specification {
    private static final String NPI = "1234567893"
    private static final LocalDateTime TIMESTAMP = LocalDateTime.now()
    private static final long ENROLLMENT_ID = 1

    AutomaticScreeningController controller
    ScreeningService service

    def setup() {
        service = Mock(ScreeningService)
        controller = new AutomaticScreeningController(service)
    }

    def 'An invalid screening ID throws'() {
        given:
        service.findScreening(_) >> Optional.empty()

        when:
        controller.viewScreening(1)

        then:
        thrown(PortalServiceRuntimeException)
    }

    def 'A non-LEIE screening throws'() {
        given:
        service.findScreening(_) >> Optional.of(new AutomaticScreening() {})

        when:
        controller.viewScreening(1)

        then:
        thrown(PortalServiceRuntimeException)
    }

    def 'An LEIE screening uses the LEIE view'() {
        given:
        'a screening with a pending enrollment'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.viewName == "admin/automatic_screening_leie"
    }

    def 'The model includes the expected attributes'() {
        given:
        'a screening with a pending enrollment'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["screening_result"] == "PASS"
        modelView.model["screening_date"] == TIMESTAMP
        modelView.model["search_term"] == NPI
        modelView.model["exclusions"].size == 0
    }

    def 'A pending enrollment is marked as in review'() {
        given:
        'a screening with a pending enrollment'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["in_review"] == true
    }

    def 'An approved enrollment is marked as not in review'() {
        given:
        'a screening with an approved enrollment'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["in_review"] == false
    }

    void 'a screening with a pending enrollment'() {
        createScreening(ViewStatics.PENDING_STATUS)
    }

    void 'a screening with an approved enrollment'() {
        createScreening(ViewStatics.APPROVED_STATUS)
    }

    void createScreening(String status) {
        def screening = new LeieAutomaticScreening()
        screening.createdAt = TIMESTAMP
        screening.enrollment = new Enrollment()
        screening.enrollment.status = new EnrollmentStatus()
        screening.enrollment.status.description = status
        screening.enrollment.ticketId = ENROLLMENT_ID
        screening.npiSearchTerm = NPI
        screening.result = AutomaticScreening.Result.PASS

        service.findScreening(_) >> Optional.of(screening)
    }
}
