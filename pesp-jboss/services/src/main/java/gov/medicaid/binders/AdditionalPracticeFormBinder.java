/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.AdditionalPracticeLocationsType;
import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.PracticeInformationType;
import gov.medicaid.domain.model.PracticeLocationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.PortalServiceRuntimeException;
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
public class AdditionalPracticeFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_07_";

    /**
     * Additional practice locations.
     */
    private static final String LOCATION_PATH = "/ProviderInformation/PracticeInformation/"
        + "AdditionalPracticeLocations/PracticeLocation";

    /**
     * Creates a new binder.
     */
    public AdditionalPracticeFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     *
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        AdditionalPracticeLocationsType locations = new AdditionalPracticeLocationsType();

        int i = 0;
        while (param(request, "objectId", i) != null) {
            PracticeLocationType location = new PracticeLocationType();
            location.setObjectId(param(request, "objectId", i)); // if lookup is successful
            if (Util.isNotBlank(location.getObjectId())) {
                String hash = param(request, "objectIdHash", i);
                if (!Util.hash(location.getObjectId(), getServerHashKey()).equals(hash)) {
                    throw new PortalServiceRuntimeException("Bad request. Invalid practice lookup hash.");
                }

                attachLinkedGroup(location);
            } else {
                location.setGroupNPI(param(request, "npi", i));
                location.setGroupName(param(request, "name", i));
                try {
                    location.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate", i)));
                } catch (BinderException e) {
                    e.setAttribute(name("effectiveDate", i), param(request, "effectiveDate", i));
                    exceptions.add(e);
                }

                AddressType address = new AddressType();
                String line2 = param(request, "addressLine2", i);
                String line1 = param(request, "addressLine1", i);
                if (Util.isBlank(line2)) {
                    line2 = line1;
                    line1 = null;
                }
                address.setAddressLine2(line1);
                address.setAddressLine2(line2);
                address.setCity(param(request, "city", i));
                address.setState(param(request, "state", i));
                address.setZipCode(param(request, "zip", i));
                address.setCounty(param(request, "county", i));
                location.setAddress(address);
            }

            locations.getPracticeLocation().add(location);
            i++;
        }

        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        practice.setAdditionalPracticeLocations(locations);
        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     *
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    public void bindToPage(EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        AdditionalPracticeLocationsType locations = XMLUtility.nsGetOtherLocations(practice);
        List<PracticeLocationType> xList = locations.getPracticeLocation();
        int i = 0;
        for (PracticeLocationType location : xList) {
            attr(mv, "objectId", i, location.getObjectId());
            if (Util.isNotBlank(location.getObjectId())) {
                attr(mv, "objectIdHash", i, Util.hash(location.getObjectId(), getServerHashKey()));
            }

            attr(mv, "npi", i, location.getGroupNPI());
            attr(mv, "name", i, location.getGroupName());
            attr(mv, "effectiveDate", i, location.getEffectiveDate());

            AddressType address = location.getAddress();
            if (address != null) {
                String line1 = address.getAddressLine1();
                String line2 = address.getAddressLine2();
                if (Util.isBlank(line1)) {
                    line1 = line2;
                    line2 = null;
                }
                attr(mv, "addressLine1", i, line1);
                attr(mv, "addressLine2", i, line2);
                attr(mv, "city", i, address.getCity());
                attr(mv, "state", i, address.getState());
                attr(mv, "zip", i, address.getZipCode());
                attr(mv, "county", i, address.getCounty());
            }
            i++;
        }

        attr(mv, "additonalLocationSize", xList.size());
    }

    /**
     * Captures the error messages related to the form.
     *
     * @param enrollment the enrollment that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        AdditionalPracticeLocationsType locations = XMLUtility.nsGetOtherLocations(practice);

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.startsWith(LOCATION_PATH)) {
                    FormError error = resolveFieldError(locations, ruleError);
                    errors.add(error);
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
     * @param locations the additional locations
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(AdditionalPracticeLocationsType locations, StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        String message = ruleError.getMessage();
        if (index != null) {
            PracticeLocationType location = locations.getPracticeLocation().get(index);
            message = ruleError.getMessage() + "(Group #" + (index + 1) + ")";
            
            boolean switchAddressLines = false;
            if (location.getAddress() != null || Util.isBlank(location.getAddress().getAddressLine1())) {
                // since line 2 is populated instead of line 1 by default
                switchAddressLines = true;
            }
            if (path.endsWith("Address")) {
                return createError(new String[]{"addressLine2", "addressLine1"}, index, message);
            } else if (path.endsWith("EffectiveDate")) {
                return createError("effectiveDate", index, message);
            } else if (path.endsWith("GroupName")) {
                return createError("name", index, message);
            } else if (path.endsWith("GroupNPI")) {
                return createError("npi", index, message);
            } else if (path.endsWith("AddressLine1")) {
                return createError(switchAddressLines ? "addressLine1" : "addressLine2", index, message);
            } else if (path.endsWith("AddressLine2")) {
                return createError(switchAddressLines ? "addressLine2" : "addressLine1", index, message);
            } else if (path.endsWith("City")) {
                return createError("city", index, message);
            } else if (path.endsWith("State")) {
                return createError("state", index, message);
            } else if (path.endsWith("ZipCode")) {
                return createError("zip", index, message);
            } else if (path.endsWith("County")) {
                return createError("county", index, message);
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
     * @param enrollment the front end model
     * @param ticket the persistent model
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        AdditionalPracticeLocationsType locations = XMLUtility.nsGetOtherLocations(practice);

        List<Affiliation> hList = new ArrayList<Affiliation>();
        List<PracticeLocationType> xList = locations.getPracticeLocation();
        for (PracticeLocationType location : xList) {
            Affiliation group = new Affiliation();
            group.setObjectType(ViewStatics.DISCRIMINATOR_LOCATION);
            group.setPrimaryInd("N");
            group.setEffectiveDate(BinderUtils.toDate(location.getEffectiveDate()));
            if (Util.isNotBlank(location.getObjectId())) {
                // store reference only
                group.setTargetProfileId(Long.parseLong(location.getObjectId()));
            } else {
                // owned record
                Organization employer = new Organization();
                employer.setNpi(location.getGroupNPI());
                employer.setName(location.getGroupName());
                ContactInformation contact = new ContactInformation();
                contact.setAddress(BinderUtils.bindAddress(location.getAddress()));
                employer.setContactInformation(contact);
                group.setEntity(employer);
            }
            hList.add(group);
        }

        ProviderProfile profile = ticket.getDetails();
        List<Affiliation> affiliations = removeOtherPracticeLocations(profile);

        synchronized (affiliations) {
            affiliations.addAll(hList);
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
        List<Affiliation> hList = filterOtherLocations(profile.getAffiliations());
        List<PracticeLocationType> xList = new ArrayList<PracticeLocationType>();
        for (Affiliation group : hList) {
            PracticeLocationType location = new PracticeLocationType();
            if (group.getTargetProfileId() > 0) {
                location.setObjectId(String.valueOf(group.getTargetProfileId()));
            }

            Entity entity = group.getEntity();
            location.setGroupNPI(entity.getNpi());
            location.setGroupName(entity.getName());
            location.setEffectiveDate(BinderUtils.toCalendar(group.getEffectiveDate()));

            ContactInformation contact = entity.getContactInformation();
            if (contact != null) {
                location.setAddress(BinderUtils.bindAddress(contact.getAddress()));
            }
            xList.add(location);
        }

        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        AdditionalPracticeLocationsType locations = XMLUtility.nsGetOtherLocations(practice);
        locations.getPracticeLocation().clear();
        locations.getPracticeLocation().addAll(xList);
    }

    /**
     * Removes all non primary practice locations from the given profile.
     *
     * @param profile the profile to manipulate
     * @return the remaining list of affiliation.
     */
    private List<Affiliation> removeOtherPracticeLocations(ProviderProfile profile) {
        if (profile.getAffiliations() == null) {
            profile.setAffiliations(new ArrayList<Affiliation>());
            return profile.getAffiliations();
        }

        List<Affiliation> affiliations = profile.getAffiliations();
        List<Affiliation> otherLocations = filterOtherLocations(affiliations);

        synchronized (affiliations) {
            affiliations.removeAll(otherLocations);
        }
        return affiliations;
    }

    /**
     * Retrieves only non primary locations.
     *
     * @param affiliations the affiliations to be filtered
     * @return the filtered affiliations
     */
    private List<Affiliation> filterOtherLocations(List<Affiliation> affiliations) {
        List<Affiliation> otherLocations = new ArrayList<Affiliation>();
        if (affiliations == null) {
            return otherLocations;
        }

        synchronized (affiliations) {
            for (Affiliation affiliation : affiliations) {
                if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())) {
                    if (!"Y".equals(affiliation.getPrimaryInd())) {
                        otherLocations.add(affiliation);
                    }
                }
            }
        }
        return otherLocations;
    }

    /**
     * Attaches the information from the linked group.
     *
     * @param location the practice location
     */
    private void attachLinkedGroup(PracticeLocationType location) {
        try {
            PracticeSearchCriteria criteria = new PracticeSearchCriteria();
            criteria.setProfileId(Long.parseLong(location.getObjectId()));
            SearchResult<PracticeLookup> results = getEnrollmentService().searchPractice(getSystemUser(), criteria);
            PracticeLookup linkedPractice = results.getItems().get(0);

            location.setGroupName(linkedPractice.getName());
            location.setGroupNPI(linkedPractice.getNpi());
            location.setAddress(new AddressType());

            AddressType address = location.getAddress();
            address.setAddressLine2(linkedPractice.getAddressLine2());
            address.setCity(linkedPractice.getCity());
            address.setState(linkedPractice.getState());
            address.setZipCode(linkedPractice.getZip());
            address.setCounty(linkedPractice.getCounty());

        } catch (PortalServiceException e) {
            throw new PortalServiceRuntimeException("Cannot verify linked practice.", e);
        }
    }

}
