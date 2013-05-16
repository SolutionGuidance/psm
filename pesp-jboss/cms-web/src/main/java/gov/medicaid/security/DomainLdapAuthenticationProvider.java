/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.security;

import gov.medicaid.entities.SystemId;

import org.springframework.security.core.Authentication;
import org.springframework.security.ldap.authentication.LdapAuthenticationProvider;
import org.springframework.security.ldap.authentication.LdapAuthenticator;

/**
 * LDAP authenticator that only handles the CMS domain requests.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DomainLdapAuthenticationProvider extends LdapAuthenticationProvider {

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
            return super.authenticate(authentication);
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
