/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
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
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.RegistrationService;

import java.util.Collection;

import javax.annotation.PostConstruct;

import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.LdapUserDetailsMapper;

/**
 * Simple extension to the {@link LdapUserDetailsMapper} that ensures the LDAP users are also present in the database.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CMSLDAPUserDetailsMapper extends LdapUserDetailsMapper {

    /**
     * Service used to get the registration.
     */
    private RegistrationService registrationService;

    /**
     * Empty constructor.
     */
    public CMSLDAPUserDetailsMapper() {
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
     * Wraps the user details to contain tracking information.
     *
     * @param context the directory context
     * @param username the user name
     * @param authority the granted authorities
     * @return the user details
     */
    public UserDetails mapUserFromContext(DirContextOperations context, String username,
        Collection<GrantedAuthority> authority) {
        try {
            UserDetails original = super.mapUserFromContext(context, username, authority);
            CMSUser user = registrationService.findByUsername(username);
            if (user == null || user.getRole() == null) {
                throw new PortalServiceRuntimeException("Invalid user data, "
                    + "all users in LDAP must have corresponding CMS records.");
            }
            return new CMSUserDetailsWrapper(original, user, SystemId.CMS_ONLINE);
        } catch (PortalServiceException e) {
            throw new PortalServiceRuntimeException("Not able to check LDAP synchronization settings.", e);
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

}
