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

package gov.medicaid.controllers.dto;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.UserStatus;
import gov.medicaid.security.CMSPrincipal;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

/**
 * Wraps the user details from the external authentication mechanism into one that tracks the external account source
 * and the corresponding internal CMS user record.
 */
public class CMSUserDetailsWrapper implements UserDetails, CMSPrincipal {

    /**
     * The original LDAP mapped user details, some properties are only in the CMS database so we wrap this.
     */
    private final UserDetails original;

    /**
     * The corresponding CMS user, if null, then the records in LDAP are not in sync and we disable the access.
     */
    private final CMSUser user;

    /**
     * The system id that authenticated this user.
     */
    private final SystemId systemId;

    /**
     * The login date.
     */
    private Date loginDate;

    /**
     * Authorities.
     */
    private final Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

    /**
     * Wraps the given user details object.
     *
     * @param original the details to be wrapped
     * @param user the corresponding CMS user in the database
     * @param systemId the system that authenticated the user
     */
    public CMSUserDetailsWrapper(UserDetails original, CMSUser user, SystemId systemId) {
        this.original = original;
        this.user = user;
        this.systemId = systemId;
        this.loginDate = new Date();

        if (user.getRole() != null) {
            String role = user.getRole().getDescription().replace(' ', '_').toUpperCase();
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role));
        }
    }

    /**
     * Returns the authorities granted to the user.
     *
     * @return the authorities granted to the user
     */
    public Collection<GrantedAuthority> getAuthorities() {
        return authorities;
    }

    /**
     * Returns the password used to authenticate the user.
     *
     * @return the password used to authenticate the user
     */
    public String getPassword() {
        return original.getPassword();
    }

    /**
     * Returns the username used to authenticate the user.
     *
     * @return the username used to authenticate the user
     */
    public String getUsername() {
        return original.getUsername();
    }

    /**
     * Indicates whether the user's account has expired.
     *
     * @return whether the user's account has expired
     */
    public boolean isAccountNonExpired() {
        return original.isAccountNonExpired();
    }

    /**
     * Indicates whether the user is locked or unlocked.
     *
     * @return whether the user is locked or unlocked
     */
    public boolean isAccountNonLocked() {
        return original.isAccountNonLocked();
    }

    /**
     * Indicates whether the user's credentials (password) has expired.
     *
     * @return whether the user's credentials (password) has expired
     */
    public boolean isCredentialsNonExpired() {
        return original.isCredentialsNonExpired();
    }

    /**
     * Indicates whether the user is enabled or disabled.
     *
     * @return whether the user is enabled or disabled.
     */
    public boolean isEnabled() {
        return user != null && user.getStatus() != UserStatus.DISABLED;
    }

    /**
     * Returns the name of the system that accepted the authentication.
     *
     * @return the authentication system id
     */
    public SystemId getAuthenticatedBySystem() {
        return systemId;
    }

    /**
     * Returns the corresponding CMS user for this authentication.
     *
     * @return the CMS user corresponding to the record
     */
    public CMSUser getUser() {
        return user;
    }

    /**
     * Returns the same as username.
     *
     * @return the username
     */
    public String getName() {
        return user.getUserId();
    }

    /**
     * The time this login was performed.
     * @return the date this entity was instantiated
     */
    public Date getLoginDate() {
        return loginDate;
    }
}
