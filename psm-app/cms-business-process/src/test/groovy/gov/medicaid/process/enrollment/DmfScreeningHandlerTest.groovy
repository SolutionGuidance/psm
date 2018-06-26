package gov.medicaid.process.enrollment

import javax.persistence.EntityManager;

import org.drools.runtime.process.WorkItem
import org.drools.runtime.process.WorkItemManager

import gov.medicaid.domain.model.ApplicantInformationType
import gov.medicaid.domain.model.EnrollmentProcess
import gov.medicaid.domain.model.EnrollmentType
import gov.medicaid.domain.model.IndividualApplicantType
import gov.medicaid.domain.model.ProviderInformationType
import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.Enrollment
import spock.lang.Specification

class DmfScreeningHandlerTest extends Specification {
    DmfScreeningHandler.ExternalDmfService service
    EntityManager entityManager
    DmfScreeningHandler handler

    void setup() {
        service = Mock(DmfScreeningHandler.ExternalDmfService)
        entityManager = Mock(EntityManager)
        handler = new DmfScreeningHandler(service, entityManager)
    }

    def buildMockModel() {
        new EnrollmentProcess([
            enrollment: new EnrollmentType([
                objectId: "1",
                providerInformation: new ProviderInformationType([
                    applicantInformation: new ApplicantInformationType([
                        personalInformation: new IndividualApplicantType([
                            socialSecurityNumber: "123456789"
                        ])
                    ])
                ])
            ])
        ])
    }

    def "Individual enrollment screened - not found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModel()
        1 * entityManager.find(Enrollment.class, 1) >>
                new Enrollment()

        1 * service.getResult("123456789") >>
                '''{
                "ssn": "123456789",
                "full_name": null,
                "dmf_record_present": false
             }'''

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def enrollment = arguments[0]
            assert enrollment.automaticScreenings.size == 1
            assert enrollment.automaticScreenings[0].result == AutomaticScreening.Result.PASS
            assert enrollment.automaticScreenings[0].matches.size() == 1
            assert enrollment.automaticScreenings[0].matches[0].ssn == "123456789"
            assert enrollment.automaticScreenings[0].matches[0].name == null
        }
        workItem.results["model"].enrollment.providerInformation.verificationStatus.notInDmf == "Y"
    }

    def "Individual enrollment screened - found but not in DMF"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModel()
        1 * entityManager.find(Enrollment.class, 1) >>
                new Enrollment()

        1 * service.getResult("123456789") >>
                '''{
                "ssn": "123456789",
                "full_name": "Jane M Smith Jr.",
                "dmf_record_present": false
             }'''

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def enrollment = arguments[0]
            assert enrollment.automaticScreenings.size == 1
            assert enrollment.automaticScreenings[0].result == AutomaticScreening.Result.PASS
            assert enrollment.automaticScreenings[0].matches.size() == 1
            assert enrollment.automaticScreenings[0].matches[0].ssn == "123456789"
            assert enrollment.automaticScreenings[0].matches[0].name == "Jane M Smith Jr."
        }
        workItem.results["model"].enrollment.providerInformation.verificationStatus.notInDmf == "Y"
    }

    def "Individual enrollment screened - found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModel()
        1 * entityManager.find(Enrollment.class, 1) >>
                new Enrollment()

        1 * service.getResult("123456789") >>
                '''{
                "ssn": "123456789",
                "full_name": "Jane M Smith Jr.",
                "dmf_record_present": true
             }'''

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def enrollment = arguments[0]
            assert enrollment.automaticScreenings.size == 1
            assert enrollment.automaticScreenings[0].result == AutomaticScreening.Result.FAIL
            assert enrollment.automaticScreenings[0].matches.size() == 1
            assert enrollment.automaticScreenings[0].matches[0].ssn == "123456789"
        }
        workItem.results["model"].enrollment.providerInformation.verificationStatus.notInDmf == "N"
    }

    def "Individual enrollment screened - error"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModel()
        1 * entityManager.find(Enrollment.class, 1) >>
                new Enrollment()

        1 * service.getResult("123456789") >> { throw new IOException("Testing") }

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def enrollment = arguments[0]
            assert enrollment.automaticScreenings.size == 1
            assert enrollment.automaticScreenings[0].result == AutomaticScreening.Result.ERROR
            assert enrollment.automaticScreenings[0].matches.size() == 0
        }
        workItem.results["model"].enrollment.providerInformation.verificationStatus == null
    }
}
