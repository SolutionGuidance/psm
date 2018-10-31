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

package gov.medicaid.services.util;

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.binders.FormBinder;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.RiskLevelType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.DmfAutomaticScreening;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.LeieAutomaticScreening;
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
import gov.medicaid.services.ProviderApplicationService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Translates the hibernate model to the business process model.
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
     * The application service.
     */
    private static ProviderApplicationService applicationService;

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
        applicationService = config.getApplicationService();
    }

    /**
     * Private constructor.
     */
    private XMLAdapter() {
    }

    /**
     * For integration with the BPM service.
     *
     * @param application the application to map
     * @return the mapped request
     */
    public static ApplicationType toXML(Application application) {
        ApplicationType applicationType = new ApplicationType();
        if (application.getApplicationId() > 0) {
            applicationType.setObjectId(String.valueOf(application.getApplicationId()));
        }
        if (application.getRequestType() != null) {
            applicationType.setRequestType(RequestType.fromValue(application.getRequestType().getDescription()));
        }

        applicationType.setActive(application.isActive());

        applicationType.setProcessInstanceId(application.getProcessInstanceId());
        applicationType.setProgressPage(application.getProgressPage());
        if (application.getSubmittedBy() != null) {
            applicationType.setSubmittedBy(application.getSubmittedBy().getUserId());
        }
        applicationType.setSubmittedOn(BinderUtils.toCalendar(application.getSubmissionDate()));
        applicationType.setStatusDate(BinderUtils.toCalendar(application.getStatusDate()));

        ProviderProfile profile = application.getDetails();
        if (profile != null) {
            RiskLevel riskLevel = profile.getRiskLevel();
            if (riskLevel != null) {
                applicationType.setRiskLevel(RiskLevelType.fromValue(riskLevel.getDescription()));
            }
        }

        if (application.getStatus() != null) {
            applicationType.setStatus(application.getStatus().getDescription());
        }

        // always run this binder
        FormBinder typeBinder = binderRegistry.get(ViewStatics.PROVIDER_TYPE_FORM);
        typeBinder.bindFromHibernate(application, applicationType);

        ViewModel viewModel = presentationService.getProviderViewModel(profile);

        Collection<UITabModel> pages = viewModel.getTabModels().values();
        for (UITabModel uiTabModel : pages) {
            List<String> formNames = uiTabModel.getFormNames();
            for (String form : formNames) {
                FormBinder binder = binderRegistry.get(form);
                if (binder != null) {
                    binder.bindFromHibernate(application, applicationType);
                } else {
                    throw new PortalServiceConfigurationException("No binder registered for form: " + form);
                }
            }
        }

        List<Document> attachments = profile.getAttachments();
        AttachedDocumentsType at = XMLUtility.nsGetAttachments(applicationType.getProviderInformation());
        for (Document attachment : attachments) {
            DocumentType doc = new DocumentType();
            doc.setObjectId("" + attachment.getId());
            doc.setName(attachment.getFilename());
            doc.setMimeType(attachment.getType());
            at.getAttachment().add(doc);
        }

        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        provider.setObjectId(String.valueOf(profile.getProfileId()));
        provider.setOwnerId(profile.getOwnerId());
        // verification fields
        VerificationStatusType verification = new VerificationStatusType();
        provider.setVerificationStatus(verification);
        application.getAutomaticScreenings()
            .forEach(as -> {
                if (as instanceof LeieAutomaticScreening) {
                    if (Boolean.TRUE.equals(as.getManualConfirmation())) {
                         verification.setNonExclusion("Y");
                    }
                } else if (as instanceof DmfAutomaticScreening) {
                    if (Boolean.TRUE.equals(as.getManualConfirmation())) {
                         verification.setNotInDmf("Y");
                    }
                }
            });

        return applicationType;
    }

    /**
     * Converts the given xml to the HBM model.
     *
     * @param user the current user
     * @param application the application to be converted
     * @return the mapped application
     * @throws PortalServiceException for any errors encountered
     */
    public static Application fromXML(CMSUser user, ApplicationType applicationType) throws PortalServiceException {
        Application application = new Application();

        // bind fields only valid for create
        RequestType requestType = applicationType.getRequestType();
        if (requestType != null) {
            application.setRequestType(lookupService.findLookupByDescription(gov.medicaid.entities.RequestType.class,
                requestType.value()));
        }

        return mergeFromXML(user, applicationType, application);
    }

    /**
     * Merges the given xml to an existing application.
     *
     * @param user the current user
     * @param application the application to be merged
     * @param application the application to merge to
     * @return the mapped application
     * @throws PortalServiceException for any errors encountered
     */
    public static Application mergeFromXML(CMSUser user, ApplicationType applicationType, Application application)
        throws PortalServiceException {
        application.setProgressPage(applicationType.getProgressPage());

        // always run this binder
        FormBinder typeBinder = binderRegistry.get(ViewStatics.PROVIDER_TYPE_FORM);
        typeBinder.bindToHibernate(applicationType, application);

        ViewModel viewModel = presentationService.getProviderViewModel(applicationType.getProviderInformation());

        Collection<UITabModel> pages = viewModel.getTabModels().values();
        for (UITabModel uiTabModel : pages) {
            List<String> formNames = uiTabModel.getFormNames();
            for (String form : formNames) {
                FormBinder binder = binderRegistry.get(form);
                if (binder != null) {
                    binder.bindToHibernate(applicationType, application);
                } else {
                    throw new PortalServiceConfigurationException("No binder registered for form: " + form);
                }
            }
        }

        // this can come from many different pages.
        associateUploads(user, applicationType, application);

        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ProviderProfile profile = application.getDetails();
        profile.setOwnerId(provider.getOwnerId());
        profile.setProfileId(BinderUtils.getAsLong(provider.getObjectId()));
        application.setApplicationId(BinderUtils.getAsLong(applicationType.getObjectId()));

        if (applicationType.getRiskLevel() != null) {
            RiskLevelType riskLevel = applicationType.getRiskLevel();
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
        if (verification != null) {
            application.getAutomaticScreenings().stream().forEach(as -> {
                if (as instanceof LeieAutomaticScreening) {
                    as.setManualConfirmation("Y".equals(verification.getNonExclusion()));
                } else if (as instanceof DmfAutomaticScreening) {
                    as.setManualConfirmation("Y".equals(verification.getNotInDmf()));
                }
            });
        }
        return application;
    }

    public static List<AutomaticScreening> mergeFromXML(
        List<AutomaticScreening> screenings,
        ApplicationType application) {

        ProviderInformationType provider = XMLUtility.nsGetProvider(application);

        // verification fields
        VerificationStatusType verification = provider.getVerificationStatus();
        if (verification != null) {
            screenings.stream().forEach(as -> {
                if (as instanceof LeieAutomaticScreening) {
                    as.setManualConfirmation("Y".equals(verification.getNonExclusion()));
                } else if (as instanceof DmfAutomaticScreening) {
                    as.setManualConfirmation("Y".equals(verification.getNotInDmf()));
                }
            });
        }

        return screenings;
    }

    /**
     * Uploads are already saved, so we just associate the entities.
     * @param user the user
     * @param application the application to associate to
     * @param application the application to associate to
     * @throws PortalServiceException for any errors encountered
     */
    private static void associateUploads(CMSUser user, ApplicationType applicationType, Application application)
        throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        profile.setAttachments(new ArrayList<Document>());

        List<Document> profileList = profile.getAttachments();
        AttachedDocumentsType ao = XMLUtility.nsGetAttachments(applicationType.getProviderInformation());
        List<DocumentType> list = ao.getAttachment();
        for (DocumentType doc : list) {
            Document oldCopy = applicationService.findAttachment(user, Long.parseLong(doc.getObjectId()));
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
     * @param application the application
     */
    public static void copyApprovalFieldsToApplication(ApplicationProcess processModel, Application application) {

    }

    /**
     * Wraps the given profile into an application XML.
     * @param baseProfile the profile to be wrapped
     * @return the wrapped profile
     */
    public static ApplicationType toXML(ProviderProfile baseProfile) {
        Application wrapper = new Application();
        wrapper.setDetails(baseProfile);
        return toXML(wrapper);
    }
}
