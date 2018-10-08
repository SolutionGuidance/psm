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

import gov.medicaid.entities.ApplicationStatus
import org.hl7.fhir.dstu3.model.Task
import spock.lang.Specification
import spock.lang.Unroll

class ApplicationStatusToFhirTest extends Specification {
    @Unroll
    def "Transforms status #statusDescription to #expectedTaskStatusCode"(
            String statusCode,
            String statusDescription,
            String expectedTaskStatusCode
    ) {
        given:
        def transformer = new ApplicationStatusToFhir()
        ApplicationStatus input = new ApplicationStatus()
        input.setCode(statusCode)
        input.setDescription(statusDescription)

        when:
        def result = transformer.apply(input)

        then:
        result == Task.TaskStatus.fromCode(expectedTaskStatusCode)

        where:
        statusCode | statusDescription || expectedTaskStatusCode
        "01"       | "Draft"           || "draft"
        "02"       | "Pending"         || "requested"
        "03"       | "Rejected"        || "rejected"
        "04"       | "Approved"        || "accepted"
    }

    def "Transforms null status to null data"() {
        given:
        def transformer = new ApplicationStatusToFhir()

        when:
        def result = transformer.apply(null)

        then:
        result == Task.TaskStatus.NULL
    }
}
