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
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.Organization
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import spock.lang.Specification

class EnrollmentAcceptsEftToFhirTest extends Specification {
    EnrollmentAcceptsEftToFhir transformer
    Enrollment enrollment

    def setup() {
        transformer = new EnrollmentAcceptsEftToFhir()
        enrollment = new Enrollment()
        enrollment.enrollmentId = 123
        enrollment.status = new EnrollmentStatus()
        enrollment.status.description = "Pending"
        enrollment.details = new ProviderProfile()
        enrollment.details.entity = new Person()
        enrollment.details.entity.id = 456
        enrollment.details.entity.providerType = new ProviderType()
        enrollment.details.entity.providerType.description = "Audiologist"
    }

    void addAffiliation(Map args, Enrollment enrollment) {
        def organization = new Organization()
        organization.setEftAccepted(args.eftAccepted)

        def affiliation = new Affiliation()
        affiliation.setEntity(organization)
        if (args.primary) {
            affiliation.setPrimaryInd("Y")
        }

        def affiliations = enrollment.details.getAffiliations()
        if (affiliations == null) {
            affiliations = new ArrayList<Affiliation>()
        }

        affiliations.add(affiliation)
        enrollment.details.setAffiliations(affiliations)
    }

    def "No primary affiliation does not accept EFT"() {
        given:
        addAffiliation(enrollment, eftAccepted: false, primary: false)
        addAffiliation(enrollment, eftAccepted: true, primary: false)

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
        addAffiliation(enrollment, eftAccepted: false, primary: true)

        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == false
    }

    def "Primary affiliation with EFT does accept EFT"() {
        given:
        addAffiliation(enrollment, eftAccepted: true, primary: true)

        when:
        def result = transformer.apply(enrollment)

        then:
        result.value.booleanValue() == true
    }

    def "Primary affiliation with no data on EFT does not accept EFT"() {
        given:
        addAffiliation(enrollment, eftAccepted: null, primary: true)

        when:
        def result = transformer.apply(enrollment)

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
