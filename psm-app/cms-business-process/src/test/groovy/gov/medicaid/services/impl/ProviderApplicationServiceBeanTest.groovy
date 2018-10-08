/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.impl

import gov.medicaid.entities.CMSUser
import gov.medicaid.entities.Document
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.Entity
import gov.medicaid.entities.Note
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.Role
import spock.lang.Specification

import javax.persistence.EntityManager
import javax.persistence.TypedQuery
import javax.persistence.Query

class ProviderEnrollmentServiceBeanTest extends Specification {
    private static final long TICKET_ID = 1
    private static final String PROFILE_QUERY =
            "FROM ProviderProfile p WHERE profileId = :profileId"
    private ProviderEnrollmentServiceBean service
    private EntityManager entityManager
    private CMSUser systemUser

    void setup() {
        service = new ProviderEnrollmentServiceBean()
        entityManager = Mock(EntityManager)
        service.em = entityManager
        systemUser = new CMSUser()
        systemUser.role = new Role()
        systemUser.role.description = "System Administrator"
    }

    def "GetTicketDetails returns null on invalid ID"() {
        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == null
    }

    def "GetTicketDetails returns null on valid ID without profile"() {
        given:
        entityManager.find(Enrollment.class, TICKET_ID) >> new Enrollment()
        entityManager.createQuery(_ as String) >> mockQuery([])

        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == null
    }

    def "GetTicketDetails returns enrollment with profile on valid ID"() {
        given:
        Enrollment enrollment = new Enrollment([profileReferenceId: 0])
        entityManager.find(Enrollment.class, TICKET_ID, _ as Map) >> enrollment
        entityManager.createQuery(PROFILE_QUERY, ProviderProfile.class) >>
                mockTypedQuery([new ProviderProfile()])
        entityManager.createQuery(_ as String) >> mockQuery([])
        entityManager.createQuery(_ as String, Note.class) >> mockTypedQuery([] as List<Note>)
        entityManager.createQuery(_ as String, Entity.class) >> mockTypedQuery([] as List<Entity>)
        entityManager.createQuery(_ as String, Document.class) >> mockTypedQuery([] as List<Document>)

        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == enrollment
    }

    private <T> Query mockQuery(List<T> returnValue) {
        def query = Mock(Query)
        query.getResultList() >> returnValue
        return query
    }

    private <T> Query mockTypedQuery(List<T> returnValue) {
        def query = Mock(TypedQuery)
        query.getResultList() >> returnValue
        return query
    }
}
