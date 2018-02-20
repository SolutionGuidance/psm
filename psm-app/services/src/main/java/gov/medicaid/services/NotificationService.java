package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.entities.EmailTemplate;

public interface NotificationService {
  
    /**
     * Status of enrollment to notify recipients about 
     */
    public static enum EnrollmentStatus{
        /**
         * Enrollment pending status
         */
        PENDING(EmailTemplate.PENDING_ENROLLMENT_INDIVIDUAL,
            EmailTemplate.PENDING_ENROLLMENT_ORGANIZATION,EmailTemplate.PENDING_ENROLLMENT_ADMIN),
        
        /**
         * Enrollment modified status
         */
        MODIFIED(EmailTemplate.MODIFIED_ENROLLMENT_INDIVIDUAL,
            EmailTemplate.MODIFIED_ENROLLMENT_ORGANIZATION,EmailTemplate.MODIFIED_ENROLLMENT_ADMIN),
        
        /**
         * Enrollment rejected status
         */
        REJECTED(EmailTemplate.REJECTED_ENROLLMENT_INDIVIDUAL,
            EmailTemplate.REJECTED_ENROLLMENT_ORGANIZATION,EmailTemplate.REJECTED_ENROLLMENT_ADMIN),
        
        /**
         * Enrollment approved status
         */
        APPROVED(EmailTemplate.APPROVED_ENROLLMENT_INDIVIDUAL,
            EmailTemplate.APPROVED_ENROLLMENT_ORGANIZATION,EmailTemplate.APPROVED_ENROLLMENT_ADMIN);
      
        /**
         * Email template for individuals.
         */
        public final EmailTemplate individualTemplate;
        
        /**
         * Email template for organizations.
         */
        public final EmailTemplate organizationTemplate;
        
        /**
         * Email template for admins.
         */
        public final EmailTemplate adminTemplate;
        
        private EnrollmentStatus(EmailTemplate individual, EmailTemplate organization, EmailTemplate admin) {
            this.individualTemplate = individual;
            this.organizationTemplate = organization;
            this.adminTemplate = admin;
        }
    }
    
    /**
     * Sends notification for enrollment status changes.
     * 
     * @param enrollmentType The enrollment model
     * @throws PortalServiceException For errors that occur when sending notification
     */
    void sendNotification(EnrollmentType enrollmentType, EnrollmentStatus status) throws PortalServiceException;
}
