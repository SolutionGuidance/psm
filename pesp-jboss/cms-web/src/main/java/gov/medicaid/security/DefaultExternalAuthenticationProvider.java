/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.security;

import gov.medicaid.controllers.dto.CMSUserDetailsWrapper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.PartnerSystemService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;

import javax.annotation.PostConstruct;

import org.springframework.dao.DataRetrievalFailureException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Mock authentication provider for demonstrating possible integration point.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
            throw new  PortalServiceConfigurationException("registrationService must be configured.");
        }
        if (system == null) {
            throw new  PortalServiceConfigurationException("system must be configured.");
        }
        if (partnerService == null) {
            throw new  PortalServiceConfigurationException("partnerService must be configured.");
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

            if (Util.isBlank(username)) {
                throw new BadCredentialsException("Username is required.");
            }

            try {
                if (!partnerService.authenticate(username, password)) {
                    throw new BadCredentialsException("Invalid credentials.");
                }
            } catch (PortalServiceException e) {
                throw new PortalServiceRuntimeException("Data lookup errors", e);
            }

            return createSuccessfulAuthentication(userToken, loadUserByUsername(username));
        }
        return null;
    }

    /**
     * Loads the user information by the external user. Auto provisions a CMS user for this record.
     *
     * @param username the username used to login
     * @return the mapped details
     */
    private UserDetails loadUserByUsername(String username) {
        try {
            CMSUser cmsUser = registrationService.findByExternalUsername(system, username);
            if (cmsUser == null) {
                cmsUser = partnerService.getUserInformation(username);
                cmsUser.setUsername(null); // for external users only id should be present
                registrationService.registerExternalUser(system, username, cmsUser);
            }
            User thirdPartyUser = new User(username, "", true, true, true, true, EMPTY_AUTH);
            return new CMSUserDetailsWrapper(thirdPartyUser, cmsUser, system);
        } catch (PortalServiceException e) {
            throw new DataRetrievalFailureException("Database error.", e);
        }

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
