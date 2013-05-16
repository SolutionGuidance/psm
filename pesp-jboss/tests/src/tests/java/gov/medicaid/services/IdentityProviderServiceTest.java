/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.dao.impl.LDAPIdentityProviderDAOBean;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.util.Util;

import java.util.List;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * Simple LDAP user management test case.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class IdentityProviderServiceTest  {

    private static LDAPIdentityProviderDAOBean bean = new LDAPIdentityProviderDAOBean();

    @BeforeClass
    public static void setupClass() {
        System.setProperty(Util.CMS_ENV, Util.PRODUCTION);
        System.setProperty(Util.CMS_CRYPT_PASSWORD, "changeit");
        bean.init();
    }

    @Test
    public void testFindGroups() throws Exception {
        List<String> groups = bean.findRoles("tcsassembler");
        Assert.assertNotNull(groups);
        System.out.println(groups.size());
        Assert.assertTrue(groups.contains("Provider"));
    }

    @Test
    public void testCreateUser() throws Exception {
        try {
            bean.removeUser("testldap");
        } catch (Exception e) {
            // ignore
        }

        CMSUser user = new CMSUser();
        user.setUsername("testldap");
        user.setEmail("hello@world.com");
        user.setFirstName("fname");
        user.setLastName("lastname");
        Role role = new Role();
        role.setDescription("Service Agent");
        user.setRole(role);
        bean.provisionUser(user, "passwd");
    }

    @Test
    public void testUpdateUser() throws Exception {
        CMSUser user = new CMSUser();
        user.setUsername("testldap");
        user.setEmail("hello1@world.com");
        user.setFirstName("1fname");
        user.setLastName("1lastname");
        Role role = new Role();
        role.setDescription("Service Admin");
        user.setRole(role);
        bean.updateUser(user);
    }

    @Test
    public void resetPassword() throws Exception {
        bean.resetPassword("testldap", "updated");
    }

    @Test
    public void testDeleteUser() throws Exception {
        bean.removeUser("testldap");
    }

}
