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

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.QualifiedProfessionalType;
import gov.medicaid.domain.model.QualifiedProfessionalsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Address;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.License;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.QPType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * This binder handles the provider type selection form.
 */
public class QualifiedProfessionalFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_29_";

    /**
     * License path.
     */
    private static final String QP_PATH = "/ProviderInformation/QualifiedProfessionals/QualifiedProfessional[";

    /**
     * Creates a new binder.
     */
    public QualifiedProfessionalFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param application
     *            the model to bind to
     * @param request
     *            the request containing the form fields
     *
     * @throws BinderException
     *             if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);

        QualifiedProfessionalsType qps = XMLUtility.nsGetQualifiedProfessionals(applicationType);
        List<QualifiedProfessionalType> qpList = qps.getQualifiedProfessional();

        // track all attachments related to affiliation licenses
        List<LicenseType> licenseList = new ArrayList<LicenseType>();
        for (QualifiedProfessionalType qp : qpList) {
            licenseList.addAll(qp.getLicense());
        }

        qpList.clear();

        // bind licenses
        int qpIndex = 0;
        Set<String> linkedAttachments = new HashSet<String>();
        while (param(request, "qpType", qpIndex) != null) {
            QualifiedProfessionalType qp = new QualifiedProfessionalType();
            qp.setType(param(request, "qpType", qpIndex));
            qp.setSubType(param(request, "qpSubType", qpIndex));
            qp.setFullName(param(request, "name", qpIndex));
            qp.setNPI(param(request, "npi", qpIndex));
            qp.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "ssn", qpIndex)));
            try {
                qp.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "dob", qpIndex)));
            } catch (BinderException e) {
                e.setAttribute(name("dob", qpIndex), param(request, "dob", qpIndex));
                exceptions.add(e);
            }
            try {
                qp.setStartDate(BinderUtils.getAsCalendar(param(request, "startDate", qpIndex)));
            } catch (BinderException e) {
                e.setAttribute(name("startDate", qpIndex), param(request, "startDate", qpIndex));
                exceptions.add(e);
            }
            qp.setEndedInd(param(request, "ended", qpIndex) != null ? "Y" : "N");
            if ("Y".equals(qp.getEndedInd())) {
                try {
                    qp.setEndDate(BinderUtils.getAsCalendar(param(request, "endDate", qpIndex)));
                } catch (BinderException e) {
                    e.setAttribute(name("endDate", qpIndex), param(request, "endDate", qpIndex));
                    exceptions.add(e);
                }
            }

            AddressType address = readIndexedAddress(request, qpIndex);
            ContactInformationType contact = new ContactInformationType();
            qp.setContactInformation(contact);
            qp.getContactInformation().setAddress(address);

            qp.setBGSNumber(param(request, "bgsNumber", qpIndex));
            try {
                qp.setBGSClearanceDate(BinderUtils.getAsCalendar(param(request, "bgsClearanceDate", qpIndex)));
            } catch (BinderException e) {
                e.setAttribute(name("bgsClearanceDate", qpIndex), param(request, "bgsClearanceDate", qpIndex));
                exceptions.add(e);
            }

            int licenseIndex = 0;
            while (param(request, "licenseType_" + qpIndex, licenseIndex) != null) {
                LicenseType licenseType = new LicenseType();
                licenseType.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);
                licenseType.setLicenseType(param(request, "licenseType_" + qpIndex, licenseIndex));
                licenseType.setLicenseNumber(param(request, "licenseNumber_" + qpIndex, licenseIndex));
                try {
                    licenseType.setOriginalIssueDate(BinderUtils.getAsCalendar(param(request, "originalIssueDate_"
                            + qpIndex, licenseIndex)));
                } catch (BinderException e) {
                    e.setAttribute(name("originalIssueDate_" + qpIndex, licenseIndex),
                            param(request, "originalIssueDate_" + qpIndex, licenseIndex));
                    exceptions.add(e);
                }
                try {
                    licenseType.setRenewalDate(BinderUtils.getAsCalendar(param(request, "renewalDate_" + qpIndex,
                            licenseIndex)));
                } catch (BinderException e) {
                    e.setAttribute(name("renewalDate_" + qpIndex, licenseIndex),
                            param(request, "renewalDate_" + qpIndex, licenseIndex));
                    exceptions.add(e);
                }
                licenseType.setIssuingState(param(request, "issuingState_" + qpIndex, licenseIndex));

                String attachmentId = (String) request.getAttribute(name("attachment_" + qpIndex, licenseIndex));
                if (attachmentId == null) { // not uploaded check for old value
                    attachmentId = param(request, "attachmentId_" + qpIndex, licenseIndex);
                }
                if (Util.isNotBlank(attachmentId)) {
                    linkedAttachments.add(attachmentId);
                }
                licenseType.setAttachmentObjectId(attachmentId);
                licenseType.setObjectId(param(request, "objectId_" + qpIndex, licenseIndex));

                qp.getLicense().add(licenseType);
                licenseIndex++;
            }
            qpList.add(qp);
            qpIndex++;

        }

        // unbind old attachments if there are no longer affiliate license references
        for (LicenseType old : licenseList) {
            String attachmentObjectId = old.getAttachmentObjectId();
            if (Util.isNotBlank(attachmentObjectId)) {
                // check if has been replaced/unlinked
                if (!linkedAttachments.contains(old.getAttachmentObjectId())) {
                    BinderUtils.unbindAttachment(XMLUtility.nsGetAttachments(provider), old.getAttachmentObjectId());
                }
            }
        }
        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param application
     *            the model to bind from
     * @param mv
     *            the model and view to bind to
     * @param readOnly
     *            if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);

        QualifiedProfessionalsType qps = XMLUtility.nsGetQualifiedProfessionals(applicationType);
        List<QualifiedProfessionalType> qpList = qps.getQualifiedProfessional();

        int qpIndex = 0;
        for (QualifiedProfessionalType qp : qpList) {
            attr(mv, "qpType", qpIndex, qp.getType());
            attr(mv, "qpSubType", qpIndex, qp.getSubType());
            attr(mv, "name", qpIndex, qp.getFullName());
            attr(mv, "npi", qpIndex, qp.getNPI());
            attr(mv, "ssn", qpIndex, BinderUtils.formatSSN(qp.getSocialSecurityNumber()));
            attr(mv, "dob", qpIndex, qp.getDateOfBirth());
            attr(mv, "startDate", qpIndex, qp.getStartDate());
            attr(mv, "ended", qpIndex, qp.getEndedInd());
            attr(mv, "endDate", qpIndex, qp.getEndDate());
            attr(mv, "bgsNumber", qpIndex, qp.getBGSNumber());
            attr(mv, "bgsClearanceDate", qpIndex, qp.getBGSClearanceDate());

            if (qp.getContactInformation() != null) {
                AddressType address = qp.getContactInformation().getAddress();
                if (address != null) {
                    attr(mv, qpIndex, address);
                }
            }

            List<LicenseType> xLicenses = qp.getLicense();

            int licenseIndex = 0;
            for (LicenseType license : xLicenses) {
                attr(mv, "licenseType_" + qpIndex, licenseIndex, license.getLicenseType());
                attr(mv, "licenseNumber_" + qpIndex, licenseIndex, license.getLicenseNumber());
                attr(mv, "originalIssueDate_" + qpIndex, licenseIndex, license.getOriginalIssueDate());
                attr(mv, "renewalDate_" + qpIndex, licenseIndex, license.getRenewalDate());
                attr(mv, "issuingState_" + qpIndex, licenseIndex, license.getIssuingState());
                attr(mv, "attachmentId_" + qpIndex, licenseIndex, license.getAttachmentObjectId());
                attr(mv, "filename_" + qpIndex, licenseIndex,
                        getAttachmentName(applicationType, license.getAttachmentObjectId()));
                licenseIndex++;
            }

            attr(mv, "licenseSize_" + qpIndex, licenseIndex);
            qpIndex++;
        }
        attr(mv, "qpSize", qpIndex);

        ProviderType pt = getLookupService().findLookupByDescription(ProviderType.class, provider.getProviderType());

        if (!readOnly) {
            List<gov.medicaid.entities.LicenseType> type = getLookupService().findRelatedLookup(
                    gov.medicaid.entities.LicenseType.class, pt.getCode(), ViewStatics.REL_QP_LICENSE_OPTIONS);
            attr(mv, "licenseTypes", type);

            List<gov.medicaid.entities.StateType> state = new ArrayList<gov.medicaid.entities.StateType>();
            state.add(getLookupService().findLookupByCode(gov.medicaid.entities.StateType.class, "MN"));

            attr(mv, "licenseStates", state);

            attr(mv, "qpTypes", getLookupService().findAllLookups(QPType.class));
        }
    }

    /**
     * Retrieves only QP affiliations.
     *
     * @param affiliations
     *            the affiliations to be filtered
     * @return the filtered affiliations
     */
    private List<Affiliation> filterQPs(List<Affiliation> affiliations) {
        List<Affiliation> qps = new ArrayList<Affiliation>();
        if (affiliations == null) {
            return qps;
        }

        synchronized (affiliations) {
            for (Affiliation affiliation : affiliations) {
                if (ViewStatics.DISCRIMINATOR_QP.equals(affiliation.getObjectType())) {
                    qps.add(affiliation);
                }
            }
        }
        return qps;
    }

    /**
     * Retrieves the related attachment name.
     *
     * @param application
     *            the application to retrieve from
     * @param attachmentObjectId
     *            the id
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
     *
     * @param application
     *            the application that was validated
     * @param messages
     *            the messages to select from
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

                if (path.equals("/ProviderInformation/QualifiedProfessionals")) {
                    errors.add(createError("qualifiedProfessionals", ruleError.getMessage()));
                } else if (path.startsWith(QP_PATH)) {
                    FormError error = resolveFieldError(ruleError);
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
     *
     * @param ruleError
     *            the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        String message = ruleError.getMessage();

        if (index != null) {
            if (path.startsWith(QP_PATH + index + "]/License")) {
                return resolveLicenseFieldError(index, ruleError);
            } else if (path.endsWith("FullName")) {
                return createError("name", index, message);
            } else if (path.endsWith("BGSClearanceDate")) {
                return createError("bgsClearanceDate", index, message);
            } else if (path.endsWith("BGSNumber")) {
                return createError("bgsNumber", index, message);
            } else if (path.endsWith("StartDate")) {
                return createError("startDate", index, message);
            } else if (path.endsWith("NPI")) {
                return createError("npi", index, message);
            } else if (path.endsWith("SocialSecurityNumber")) {
                return createError("ssn", index, message);
            } else if (path.endsWith("DateOfBirth")) {
                return createError("dob", index, message);
            } else if (path.endsWith("Type")) {
                return createError("qpType", index, message);
            }
        }

        // general location error
        return createError("group", message);
    }

    private FormError resolveLicenseFieldError(Integer qpIndex, StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path.substring((QP_PATH + qpIndex + "]").length()));
        String message = ruleError.getMessage();

        if (index != null) {
            message = ruleError.getMessage() + "(QP# " + (qpIndex + 1) + ", License #" + (index + 1) + ")";
            if (path.endsWith("LicenseType")) {
                return createError("licenseType_" + qpIndex, index, message);
            } else if (path.endsWith("SpecialtyType")) {
                return createError("licenseType_" + qpIndex, index, message);
            } else if (path.endsWith("LicenseNumber")) {
                return createError("licenseNumber_" + qpIndex, index, message);
            } else if (path.endsWith("OriginalIssueDate")) {
                return createError("originalIssueDate_" + qpIndex, index, message);
            } else if (path.endsWith("RenewalDate")) {
                return createError("renewalDate_" + qpIndex, index, message);
            } else if (path.endsWith("IssuingState")) {
                return createError("issuingState_" + qpIndex, index, message);
            } else if (path.endsWith("AttachmentObjectId")) {
                return createError("attachment_" + qpIndex, index, message);
            }
        }

        // general location error
        return createError("group", message);
    }

    /**
     * Resolves the index of the field that caused the error.
     *
     * @param path
     *            the field path
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
     * @param application
     *            the front end model
     * @param application
     *            the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        QualifiedProfessionalsType xQPs = XMLUtility.nsGetQualifiedProfessionals(applicationType);

        ProviderProfile profile = application.getDetails();
        if (profile.getAffiliations() == null) {
            profile.setAffiliations(new ArrayList<Affiliation>());
        }

        List<Affiliation> oldQPList = filterQPs(profile.getAffiliations());
        profile.getAffiliations().removeAll(oldQPList);

        List<QualifiedProfessionalType> qpList = xQPs.getQualifiedProfessional();
        for (QualifiedProfessionalType qp : qpList) {
            Affiliation a = new Affiliation();
            a.setObjectType(ViewStatics.DISCRIMINATOR_QP);
            a.setQpType(getLookupService().findLookupByDescription(QPType.class, qp.getType()));
            a.setMhpType(qp.getSubType());
            a.setEffectiveDate(BinderUtils.toDate(qp.getStartDate()));
            a.setTerminatedInd(qp.getEndedInd());
            a.setTerminationDate(BinderUtils.toDate(qp.getEndDate()));
            a.setAcknowledgementAttachmentId(qp.getAcknowledgementObjectId());
            Person person = new Person();
            a.setEntity(person);
            person.setName(qp.getFullName());
            person.setSsn(qp.getSocialSecurityNumber());
            person.setDob(BinderUtils.toDate(qp.getDateOfBirth()));
            person.setNpi(qp.getNPI());
            person.setBackgroundStudyId(qp.getBGSNumber());
            if (qp.getContactInformation() != null) {
                person.setContactInformation(new ContactInformation());
                AddressType address = qp.getContactInformation().getAddress();
                person.getContactInformation().setAddress(BinderUtils.bindAddress(address));
            }
            person.setBackgroundClearanceDate(BinderUtils.toDate(qp.getBGSClearanceDate()));

            List<License> affiliateLicenses = new ArrayList<License>();
            List<LicenseType> xList = qp.getLicense();
            for (LicenseType xLicense : xList) {
                License hLicense = new License();
                hLicense.setType(getLookupService().findLookupByDescription(gov.medicaid.entities.LicenseType.class,
                        xLicense.getLicenseType()));
                hLicense.setLicenseNumber(xLicense.getLicenseNumber());
                if (Util.isNotBlank(xLicense.getAttachmentObjectId())) {
                    hLicense.setAttachmentId(Long.parseLong(xLicense.getAttachmentObjectId()));
                }
                hLicense.setOriginalIssueDate(BinderUtils.toDate(xLicense.getOriginalIssueDate()));
                hLicense.setRenewalEndDate(BinderUtils.toDate(xLicense.getRenewalDate()));
                hLicense.setIssuingUSState(xLicense.getIssuingState());
                affiliateLicenses.add(hLicense);
            }
            a.setAffiliateLicenses(affiliateLicenses);
            profile.getAffiliations().add(a);
        }
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application
     *            the persistent model
     * @param application
     *            the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        List<Affiliation> hQPs = filterQPs(profile.getAffiliations());
        QualifiedProfessionalsType xQPs = XMLUtility.nsGetQualifiedProfessionals(applicationType);

        for (Affiliation hQP : hQPs) {
            QualifiedProfessionalType xQP = new QualifiedProfessionalType();
            if (hQP.getQpType() != null) {
                xQP.setType(hQP.getQpType().getDescription());
            }
            xQP.setSubType(hQP.getMhpType());
            xQP.setStartDate(BinderUtils.toCalendar(hQP.getEffectiveDate()));
            xQP.setEndedInd(hQP.getTerminatedInd());
            xQP.setEndDate(BinderUtils.toCalendar(hQP.getTerminationDate()));
            xQP.setAcknowledgementObjectId(hQP.getAcknowledgementAttachmentId());
            Person person = (Person) hQP.getEntity();
            if (person != null) {
                xQP.setFullName(person.getName());
                xQP.setSocialSecurityNumber(person.getSsn());
                xQP.setDateOfBirth(BinderUtils.toCalendar(person.getDob()));
                xQP.setNPI(person.getNpi());
                xQP.setBGSNumber(person.getBackgroundStudyId());
                xQP.setBGSClearanceDate(BinderUtils.toCalendar(person.getBackgroundClearanceDate()));
                if (person.getContactInformation() != null) {
                    xQP.setContactInformation(new ContactInformationType());
                    Address address = person.getContactInformation().getAddress();
                    xQP.getContactInformation().setAddress(BinderUtils.bindAddress(address));
                }
            }

            List<License> hList = hQP.getAffiliateLicenses();
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
                xQP.getLicense().add(xLicense);
            }

            xQPs.getQualifiedProfessional().add(xQP);
        }
    }
}
