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

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.LicenseInformationType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.License;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.util.PDFHelper;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * This binder handles the provider type selection form.
 */
public class LicenseInformationFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_03_";

    /**
     * License path.
     */
    private static final String LICENSE_PATH = "/ProviderInformation/LicenseInformation/License";

    /**
     * Creates a new binder.
     */
    public LicenseInformationFormBinder() {
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
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        LicenseInformationType licenseInfo = XMLUtility.nsGetLicenseInformation(provider);
        List<LicenseType> licenseList = filter(licenseInfo.getLicense(), ViewStatics.DISCRIMINATOR_LICENSE);
        synchronized (licenseInfo.getLicense()) {
            licenseInfo.getLicense().removeAll(licenseList);
        }

        // bind licenses
        int i = 0;
        Set<String> linkedAttachments = new HashSet<String>();
        while (param(request, "licenseType", i) != null) {
            LicenseType licenseType = new LicenseType();
            licenseType.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);
            licenseType.setLicenseType(param(request, "licenseType", i));
            licenseType.setLicenseNumber(param(request, "licenseNumber", i));
            try {
                licenseType.setOriginalIssueDate(BinderUtils.getAsCalendar(param(request, "originalIssueDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("originalIssueDate", i), param(request, "originalIssueDate", i));
                exceptions.add(e);
            }
            try {
                licenseType.setRenewalDate(BinderUtils.getAsCalendar(param(request, "renewalDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("renewalDate", i), param(request, "renewalDate", i));
                exceptions.add(e);
            }
            licenseType.setIssuingState(param(request, "issuingState", i));

            String attachmentId = (String) request.getAttribute(name("attachment", i));
            if (attachmentId == null) { // not uploaded check for old value
                attachmentId = param(request, "attachmentId", i);
            }
            if (Util.isNotBlank(attachmentId)) {
                linkedAttachments.add(attachmentId);
            }
            licenseType.setAttachmentObjectId(attachmentId);
            licenseType.setObjectId(param(request, "objectId", i));

            synchronized (licenseInfo.getLicense()) {
                licenseInfo.getLicense().add(licenseType);
            }
            i++;
        }

        synchronized (licenseList) {
            // unbind old attachments if there are no longer license references
            for (LicenseType old : licenseList) {
                String attachmentObjectId = old.getAttachmentObjectId();
                if (Util.isNotBlank(attachmentObjectId)) {
                    // check if has been replaced/unlinked
                    if (!linkedAttachments.contains(old.getAttachmentObjectId())) {
                        BinderUtils.unbindAttachment(XMLUtility.nsGetAttachments(provider), old.getAttachmentObjectId());
                    }
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
        LicenseInformationType licenseInfo = XMLUtility.nsGetLicenseInformation(provider);
        List<LicenseType> xLicenses = licenseInfo.getLicense();
        synchronized (xLicenses) {
            int i = 0;
            for (LicenseType license : xLicenses) {
                if (!ViewStatics.DISCRIMINATOR_LICENSE.equals(license.getObjectType())) {
                    continue;
                }
                attr(mv, "licenseType", i, license.getLicenseType());
                attr(mv, "licenseNumber", i, license.getLicenseNumber());
                attr(mv, "originalIssueDate", i, license.getOriginalIssueDate());
                attr(mv, "renewalDate", i, license.getRenewalDate());
                attr(mv, "issuingState", i, license.getIssuingState());
                attr(mv, "attachmentId", i, license.getAttachmentObjectId());
                attr(mv, "filename", i, getAttachmentName(applicationType, license.getAttachmentObjectId()));
                i++;
            }
            attr(mv, "attachmentSize", i);
        }

        ProviderType pt = getProviderTypeService().getByDescription(provider.getProviderType());

        if (!readOnly) {
            attr(mv, "licenseTypes", pt.getLicenseTypes());

            List<gov.medicaid.entities.StateType> state = new ArrayList<gov.medicaid.entities.StateType>();
            if (applicationType.getProviderInformation().getProviderType().equals(gov.medicaid.domain.model.ProviderType.COMMUNITY_HEALTH_CARE_WORKER.value())
                    || applicationType.getProviderInformation().getProviderType().equals(gov.medicaid.domain.model.ProviderType.PERSONAL_CARE_ASSISTANT.value())) {
                state = getLookupService().findRelatedLookup(
                        gov.medicaid.entities.StateType.class, pt.getCode(), ViewStatics.REL_LICENSE_STATE_OPTIONS);
            } else {
                state = getLookupService().findAllLookups(gov.medicaid.entities.StateType.class);
            }
            attr(mv, "licenseStates", state);
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

        LicenseInformationType licenseInformation = XMLUtility.nsGetLicenseInformation(applicationType
            .getProviderInformation());
        List<LicenseType> licenses = filter(licenseInformation.getLicense(), ViewStatics.DISCRIMINATOR_LICENSE);
        Map<Integer, Integer> indexMapping = mapIndexes(licenseInformation.getLicense(), licenses);
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.startsWith(LICENSE_PATH)) {
                    FormError error = resolveFieldError(indexMapping, ruleError);
                    if (error != null) {
                        errors.add(error);
                    }
                }
                if (errors.size() > count) { // caught
                    caughtMessages.add(ruleError);
                }
            }
            // so it does not get processed anywhere again
            ruleErrors.removeAll(caughtMessages);
        }

        if (errors.isEmpty()) {
            return NO_ERRORS;
        }
        return errors;
    }

    /**
     * Resolves the specific license that is causing the error from the license list.
     * @param indexMapping the license index mapping
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(Map<Integer, Integer> indexMapping, StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = indexMapping.get(resolveIndex(path));

        String message = ruleError.getMessage();
        if (index != null) {
            message = ruleError.getMessage() + "(License #" + (index + 1) + ")";
            if (path.endsWith("LicenseType")) {
                return createError("licenseType", index, message);
            } else if (path.endsWith("SpecialtyType")) {
                return createError("licenseType", index, message);
            } else if (path.endsWith("LicenseNumber")) {
                return createError("licenseNumber", index, message);
            } else if (path.endsWith("OriginalIssueDate")) {
                return createError("originalIssueDate", index, message);
            } else if (path.endsWith("RenewalDate")) {
                return createError("renewalDate", index, message);
            } else if (path.endsWith("IssuingState")) {
                return createError("issuingState", index, message);
            } else if (path.endsWith("AttachmentObjectId")) {
                return createError("attachment", index, message);
            }
        }

        if (path.endsWith("Required")) {
            return createError("application", ruleError.getMessage());
        }
        // not a license field error
        return null;
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        LicenseInformationType licenseInfo = XMLUtility.nsGetLicenseInformation(provider);
        ProviderProfile profile = application.getDetails();
        if (profile.getCertifications() == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_LICENSE);
        profile.getCertifications().removeAll(hList);
        Map<String, License> hMap = mapById(hList);

        List<LicenseType> xList = filter(licenseInfo.getLicense(), ViewStatics.DISCRIMINATOR_LICENSE);
        for (LicenseType xLicense : xList) {
            License hLicense = null;
            if (hMap.get(xLicense.getObjectId()) != null) {
                hLicense = hMap.get(xLicense.getObjectId());
            } else {
                hLicense = new License();
            }
            hLicense.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);

            hLicense.setType(getLookupService().findLookupByDescription(gov.medicaid.entities.LicenseType.class,
                xLicense.getLicenseType()));
            hLicense.setLicenseNumber(xLicense.getLicenseNumber());
            if (Util.isNotBlank(xLicense.getAttachmentObjectId())) {
                hLicense.setAttachmentId(Long.parseLong(xLicense.getAttachmentObjectId()));
            }
            hLicense.setOriginalIssueDate(BinderUtils.toDate(xLicense.getOriginalIssueDate()));
            hLicense.setRenewalEndDate(BinderUtils.toDate(xLicense.getRenewalDate()));
            hLicense.setIssuingUSState(xLicense.getIssuingState());
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        LicenseInformationType licenseInfo = XMLUtility.nsGetLicenseInformation(provider);
        ProviderProfile profile = application.getDetails();
        List<License> certifications = profile.getCertifications();
        if (certifications == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        List<LicenseType> xList = filter(licenseInfo.getLicense(), ViewStatics.DISCRIMINATOR_LICENSE);
        licenseInfo.getLicense().removeAll(xList);

        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_LICENSE);
        for (License license : hList) {
            LicenseType xLicense = new LicenseType();
            if (license.getType() != null) {
                xLicense.setLicenseType(license.getType().getDescription());
            }
            xLicense.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);
            xLicense.setLicenseNumber(license.getLicenseNumber());
            if (license.getAttachmentId() > 0) {
                xLicense.setAttachmentObjectId("" + license.getAttachmentId());
            }
            xLicense.setOriginalIssueDate(BinderUtils.toCalendar(license.getOriginalIssueDate()));
            xLicense.setRenewalDate(BinderUtils.toCalendar(license.getRenewalEndDate()));
            xLicense.setIssuingState(license.getIssuingUSState());
            xLicense.setObjectId("" + license.getId());
            licenseInfo.getLicense().add(xLicense);
        }
    }

    @Override
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model)
        throws DocumentException {
        String ns = NAMESPACE;
        if ("Y".equals(PDFHelper.value(model, ns, "bound"))) {
            // License Info Section
            PdfPTable licenseInfo = new PdfPTable(new float[] {3, 10, 10, 10, 10, 10});
            licenseInfo.getDefaultCell().setBorder(0);
            licenseInfo.getDefaultCell().setHorizontalAlignment(PdfPCell.ALIGN_CENTER);

            licenseInfo.setTotalWidth(72 * 7);
            licenseInfo.setLockedWidth(true);

            PDFHelper.addCenterCell(licenseInfo, "#");
            PDFHelper.addCenterCell(licenseInfo, "Type of License/Certification");
            PDFHelper.addCenterCell(licenseInfo, "License/Certification #");
            PDFHelper.addCenterCell(licenseInfo, "Original Issue Date (MM/DD/YYYY)");
            PDFHelper.addCenterCell(licenseInfo, "Renewal End Date (MM/DD/YYYY)");
            PDFHelper.addCenterCell(licenseInfo, "Issuing State");
            licenseInfo.completeRow();

            int size = Integer.parseInt(PDFHelper.value(model, ns, "attachmentSize"));
            for (int i = 0; i < size; i++) {
                PDFHelper.addCenterCell(licenseInfo, String.valueOf(i + 1));
                PDFHelper.addCenterCell(licenseInfo, PDFHelper.value(model, ns, "licenseType", i));
                PDFHelper.addCenterCell(licenseInfo, PDFHelper.value(model, ns, "licenseNumber", i));
                PDFHelper.addCenterCell(licenseInfo, PDFHelper.value(model, ns, "originalIssueDate", i));
                PDFHelper.addCenterCell(licenseInfo, PDFHelper.value(model, ns, "renewalDate", i));
                PDFHelper.addCenterCell(licenseInfo, PDFHelper.value(model, ns, "issuingState", i));
            }

            document.add(licenseInfo);
        }
    }

    /**
     * Filters the given license objects and gets only those of the given type.
     *
     * @param license the licenses to filter
     * @param objectType the type to return
     * @return the matching licenses
     */
    private List<LicenseType> filter(List<LicenseType> license, String objectType) {
        List<LicenseType> licenseObjects = new ArrayList<LicenseType>();
        synchronized (license) {
            for (LicenseType licenseType : license) {
                if (objectType.equals(licenseType.getObjectType())) {
                    licenseObjects.add(licenseType);
                }
            }
        }
        return licenseObjects;
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
