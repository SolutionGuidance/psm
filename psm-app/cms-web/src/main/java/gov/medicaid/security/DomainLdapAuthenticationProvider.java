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

import gov.medicaid.entities.SystemId;

import org.springframework.security.core.Authentication;
import org.springframework.security.ldap.authentication.LdapAuthenticationProvider;
import org.springframework.security.ldap.authentication.LdapAuthenticator;

import java.util.logging.Logger;

/**
 * LDAP authenticator that only handles the CMS domain requests.
 */
public class DomainLdapAuthenticationProvider extends LdapAuthenticationProvider {

    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Wraps the given authenticator.
     *
     * @param authenticator the authenticator to be used.
     */
    public DomainLdapAuthenticationProvider(LdapAuthenticator authenticator) {
        super(authenticator);
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
            logger.info("Authenticating user via LDAP bind.");
            Authentication authenticate = super.authenticate(authentication);

            if (authenticate.isAuthenticated()) {
                logger.info("Successfully bound user..");
                return authenticate;
            }
        }
        return null;
    }

    /**
     * Returns true for instances of <code>DomainAuthenticationToken</code>.
     * @param authentication the object to test
     * @return true if the object is an instance of DomainAuthenticationToken
     */
    public boolean supports(Class<? extends Object> authentication) {
        return authentication.isAssignableFrom(DomainAuthenticationToken.class);
    }
}
