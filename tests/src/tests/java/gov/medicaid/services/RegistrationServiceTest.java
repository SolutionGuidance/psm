/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import java.util.Properties;

import gov.medicaid.dao.impl.LDAPIdentityProviderDAOBean;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.impl.RegistrationServiceBean;
import gov.medicaid.services.impl.SequenceGeneratorBean;
import gov.medicaid.services.util.Util;

import javax.mail.Session;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.BeforeClass;
import org.junit.Test;

/**
 * Simple registration test case.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class RegistrationServiceTest extends CMSTestCase {

    /**
     * Registration service.
     */
    private static RegistrationServiceBean registration = new RegistrationServiceBean();

    /**
     * LDAP service.
     */
    private static LDAPIdentityProviderDAOBean bean = new LDAPIdentityProviderDAOBean();

    /**
     * Entity manager.
     */
    private static EntityManager em;

    /**
     * Sequence generator.
     */
    private static SequenceGeneratorBean sequence = new SequenceGeneratorBean();

    /**
     * Setup the test.
     */
    @BeforeClass
    public static void setupClass() {
        System.setProperty(Util.CMS_ENV, Util.PRODUCTION);
        System.setProperty(Util.CMS_CRYPT_PASSWORD, "changeit");
        bean.init();

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cms");
        em = emf.createEntityManager();
        sequence.setEm(em);
        registration.setEm(em);
        registration.setSequence(sequence);
        registration.setIdentityProvider(bean);
        Properties props = new Properties();
        props.put("mail.smtp.host", "localhost");
        Session session = Session.getDefaultInstance(props, null);
        registration.setSession(session);
        createLookups();
        registration.init();
    }

    /**
     * Creates test lookups.
     */
    private static void createLookups() {
        em.getTransaction().begin();
        Role r1 = new Role();
        r1.setCode("R1");
        r1.setDescription(ViewStatics.ROLE_PROVIDER);
        em.persist(r1);

        em.getTransaction().commit();
        em.clear();
    }

    /**
     * Tests a register call.
     * @throws Exception to JUnit
     */
    @Test
    public void testRegister() throws Exception {
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

        em.getTransaction().begin();
        System.out.println(registration.register(user));
        em.getTransaction().commit();
        em.clear();
        System.out.println(registration.findByUsername("testldap"));
    }

    /**
     * Tests external registration.
     * @throws Exception to JUnit
     */
    @Test
    public void testRegisterExternal() throws Exception {
        CMSUser user = new CMSUser();
        user.setEmail("hello@world.com");
        user.setFirstName("fname");
        user.setLastName("lastname");

        em.getTransaction().begin();
        System.out.println(registration.registerExternalUser(SystemId.MN_ITS, "testldap", user));
        em.getTransaction().commit();
        em.clear();
        System.out.println(registration.findByUsername("testldap"));
        System.out.println(registration.findByExternalUsername(SystemId.MN_ITS, "testldap"));
    }
}
