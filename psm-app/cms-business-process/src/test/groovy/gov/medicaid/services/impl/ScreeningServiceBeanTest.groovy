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

import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.LeieAutomaticScreening
import spock.lang.Specification

import javax.persistence.EntityGraph
import javax.persistence.EntityManager

class ScreeningServiceBeanTest extends Specification {
    ScreeningServiceBean screeningService
    EntityManager entityManager

    def setup() {
        entityManager = Mock(EntityManager)
        screeningService = new ScreeningServiceBean()
        screeningService.em = entityManager
    }

    def "FindScreening returns empty if not found"() {
        given:
        entityManager.find(_, _) >> null

        when:
        def result = screeningService.findScreening(1)

        then:
        !result.isPresent()
    }

    def "FindScreening returns value if found"() {
        given:
        def screening = new LeieAutomaticScreening()
        entityManager.find(_, _) >> screening

        when:
        def result = screeningService.findScreening(1)

        then:
        result.isPresent()
        result.get() == screening
    }
}
