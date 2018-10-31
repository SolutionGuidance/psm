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

package gov.medicaid.controllers.admin

import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.Application
import gov.medicaid.entities.ApplicationStatus
import gov.medicaid.entities.LeieAutomaticScreening
import gov.medicaid.entities.dto.ViewStatics
import gov.medicaid.services.PortalServiceRuntimeException
import gov.medicaid.services.ProviderApplicationService
import gov.medicaid.services.ScreeningService
import spock.lang.Specification

import java.time.LocalDateTime

class AutomaticScreeningControllerTest extends Specification {
    private static final String NPI = "1234567893"
    private static final LocalDateTime TIMESTAMP = LocalDateTime.now()
    private static final long APPLICATION_ID = 1

    AutomaticScreeningController controller
    ScreeningService screeningService
    ProviderApplicationService providerApplicationService

    def setup() {
        screeningService = Mock(ScreeningService)
        providerApplicationService = Mock(ProviderApplicationService)
        controller = new AutomaticScreeningController(
                screeningService,
                providerApplicationService
        )
    }

    def 'An invalid screening ID throws'() {
        given:
        screeningService.findScreening(_) >> Optional.empty()

        when:
        controller.viewScreening(1)

        then:
        thrown(PortalServiceRuntimeException)
    }

    def 'A non-LEIE screening throws'() {
        given:
        screeningService.findScreening(_) >> Optional.of(new AutomaticScreening() {
            String getType() { return "" }
        })

        when:
        controller.viewScreening(1)

        then:
        thrown(PortalServiceRuntimeException)
    }

    def 'An LEIE screening uses the LEIE view'() {
        given:
        'a screening with a pending application'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.viewName == "admin/automatic_screening_leie"
    }

    def 'The model includes the expected attributes'() {
        given:
        'a screening with a pending application'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["screening_result"] == "PASS"
        modelView.model["screening_date"] == TIMESTAMP
        modelView.model["search_term"] == NPI
        modelView.model["exclusions"].size() == 0
    }

    def 'A pending application is marked as in review'() {
        given:
        'a screening with a pending application'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["in_review"] == true
    }

    def 'An approved application is marked as not in review'() {
        given:
        'a screening with an approved application'()

        when:
        def modelView = controller.viewScreening(1)

        then:
        modelView.model["in_review"] == false
    }

    void 'a screening with a pending application'() {
        createScreening(ViewStatics.PENDING_STATUS)
    }

    void 'a screening with an approved application'() {
        createScreening(ViewStatics.APPROVED_STATUS)
    }

    void createScreening(String status) {
        def screening = new LeieAutomaticScreening()
        screening.createdAt = TIMESTAMP
        screening.application = new Application()
        screening.application.status = new ApplicationStatus()
        screening.application.status.description = status
        screening.application.applicationId = APPLICATION_ID
        screening.npiSearchTerm = NPI
        screening.result = AutomaticScreening.Result.PASS

        screeningService.findScreening(_) >> Optional.of(screening)
    }
}
