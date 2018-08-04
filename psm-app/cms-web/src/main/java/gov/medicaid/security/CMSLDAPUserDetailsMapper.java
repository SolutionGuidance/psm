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
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.RegistrationService;

import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.LdapUserDetailsMapper;

import javax.annotation.PostConstruct;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Simple extension to the {@link LdapUserDetailsMapper} that ensures the LDAP users are also present in the database.
 */
public class CMSLDAPUserDetailsMapper extends LdapUserDetailsMapper {

    /**
     * Group search base key.
     */
    private static final String GROUPS_SEARCH_BASE = "groupsSearchBase";

    /**
     * User DN pattern.
     */
    private static final String USER_DN_PATTERN = "userDnPattern";

    /**
     * Group object class.
     */
    private static final String GROUP_SEARCH_FILTER = "groupSearchFilter";

    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Service used to get the registration.
     */
    private RegistrationService registrationService;

    /**
     * The group search base.
     */
    private String groupsSearchBase;

    /**
     * The user DN pattern.
     */
    private String userDNPattern;

    /**
     * The groups filter pattern.
     */
    private String groupsFilterPattern;

    /**
     * The ldap configuration.
     */
    private Properties env;

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

        CMSConfigurator config = new CMSConfigurator();
        env = config.getLdapSettings();
        groupsSearchBase = env.getProperty(GROUPS_SEARCH_BASE);
        userDNPattern = env.getProperty(USER_DN_PATTERN);
        groupsFilterPattern = env.getProperty(GROUP_SEARCH_FILTER);
    }

    /**
     * Wraps the user details to contain tracking information.
     *
     * @param context the directory context
     * @param username the username
     * @param authority the granted authorities
     * @return the user details
     */
    @Override
    public UserDetails mapUserFromContext(
            DirContextOperations context,
            String username,
            Collection<? extends GrantedAuthority> authority
    ) {
        try {
            UserDetails original = super.mapUserFromContext(context, username, authority);
            logger.info("Searching for LDAP groups...");
            List<String> roles = findRoles(username);
            logger.info("Found: " + roles);

            CMSUser user = registrationService.findByExternalUsername(SystemId.MN_ITS, username);
            if (user == null || user.getRole() == null) {
                user = new CMSUser();
                Role role = new Role();
                if (roles.contains(ViewStatics.ROLE_SYSTEM_ADMINISTRATOR)) {
                    role.setCode("R4");
                    role.setDescription(ViewStatics.ROLE_SYSTEM_ADMINISTRATOR);
                } else if (roles.contains(ViewStatics.ROLE_SERVICE_ADMINISTRATOR)) {
                    role.setCode("R3");
                    role.setDescription(ViewStatics.ROLE_SERVICE_ADMINISTRATOR);
                } else if (roles.contains(ViewStatics.ROLE_SERVICE_AGENT)) {
                    role.setCode("R2");
                    role.setDescription(ViewStatics.ROLE_SERVICE_AGENT);
                } else {
                    role.setCode("R1");
                    role.setDescription(ViewStatics.ROLE_PROVIDER);
                }
                user.setRole(role);
                logger.info("First time login detected.. provisioning external user. " + user.getUsername());
                registrationService.registerExternalUser(SystemId.MN_ITS, username, user);
            }
            return new CMSUserDetailsWrapper(original, user, SystemId.MN_ITS);
        } catch (PortalServiceException e) {
            dumpLDAPConfig();
            logger.log(Level.SEVERE, "Could not complete LDAP login and authorization.", e);
            throw new PortalServiceRuntimeException("Could not complete LDAP login and authorization.", e);
        }
    }

    /**
     * Debugs the LDAP configuration being used.
     */
    private void dumpLDAPConfig() {
        Set<Entry<Object, Object>> entrySet = env.entrySet();
        logger.info("dumping LDAP Configuration");
        for (Entry<Object, Object> entry : entrySet) {
            logger.info(entry.getKey() + "=" + entry.getValue());
        }
    }

    /**
     * Retrieves the roles for the from the identity provider.
     *
     * @param username the user to get the roles for
     * @return the list of roles for the user
     * @throws PortalServiceException for any errors encountered
     */
    @SuppressWarnings("rawtypes")
    public List<String> findRoles(String username) throws PortalServiceException {
        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);

            // Search for groups the user belongs to in order to get their names
            // Create the search controls
            SearchControls groupsSearchCtls = new SearchControls();

            // Specify the search scope
            groupsSearchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);

            // Specify the attributes to return
            String groupsReturnedAtts[] = {"cn"};
            groupsSearchCtls.setReturningAttributes(groupsReturnedAtts);

            String userDn = MessageFormat.format(userDNPattern, username);
            // Search for objects using the filter
            NamingEnumeration groupsAnswer = ctx.search(groupsSearchBase,
                MessageFormat.format(groupsFilterPattern, userDn), groupsSearchCtls);

            List<String> groups = new ArrayList<String>();
            // Loop through the search results
            while (groupsAnswer.hasMoreElements()) {

                SearchResult sr = (SearchResult) groupsAnswer.next();
                Attributes attrs = sr.getAttributes();

                if (attrs != null) {
                    groups.add((String) attrs.get("cn").get());
                }

                if (sr.getObject() instanceof Context) {
                    closeContext((Context) sr.getObject());
                }
            }
            return groups;
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Unable to get groups.", e);
        } finally {
            closeContext(ctx);
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
     * Closes the given context.
     * @param ctx the context to be closed
     */
    private void closeContext(Context ctx) {
        if (ctx != null) {
            try {
                ctx.close();
            } catch (NamingException e) {
                throw new PortalServiceRuntimeException("Unable to close resource.", e);
            }
        }
    }
}
