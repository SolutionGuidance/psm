/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.binders;

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.CountyContractType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization disclosure.
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
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
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

        return Collections.emptyList();
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
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
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
     * @param application the application that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages) {
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
     * @param applicationType the front end model
     * @param application the persistent model
     * @throws PortalServiceException
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Organization)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
        Organization org = (Organization) profile.getEntity();
        org.setProviderSubType(credentials.getFacilityType());
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
        if (profile.getEntity() instanceof Organization) {
            Organization org = (Organization) profile.getEntity();
            credentials.setFacilityType(org.getProviderSubType());
        }
    }
}
