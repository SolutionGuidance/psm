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

import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException
import spock.lang.Specification
import spock.lang.Unroll

class ApplicationStatusToPsmNameTest extends Specification {
    private ApplicationStatusToPsmName function

    def setup() {
        function = new ApplicationStatusToPsmName()
    }

    @Unroll
    def "#fhirName maps to #psmName"(fhirName, psmName) {
        expect:
        function.apply(fhirName) == psmName

        where:
        fhirName    | psmName
        "draft"     | "Draft"
        "requested" | "Pending"
        "rejected"  | "Rejected"
        "accepted"  | "Approved"
    }

    @Unroll
    def "Conversion is not case sensitive"(fhirName, psmName) {
        expect:
        function.apply(fhirName) == psmName

        where:
        fhirName    | psmName
        "DRAFT"     | "Draft"
        "Requested" | "Pending"
        "ReJeCtEd"  | "Rejected"
        "accepted"  | "Approved"
    }

    def "Invalid status is rejected"() {
        when:
        function.apply("not a valid status")

        then:
        thrown(InvalidRequestException)
    }
}
