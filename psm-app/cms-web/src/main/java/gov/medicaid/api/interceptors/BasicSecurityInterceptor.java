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

package gov.medicaid.api.interceptors;

import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.exceptions.AuthenticationException;
import ca.uhn.fhir.rest.server.interceptor.InterceptorAdapter;
import com.google.common.annotations.VisibleForTesting;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.RegistrationService;
import org.apache.commons.codec.binary.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.Charset;
import java.util.Map;

public class BasicSecurityInterceptor extends InterceptorAdapter {
    /**
     * Registration Service (used for authentication.)
     */
    private final RegistrationService registrationService;

    public BasicSecurityInterceptor(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * This interceptor implements HTTP Basic Auth, which specifies that
     * a username and password are provided in a header called Authorization.
     */
    @Override
    public boolean incomingRequestPostProcessed(
            RequestDetails theRequestDetails,
            HttpServletRequest theRequest,
            HttpServletResponse theResponse)
            throws AuthenticationException {
        String authHeader = theRequest.getHeader("Authorization");
        String username = getUsernameFromBasicAuthHeader(authHeader);
        String password = getPasswordFromBasicAuthHeader(authHeader);
        if (authenticateUser(username, password)
         && setCurrentUser(theRequestDetails, username)) {
            return true;
        } else {
            throw generateAuthenticationException("Invalid username or password");
        }
    }

    private boolean authenticateUser(String username, String password) {
        try {
            return registrationService.authenticate(username, password);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Register the current CMS user in the request details userdata.
     * Returns false if the user cannot be set.
     *
     * @param theRequestDetails The RequestDetails object to store the user in
     * @param username          The username to be looked up
     */
    private boolean setCurrentUser(
            RequestDetails theRequestDetails,
            String username) {
        try {
            CMSUser currentUser = registrationService.findByUsername(username);
            Map<Object, Object> userData = theRequestDetails.getUserData();
            userData.put("currentUser", currentUser);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @VisibleForTesting
    String getUsernameFromBasicAuthHeader(String authHeader) throws AuthenticationException {
        return decodeBasicAuthHeader(authHeader)[0];
    }

    @VisibleForTesting
    String getPasswordFromBasicAuthHeader(String authHeader) throws AuthenticationException {
        return decodeBasicAuthHeader(authHeader)[1];
    }

    private String[] decodeBasicAuthHeader(String authHeader) throws AuthenticationException {
        if (authHeader == null || authHeader.startsWith("Basic ") == false) {
            throw generateAuthenticationException("Invalid or missing authorization header");
        }
        String base64 = authHeader.substring("Basic ".length());
        String base64decoded = new String(
            Base64.decodeBase64(base64),
            Charset.forName("UTF-8")
        );
        return base64decoded.split(":", 2);
    }

    private AuthenticationException generateAuthenticationException(String message) {
        AuthenticationException exception = new AuthenticationException(message);
        exception.addResponseHeader(
            "WWW-Authenticate",
            "Basic realm=\"PSM\", charset=\"UTF-8\""
        );
        return exception;
    }
}
