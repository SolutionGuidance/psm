package gov.medicaid.api.interceptors

import ca.uhn.fhir.rest.server.exceptions.AuthenticationException
import org.apache.commons.codec.binary.Base64
import spock.lang.Specification
import spock.lang.Unroll

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
    }

    private static String createBasicAuthHeader(
        String username,
        String password
    ) {
        return "Basic " + Base64.encodeBase64String(
            String.format("%s:%s", username, password).getBytes()
        )
    }
}
