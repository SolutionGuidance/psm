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

package gov.medicaid.services.util;

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.binders.FormBinder;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.RiskLevelType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RiskLevel;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.ProviderEnrollmentService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Translates the hibernate model to the business process model.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public final class XMLAdapter {

    /**
     * The lookup service.
     */
    private static LookupService lookupService;

    /**
     * The presentation service.
     */
    private static PresentationService presentationService;

    /**
     * The enrollment service.
     */
    private static ProviderEnrollmentService enrollmentService;

    /**
     * Registry of binders.
     */
    private static Map<String, FormBinder> binderRegistry;

    /**
     * Self configure dependencies.
     */
    static {
        CMSConfigurator config = new CMSConfigurator();
        lookupService = config.getLookupService();
        presentationService = config.getPresentationService();
        binderRegistry = config.getBinderRegistry();
        enrollmentService = config.getEnrollmentService();
    }

    /**
     * Private constructor.
     */
    private XMLAdapter() {
    }

    /**
     * For integration with the BPM service.
     *
     * @param ticket the ticket to map
     * @return the mapped request
     */
    public static EnrollmentType toXML(Enrollment ticket) {
        EnrollmentType enrollment = new EnrollmentType();
        if (ticket.getTicketId() > 0) {
            enrollment.setObjectId(String.valueOf(ticket.getTicketId()));
        }
        if (ticket.getRequestType() != null) {
            enrollment.setRequestType(RequestType.fromValue(ticket.getRequestType().getDescription()));
        }

        enrollment.setProcessInstanceId(ticket.getProcessInstanceId());
        enrollment.setProgressPage(ticket.getProgressPage());
        if (ticket.getSubmittedBy() != null) {
            enrollment.setSubmittedBy(ticket.getSubmittedBy().getUserId());
        }
        enrollment.setSubmittedOn(BinderUtils.toCalendar(ticket.getSubmissionDate()));
        enrollment.setStatusDate(BinderUtils.toCalendar(ticket.getStatusDate()));

        ProviderProfile profile = ticket.getDetails();
        if (profile != null) {
            RiskLevel riskLevel = profile.getRiskLevel();
            if (riskLevel != null) {
                enrollment.setRiskLevel(RiskLevelType.fromValue(riskLevel.getDescription()));
            }
        }

        if (ticket.getStatus() != null) {
            enrollment.setStatus(ticket.getStatus().getDescription());
        }

        // always run this binder
        FormBinder typeBinder = binderRegistry.get(ViewStatics.PROVIDER_TYPE_FORM);
        typeBinder.bindFromHibernate(ticket, enrollment);

        ViewModel viewModel = presentationService.getProviderViewModel(profile);

        Collection<UITabModel> pages = viewModel.getTabModels().values();
        for (UITabModel uiTabModel : pages) {
            List<String> formNames = uiTabModel.getFormNames();
            for (String form : formNames) {
                FormBinder binder = binderRegistry.get(form);
                if (binder != null) {
                    binder.bindFromHibernate(ticket, enrollment);
                } else {
                    throw new PortalServiceConfigurationException("No binder registered for form: " + form);
                }
            }
        }

        List<Document> attachments = profile.getAttachments();
        AttachedDocumentsType at = XMLUtility.nsGetAttachments(enrollment.getProviderInformation());
        for (Document attachment : attachments) {
            DocumentType doc = new DocumentType();
            doc.setObjectId("" + attachment.getId());
            doc.setName(attachment.getFilename());
            doc.setMimeType(attachment.getType());
            at.getAttachment().add(doc);
        }

        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        provider.setObjectId(String.valueOf(profile.getProfileId()));
        // verification fields
        VerificationStatusType verification = new VerificationStatusType();
        provider.setVerificationStatus(verification);
        if (profile.getEntity() != null) {
            provider.setLegacyTransfer(profile.getEntity().getLegacyIndicator());
            verification.setNonExclusion(profile.getEntity().getNonExclusionVerifiedInd());
        }

        return enrollment;
    }

    /**
     * Converts the given xml to the HBM model.
     *
     * @param user the current user
     * @param enrollment the enrollment to be converted
     * @return the mapped ticket
     * @throws PortalServiceException for any errors encountered
     */
    public static Enrollment fromXML(CMSUser user, EnrollmentType enrollment) throws PortalServiceException {
        Enrollment ticket = new Enrollment();

        // bind fields only valid for create
        RequestType requestType = enrollment.getRequestType();
        if (requestType != null) {
            ticket.setRequestType(lookupService.findLookupByDescription(gov.medicaid.entities.RequestType.class,
                requestType.value()));
        }

        return mergeFromXML(user, enrollment, ticket);
    }

    /**
     * Merges the given xml to an existing ticket.
     *
     * @param user the current user
     * @param enrollment the enrollment to be merged
     * @param ticket the ticket to merge to
     * @return the mapped ticket
     * @throws PortalServiceException for any errors encountered
     */
    public static Enrollment mergeFromXML(CMSUser user, EnrollmentType enrollment, Enrollment ticket)
        throws PortalServiceException {
        ticket.setProgressPage(enrollment.getProgressPage());

        // always run this binder
        FormBinder typeBinder = binderRegistry.get(ViewStatics.PROVIDER_TYPE_FORM);
        typeBinder.bindToHibernate(enrollment, ticket);

        ViewModel viewModel = presentationService.getProviderViewModel(enrollment.getProviderInformation());

        Collection<UITabModel> pages = viewModel.getTabModels().values();
        for (UITabModel uiTabModel : pages) {
            List<String> formNames = uiTabModel.getFormNames();
            for (String form : formNames) {
                FormBinder binder = binderRegistry.get(form);
                if (binder != null) {
                    binder.bindToHibernate(enrollment, ticket);
                } else {
                    throw new PortalServiceConfigurationException("No binder registered for form: " + form);
                }
            }
        }

        // this can come from many different pages.
        associateUploads(user, enrollment, ticket);

        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        ProviderProfile profile = ticket.getDetails();
        profile.setProfileId(BinderUtils.getAsLong(provider.getObjectId()));
        ticket.setTicketId(BinderUtils.getAsLong(enrollment.getObjectId()));

        if (enrollment.getRiskLevel() != null) {
            RiskLevelType riskLevel = enrollment.getRiskLevel();
            switch (riskLevel) {
            case HIGH:
                profile.setRiskLevel(lookupService.findLookupByDescription(RiskLevel.class, "High"));
                break;
            case MODERATE:
                profile.setRiskLevel(lookupService.findLookupByDescription(RiskLevel.class, "Moderate"));
                break;
            case LIMITED:
                profile.setRiskLevel(lookupService.findLookupByDescription(RiskLevel.class, "Limited"));
                break;
            }
        }

        // verification fields
        VerificationStatusType verification = provider.getVerificationStatus();
        Entity entity = profile.getEntity();
        if (entity != null) {
            entity.setLegacyIndicator(provider.getLegacyTransfer());
        }
        if (verification != null && entity != null) {
            entity.setNonExclusionVerifiedInd(verification.getNonExclusion());
        }
        return ticket;
    }

    /**
     * Uploads are already saved, so we just associate the entities.
     * @param user the user
     * @param enrollment the enrollment to associate to
     * @param ticket the ticket to associate to
     * @throws PortalServiceException for any errors encountered
     */
    private static void associateUploads(CMSUser user, EnrollmentType enrollment, Enrollment ticket)
        throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        profile.setAttachments(new ArrayList<Document>());

        List<Document> profileList = profile.getAttachments();
        AttachedDocumentsType ao = XMLUtility.nsGetAttachments(enrollment.getProviderInformation());
        List<DocumentType> list = ao.getAttachment();
        for (DocumentType doc : list) {
            Document oldCopy = enrollmentService.findAttachment(user, Long.parseLong(doc.getObjectId()));
            if (oldCopy != null) {
                Document clone = BinderUtils.clone(oldCopy);
                clone.setFilename(doc.getName());
                profileList.add(clone); // detach from session
            }
        }
    }

    /**
     * For integration with approval.
     *
     * @param processModel the process model
     * @param ticket the enrollment ticket
     */
    public static void copyApprovalFieldsToTicket(EnrollmentProcess processModel, Enrollment ticket) {

    }

    /**
     * Wraps the given profile into an enrollment XML.
     * @param baseProfile the profile to be wrapped
     * @return the wrapped profile
     */
    public static EnrollmentType toXML(ProviderProfile baseProfile) {
        Enrollment wrapper = new Enrollment();
        wrapper.setDetails(baseProfile);
        return toXML(wrapper);
    }
}
