/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 * This binder handles the organization disclosure.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FacilityCapacityFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_27_";

    /**
     * Creates a new binder.
     */
    public FacilityCapacityFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     *
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        String beds = param(request, "numberOfBeds");
        if (StringUtils.isNumeric(beds)) {
            creds.setNumberOfBeds((int) BinderUtils.getAsLong(beds));
        }
        
        try {
            creds.setNumberOfBedsEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate")));
        } catch (BinderException e) {
            e.setAttribute(name("effectiveDate"), param(request, "effectiveDate"));
            exceptions.add(e);
        }
        
        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     *
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        if (creds.getNumberOfBeds() != null) {
            attr(mv, "numberOfBeds", creds.getNumberOfBeds());
        }
        attr(mv, "effectiveDate", creds.getNumberOfBedsEffectiveDate());
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
                
                if (path.equals("/ProviderInformation/FacilityCredentials/NumberOfBeds")) {
                    errors.add(createError("numberOfBeds", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/FacilityCredentials/NumberOfBedsEffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
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
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        ProviderProfile profile = ticket.getDetails();
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        profile.setNumberOfBeds(creds.getNumberOfBeds());
        profile.setNumberOfBedsEffectiveDate(BinderUtils.toDate(creds.getNumberOfBedsEffectiveDate()));
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        ProviderProfile profile = ticket.getDetails();
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        creds.setNumberOfBeds(profile.getNumberOfBeds());
        creds.setNumberOfBedsEffectiveDate(BinderUtils.toCalendar(profile.getNumberOfBedsEffectiveDate()));
    }
}
