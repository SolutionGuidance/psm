/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the facility eligibility.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FacilityEligibilityFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_38_";

    /**
     * Creates a new binder.
     */
    public FacilityEligibilityFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    @SuppressWarnings("unchecked")
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        creds.setPhysicalAndOccupationTherapyServices(param(request, "therapyIndicator"));
        
        creds.setTitle18NumberOfBeds((int) BinderUtils.getAsLong(param(request, "title18BedCount")));
        creds.setTitle19NumberOfBeds((int) BinderUtils.getAsLong(param(request, "title19BedCount")));
        creds.setDualCertifiedNumberOfBeds((int) BinderUtils.getAsLong(param(request, "dualCertBedCount")));
        creds.setICFNumberOfBeds((int) BinderUtils.getAsLong(param(request, "icfBedCount")));

        return Collections.EMPTY_LIST;
    }
    
    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        attr(mv, "therapyIndicator", creds.getPhysicalAndOccupationTherapyServices());
        attr(mv, "title18BedCount", creds.getTitle18NumberOfBeds());
        attr(mv, "title19BedCount", creds.getTitle19NumberOfBeds());
        attr(mv, "dualCertBedCount", creds.getDualCertifiedNumberOfBeds());
        attr(mv, "icfBedCount", creds.getICFNumberOfBeds());
    }
    
    /**
     * Captures the error messages related to the form.
     * @param enrollment the enrollment that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();

                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (errors.size() > count) { // caught
                    caughtMessages.add(ruleError);
                }
            }

            // so it does not get processed anywhere again
            ruleErrors.removeAll(caughtMessages);
        }

        return errors.isEmpty() ? NO_ERRORS : errors;
    }

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param enrollment the front end model
     * @param ticket the persistent model
     * @throws PortalServiceException 
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Organization)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }
        
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        profile.setPhysicalAndOccupationalTherapyInd(credentials.getPhysicalAndOccupationTherapyServices());
        profile.setTitle18NumberOfBeds(credentials.getTitle18NumberOfBeds());
        profile.setTitle19NumberOfBeds(credentials.getTitle19NumberOfBeds());
        profile.setDualCertifiedNumberOfBeds(credentials.getDualCertifiedNumberOfBeds());
        profile.setIcfNumberOfBeds(credentials.getICFNumberOfBeds());
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        ProviderProfile profile = ticket.getDetails();
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        credentials.setPhysicalAndOccupationTherapyServices(profile.getPhysicalAndOccupationalTherapyInd());
        credentials.setTitle18NumberOfBeds(profile.getTitle18NumberOfBeds());
        credentials.setTitle19NumberOfBeds(profile.getTitle19NumberOfBeds());
        credentials.setDualCertifiedNumberOfBeds(profile.getDualCertifiedNumberOfBeds());
        credentials.setICFNumberOfBeds(profile.getIcfNumberOfBeds());
    }
}
