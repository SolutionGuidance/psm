/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.security;

import gov.medicaid.controllers.dto.CMSUserDetailsWrapper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.logging.Logger;

/**
 * Database authenticator that only handles the CMS domain requests.
 */
public class DomainDatabaseAuthenticationProvider implements AuthenticationProvider {

    /**
     * Empty roles.
     */
    private static final ArrayList<GrantedAuthority> EMPTY_AUTH = new ArrayList<GrantedAuthority>();

    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * The identity provider.
     */
    private RegistrationService registrationService;

    /**
     * Creates a new provider.
     */
    public DomainDatabaseAuthenticationProvider() {
    }

    /**
     * Simply allows the superclass logic, but only if the domain is CMS.
     *
     * @param authentication the authentication object
     * @return the processed object
     */
    public Authentication authenticate(Authentication authentication) {
        final DomainAuthenticationToken userToken = (DomainAuthenticationToken) authentication;
        if (SystemId.valueOf(userToken.getDomain()) == SystemId.CMS_ONLINE) {
            final String username = userToken.getName();
            final String password = (String) authentication.getCredentials();
            try {
                logger.info("Attempting database authentication...");
                boolean valid = registrationService.authenticate(username, password);
                if (valid) {
                    logger.info("Internal user found, loading credentials...");
                    return createSuccessfulAuthentication(userToken, loadUserByUsername(username));
                }
                logger.info("User not authenticated, will fallback to next authentication method");
            } catch (PortalServiceException e) {
                return null;
            }
        }
        return null;
    }

    /**
     * Creates the final <tt>Authentication</tt> object which will be returned from the <tt>authenticate</tt> method.
     *
     * @param authentication the original authentication request token
     * @param user the <tt>UserDetails</tt> instance returned by the configured <tt>UserDetailsContextMapper</tt>.
     * @return the Authentication object for the fully authenticated user.
     */
    private Authentication createSuccessfulAuthentication(UsernamePasswordAuthenticationToken authentication,
        UserDetails user) {
        Object password = authentication.getCredentials();
        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user, password,
            user.getAuthorities());
        result.setDetails(user);
        return result;
    }

    /**
     * Loads the user into a principal.
     *
     * @param userId the user id
     * @return the user principal
     */
    public UserDetails loadUserByUsername(String userId) {
        CMSUser cmsUser = registrationService.findByUsername(userId);
        if (cmsUser == null) {
            return null;
        }

        // we do not remembering external users
        if (cmsUser.getUsername() == null) {
            return null;
        }

        User user = new User(cmsUser.getUsername(), "", true, true, true, true, EMPTY_AUTH);
        return new CMSUserDetailsWrapper(user, cmsUser, SystemId.CMS_ONLINE);
    }

    /**
     * Returns true for instances of <code>DomainAuthenticationToken</code>.
     * @param authentication the object to test
     * @return true if the object is an instance of DomainAuthenticationToken
     */
    public boolean supports(Class<? extends Object> authentication) {
        return authentication.isAssignableFrom(DomainAuthenticationToken.class);
    }

    /**
     * Gets the value of the field <code>registrationService</code>.
     * @return the registrationService
     */
    public RegistrationService getRegistrationService() {
        return registrationService;
    }

    /**
     * Sets the value of the field <code>registrationService</code>.
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }
}
