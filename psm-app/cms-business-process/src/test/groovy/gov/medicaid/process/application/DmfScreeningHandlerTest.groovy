package gov.medicaid.process.application

import javax.persistence.EntityManager;

import org.drools.runtime.process.WorkItem
import org.drools.runtime.process.WorkItemManager

import gov.medicaid.domain.model.ApplicantInformationType
import gov.medicaid.domain.model.BeneficialOwnerType
import gov.medicaid.domain.model.DesignatedContactType
import gov.medicaid.domain.model.DesignatedContactInformationType
import gov.medicaid.domain.model.ApplicationProcess
import gov.medicaid.domain.model.ApplicationType
import gov.medicaid.domain.model.GroupMemberType
import gov.medicaid.domain.model.IndividualApplicantType
import gov.medicaid.domain.model.MemberInformationType
import gov.medicaid.domain.model.OwnershipInformationType
import gov.medicaid.domain.model.PersonType
import gov.medicaid.domain.model.ProviderInformationType
import gov.medicaid.domain.model.QualifiedProfessionalType
import gov.medicaid.domain.model.QualifiedProfessionalsType
import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.Application
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

    def buildMockModelForIndividual() {
        new ApplicationProcess([
            application: new ApplicationType([
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

    // This organization structure is complete for testing purposes
    // but actually can't exist via the normal workflow
    def buildMockModelForOrganization() {
        new ApplicationProcess([
            application: new ApplicationType([
                objectId: "1",
                providerInformation: new ProviderInformationType([
                    qualifiedProfessionals: new QualifiedProfessionalsType([
                        qualifiedProfessional: [
                            new QualifiedProfessionalType([socialSecurityNumber: "123456789"]),
                            new QualifiedProfessionalType([socialSecurityNumber: "223456789"])
                        ]
                    ]),
                    designatedContactInformation: new DesignatedContactInformationType([
                        designatedContact: [
                            new DesignatedContactType([socialSecurityNumber: "323456789"]),
                            new DesignatedContactType([socialSecurityNumber: "223456789"])  // duplicate SSN purposeful
                        ]
                    ]),
                    memberInformation: new MemberInformationType([
                        groupMember: [
                            new GroupMemberType([socialSecurityNumber: "423456789"]),
                            new GroupMemberType([socialSecurityNumber: "523456789"])
                        ]
                    ]),
                    ownershipInformation: new OwnershipInformationType([
                        beneficialOwner: [
                            new BeneficialOwnerType([
                                personInformation: new PersonType([
                                    socialSecurityNumber: "623456789"
                                ])
                            ])
                        ]
                    ])
                ])
            ])
        ])
    }

    def notFoundResult(ssn) {
        """{
               "ssn": "$ssn",
               "full_name": null,
               "dmf_record_present": false
           }"""
    }

    def foundResult(ssn) {
        """{
               "ssn": "$ssn",
               "full_name": "Jane M Smith Jr.",
               "dmf_record_present": true
           }"""
    }

    def "Individual application screened - not found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForIndividual()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> notFoundResult("123456789")

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.PASS
            assert application.automaticScreenings[0].matches.size() == 1
            assert application.automaticScreenings[0].matches[0].ssn == "123456789"
            assert application.automaticScreenings[0].matches[0].name == null
        }
        workItem.results["model"].application.providerInformation.verificationStatus.notInDmf == "Y"
    }

    def "Individual application screened - found but not in DMF"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForIndividual()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >>
                '''{
                "ssn": "123456789",
                "full_name": "Jane M Smith Jr.",
                "dmf_record_present": false
             }'''

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.PASS
            assert application.automaticScreenings[0].matches.size() == 1
            assert application.automaticScreenings[0].matches[0].ssn == "123456789"
            assert application.automaticScreenings[0].matches[0].name == "Jane M Smith Jr."
        }
        workItem.results["model"].application.providerInformation.verificationStatus.notInDmf == "Y"
    }

    def "Individual application screened - found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForIndividual()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> foundResult("123456789")

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.FAIL
            assert application.automaticScreenings[0].matches.size() == 1
            assert application.automaticScreenings[0].matches[0].ssn == "123456789"
        }
        workItem.results["model"].application.providerInformation.verificationStatus.notInDmf == "N"
    }

    def "Individual application screened - error"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForIndividual()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> { throw new IOException("Testing") }

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.ERROR
            assert application.automaticScreenings[0].matches.size() == 0
        }
        workItem.results["model"].application.providerInformation.verificationStatus == null
    }

    def "Group application screened - not found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForOrganization()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> notFoundResult("123456789")
        1 * service.getResult("223456789") >> notFoundResult("223456789")
        1 * service.getResult("323456789") >> notFoundResult("323456789")
        1 * service.getResult("423456789") >> notFoundResult("423456789")
        1 * service.getResult("523456789") >> notFoundResult("523456789")
        1 * service.getResult("623456789") >> notFoundResult("623456789")

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.PASS
            assert application.automaticScreenings[0].matches.size() == 6
            assert application.automaticScreenings[0].matches[0].ssn == "123456789"
            assert application.automaticScreenings[0].matches[1].ssn == "223456789"
            assert application.automaticScreenings[0].matches[2].ssn == "323456789"
            assert application.automaticScreenings[0].matches[3].ssn == "423456789"
            assert application.automaticScreenings[0].matches[4].ssn == "523456789"
            assert application.automaticScreenings[0].matches[5].ssn == "623456789"
        }
        workItem.results["model"].application.providerInformation.verificationStatus.notInDmf == "Y"
    }

    def "Group application screened - two found"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForOrganization()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> notFoundResult("123456789")
        1 * service.getResult("223456789") >> notFoundResult("223456789")
        1 * service.getResult("323456789") >> foundResult("323456789")
        1 * service.getResult("423456789") >> notFoundResult("423456789")
        1 * service.getResult("523456789") >> foundResult("523456789")
        1 * service.getResult("623456789") >> notFoundResult("623456789")

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.FAIL
            assert application.automaticScreenings[0].matches.size() == 6
            assert application.automaticScreenings[0].matches[0].ssn == "123456789"
            assert application.automaticScreenings[0].matches[1].ssn == "223456789"
            assert application.automaticScreenings[0].matches[2].ssn == "323456789"
            assert application.automaticScreenings[0].matches[3].ssn == "423456789"
            assert application.automaticScreenings[0].matches[4].ssn == "523456789"
            assert application.automaticScreenings[0].matches[5].ssn == "623456789"
        }
        workItem.results["model"].application.providerInformation.verificationStatus.notInDmf == "N"
    }

    def "Group application screened - error"() {
        given:

        def workItem = Mock(WorkItem)
        def results = new HashMap()

        workItem.results >> results

        when:
        workItem.getParameter("model") >> buildMockModelForOrganization()
        1 * entityManager.find(Application.class, 1) >>
                new Application()

        1 * service.getResult("123456789") >> notFoundResult("123456789")
        1 * service.getResult("223456789") >> notFoundResult("223456789")
        1 * service.getResult("323456789") >> foundResult("323456789")
        1 * service.getResult("423456789") >> notFoundResult("423456789")
        1 * service.getResult("523456789") >> { throw new IOException("Testing") }
        0 * service.getResult("623456789") >> notFoundResult("623456789") // To ensure it got shored by error

        handler.executeWorkItem(workItem, Mock(WorkItemManager))

        then:

        1 * entityManager.merge(*_) >> { arguments ->
            def application = arguments[0]
            assert application.automaticScreenings.size == 1
            assert application.automaticScreenings[0].result == AutomaticScreening.Result.ERROR
            assert application.automaticScreenings[0].matches.size() == 0
        }
        workItem.results["model"].application.providerInformation.verificationStatus == null
    }
}
