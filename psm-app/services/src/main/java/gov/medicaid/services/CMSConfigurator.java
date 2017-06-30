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
package gov.medicaid.services;

import gov.medicaid.binders.BaseFormBinder;
import gov.medicaid.binders.FormBinder;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.util.Util;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

/**
 * CMS configurator.
 *
 * v1.1 - WAS Porting - setting JNDI on persistence.xml for entity manager is JBOSS specific
 * @author TCSASSEMBLER
 * @version 1.1
 */
public class CMSConfigurator {

    /**
     * Default cms configuration file.
     */
    private static final String DEFAULT_CMS_CONFIG_FILE = "/cms.properties";

    /**
     * Global settings.
     */
    private static Properties globalSettings;

    /**
     * EMF that uses the XA data source.
     */
	private EntityManagerFactory emf;

	private EntityManager portalEntityManager;

    /**
     * Reads the configuration and stores it.
     */
    public CMSConfigurator() {
        InputStream stream = getClass().getResourceAsStream(DEFAULT_CMS_CONFIG_FILE);
        if (stream == null) {
            throw new PortalServiceConfigurationException(
                "Could not find application configuration, make sure it is in the classpath.");
        }

        if (globalSettings == null) {
            synchronized (CMSConfigurator.class) {
                globalSettings = Util.newEncryptionEnabledProps();
                try {
                    globalSettings.load(stream);
                } catch (IOException e) {
                    throw new PortalServiceConfigurationException(
                        "Could not read application configuration, make sure it is in the classpath.");
                } finally {
                    if (stream != null) {
                        try {
                            stream.close();
                        } catch (IOException e) {
                            throw new PortalServiceConfigurationException("Unable to close configuration.");
                        }
                    }
                }
            }
        } else {
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException e) {
                    throw new PortalServiceConfigurationException("Unable to close configuration.");
                }
            }
        }
    }

    /**
     * Gets the subject to be used for the given email type.
     *
     * @param emailType the type of email to send
     * @return the configured subject
     */
    public String getEmailSubject(EmailTemplate emailType) {
        return globalSettings.getProperty("email." + emailType.name() + ".subject");
    }

    /**
     * Gets the email template to be used for the given email type.
     *
     * @param emailType the type of email to send
     * @return the configured template path
     */
    public String getEmailTemplateFile(EmailTemplate emailType) {
        return globalSettings.getProperty("email." + emailType.name() + ".template");
    }

    /**
     * Retrieves the LDAP settings environment.
     *
     * @return the LDAP environment settings
     */
    public Properties getLdapSettings() {
        Set<Entry<Object, Object>> entrySet = globalSettings.entrySet();
        Properties clone = new Properties();
        for (Entry<Object, Object> entry : entrySet) {
            if (entry.getKey().toString().startsWith("ldap.")) {
                clone.put(entry.getKey().toString().substring(5), globalSettings.get(entry.getKey()));
            }
        }
        return clone;
    }

    /**
     * Retrieves the lookup service from the default JNDI context.
     *
     * @return the lookup service
     */
    public LookupService getLookupService() {
        return (LookupService) fromContext("jndi.LookupService", false);
    }

    /**
     * Retrieves the presentation service from the default JNDI context.
     *
     * @return the presentation service
     */
    public PresentationService getPresentationService() {
        return (PresentationService) fromContext("jndi.PresentationService", false);
    }

    /**
     * Retrieves the binder registry.
     *
     * @return the configured binder registry
     */
    public Map<String, FormBinder> getBinderRegistry() {
        try {
            Map<String, FormBinder> binders = new HashMap<String, FormBinder>();
            int i = 1;
            while (globalSettings.getProperty("binders." + i + ".name") != null) {
                String key = globalSettings.getProperty("binders." + i + ".name");
                String cls = globalSettings.getProperty("binders." + i + ".class");
                BaseFormBinder binder = (BaseFormBinder) Class.forName(cls).newInstance();
                binder.init();
                binders.put(key, binder);
                i++;
            }
            return binders;
        } catch (InstantiationException e) {
            throw new PortalServiceConfigurationException("Could not initialize binder registry.", e);
        } catch (IllegalAccessException e) {
            throw new PortalServiceConfigurationException("Could not initialize binder registry.", e);
        } catch (ClassNotFoundException e) {
            throw new PortalServiceConfigurationException("Could not initialize binder registry.", e);
        } catch (ClassCastException e) {
            throw new PortalServiceConfigurationException("Expected all binders to extend BaseFormBinder.", e);
        }
    }

    /**
     * Retrieves the binder registry.
     *
     * @return the configured binder registry
     */
    public Map<String, String> getNewEnrollmentViewRegistry() {
        Map<String, String> forms = new HashMap<String, String>();
        int i = 1;
        while (globalSettings.getProperty("binders." + i + ".name") != null) {
            String key = globalSettings.getProperty("binders." + i + ".name");
            String jsp = globalSettings.getProperty("binders." + i + ".jsp");
            if (jsp != null) {
                forms.put(key, jsp);
            }
            i++;
        }
        return forms;
    }

    /**
     * Retrieves the binder registry.
     *
     * @return the configured binder registry
     */
    public Map<String, String> getSummaryViewRegistry() {
        Map<String, String> forms = new HashMap<String, String>();
        int i = 1;
        while (globalSettings.getProperty("binders." + i + ".name") != null) {
            String key = globalSettings.getProperty("binders." + i + ".name");
            String jsp = globalSettings.getProperty("binders." + i + ".summaryjsp");
            if (jsp != null) {
                forms.put(key, jsp);
            }
            i++;
        }
        return forms;
    }

    /**
     * Retrieves the enrollment service.
     *
     * @return the enrollment service from the JNDI tree.
     */
    public ProviderEnrollmentService getEnrollmentService() {
        return (ProviderEnrollmentService) fromContext("jndi.ProviderEnrollmentService", false);
    }

    /**
     * Retrieves the object from the JNDI tree.
     *
     * @param jndiName the JNDI name configuration property
     * @param direct if true the first argument is not a property name and should be used directly
     * @return the object from the configured property
     */
    private Object fromContext(String jndiName, boolean direct) {
        try {
            InitialContext ctx = new InitialContext();
            if (direct) {
                return ctx.lookup(jndiName);
            } else {
                return ctx.lookup(globalSettings.getProperty(jndiName));
            }
        } catch (NamingException e) {
            throw new PortalServiceConfigurationException("Could not initialize provider enrollment service.", e);
        }
    }

    /**
     * Retrieves the hashing key for request validation.
     *
     * @return the configured key
     */
    public String getServerHashKey() {
        return globalSettings.getProperty("keys.formhash");
    }

    /**
     * Retrieves the dummy system user.
     *
     * @return the system user to be used for internal calls.
     */
    public CMSUser getSystemUser() {
        CMSUser cmsUser = new CMSUser();
        cmsUser.setUserId("SYSTEM");
        cmsUser.setUsername("system");
        Role role = new Role();
        role.setDescription("System Administrator");
        role.setCode("R4");
        cmsUser.setRole(role);
        return cmsUser;
    }

    /**
     * Retrieves all known partner services.
     *
     * @return the map of partner services
     */
    public Map<SystemId, PartnerSystemService> getPartnerServices() {
        // only known partner service for now
        HashMap<SystemId, PartnerSystemService> map = new HashMap<SystemId, PartnerSystemService>();
        map.put(SystemId.MN_ITS, (PartnerSystemService) fromContext("jndi.MNITSPartnerServiceBean", false));
        return map;
    }

    /**
     * Retrieves the sequence generator from the JNDI tree.
     *
     * @return the sequence generator
     */
    public SequenceGenerator getSequenceGenerator() {
        return (SequenceGenerator) fromContext("jndi.SequenceGenerator", false);
    }

    /**
     * Retrieves the portal entity manager from the JNDI tree.
     *
     * @return the portal entity manager
     */
    public EntityManager getPortalEntityManager() {
    	if (emf == null) {
    		emf = Persistence.createEntityManagerFactory("cms");
    		portalEntityManager = emf.createEntityManager();
    	}
		return portalEntityManager;
    }

    /**
     * Creates the velocity engine for templating functions.
     * @return the velocity engine
     */
    public VelocityEngine getVelocityEngine() {
        VelocityEngine velocityEngine = new VelocityEngine();
        velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());

        velocityEngine.init();
        return velocityEngine;
    }

    /**
     * For administrator and agent dashboards, this returns the maximum number of notifications shown.
     * @return the configured display size
     */
    public int getMaxNotificationsDisplay() {
        return Integer.parseInt(globalSettings.getProperty("display.notifications.max"));
    }

    /**
     * Retrieves the base URL for the external sources services.
     * @return the configured base URL for the current environment
     */
    public String getExternalSourceBase() {
        if (Util.PRODUCTION.equals(System.getProperty(Util.CMS_ENV))) {
            return globalSettings.getProperty("extsources.PROD.base");
        } else {
            return globalSettings.getProperty("extsources.TEST.base");
        }
    }

    /**
     * Retrieves the flag setting for using external or embedded rules
     * @return the flag setting for rules
     */
	public String getUseEmbeddedRules() {
        return globalSettings.getProperty("rules.embedded");
	}

    /**
     * Gets the configured pdf files folder
     * 
     * @return the pdf files folder
     */
    public String getExportPDFFolder() {
        return globalSettings.getProperty("export.pdf.folder");
    }

    /**
     * The allowed referrer domain for MN logins.
     * @return the configured domain
     */
	public String getInternalSecurityDomain() {
        return globalSettings.getProperty("internalSecurityDomain");
	}
	
	/**
	 * The allowed referrer domain for MN logins.
	 * @return the configured domain
	 */
	public String getInternalSecurityToken() {
		return globalSettings.getProperty("internalSecurityToken");
	}
}
