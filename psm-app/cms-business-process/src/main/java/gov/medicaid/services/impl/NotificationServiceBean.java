package gov.medicaid.services.impl;

import java.io.StringWriter;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;

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

          Template template = velocityEngine.getTemplate(config.getEmailTemplateFile(emailType));
          StringWriter writer = new StringWriter();
          VelocityContext velocityContext = new VelocityContext();
          for (Map.Entry<String, Object> entry : vars.entrySet()) {
              velocityContext.put(entry.getKey(), entry.getValue());
          }

          template.merge(velocityContext, writer);
          message.setText(writer.toString());

          Transport.send(message);
        } catch (Exception e) {
          throw new PortalServiceException("Error while sending notification.", e);
        }
    }
}
