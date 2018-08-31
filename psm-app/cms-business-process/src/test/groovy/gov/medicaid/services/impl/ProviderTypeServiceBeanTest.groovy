package gov.medicaid.services.impl

import gov.medicaid.entities.AgreementDocument
import gov.medicaid.entities.LicenseType
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.ProviderTypeSearchCriteria
import gov.medicaid.services.LookupService
import spock.lang.Specification

import javax.persistence.EntityGraph
import javax.persistence.EntityManager
import javax.persistence.Query
import javax.persistence.TypedQuery

class ProviderTypeServiceBeanTest extends Specification {
    ProviderTypeServiceBean providerTypeService
    EntityManager entityManager
    EntityGraph entityGraph

    def setup() {
        entityGraph = Mock(EntityGraph)
        entityManager = Mock(EntityManager)
        entityManager.getEntityGraph(_) >> entityGraph
        providerTypeService = new ProviderTypeServiceBean()
        providerTypeService.em = entityManager
    }

    def "Find ProviderType List doesn't use EntityGraph"() {
        when:
        def criteria = new ProviderTypeSearchCriteria()
        criteria.setPageNumber(1)
        criteria.setPageSize(10)
        def query = Mock(Query)
        query.getSingleResult() >> 0
        query.getResultList() >> []
        entityManager.createQuery(_) >> query

        def typedQuery = Mock(TypedQuery)
        typedQuery.getResultList() >> []
        entityManager.createQuery(_, _) >> typedQuery

        def searchResult = providerTypeService.search(criteria)
        def allResult = providerTypeService.getAllProviderTypes()

        then:
        0 * entityManager.getEntityGraph(_)
        searchResult.items.size == 0
        allResult.size == 0
    }

    def "Get ProviderType searches for Agreements/Licenses"() {
        when:
        entityManager.find(_, _, _) >> new ProviderType([code: '00'])
        def pt = providerTypeService.get('00')

        then:
        1 * entityManager.getEntityGraph("ProviderType with AgreementDocuments and LicenseTypes")
        pt.code == '00'
    }

    def "Get ProviderType then update"() {
        given:
        entityManager.find(_, _, _) >> new ProviderType([code: '00'])

        def agreementDocumentQuery = Mock(TypedQuery)
        agreementDocumentQuery.setParameter(_, _) >> agreementDocumentQuery
        agreementDocumentQuery.getResultList() >> [
            new AgreementDocument([id: 1]),
            new AgreementDocument([id: 2])
        ]
        entityManager.createQuery(_, AgreementDocument.class) >> agreementDocumentQuery

        def licenseTypeQuery = Mock(TypedQuery)
        licenseTypeQuery.setParameter(_, _) >> licenseTypeQuery
        licenseTypeQuery.getResultList() >> [
            new LicenseType(),
            new LicenseType(),
            new LicenseType()
        ]
        entityManager.createQuery(_, LicenseType.class) >> licenseTypeQuery

        def countQuery = Mock(Query)
        countQuery.getSingleResult() >> 0
        countQuery.setParameter(_, _) >> countQuery
        entityManager.createQuery(_) >> countQuery

        when:
        def pt = providerTypeService.get('00')
        providerTypeService.updateProviderTypeAgreementSettings(pt, [0, 1] as long[]);
        providerTypeService.updateProviderTypeLicenseSettings(pt, ["0", "1", "2"] as String[]);
        providerTypeService.updateProviderTypeCanDelete(pt);

        then:
        pt.agreementDocuments.size() == 2
        pt.licenseTypes.size() == 3
        pt.canDelete == true
    }

    def "Create ProviderType generates codes"() {
        when:

        def providerTypes = []
        def lookupService = Mock(LookupService)
        providerTypeService.setLookupService(lookupService)
        lookupService.findAllLookups(ProviderType.class) >> providerTypes

        entityManager.persist(_) >> { args -> providerTypes.add(args[0]) }

        providerTypeService.create(new ProviderType())
        providerTypeService.create(new ProviderType())
        providerTypeService.create(new ProviderType())
        providerTypeService.create(new ProviderType())
        def code = providerTypeService.create(new ProviderType())

        then:
        code == 'AE'
    }
}
