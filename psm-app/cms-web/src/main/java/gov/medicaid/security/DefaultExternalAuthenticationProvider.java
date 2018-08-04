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
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.RoleView;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.PartnerSystemService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import javax.annotation.PostConstruct;

import java.util.ArrayList;

/**
 * Mock authentication provider for demonstrating possible integration point.
 */
public class DefaultExternalAuthenticationProvider implements AuthenticationProvider {

    /**
     * Empty roles.
     */
    private static final ArrayList<GrantedAuthority> EMPTY_AUTH = new ArrayList<GrantedAuthority>();

    /**
     * Registration service.
     */
    private RegistrationService registrationService;

    /**
     * Handled system.
     */
    private SystemId system;

    /**
     * External services.
     */
    private PartnerSystemService partnerService;

    /**
     * Empty constructor.
     */
    public DefaultExternalAuthenticationProvider() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    public void init() {
        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService must be configured.");
        }
        if (system == null) {
            throw new PortalServiceConfigurationException("system must be configured.");
        }
        if (partnerService == null) {
            throw new PortalServiceConfigurationException("partnerService must be configured.");
        }
    }

    /**
     * Authenticates the user.
     * @param authentication the authentication details
     * @return the authenticated user if the password is 'secret', null otherwise
     */
    public Authentication authenticate(Authentication authentication) {
        final DomainAuthenticationToken userToken = (DomainAuthenticationToken) authentication;
        SystemId domain = SystemId.valueOf(userToken.getDomain());
        if (domain == system) {
            String username = userToken.getName();
            String password = (String) authentication.getCredentials();
            String profileNPI = userToken.getProfileNPI();
            String referrer = userToken.getReferrer();

            if (Util.isBlank(username)) {
                throw new BadCredentialsException("Username is required.");
            } else if (Util.isBlank(password)) {
                throw new BadCredentialsException("Token is required.");
            } else if (Util.isBlank(profileNPI)) {
                throw new BadCredentialsException("Provider NPI is required.");
            } else if (Util.isBlank(referrer)) {
                throw new BadCredentialsException("Referrer is required.");
            }

            if (!partnerService.authenticate(username, password, profileNPI, referrer)) {
                throw new BadCredentialsException("Invalid credentials.");
            }

            return createSuccessfulAuthentication(userToken, loadProxyUser(username, profileNPI));
        }
        return null;
    }

    /**
     * Loads the user information by the external user. Auto provisions a CMS user for this record.
     *
     * @param userNPI the username used to login
     * @param profileNPI
     * @return the mapped details
     */
    private UserDetails loadProxyUser(String userNPI, String profileNPI) {
        CMSUser cmsUser = registrationService.findByExternalUsername(system, userNPI);
        if (cmsUser == null) {
            cmsUser = new CMSUser();
            // set defaults
            cmsUser.setLastName(userNPI);
            registrationService.registerExternalUser(system, userNPI, cmsUser);
        }

        // set session based fields
        if (userNPI.equals(profileNPI)) {
            cmsUser.setExternalRoleView(RoleView.SELF);
        } else {
            cmsUser.setExternalRoleView(RoleView.EMPLOYER);
        }
        cmsUser.setProxyForNPI(profileNPI);
        ExternalAccountLink link = registrationService.findAccountLink(
                cmsUser.getUserId(), system, userNPI);
        cmsUser.setExternalAccountLink(link);

        User springUserObject = new User(userNPI, "", true, true, true, true, EMPTY_AUTH);
        return new CMSUserDetailsWrapper(springUserObject, cmsUser, system);
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
        result.setDetails(authentication.getDetails());

        return result;
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
     * Sets the value of the field <code>registrationService</code>.
     *
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * Sets the value of the field <code>system</code>.
     * @param system the system to set
     */
    public void setSystem(SystemId system) {
        this.system = system;
    }

    /**
     * Sets the value of the field <code>partnerService</code>.
     * @param partnerService the partnerService to set
     */
    public void setPartnerService(PartnerSystemService partnerService) {
        this.partnerService = partnerService;
    }
}
