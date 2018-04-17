package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.entities.EmailTemplate;
import java.util.Map;

public interface NotificationService {

    /**
     * Sends email notifications.
     *
     * @param email the recipient
     * @param emailType the name of the template to be used
     * @param vars the substitution variables to put in the templating context
     * @throws PortalServiceException for any errors encountered
     */
    void sendNotification(
        String email,
        EmailTemplate emailType,
        Map<String, Object> vars
    ) throws PortalServiceException;

    void sendEnrollmentNotification(
        EnrollmentType enrollment,
        EmailTemplate emailType
    ) throws PortalServiceException;
}
