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
import gov.medicaid.domain.model.CountyContractType;
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
public class FacilityTypeFormBinder extends BaseFormBinder {

    private static final String CONTRACT_WITH_COUNTY = "Contract With County";
    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_36_";

    /**
     * Creates a new binder.
     */
    public FacilityTypeFormBinder() {
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
        credentials.setFacilityType(param(request, "facilityType"));
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        if ("A county contracted provider".equals(credentials.getFacilityType())) {
            CountyContractType countyInfo = new CountyContractType();
            credentials.setContractWithCounty(countyInfo);

            String attachmentId = (String) request.getAttribute(NAMESPACE + "countyContract");
            if (attachmentId != null) {
                replaceDocument(XMLUtility.nsGetAttachments(provider), attachmentId, CONTRACT_WITH_COUNTY);
            }

            List<DocumentType> attachment = attachments.getAttachment();
            for (DocumentType doc : attachment) {
                if (CONTRACT_WITH_COUNTY.equals(doc.getName())) {
                    countyInfo.setContractAttachmentObjectId(doc.getObjectId());
                    break;
                }
            }
        } else {
            deleteAttachment(attachments, CONTRACT_WITH_COUNTY);
            credentials.setContractWithCounty(null);
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


    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        attr(mv, "facilityType", credentials.getFacilityType());
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        List<DocumentType> attachment = attachments.getAttachment();
        for (DocumentType doc : attachment) {
            if (CONTRACT_WITH_COUNTY.equals(doc.getName())) {
                attr(mv, "countyContract", doc.getObjectId());
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

                if (path.equals("/ProviderInformation/FacilityCredentials/ContractWithCounty")) {
                    errors.add(createError("countyContract", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/FacilityCredentials/FacilityType")) {
                    errors.add(createError("facilityType", ruleError.getMessage()));
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
        org.setProviderSubType(credentials.getFacilityType());
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
            credentials.setFacilityType(org.getProviderSubType());
        }
    }
}
