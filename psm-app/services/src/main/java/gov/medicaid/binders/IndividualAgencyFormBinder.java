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

import gov.medicaid.domain.model.AgencyInformationType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
 */
public class IndividualAgencyFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_11_";

    /**
     * Path to agency information.
     */
    private static final String AGENCY_INFO = "/ProviderInformation/AgencyInformation/";

    /**
     * Creates a new binder.
     */
    public IndividualAgencyFormBinder() {
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
        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(applicationType);
        agency.setObjectId(param(request, "objectId")); // if lookup is successful
        if (Util.isNotBlank(agency.getObjectId())) {
            String hash = param(request, "objectIdHash");
            if (!Util.hash(agency.getObjectId(), getServerHashKey()).equals(hash)) {
                throw new PortalServiceRuntimeException("Bad request. Invalid practice lookup hash.");
            }

            attachLinkedGroup(agency);
        } else {

            agency.setName(param(request, "name"));
            agency.setAgencyId(param(request, "agencyId"));
            agency.setNPI(param(request, "npi"));
            agency.setFaxNumber(BinderUtils.concatPhone(param(request, "fax1"), param(request, "fax2"),
                param(request, "fax3"), ""));
            agency.setContactName(param(request, "contactName"));
            agency.setBackgroundStudyId(param(request, "bgsId"));
            try {
                agency.setClearanceDate(BinderUtils.getAsCalendar(param(request, "clearanceDate")));
            } catch (BinderException e) {
                e.setAttribute(name("clearanceDate"), param(request, "clearanceDate"));
                exceptions.add(e);
            }
        }

        agency.setContinuousEmploymentIndicator(param(request, "continuousEmployment"));
        applicationType.getProviderInformation().setEmployedOrContractedByGroup(param(request, "additionalAgency"));
        return exceptions;
    }

    /**
     * Attaches the values for the linked group.
     * @param agency the practice to attach to
     */
    private void attachLinkedGroup(AgencyInformationType agency) {
        PracticeSearchCriteria criteria = new PracticeSearchCriteria();
        criteria.setProfileId(Long.parseLong(agency.getObjectId()));
        criteria.setAgency(true);

        SearchResult<PracticeLookup> results = getApplicationService().searchPractice(getSystemUser(), criteria);
        PracticeLookup linkedPractice = results.getItems().get(0);

        agency.setName(linkedPractice.getName());
        agency.setAgencyId(linkedPractice.getAgencyId());
        agency.setNPI(linkedPractice.getNpi());
        agency.setFaxNumber(linkedPractice.getFaxNumber());
        agency.setContactName(linkedPractice.getContactName());
        agency.setBackgroundStudyId(linkedPractice.getBgsId());
        agency.setClearanceDate(BinderUtils.toCalendar(linkedPractice.getClearanceDate()));
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(applicationType);
        attr(mv, "bound", "Y");

        attr(mv, "objectId", agency.getObjectId());
        if (Util.isNotBlank(agency.getObjectId())) {
            attr(mv, "objectIdHash", Util.hash(agency.getObjectId(), getServerHashKey()));
        }

        attr(mv, "name", agency.getName());
        attr(mv, "agencyId", agency.getAgencyId());
        attr(mv, "npi", agency.getNPI());

        String[] fax = BinderUtils.splitPhone(agency.getFaxNumber());
        attr(mv, "fax1", fax[0]);
        attr(mv, "fax2", fax[1]);
        attr(mv, "fax3", fax[2]);

        attr(mv, "contactName", agency.getContactName());
        attr(mv, "bgsId", agency.getBackgroundStudyId());
        attr(mv, "clearanceDate", agency.getClearanceDate());
        attr(mv, "continuousEmployment", agency.getContinuousEmploymentIndicator());

        attr(mv, "additionalAgency", applicationType.getProviderInformation().getEmployedOrContractedByGroup());
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
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals(AGENCY_INFO + "Name")) {
                    errors.add(createError("name", ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "AgencyId")) {
                    errors.add(createError("agencyId", ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "NPI")) {
                    errors.add(createError("npi", ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "FaxNumber")) {
                    String[] phoneGroup = new String[]{"fax1", "fax2", "fax3"};
                    errors.add(createError(phoneGroup, ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "ContactName")) {
                    errors.add(createError("contactName", ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "BackgroundStudyId")) {
                    errors.add(createError("bgsId", ruleError.getMessage()));
                } else if (path.equals(AGENCY_INFO + "ClearanceDate")) {
                    errors.add(createError("clearanceDate", ruleError.getMessage()));
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
     * @param applicationType the front end model
     * @param application the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(applicationType);
        ProviderProfile profile = application.getDetails();
        List<Affiliation> groups = profile.getAffiliations();
        if (groups == null) {
            groups = new ArrayList<Affiliation>();
            profile.setAffiliations(groups);
        } else {
            Affiliation primary = findPrimaryGroup(groups);
            groups.remove(primary);
        }

        Affiliation primary = new Affiliation();
        primary.setObjectType(ViewStatics.DISCRIMINATOR_AGENCY);
        primary.setPrimaryInd("Y");
        profile.setEmployedSinceClearance(agency.getContinuousEmploymentIndicator());
        profile.setEmployedOrContractedByGroup(provider.getEmployedOrContractedByGroup());

        if (Util.isNotBlank(agency.getObjectId())) {
            // we only need the profile id
            long agencyProfileId = Long.parseLong(agency.getObjectId());
            primary.setTargetProfileId(agencyProfileId);
        } else {
            Organization employer = new Organization();
            employer.setName(agency.getName());
            employer.setAgencyId(agency.getAgencyId());
            employer.setNpi(agency.getNPI());
            employer.setBackgroundStudyId(agency.getBackgroundStudyId());
            employer.setBackgroundClearanceDate(BinderUtils.toDate(agency.getClearanceDate()));
            ContactInformation hContact = new ContactInformation();
            employer.setContactInformation(hContact);
            hContact.setFaxNumber(agency.getFaxNumber());
            primary.setEntity(employer);

            DesignatedContact contact = new DesignatedContact();
            contact.setPerson(new Person());
            contact.setType(DesignatedContactType.AGENCY_CONTACT_NAME);
            contact.getPerson().setName(agency.getContactName());
            replaceAgencyContact(profile, contact);
        }
        groups.add(primary);
    }

    /**
     * Replaces the agency contact name from the profile.
     * @param profile the profile to be updated
     * @param contact the new agency contact person
     */
    private void replaceAgencyContact(ProviderProfile profile, DesignatedContact contact) {
        List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
        if (designatedContacts != null) {
            for (Iterator<DesignatedContact> iterator = designatedContacts.iterator(); iterator.hasNext();) {
                DesignatedContact designatedContact = iterator.next();
                if (designatedContact.getType() == DesignatedContactType.AGENCY_CONTACT_NAME) {
                    iterator.remove();
                }
            }
        } else {
            designatedContacts = new ArrayList<DesignatedContact>();
            profile.setDesignatedContacts(designatedContacts);
        }

        designatedContacts.add(contact);
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ProviderProfile profile = application.getDetails();
        List<Affiliation> groups = profile.getAffiliations();

        Affiliation primary = findPrimaryGroup(groups);
        if (primary == null) {
            // no employer information.
            return;
        }

        if (primary.getEntity() instanceof Person) {
            throw new PortalServiceRuntimeException("Bad Data. Practice group cannot be an individual provider.");
        }

        AgencyInformationType agency = XMLUtility.nsGetAgencyInformation(applicationType);

        Organization employer = (Organization) primary.getEntity();
        if ("Y".equals(employer.getEnrolled())) {
            // do not show organization's private information
            agency.setObjectId(String.valueOf(employer.getProfileId()));

        }

        ContactInformation hContact = employer.getContactInformation();
        if (hContact != null) {
            agency.setFaxNumber(hContact.getFaxNumber());
        }

        agency.setName(employer.getName());
        agency.setAgencyId(employer.getAgencyId());
        agency.setNPI(employer.getNpi());
        agency.setBackgroundStudyId(employer.getBackgroundStudyId());
        agency.setClearanceDate(BinderUtils.toCalendar(employer.getBackgroundClearanceDate()));
        agency.setContinuousEmploymentIndicator(profile.getEmployedSinceClearance());
        provider.setEmployedOrContractedByGroup(profile.getEmployedOrContractedByGroup());

        List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
        if (designatedContacts != null) {
            for (DesignatedContact designatedContact : designatedContacts) {
                if (designatedContact.getType() == DesignatedContactType.AGENCY_CONTACT_NAME) {
                    agency.setContactName(designatedContact.getPerson().getName());
                }
            }
        }
    }

    /**
     * Retrieves the primary affiliation, null if not found.
     *
     * @param groups all affiliations
     * @return the one with PRIMARY=Y
     */
    protected Affiliation findPrimaryGroup(List<Affiliation> groups) {
        synchronized (groups) {
            for (Affiliation affiliation : groups) {
                if (ViewStatics.DISCRIMINATOR_AGENCY.equals(affiliation.getObjectType())) {
                    if ("Y".equals(affiliation.getPrimaryInd())) {
                        return affiliation;
                    }
                }
            }
        }
        return null;
    }
}
