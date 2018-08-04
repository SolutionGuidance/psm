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

package gov.medicaid.api.interceptors

import ca.uhn.fhir.rest.server.exceptions.AuthenticationException
import org.apache.commons.codec.binary.Base64
import spock.lang.Specification
import spock.lang.Unroll

import java.nio.charset.Charset

class BasicSecurityInterceptorTest extends Specification {
    BasicSecurityInterceptor interceptor

    def setup() {
        interceptor = new BasicSecurityInterceptor(null)
    }

    @Unroll
    def "username lookup throws on #bad header"(String bad, String header) {
        when:
        interceptor.getUsernameFromBasicAuthHeader(header)

        then:
        thrown(AuthenticationException)

        where:
        bad         | header
        "null"      | null
        "empty"     | ""
        "non-basic" | "Advanced"
    }

    @Unroll
    def "password lookup throws on #bad header"(String bad, String header) {
        when:
        interceptor.getPasswordFromBasicAuthHeader(header)

        then:
        thrown(AuthenticationException)

        where:
        bad         | header
        "null"      | null
        "empty"     | ""
        "non-basic" | "Advanced"
    }

    @Unroll
    def "valid header for (#username, #password) correctly decodes"(
        String username,
        String password
    ) {
        when:
        def decodedUsername = interceptor.getUsernameFromBasicAuthHeader(
            createBasicAuthHeader(username, password)
        )
        def decodedPassword = interceptor.getPasswordFromBasicAuthHeader(
            createBasicAuthHeader(username, password)
        )

        then:
        decodedUsername == username
        decodedPassword == password

        where:
        username   | password
        "username" | "password"
        "username" | "pass:word"
        "username" | "pass::word"
        "✓"        | "✓"
    }

    private static String createBasicAuthHeader(
        String username,
        String password
    ) {
        return "Basic " + Base64.encodeBase64String(
            String.format("%s:%s", username, password).getBytes(
                Charset.forName("UTF-8")
            )
        )
    }
}
