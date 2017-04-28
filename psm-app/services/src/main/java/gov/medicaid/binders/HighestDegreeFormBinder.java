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

import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentNames;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Degree;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the provider type selection form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException for binding errors
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
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
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
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
     * @param enrollment the front end model
     * @param ticket the persistent model
     * @throws PortalServiceException for binding errors
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Person)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        ProviderInformationType providerInfo = enrollment.getProviderInformation();
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
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        ProviderProfile profile = ticket.getDetails();
        if (profile != null) {
            Entity entity = profile.getEntity();
            if (entity != null) {
                Person person = (Person) entity;
                IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
                if (person.getDegree() != null) {
                    individual.setHighestDegreeEarned(person.getDegree().getDescription());
                }
                individual.setDegreeAwardDate(BinderUtils.toCalendar(person.getDegreeAwardDate()));
            }
        }
    }
}
