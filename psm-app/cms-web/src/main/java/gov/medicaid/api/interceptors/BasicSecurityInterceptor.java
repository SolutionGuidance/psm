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
        if (authHeader == null || authHeader.startsWith("Basic ") == false) {
            throw generateAuthenticationException("Invalid or missing authorization header");
        }
        String base64 = authHeader.substring("Basic ".length());
        String base64decoded = new String(Base64.decodeBase64(base64));
        String[] parts = base64decoded.split(":", 2);
        return parts[0];
    }

    @VisibleForTesting
    String getPasswordFromBasicAuthHeader(String authHeader) throws AuthenticationException {
        if (authHeader == null || authHeader.startsWith("Basic ") == false) {
            throw generateAuthenticationException("Invalid or missing authorization header");
        }
        String base64 = authHeader.substring("Basic ".length());
        String base64decoded = new String(Base64.decodeBase64(base64));
        String[] parts = base64decoded.split(":", 2);
        return parts[1];
    }

    private AuthenticationException generateAuthenticationException(String message) {
        return (new AuthenticationException(message))
            .addAuthenticateHeaderForRealm("psm");
    }
}
