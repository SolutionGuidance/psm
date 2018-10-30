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
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.RegistrationService;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import javax.annotation.PostConstruct;

import java.util.ArrayList;

/**
 * User details implementation for use of the remember me services.
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

}
