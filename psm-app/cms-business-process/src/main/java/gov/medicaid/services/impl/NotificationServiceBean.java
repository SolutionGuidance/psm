/*
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

package gov.medicaid.services.impl;

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.entities.SentNotification;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.io.StringWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Stateless
@Local(NotificationService.class)
public class NotificationServiceBean extends BaseService implements NotificationService {
    /**
     * Represents the velocity engine, it is initialized during post construct and never modified after.
     */
    private VelocityEngine velocityEngine;

    /**
     * CMS Configuration object, used for loading resources used in this bean
     */
    private CMSConfigurator config;

    /**
     * Represents the mail session. It is injected by the container it is used in the business methods. It may have any
     * value, fully mutable, but not expected to change after dependency injection
     */
    @Resource(mappedName = "java:/Mail")
    private Session session;

    @PostConstruct
    public void init() {
        super.init();
        if (session == null) {
            throw new PortalServiceConfigurationException("session must be configured.");
        }

        config = new CMSConfigurator();
        velocityEngine = getVelocityEngine();
    }

    /**
     * Creates the velocity engine for templating functions.
     * @return the velocity engine
     */
    private VelocityEngine getVelocityEngine() {
        VelocityEngine velocityEngine = new VelocityEngine();
        velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        velocityEngine.init();
        return velocityEngine;
    }

    private String populateTemplate(
        EmailTemplate emailType,
        Map<String, Object> vars
    ) {
        Template template = velocityEngine.getTemplate(config.getEmailTemplateFile(emailType));
        StringWriter writer = new StringWriter();
        VelocityContext velocityContext = new VelocityContext();
        for (Map.Entry<String, Object> entry : vars.entrySet()) {
            velocityContext.put(entry.getKey(), entry.getValue());
        }

        template.merge(velocityContext, writer);
        return writer.toString();
    }

    private void saveNotification(
        String emailAddress,
        EmailTemplate emailType,
        Map<String, Object> vars
    ) {
        // TODO: We never want to store plaintext passwords
        // The right way to do this would be to never email plaintext passwords.
        // For now we are going to do this, which is not really appropriate since it
        // relies on passwords being sent in a passwords variable to the template,
        // and if the templates change the name of the password variable
        // then this code will silently no longer have the intended effect.
        //
        // Sorry to the future, and to the children, but this feels like the best
        // balance of "generic solution" and "not overengineered" outside of actually
        // addressing the emailed passwords tech debt problem.
        //
        // Related Issue: https://github.com/SolutionGuidance/psm/issues/34
        if (vars.containsKey("password")) {
            vars.put("password", "********");
        }

        String emailContent = populateTemplate(emailType, vars);
        SentNotification sentNotification = new SentNotification();
        sentNotification.setNotificationType(emailType);
        sentNotification.setSentTo(emailAddress);
        sentNotification.setNotificationContent(emailContent);
        sentNotification.setSentAt(new Date());
        sentNotification.setNotificationId(0);
        getEm().persist(sentNotification);
    }

    @Override
    public void sendNotification(
        String emailAddress,
        EmailTemplate emailType,
        Map<String, Object> vars
    ) throws PortalServiceException {
      MimeMessage message = new MimeMessage(session);
      try {
          message.setRecipient(RecipientType.TO, new InternetAddress(emailAddress));
          message.setSubject(config.getEmailSubject(emailType));
          message.setText(populateTemplate(emailType, vars));

          saveNotification(emailAddress, emailType, vars);
          Transport.send(message);
        } catch (Exception e) {
          throw new PortalServiceException("Error while sending notification.", e);
        }
    }

    @Override
    public void sendApplicationNotification(
        ApplicationType applicationType,
        EmailTemplate emailType
    ) throws PortalServiceException {
        Map<String, Object> vars = new HashMap<>();
        String contact_name = applicationType.getContactInformation().getName();
        vars.put("submitter", contact_name);
        String emailAddress = applicationType.getContactInformation().getEmailAddress();
        if (emailAddress != null && emailAddress.trim().length() > 0) {
            sendNotification(emailAddress, emailType, vars);
        } else {
            getLogger().warning("Skipping notification as email address was missing");
        }
    }
}
