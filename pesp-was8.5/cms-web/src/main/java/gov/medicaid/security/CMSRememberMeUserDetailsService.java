/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.security;

import gov.medicaid.controllers.dto.CMSUserDetailsWrapper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;

import java.util.ArrayList;

import javax.annotation.PostConstruct;

import org.springframework.dao.DataRetrievalFailureException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * User details implementation for use of the remember me services.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CMSRememberMeUserDetailsService implements UserDetailsService {

    /**
     * Empty roles.
     */
    private static final ArrayList<GrantedAuthority> EMPTY_AUTH = new ArrayList<GrantedAuthority>();

    /**
     * Service used to get the registration.
     */
    private RegistrationService registrationService;

    /**
     * Empty constructor.
     */
    public CMSRememberMeUserDetailsService() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    public void init() {
        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService is not configured properly.");
        }
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
     * Loads the user into a principal.
     *
     * @param userId the user id
     * @return the user principal
     */
    public UserDetails loadUserByUsername(String userId) {
        try {
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
        } catch (PortalServiceException e) {
            throw new DataRetrievalFailureException("Database error.", e);
        }
    }

}
