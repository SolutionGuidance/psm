/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.CountyContractType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.dto.FormError;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


/**
 * This binder handles the organization disclosure.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AdultDayTreatmentApplicationFormBinder extends BaseFormBinder {

    private static final String ADULT_DAY_TREATMENT_APPLICATION = "Adult Day Treatment Application";
    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_35_";

    /**
     * Creates a new binder.
     */
    public AdultDayTreatmentApplicationFormBinder() {
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        CountyContractType countyInfo = new CountyContractType();
        credentials.setContractWithCounty(countyInfo);
        
        String attachmentId = (String) request.getAttribute(NAMESPACE + "application");
        if (attachmentId != null) {
            replaceDocument(XMLUtility.nsGetAttachments(provider), attachmentId, ADULT_DAY_TREATMENT_APPLICATION);
        }

        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType doc : attachment) {
            if (ADULT_DAY_TREATMENT_APPLICATION.equals(doc.getName())) {
                credentials.setAdultDayTreatmentApplication(doc.getObjectId());
                break;
            }
        }
        
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType doc : attachment) {
            if (ADULT_DAY_TREATMENT_APPLICATION.equals(doc.getName())) {
                attr(mv, "application", doc.getObjectId());
                break;
            }
        }

    }

    private void replaceDocument(AttachedDocumentsType attachments, String id, String value) {
        List<DocumentType> toRemove = new ArrayList<DocumentType>();
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType doc : attachment) {
            if (id.equals(doc.getObjectId())) {
                doc.setName(value);
            } else if (value.equals(doc.getName())) {
                toRemove.add(doc);
            }
        }
        
        attachments.getAttachment().removeAll(toRemove);
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
                
                if (path.equals("/ProviderInformation/FacilityCredentials/AdultDayTreatmentApplication")) {
                    errors.add(createError("application", ruleError.getMessage()));
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
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
    }
}
