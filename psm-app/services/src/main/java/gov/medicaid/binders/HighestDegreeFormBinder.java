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

import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentNames;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Degree;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
 */
public class HighestDegreeFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_14_";

    /**
     * The XML path that maps to highest degree.
     */
    private static final String DEGREE_PATH = "/ProviderInformation/ApplicantInformation/PersonalInformation/"
        + "HighestDegreeEarned";

    /**
     * The XML path that maps to additional practice question.
     */
    private static final String DEGREE_DATE_PATH = "/ProviderInformation/ApplicantInformation/PersonalInformation/"
        + "DegreeAwardDate";

    /**
     * Creates a new binder.
     */
    public HighestDegreeFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException for binding errors
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        individual.setHighestDegreeEarned(param(request, "highestDegreeEarned"));
        try {
            individual.setDegreeAwardDate(BinderUtils.getAsCalendar(param(request, "degreeAwardDate")));
        } catch (BinderException e) {
            e.setAttribute(name("degreeAwardDate"), param(request, "degreeAwardDate"));
            exceptions.add(e);
        }

        String attachmentId = (String) request.getAttribute(id() + "copyOfHighestDegree");
        if (Util.isNotBlank(attachmentId)) { // set the document name properly
            AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
            List<DocumentType> allAttachments = attachments.getAttachment();
            for (DocumentType documentType : allAttachments) {
                if (attachmentId.equals(documentType.getObjectId())) {
                    documentType.setName(DocumentNames.COPY_OF_HIGHEST_DEGREE_EARNED.value());
                }
            }
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        attr(mv, "highestDegreeEarned", individual.getHighestDegreeEarned());
        attr(mv, "degreeAwardDate", individual.getDegreeAwardDate());

        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);
        List<DocumentType> allAttachments = attachments.getAttachment();
        for (DocumentType documentType : allAttachments) {
            if (DocumentNames.COPY_OF_HIGHEST_DEGREE_EARNED.value().equals(documentType.getName())) {
                documentType.setName(DocumentNames.COPY_OF_HIGHEST_DEGREE_EARNED.value());
                attr(mv, "copyOfHighestDegree", documentType.getObjectId());
            }
        }

        if (!readOnly) {
            List<Degree> type = getLookupService().findAllLookups(Degree.class);
            attr(mv, "degreeTypes", type);
        }
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

                if (path.equals(DEGREE_PATH)) {
                    errors.add(createError("highestDegreeEarned", ruleError.getMessage()));
                } else if (path.equals(DEGREE_DATE_PATH)) {
                    errors.add(createError("degreeAwardDate", ruleError.getMessage()));
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
     * @throws PortalServiceException for binding errors
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Person)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        ProviderInformationType providerInfo = applicationType.getProviderInformation();
        if (providerInfo != null) {
            Person person = (Person) profile.getEntity();
            ApplicantInformationType ai = providerInfo.getApplicantInformation();
            if (ai != null && ai.getPersonalInformation() != null) {
                IndividualApplicantType pInfo = ai.getPersonalInformation();
                if (Util.isNotBlank(pInfo.getHighestDegreeEarned())) {
                    person.setDegree(getLookupService().findLookupByDescription(Degree.class,
                        pInfo.getHighestDegreeEarned()));
                }
                person.setDegreeAwardDate(BinderUtils.toDate(pInfo.getDegreeAwardDate()));
            }
        }
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        if (profile != null) {
            Entity entity = profile.getEntity();
            if (entity != null) {
                Person person = (Person) entity;
                IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
                if (person.getDegree() != null) {
                    individual.setHighestDegreeEarned(person.getDegree().getDescription());
                }
                individual.setDegreeAwardDate(BinderUtils.toCalendar(person.getDegreeAwardDate()));
            }
        }
    }
}
