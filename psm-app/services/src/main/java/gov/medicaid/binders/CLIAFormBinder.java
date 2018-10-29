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
import gov.medicaid.domain.model.CLIACertificateType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.License;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * This binder handles the provider type selection form.
 */
public class CLIAFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_22_";

    /**
     * License path.
     */
    private static final String LICENSE_PATH = "/ProviderInformation/FacilityCredentials/CLIACertificate[";

    /**
     * Creates a new binder.
     */
    public CLIAFormBinder() {
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
        FacilityCredentialsType licenseInfo = XMLUtility.nsGetFacilityCredentials(applicationType);
        List<CLIACertificateType> licenseList = new ArrayList<CLIACertificateType>(licenseInfo.getCLIACertificate());
        licenseInfo.getCLIACertificate().clear();

        // bind licenses
        int i = 0;
        Set<String> linkedAttachments = new HashSet<String>();
        while (param(request, "licenseNumber", i) != null) {
            CLIACertificateType licenseType = new CLIACertificateType();
            licenseType.setCertificateNumber(param(request, "licenseNumber", i));

            String attachmentId = (String) request.getAttribute(name("attachment", i));
            if (attachmentId == null) { // not uploaded check for old value
                attachmentId = param(request, "attachmentId", i);
            }
            if (Util.isNotBlank(attachmentId)) {
                linkedAttachments.add(attachmentId);
            }
            licenseType.setAttachmentObjectId(attachmentId);
            licenseType.setObjectId(param(request, "objectId", i));

            synchronized (licenseInfo.getCLIACertificate()) {
                licenseInfo.getCLIACertificate().add(licenseType);
            }
            i++;
        }

        synchronized (licenseList) {
            // unbind old attachments if there are no longer license references
            for (CLIACertificateType old : licenseList) {
                String attachmentObjectId = old.getAttachmentObjectId();
                if (Util.isNotBlank(attachmentObjectId)) {
                    // check if has been replaced/unlinked
                    if (!linkedAttachments.contains(old.getAttachmentObjectId())) {
                        BinderUtils.unbindAttachment(XMLUtility.nsGetAttachments(provider), old.getAttachmentObjectId());
                    }
                }
            }
        }

        return Collections.emptyList();
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType licenseInfo = XMLUtility.nsGetFacilityCredentials(applicationType);
        List<CLIACertificateType> xLicenses = licenseInfo.getCLIACertificate();
        synchronized (xLicenses) {
            int i = 0;
            for (CLIACertificateType license : xLicenses) {
                attr(mv, "licenseNumber", i, license.getCertificateNumber());
                attr(mv, "attachmentId", i, license.getAttachmentObjectId());
                attr(mv, "filename", i, getAttachmentName(applicationType, license.getAttachmentObjectId()));
                i++;
            }
            attr(mv, "attachmentSize", i);
        }
    }

    /**
     * Retrieves the related attachment name.
     *
     * @param application the application to retrieve from
     * @param attachmentObjectId the id
     * @return the name related
     */
    private String getAttachmentName(ApplicationType applicationType, String attachmentObjectId) {
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(applicationType.getProviderInformation());
        List<DocumentType> list = attachments.getAttachment();
        synchronized (list) {
            for (DocumentType documentType : list) {
                if (documentType.getObjectId().equals(attachmentObjectId)) {
                    return documentType.getName();
                }
            }
        }
        return null;
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param application the application that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
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

                if (path.startsWith(LICENSE_PATH)) {
                    FormError error = resolveFieldError(ruleError);
                    errors.add(error);
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
     * Resolves the specific license that is causing the error from the license list.
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        String message = ruleError.getMessage();

        if (index != null) {
            if (path.endsWith("/CertificateNumber")) {
                return createError("licenseNumber", index, message);
            } else if (path.endsWith("AttachmentObjectId")) {
                return createError("attachmentId", index, message);
            }
        }

        // general location error
        return createError("group", message);
    }

    /**
     * Resolves the index of the field that caused the error.
     * @param path the field path
     * @return the index of the field, null if cannot be resolved
     */
    private Integer resolveIndex(String path) {
        String strIdx = Util.getStringInBetween(path, "[", "]");
        if (!Util.isBlank(strIdx)) {
            return Integer.parseInt(strIdx);
        }
        return null;
    }

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param applicationType the front end model
     * @param application the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        FacilityCredentialsType licenseInfo = XMLUtility.nsGetFacilityCredentials(applicationType);
        ProviderProfile profile = application.getDetails();
        if (profile.getCertifications() == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_CLIA);
        profile.getCertifications().removeAll(hList);
        Map<String, License> hMap = mapById(hList);

        List<CLIACertificateType> xList = licenseInfo.getCLIACertificate();
        for (CLIACertificateType xLicense : xList) {
            License hLicense = null;
            if (hMap.get(xLicense.getObjectId()) != null) {
                hLicense = hMap.get(xLicense.getObjectId());
            } else {
                hLicense = new License();
            }
            hLicense.setObjectType(ViewStatics.DISCRIMINATOR_CLIA);
            hLicense.setLicenseNumber(xLicense.getCertificateNumber());
            if (Util.isNotBlank(xLicense.getAttachmentObjectId())) {
                hLicense.setAttachmentId(Long.parseLong(xLicense.getAttachmentObjectId()));
            }
            profile.getCertifications().add(hLicense);
        }
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        FacilityCredentialsType licenseInfo = XMLUtility.nsGetFacilityCredentials(applicationType);
        ProviderProfile profile = application.getDetails();
        List<License> certifications = profile.getCertifications();
        if (certifications == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        licenseInfo.getCLIACertificate().clear();

        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_CLIA);
        for (License license : hList) {
            CLIACertificateType xLicense = new CLIACertificateType();
            xLicense.setCertificateNumber(license.getLicenseNumber());
            if (license.getAttachmentId() > 0) {
                xLicense.setAttachmentObjectId("" + license.getAttachmentId());
            }
            xLicense.setObjectId("" + license.getId());
            licenseInfo.getCLIACertificate().add(xLicense);
        }
    }

    /**
     * Maps the given license list by the id.
     *
     * @param hList the list to map
     * @return the mapped licenses
     */
    private Map<String, License> mapById(List<License> hList) {
        Map<String, License> m = new HashMap<String, License>();
        synchronized (hList) {
            for (License license : hList) {
                m.put("" + license.getId(), license);
            }
        }
        return m;
    }

    /**
     * Filters the given certifications by type.
     *
     * @param certifications the list to filter
     * @param type the required type
     * @return the filtered matches
     */
    private List<License> filterLicenses(List<License> certifications, String type) {
        ArrayList<License> list = new ArrayList<License>();
        synchronized (certifications) {
            for (License license : certifications) {
                if (type.equals(license.getObjectType())) {
                    list.add(license);
                }
            }
        }
        return list;
    }
}
