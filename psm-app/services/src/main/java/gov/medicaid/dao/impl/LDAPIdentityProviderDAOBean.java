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

package gov.medicaid.dao.impl;

import gov.medicaid.dao.IdentityProviderDAO;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Role;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.util.Util;

import org.apache.commons.codec.binary.Base64;

import javax.annotation.PostConstruct;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * This is an EJB implementation for the {@link IdentityProviderDAO} which connects directly to configurable LDAP
 * servers.
 */
@Stateless
@Local(IdentityProviderDAO.class)
public class LDAPIdentityProviderDAOBean implements IdentityProviderDAO {

    /**
     * Group search base key.
     */
    private static final String GROUPS_SEARCH_BASE = "groupsSearchBase";

    /**
     * User DN pattern.
     */
    private static final String USER_DN_PATTERN = "userDnPattern";

    /**
     * Group DN pattern.
     */
    private static final String GROUP_DN_PATTERN = "groupDnPattern";

    /**
     * Group object class.
     */
    private static final String GROUP_SEARCH_FILTER = "groupSearchFilter";

    /**
     * Group member attribute.
     */
    private static final String GROUP_MEMBER_ATTR = "groupMemberAttribute";

    /**
     * LDAP environment, this is initializes during post-construction.
     */
    private Properties env;

    /**
     * The group search base.
     */
    private String groupsSearchBase;

    /**
     * The user DN pattern.
     */
    private String userDNPattern;

    /**
     * The group DN pattern.
     */
    private String groupDNPattern;

    /**
     * The groups filter pattern.
     */
    private String groupsFilterPattern;

    /**
     * The group membership attribute.
     */
    private String groupMemberAttr;

    /**
     * CMS configuration.
     */
    private CMSConfigurator config;

    /**
     * Empty constructor.
     */
    public LDAPIdentityProviderDAOBean() {
    }

    /**
     * Initializes this service, if any configuration property is missing then an exception is raised.
     */
    @PostConstruct
    public void init() {
        config = new CMSConfigurator();
        env = config.getLdapSettings();

        checkConfig(GROUPS_SEARCH_BASE);
        checkConfig(USER_DN_PATTERN);
        checkConfig(GROUP_MEMBER_ATTR);
        checkConfig(GROUP_SEARCH_FILTER);
        checkConfig(GROUP_DN_PATTERN);

        groupsSearchBase = env.getProperty(GROUPS_SEARCH_BASE);
        userDNPattern = env.getProperty(USER_DN_PATTERN);
        groupDNPattern = env.getProperty(GROUP_DN_PATTERN);
        groupMemberAttr = env.getProperty(GROUP_MEMBER_ATTR);
        groupsFilterPattern = env.getProperty(GROUP_SEARCH_FILTER);
    }

    /**
     * Asks the identity provider to provision a new user with the given profile and password.
     *
     * @param user the user to be provisioned
     * @param password the password for the user
     * @throws PortalServiceException for any errors encountered
     */
    public void provisionUser(CMSUser user, String password) throws PortalServiceException {
        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);
            List<Attribute> profileAttributes = mapAttributes(user);

            // set type
            Attribute oc = new BasicAttribute("objectClass");
            oc.add("top");
            oc.add("person");
            oc.add("organizationalPerson");
            oc.add("inetOrgPerson");

            // build the entry
            BasicAttributes entry = new BasicAttributes();
            for (Attribute attribute : profileAttributes) {
                entry.put(attribute);
            }

            // initial password
            entry.put(new BasicAttribute("userPassword", hash(password)));
            entry.put(oc);

            ctx.createSubcontext(MessageFormat.format(userDNPattern, user.getUsername()), entry);
            synchRoles(user.getUsername(), user.getRole());
        } catch (NamingException e) {
            throw new PortalServiceException("Error while provisioning user.", e);
        } finally {
            closeContext(ctx);
        }
    }

    /**
     * Updates the profile of the user on the external provider.
     *
     * @param user the profile to be updated (it is assumed username is never changed)
     * @throws PortalServiceException for any errors encountered
     */
    public void updateUser(CMSUser user) throws PortalServiceException {
        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);

            List<ModificationItem> mods = new ArrayList<ModificationItem>();
            List<Attribute> profile = mapAttributes(user);
            for (Attribute attribute : profile) {
                mods.add(new ModificationItem(DirContext.REPLACE_ATTRIBUTE, attribute));
            }
            ctx.modifyAttributes(MessageFormat.format(userDNPattern, user.getUsername()),
                mods.toArray(new ModificationItem[0]));

            synchRoles(user.getUsername(), user.getRole());
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Unable to save user.", e);
        } finally {
            closeContext(ctx);
        }
    }

    /**
     * Resets the password for the given user.
     *
     * @param username the username
     * @param password the new password
     * @throws PortalServiceException for any errors encountered
     */
    public void resetPassword(String username, String password) throws PortalServiceException {
        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);
            BasicAttribute pw = new BasicAttribute("userPassword", hash(password));

            ModificationItem[] mods = new ModificationItem[1];
            mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, pw);
            ctx.modifyAttributes(MessageFormat.format(userDNPattern, username), mods);
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Unable to reset password.", e);
        } finally {
            closeContext(ctx);
        }
    }

    /**
     * Removes the user from the underlying identity provider.
     *
     * @param username this is the user that will be permanently removed
     * @throws PortalServiceException for any errors encountered
     */
    public void removeUser(String username) throws PortalServiceException {
        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);
            List<String> roles = findRoles(username);
            for (String existingRole : roles) {
                removeRoleAssignment(ctx, username, existingRole);
            }
            ctx.unbind(MessageFormat.format(userDNPattern, username));
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Unable to get groups.", e);
        } finally {
            closeContext(ctx);
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
     * Synchronizes the roles between the application and the identity provider.
     *
     * @param username the user to synchronize the role for
     * @param role the role that should be set on the identity provider
     * @throws PortalServiceException for any errors encountered
     */
    private void synchRoles(String username, Role role) throws PortalServiceException {
        List<String> roles = findRoles(username);

        DirContext ctx = null;
        try {
            ctx = new InitialDirContext(env);

            // remove all roles, we expect only one
            for (String existingRole : roles) {
                if (!existingRole.equals(role.getDescription())) {
                    removeRoleAssignment(ctx, username, existingRole);
                }
            }

            // add the new role if needed
            if (!roles.contains(role.getDescription())) {
                ModificationItem[] mods = new ModificationItem[1];
                BasicAttribute m = new BasicAttribute(groupMemberAttr, MessageFormat.format(userDNPattern, username));
                mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, m);
                ctx.modifyAttributes(MessageFormat.format(groupDNPattern, role.getDescription()), mods);
            }
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Unable to reset password.", e);
        } finally {
            closeContext(ctx);
        }

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

    /**
     * Removes the given user from the given role.
     *
     * @param ctx the directory context
     * @param username the user to be removed
     * @param existingRole the role to be removed from
     * @throws NamingException for any errors encountered
     */
    private void removeRoleAssignment(DirContext ctx, String username, String existingRole) throws NamingException {
        ModificationItem[] mods = new ModificationItem[1];
        BasicAttribute m = new BasicAttribute(groupMemberAttr, MessageFormat.format(userDNPattern, username));
        mods[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, m);
        ctx.modifyAttributes(MessageFormat.format(groupDNPattern, existingRole), mods);
    }

    /**
     * Checks the configuration for the given key.
     *
     * @param key the key to check in the configuration, if not found or is blank, then an exception is raised
     */
    private void checkConfig(String key) {
        if (Util.isBlank(env.getProperty(key))) {
            throw new PortalServiceConfigurationException("Missing configuration value for " + key + ".");
        }
    }

    /**
     * Maps supported attributes from the application to the LDAP profile.
     *
     * @param user the user to map the attributes for
     * @return the list of mapped attrbiutes
     */
    private List<Attribute> mapAttributes(CMSUser user) {
        List<Attribute> profileAttributes = new ArrayList<Attribute>();
        profileAttributes.add(new BasicAttribute("sn", user.getLastName()));
        profileAttributes.add(new BasicAttribute("cn", user.getFirstName() + " " + user.getLastName()));

        if (user.getFirstName() != null) {
            profileAttributes.add(new BasicAttribute("givenName", user.getFirstName()));
        }
        if (user.getEmail() != null) {
            profileAttributes.add(new BasicAttribute("mail", user.getEmail()));
        }
        if (user.getPhoneNumber() != null) {
            profileAttributes.add(new BasicAttribute("telephoneNumber", user.getPhoneNumber()));
        }
        return profileAttributes;
    }

    /**
     * Hashes the given password so it is not stored as plain text on LDAP.
     *
     * @param password the plain text password to hash
     * @return the hashed password
     */
    private String hash(String password) {
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA");
            sha.update(password.getBytes());
            byte[] hash = sha.digest();
            return "{SHA}" + new String(Base64.encodeBase64(hash));
        } catch (NoSuchAlgorithmException e) {
            throw new PortalServiceConfigurationException("No valid encryption algorithm was found.", e);
        }
    }

    /**
     * Bind authenticate.
     *
     * @param username the user to be used
     * @param password the password to be used
     * @return true if the user was authenticated
     * @throws PortalServiceException for any errors encountered
     */
    public boolean authenticate(String username, String password) throws PortalServiceException {
        DirContext ctx = null;
        try {
            Properties props = new Properties();
            props.put(Context.INITIAL_CONTEXT_FACTORY, env.getProperty(Context.INITIAL_CONTEXT_FACTORY));
            props.put(Context.PROVIDER_URL, env.getProperty(Context.PROVIDER_URL));
            props.put(Context.SECURITY_PRINCIPAL, MessageFormat.format(userDNPattern, username));
            props.put(Context.SECURITY_CREDENTIALS, password);
            ctx = new InitialDirContext(props);
            return true;
        } catch (AuthenticationException authEx) {
            return false;
        } catch (NamingException e) {
            throw new PortalServiceException("Could not verify authentication results.", e);
        } finally {
            closeContext(ctx);
        }
    }
}
