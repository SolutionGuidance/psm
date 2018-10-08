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

import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import org.hl7.fhir.dstu3.model.Task
import org.hl7.fhir.dstu3.model.Task.ParameterComponent
import spock.lang.Specification

class EnrollmentToFhirTest extends Specification {
    EnrollmentToFhir transformer
    Enrollment enrollment

    def getInputByType(inputs, name) {
        for (ParameterComponent input : inputs) {
            if (input.getType().getText() == name)
                return input;
        }
        return null;
    }

    def setup() {
        transformer = new EnrollmentToFhir()

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

    def "Entity is included as a contained resource"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasContained()
        result.getContained().size() == 1
        result.getContained().first().id == "#456"
    }

    def "Status is set"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasStatus()
        result.getStatus() == Task.TaskStatus.REQUESTED
    }

    def "Intent is set"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasIntent()
        result.getIntent() == Task.TaskIntent.PROPOSAL
    }

    def "Provider type is set as input"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasInput()
        def input = getInputByType(result.input, "Provider Type")
        input.value.toString() == "Audiologist"
    }

    def "Accepts EFT is set as input"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasInput()
        def input = getInputByType(result.input, "Accepts EFT")
        input.value.booleanValue() == false
    }

    def "Enrollment ID is set as identifier"() {
        when:
        def result = transformer.apply(enrollment)

        then:
        result.hasId()
        result.getId() == "123"
    }
}
