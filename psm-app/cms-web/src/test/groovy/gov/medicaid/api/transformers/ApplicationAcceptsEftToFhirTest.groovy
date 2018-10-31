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

package gov.medicaid.api.transformers

import gov.medicaid.entities.Affiliation
import gov.medicaid.entities.Application
import gov.medicaid.entities.ApplicationStatus
import gov.medicaid.entities.Organization
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import spock.lang.Specification

class ApplicationAcceptsEftToFhirTest extends Specification {
    ApplicationAcceptsEftToFhir transformer
    Application application

    def setup() {
        transformer = new ApplicationAcceptsEftToFhir()
        application = new Application()
        application.applicationId = 123
        application.status = new ApplicationStatus()
        application.status.description = "Pending"
        application.details = new ProviderProfile()
        application.details.entity = new Person()
        application.details.entity.id = 456
        application.details.entity.providerType = new ProviderType()
        application.details.entity.providerType.description = "Audiologist"
    }

    void addAffiliation(Map args, Application application) {
        def organization = new Organization()
        organization.setEftAccepted(args.eftAccepted)

        def affiliation = new Affiliation()
        affiliation.setEntity(organization)
        if (args.primary) {
            affiliation.setPrimaryInd("Y")
        }

        def affiliations = application.details.getAffiliations()
        if (affiliations == null) {
            affiliations = new ArrayList<Affiliation>()
        }

        affiliations.add(affiliation)
        application.details.setAffiliations(affiliations)
    }

    def "No primary affiliation does not accept EFT"() {
        given:
        addAffiliation(application, eftAccepted: false, primary: false)
        addAffiliation(application, eftAccepted: true, primary: false)

        when:
        def result = transformer.apply(application)

        then:
        result.value.booleanValue() == false
    }

    def "Application without affiliations does not accept EFT"() {
        when:
        def result = transformer.apply(application)

        then:
        result.value.booleanValue() == false
    }

    def "Primary affiliation without EFT does not accept EFT"() {
        given:
        addAffiliation(application, eftAccepted: false, primary: true)

        when:
        def result = transformer.apply(application)

        then:
        result.value.booleanValue() == false
    }

    def "Primary affiliation with EFT does accept EFT"() {
        given:
        addAffiliation(application, eftAccepted: true, primary: true)

        when:
        def result = transformer.apply(application)

        then:
        result.value.booleanValue() == true
    }

    def "Primary affiliation with no data on EFT does not accept EFT"() {
        given:
        addAffiliation(application, eftAccepted: null, primary: true)

        when:
        def result = transformer.apply(application)

        then:
        result.value.booleanValue() == false
    }

    def "Transforming null throws"() {
        when:
        transformer.apply(null)

        then:
        thrown(NullPointerException)
    }
}
