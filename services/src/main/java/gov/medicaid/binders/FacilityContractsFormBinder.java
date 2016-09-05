/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SignedContractType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.License;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the provider type selection form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FacilityContractsFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_34_";

    /**
     * License path.
     */
    private static final String LICENSE_PATH = "/ProviderInformation/FacilityCredentials/SignedContract[";

    private static final String[] ALL_CONTRACTS = new String[] {"Adult Rehabilitative Mental Health Services",
        "Children's Therapeutic Services and Supports (CTSS)", "Adult Crisis Response Services - Crisis Assessment & Crisis Intervention",
        "Adult Crisis Response Services - Crisis Stabilization", "Adult Crisis Response Services - Short-Term Residential",};
    
    /**
     * Creates a new binder.
     */
    public FacilityContractsFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        List<SignedContractType> oldContracts = new ArrayList<SignedContractType>(creds.getSignedContract());
        List<SignedContractType> contracts = creds.getSignedContract();
        contracts.clear();

        // bind licenses
        int i = 0;
        Set<String> linkedAttachments = new HashSet<String>();
        while (param(request, "contractType", i) != null) {
            if (param(request, "certificateInd", i) != null) {
                SignedContractType contract = new SignedContractType();
                contract.setCertificateInd(param(request, "certificateInd", i));
                contract.setName(param(request, "contractType", i));
                try {
                    contract.setBeginDate(BinderUtils.getAsCalendar(param(request, "beginDate", i)));
                } catch (BinderException e) {
                    e.setAttribute(name("beginDate", i), param(request, "beginDate", i));
                    exceptions.add(e);
                }
                
                try {
                    contract.setEndDate(BinderUtils.getAsCalendar(param(request, "endDate", i)));
                } catch (BinderException e) {
                    e.setAttribute(name("endDate", i), param(request, "endDate", i));
                    exceptions.add(e);
                }
    
                String attachmentId = (String) request.getAttribute(name("attachment", i));
                if (attachmentId == null) { // not uploaded check for old value
                    attachmentId = param(request, "attachmentId", i);
                }
                if (Util.isNotBlank(attachmentId)) {
                    linkedAttachments.add(attachmentId);
                }
                contract.setCopyAttachmentId(attachmentId);
                contracts.add(contract);
            }
            i++;
        }

        // unbind old attachments if there are no longer license references
        for (SignedContractType old : oldContracts) {
            String attachmentObjectId = old.getCopyAttachmentId();
            if (Util.isNotBlank(attachmentObjectId)) {
                // check if has been replaced/unlinked
                if (!linkedAttachments.contains(old.getCopyAttachmentId())) {
                    BinderUtils.unbindAttachment(XMLUtility.nsGetAttachments(provider), old.getCopyAttachmentId());
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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        List<SignedContractType> xContracts = creds.getSignedContract();
        for (int j = 0; j < ALL_CONTRACTS.length; j++) {
            String option = ALL_CONTRACTS[j];
            for (SignedContractType contract : xContracts) {
                if (option.equals(contract.getName())) {
                    attr(mv, "contractType", j, contract.getName());
                    attr(mv, "certificateInd", j, "Y");
                    attr(mv, "beginDate", j, contract.getBeginDate());
                    attr(mv, "endDate", j, contract.getEndDate());
                    attr(mv, "attachmentId", j, contract.getCopyAttachmentId());
                    attr(mv, "filename", j, getAttachmentName(enrollment, contract.getCopyAttachmentId()));
                    break;
                } else {
                    attr(mv, "certificateInd", j, "N");
                }
            }
        }
        attr(mv, "attachmentSize", xContracts.size());
    }

    /**
     * Retrieves the related attachment name.
     *
     * @param enrollment the enrollment to retrieve from
     * @param attachmentObjectId the id
     * @return the name related
     */
    private String getAttachmentName(EnrollmentType enrollment, String attachmentObjectId) {
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(enrollment.getProviderInformation());
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
            Map<Integer, Integer> indexMap = mapByName(XMLUtility.nsGetFacilityCredentials(enrollment).getSignedContract());
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals("/ProviderInformation/FacilityCredentials/SignedContract")) {
                    errors.add(createError("signedContracts", ruleError.getMessage()));
                } else if (path.startsWith(LICENSE_PATH)) {
                    
                    FormError error = resolveFieldError(ruleError, indexMap);
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
     * Maps the given license list by the id.
     *
     * @param hList the list to map
     * @return the mapped licenses
     */
    private Map<Integer, Integer> mapByName(List<SignedContractType> hList) {
        Map<Integer, Integer> m = new HashMap<Integer, Integer>();
        for (int j = 0; j < ALL_CONTRACTS.length; j++) {
            String option = ALL_CONTRACTS[j];
            int i = 0;
            for (SignedContractType signedContractType : hList) {
                if (option.equals(signedContractType.getName())) {
                    m.put(i, j);
                    break;
                }
                i++;
            }
            
        }
        return m;
    }

    /**
     * Resolves the specific license that is causing the error from the license list.
     * @param ruleError the error to resolve
     * @param indexMap the mapping of real indices
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError, Map<Integer, Integer> indexMap) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);
        if (index != null) {
            index = indexMap.get(index);
        }

        String message = ruleError.getMessage();
        if (index != null) {
            message = ruleError.getMessage() + "(Contract/Certificate #" + (index + 1) + ")";
            if (path.endsWith("BeginDate")) {
                return createError("beginDate", index, message);
            } else if (path.endsWith("EndDate")) {
                return createError("endDate", index, message);
            } else if (path.endsWith("CopyAttachmentId")) {
                return createError("attachment", index, message);
            }
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
     * @param enrollment the front end model
     * @param ticket the persistent model
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        ProviderProfile profile = ticket.getDetails();
        if (profile.getCertifications() == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_CONTRACT);
        profile.getCertifications().removeAll(hList);
        List<SignedContractType> xList = creds.getSignedContract();
        for (SignedContractType xLicense : xList) {
            License hLicense = new License();
            hLicense.setObjectType(ViewStatics.DISCRIMINATOR_CONTRACT);
            hLicense.setType(getLookupService().findLookupByDescription(gov.medicaid.entities.LicenseType.class,
                xLicense.getName()));
            if (Util.isNotBlank(xLicense.getCopyAttachmentId())) {
                hLicense.setAttachmentId(Long.parseLong(xLicense.getCopyAttachmentId()));
            }
            hLicense.setOriginalIssueDate(BinderUtils.toDate(xLicense.getBeginDate()));
            hLicense.setRenewalEndDate(BinderUtils.toDate(xLicense.getEndDate()));
            profile.getCertifications().add(hLicense);
        }
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(enrollment);
        ProviderProfile profile = ticket.getDetails();
        List<License> certifications = profile.getCertifications();
        if (certifications == null) {
            profile.setCertifications(new ArrayList<License>());
        }
        List<SignedContractType> xList = creds.getSignedContract();
        creds.getLicense().removeAll(xList);

        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_CONTRACT);
        for (License license : hList) {
            SignedContractType xLicense = new SignedContractType();
            if (license.getType() != null) {
                xLicense.setName(license.getType().getDescription());
            }
            if (license.getAttachmentId() > 0) {
                xLicense.setCopyAttachmentId("" + license.getAttachmentId());
            }
            xLicense.setBeginDate(BinderUtils.toCalendar(license.getOriginalIssueDate()));
            xLicense.setEndDate(BinderUtils.toCalendar(license.getRenewalEndDate()));
            xLicense.setObjectId("" + license.getId());
            creds.getSignedContract().add(xLicense);
        }
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
