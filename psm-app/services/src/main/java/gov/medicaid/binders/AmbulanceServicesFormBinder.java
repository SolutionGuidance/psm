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

import gov.medicaid.domain.model.AmbulanceServicesType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.DocumentNames;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CategoryOfService;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the ambulance services licenses.
 */
public class AmbulanceServicesFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_39_";

    /**
     * Ambulance service selection.
     */
    private final List<CategoryOfService> categories = new ArrayList<CategoryOfService>();

    /**
     * Initializes the available options for ambulance services.
     */
    static {
    }

    /**
     * License path.
     */
    private static final String SERVICES_PATH = "/ProviderInformation/FacilityCredentials/AmbulanceServices[";

    /**
     * Creates a new binder.
     */
    public AmbulanceServicesFormBinder() {
        super(NAMESPACE);

        CategoryOfService cat = new CategoryOfService();
        cat.setCode("basicServices");
        cat.setDescription(DocumentNames.AMBULANCE_SERVICES_BASIC_SERVICE.value());
        categories.add(cat);

        CategoryOfService cat2 = new CategoryOfService();
        cat2.setCode("advancedLifeSupport");
        cat2.setDescription(DocumentNames.AMBULANCE_SERVICES_ADVANCED_LIFE_SUPPORT.value());
        categories.add(cat2);

        CategoryOfService cat3 = new CategoryOfService();
        cat3.setCode("airTransport");
        cat3.setDescription(DocumentNames.AMBULANCE_SERVICES_AIR_TRANSPORT_WITH_FAA_AIR_WORTHINESS_CERTIFICATE.value());
        categories.add(cat3);
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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        List<AmbulanceServicesType> servicesList = creds.getAmbulanceServices();
        AttachedDocumentsType attachments = XMLUtility.nsGetAttachments(provider);

        for (CategoryOfService category : categories) {
            String type1Indicator = param(request, category.getCode() + "Indicator");
            if ("Y".equals(type1Indicator)) {
                AmbulanceServicesType service = nsGetService(servicesList, category.getDescription());
                String attachmentId = (String) request.getAttribute(NAMESPACE + category.getCode());
                if (attachmentId != null) {
                    BinderUtils.replaceDocument(attachments, attachmentId, category.getDescription());
                    service.setAttachmentObjectId(attachmentId);
                }
            } else {
                removeService(servicesList, category.getDescription());
            }
        }
        return Collections.emptyList();
    }

    /**
     * Finds the service with the given name
     * @param servicesList the service list
     * @param serviceName the service name
     * @return the service from the list with the same name, if not found, a new one is created
     */
    private AmbulanceServicesType nsGetService(List<AmbulanceServicesType> servicesList, String serviceName) {
        for (AmbulanceServicesType ambulanceServicesType : servicesList) {
            if (serviceName.equalsIgnoreCase(ambulanceServicesType.getServiceType())) {
                return ambulanceServicesType;
            }
        }

        AmbulanceServicesType ambulanceServicesType = new AmbulanceServicesType();
        ambulanceServicesType.setServiceType(serviceName);
        servicesList.add(ambulanceServicesType);
        return ambulanceServicesType;
    }

    /**
     * Removes the service with the given name from the list.
     * @param servicesList the list to inspect
     * @param serviceName the name of the service to be removed
     */
    private void removeService(List<AmbulanceServicesType> servicesList, String serviceName) {
        List<AmbulanceServicesType> toRemove = new ArrayList<AmbulanceServicesType>();
        for (AmbulanceServicesType ambulanceServicesType : servicesList) {
            if (serviceName.equalsIgnoreCase(ambulanceServicesType.getServiceType())) {
                toRemove.add(ambulanceServicesType);
            }
        }
        servicesList.removeAll(toRemove);
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        List<AmbulanceServicesType> ambulanceServices = creds.getAmbulanceServices();
        for (AmbulanceServicesType service : ambulanceServices) {
            for (CategoryOfService category : categories) {
                if (category.getDescription().equals(service.getServiceType())) {
                    attr(mv, category.getCode() + "Indicator", "Y");
                    attr(mv, category.getCode(), service.getAttachmentObjectId());
                }
            }
        }
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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        List<AmbulanceServicesType> services = creds.getAmbulanceServices();
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.startsWith(SERVICES_PATH)) {
                    FormError error = resolveFieldError(services, ruleError);
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
     * @param services the services entered
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(List<AmbulanceServicesType> services, StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        AmbulanceServicesType service = services.get(index);
        String message = ruleError.getMessage() + "(" + service.getServiceType() + ")";

        if (index != null) {
            if (path.endsWith("/ServiceType")) {
                return createError("licenseNumber", index, message);
            } else if (path.endsWith("AttachmentObjectId")) {
                for (CategoryOfService category : categories) {
                    if (category.getDescription().equals(service.getServiceType())) {
                        return createError(category.getCode(), message);
                    }
                }
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
        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_AMBULANCE_SERVICE);
        profile.getCertifications().removeAll(hList);
        Map<String, License> hMap = mapById(hList);

        List<AmbulanceServicesType> xList = licenseInfo.getAmbulanceServices();
        for (AmbulanceServicesType xLicense : xList) {
            License hLicense = null;
            if (hMap.get(xLicense.getObjectId()) != null) {
                hLicense = hMap.get(xLicense.getObjectId());
            } else {
                hLicense = new License();
            }
            hLicense.setObjectType(ViewStatics.DISCRIMINATOR_AMBULANCE_SERVICE);
            hLicense.setType(getLookupService().findLookupByDescription(LicenseType.class, xLicense.getServiceType()));
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
        licenseInfo.getAmbulanceServices().clear();

        List<License> hList = filterLicenses(profile.getCertifications(), ViewStatics.DISCRIMINATOR_AMBULANCE_SERVICE);
        for (License license : hList) {
            AmbulanceServicesType xLicense = new AmbulanceServicesType();
            if (license.getType() != null) {
                xLicense.setServiceType(license.getType().getDescription());
            }
            if (license.getAttachmentId() > 0) {
                xLicense.setAttachmentObjectId("" + license.getAttachmentId());
            }
            xLicense.setObjectId("" + license.getId());
            licenseInfo.getAmbulanceServices().add(xLicense);
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
