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

import gov.medicaid.domain.model.AgencyInformationType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.GroupAffiliationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.CMSUser;
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
public class AdditionalAgencyFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_12_";

    /**
     * Additional Agency path.
     */
    private static final String ADD_AGENCY_PATH = "/ProviderInformation/AgencyInformation/Affiliation";

    /**
     * Creates a new binder.
     */
    public AdditionalAgencyFormBinder() {
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

        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(enrollment);
        agency.getAffiliation().clear();

        int i = 0;
        while (param(request, "objectId", i) != null) {
            GroupAffiliationType location = new GroupAffiliationType();
            location.setObjectId(param(request, "objectId", i)); // if lookup is successful
            if (Util.isNotBlank(location.getObjectId())) {
                String hash = param(request, "objectIdHash", i);
                if (!Util.hash(location.getObjectId(), getServerHashKey()).equals(hash)) {
                    throw new PortalServiceRuntimeException("Bad request. Invalid practice lookup hash.");
                }

                attachLinkedGroup(location);
            } else {
                location.setNPI(param(request, "npi", i));
                location.setName(param(request, "name", i));
                location.setStudyId(param(request, "studyId", i));
                try {
                    location.setClearanceDate(BinderUtils.getAsCalendar(param(request, "clearanceDate", i)));
                } catch (BinderException e) {
                    e.setAttribute(name("clearanceDate", i), param(request, "clearanceDate", i));
                    exceptions.add(e);
                }
            }

            agency.getAffiliation().add(location);
            i++;
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(enrollment);
        List<GroupAffiliationType> xList = agency.getAffiliation();
        int i = 0;
        for (GroupAffiliationType location : xList) {
            attr(mv, "objectId", i, location.getObjectId());
            if (Util.isNotBlank(location.getObjectId())) {
                attr(mv, "objectIdHash", i, Util.hash(location.getObjectId(), getServerHashKey()));
            }

            attr(mv, "npi", i, location.getNPI());
            attr(mv, "name", i, location.getName());
            attr(mv, "studyId", i, location.getStudyId());
            attr(mv, "clearanceDate", i, location.getClearanceDate());
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

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.startsWith(ADD_AGENCY_PATH)) {
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

        if (errors.isEmpty()) {
            return NO_ERRORS;
        }
        return errors;
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
            message = ruleError.getMessage() + "(Agency #" + (index + 1) + ")";
            if (path.endsWith("StudyId")) {
                return createError("studyId", index, message);
            } else if (path.endsWith("Name")) {
                return createError("name", index, message);
            } else if (path.endsWith("NPI")) {
                return createError("npi", index, message);
            } else if (path.endsWith("ClearanceDate")) {
                return createError("clearanceDate", index, message);
            }
        }

        // general location error
        return createError("affiliation", message);
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
        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(enrollment);
        List<Affiliation> hList = new ArrayList<Affiliation>();
        List<GroupAffiliationType> xList = agency.getAffiliation();
        for (GroupAffiliationType location : xList) {
            Affiliation group = new Affiliation();
            group.setObjectType(ViewStatics.DISCRIMINATOR_AGENCY);
            group.setPrimaryInd("N");
            if (Util.isNotBlank(location.getObjectId())) {
                // store reference only
                group.setTargetProfileId(Long.parseLong(location.getObjectId()));
            } else {
                // owned record
                Organization employer = new Organization();
                employer.setNpi(location.getNPI());
                employer.setName(location.getName());
                employer.setBackgroundStudyId(location.getStudyId());
                employer.setBackgroundClearanceDate(BinderUtils.toDate(location.getClearanceDate()));
                group.setEntity(employer);
            }
            hList.add(group);
        }

        ProviderProfile profile = ticket.getDetails();
        List<Affiliation> affiliations = removeOtherAgencies(profile);

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
        List<Affiliation> hList = filterOtherAgencies(profile.getAffiliations());
        List<GroupAffiliationType> xList = new ArrayList<GroupAffiliationType>();
        for (Affiliation group : hList) {
            GroupAffiliationType location = new GroupAffiliationType();
            if (group.getTargetProfileId() > 0) {
                location.setObjectId(String.valueOf(group.getTargetProfileId()));
            }

            Entity entity = group.getEntity();
            location.setNPI(entity.getNpi());
            location.setName(entity.getName());

            Organization org = (Organization) entity;
            location.setStudyId(org.getBackgroundStudyId());
            location.setClearanceDate(BinderUtils.toCalendar(org.getBackgroundClearanceDate()));
            xList.add(location);
        }

        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(enrollment);
        agency.getAffiliation().clear();
        agency.getAffiliation().addAll(xList);
    }

    /**
     * Removes all non primary practice locations from the given profile.
     *
     * @param profile the profile to manipulate
     * @return the remaining list of affiliation.
     */
    private List<Affiliation> removeOtherAgencies(ProviderProfile profile) {
        if (profile.getAffiliations() == null) {
            profile.setAffiliations(new ArrayList<Affiliation>());
            return profile.getAffiliations();
        }

        List<Affiliation> affiliations = profile.getAffiliations();
        List<Affiliation> otherLocations = filterOtherAgencies(affiliations);

        synchronized (affiliations) {
            affiliations.removeAll(otherLocations);
        }
        return affiliations;
    }

    /**
     * Retrieves only non primary locations.
     * @param affiliations the affiliations to be filtered
     * @return the filtered affiliations
     */
    private List<Affiliation> filterOtherAgencies(List<Affiliation> affiliations) {
        List<Affiliation> otherLocations = new ArrayList<Affiliation>();
        if (affiliations == null) {
            return otherLocations;
        }

        synchronized (affiliations) {
            for (Affiliation affiliation : affiliations) {
                if (ViewStatics.DISCRIMINATOR_AGENCY.equals(affiliation.getObjectType())) {
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
     * @param location the practice location
     */
    private void attachLinkedGroup(GroupAffiliationType location) {
        try {
            PracticeSearchCriteria criteria = new PracticeSearchCriteria();
            criteria.setProfileId(Long.parseLong(location.getObjectId()));
            criteria.setAgency(true);
            SearchResult<PracticeLookup> results = getEnrollmentService().searchPractice(getSystemUser(), criteria);
            PracticeLookup linkedPractice = results.getItems().get(0);

            location.setName(linkedPractice.getName());
            location.setNPI(linkedPractice.getNpi());
            location.setStudyId(linkedPractice.getBgsId());
            location.setClearanceDate(BinderUtils.toCalendar(linkedPractice.getClearanceDate()));
        } catch (PortalServiceException e) {
            throw new PortalServiceRuntimeException("Cannot verify linked agency.", e);
        }
    }

}
