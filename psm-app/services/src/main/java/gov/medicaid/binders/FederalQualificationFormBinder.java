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
package gov.medicaid.binders;

import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentNames;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
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
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the organization disclosure.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FederalQualificationFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_37_";

    /**
     * Creates a new binder.
     */
    public FederalQualificationFormBinder() {
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
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        creds.setFederalQualificationType(param(request, "qualificationType"));

        String attachmentId = (String) request.getAttribute(NAMESPACE + "hcfaApproval");
        if (attachmentId != null) {
            replaceDocument(attachments, attachmentId, DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value());
        }

        attachmentId = (String) request.getAttribute(NAMESPACE + "grantDocuments");
        if (attachmentId != null) {
            replaceDocument(attachments, attachmentId, DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value());
        }

        attachmentId = (String) request.getAttribute(NAMESPACE + "statusContract");
        if (attachmentId != null) {
            replaceDocument(attachments, attachmentId, DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value());
        }

        attachmentId = (String) request.getAttribute(NAMESPACE + "indianHealthServiceContract");
        if (attachmentId != null) {
            replaceDocument(attachments, attachmentId, DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value());
        }

        if (DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value().equals(creds.getFederalQualificationType())) {
            deleteAttachment(attachments, DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value());
            deleteAttachment(attachments, DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value());
            deleteAttachment(attachments, DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value());
        } else if (DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value().equals(creds.getFederalQualificationType())) {
            deleteAttachment(attachments, DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value());
            deleteAttachment(attachments, DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value());
            deleteAttachment(attachments, DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value());
        } else if (DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value().equals(creds.getFederalQualificationType())) {
            deleteAttachment(attachments, DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value());
            deleteAttachment(attachments, DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value());
            deleteAttachment(attachments, DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value());
        } else if (DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value().equals(creds.getFederalQualificationType())) {
            deleteAttachment(attachments, DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value());
            deleteAttachment(attachments, DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value());
            deleteAttachment(attachments, DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value());
        }

        return Collections.EMPTY_LIST;
    }

    private void deleteAttachment(AttachedDocumentsType attachments2, String name) {
        List<DocumentType> attachments = attachments2.getAttachment();
        if (attachments != null) {
            for (Iterator<DocumentType> iterator = attachments.iterator(); iterator.hasNext();) {
                DocumentType document = iterator.next();
                if (name.equals(document.getName())) {
                    iterator.remove();
                    break;
                }
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

        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        attr(mv, "qualificationType", creds.getFederalQualificationType());

        for (DocumentType doc : attachment) {
            if (DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value().equals(doc.getName())) {
                attr(mv, "hcfaApproval", doc.getObjectId());
            } else if (DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value().equals(doc.getName())) {
                attr(mv, "grantDocuments", doc.getObjectId());
            } else if (DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value().equals(doc.getName())) {
                attr(mv, "statusContract", doc.getObjectId());
            } else if (DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value().equals(doc.getName())) {
                attr(mv, "indianHealthServiceContract", doc.getObjectId());
            }
        }
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

                if (path.equals("/ProviderInformation/AttachedDocuments[name=\"Federal Qualification Type\"]")) {
                    FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
                    if (DocumentNames.APPROVAL_LETTER_FROM_HEALTH_CARE_FINANCE_ADMINISTRATION_HCFA.value().equals(creds.getFederalQualificationType())) {
                        errors.add(createError(new String[]{"hcfaApproval"}, ruleError.getMessage()));
                    } else if (DocumentNames.COPIES_OF_THE_330_GRANT_DOCUMENTS.value().equals(creds.getFederalQualificationType())) {
                        errors.add(createError(new String[]{"grantDocuments"}, ruleError.getMessage()));
                    } else if (DocumentNames.COVER_PAGE_OF_PUBLIC_LAW_93_638_STATUS_CONTRACT.value().equals(creds.getFederalQualificationType())) {
                        errors.add(createError(new String[]{"statusContract"}, ruleError.getMessage()));
                    } else if (DocumentNames.COMPACT_WITH_THE_INDIAN_HEALTH_SERVICE.value().equals(creds.getFederalQualificationType())) {
                        errors.add(createError(new String[]{"indianHealthServiceContract"}, ruleError.getMessage()));
                    } else {
                        errors.add(createError("group", ruleError.getMessage()));
                    }
                } else if (path.equals("/ProviderInformation/FacilityCredentials/FederalQualificationType")) {
                    errors.add(createError("qualificationType", ruleError.getMessage()));
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
        Organization org = (Organization) profile.getEntity();
        org.setProviderSubType(credentials.getFederalQualificationType());
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
        if (profile.getEntity() instanceof Organization) {
            Organization org = (Organization) profile.getEntity();
            credentials.setFederalQualificationType(org.getProviderSubType());
        }
    }
}
