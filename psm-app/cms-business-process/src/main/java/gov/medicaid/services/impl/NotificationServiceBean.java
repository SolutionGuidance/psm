package gov.medicaid.services.impl;

import java.io.StringWriter;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(NotificationService.class)
public class NotificationServiceBean extends BaseService implements NotificationService {
    /**
     * Represents the velocity engine, it is initialized during post construct and never modified after.
     */
    private VelocityEngine velocityEngine;

    /**
     * CMS Configuration object.
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
        velocityEngine = config.getVelocityEngine();
    }
  
    @Override
    public void sendNotification(EnrollmentType enrollment, NotificationService.EnrollmentStatus status) 
        throws PortalServiceException {
      String email = enrollment.getContactInformation().getEmailAddress();
      MimeMessage message = new MimeMessage(session);
      try {
          message.setRecipient(RecipientType.TO, new InternetAddress(email));
          message.setSubject(config.getEmailSubject(status.individualTemplate));
          Template template = velocityEngine.getTemplate(config.getEmailTemplateFile(status.individualTemplate));
          StringWriter writer = new StringWriter();
          VelocityContext velocityContext = new VelocityContext();
          //for (Map.Entry<String, Object> entry : vars.entrySet()) {
          //    velocityContext.put(entry.getKey(), entry.getValue());
          //}
          template.merge(velocityContext, writer);
          message.setText(writer.toString());
          Transport.send(message);
        } catch (Exception e) {
          throw new PortalServiceException("Error while sending notification.", e);
        }
    }
}
