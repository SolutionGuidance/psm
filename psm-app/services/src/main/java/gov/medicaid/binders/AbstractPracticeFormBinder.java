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
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.PracticeInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RoleView;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
 */
public abstract class AbstractPracticeFormBinder extends BaseFormBinder {

    /**
     * Path to practice information.
     */
    public static final String PRACTICE_INFO = "/ProviderInformation/PracticeInformation/";

    /**
     * Creates a new binder.
     * @param namespace the form namespace
     */
    protected AbstractPracticeFormBinder(String namespace) {
        super(namespace);
    }

    /**
     * Binds the request to the model.
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
        practice.setObjectId(param(request, "objectId")); // if lookup is successful
        if (Util.isNotBlank(practice.getObjectId())) {
            String hash = param(request, "objectIdHash");
            if (!Util.hash(practice.getObjectId(), getServerHashKey()).equals(hash)) {
                throw new PortalServiceRuntimeException("Bad request. Invalid practice lookup hash.");
            }

            attachLinkedGroup(practice);

        } else {

            practice.setName(param(request, "name"));
            practice.setGroupNPI(param(request, "npi"));
            AddressType address = readPrimaryAddress(request);
            XMLUtility.nsGetContactInformation(practice).setAddress(address);

            ContactInformationType contact = XMLUtility.nsGetContactInformation(practice);
            contact.setPhoneNumber(BinderUtils.concatPhone(param(request, "phone1"), param(request, "phone2"),
                param(request, "phone3"), param(request, "phone4")));
            contact.setFaxNumber(BinderUtils.concatPhone(param(request, "fax1"), param(request, "fax2"),
                param(request, "fax3"), ""));
        }

        return Collections.emptyList();
    }

    /**
     * Attaches the values for the linked group.
     * @param practice the practice to attach to
     */
    private void attachLinkedGroup(PracticeInformationType practice) {
        PracticeSearchCriteria criteria = new PracticeSearchCriteria();
        criteria.setProfileId(Long.parseLong(practice.getObjectId()));
        SearchResult<PracticeLookup> results = getApplicationService().searchPractice(getSystemUser(), criteria);
        PracticeLookup linkedPractice = results.getItems().get(0);

        practice.setName(linkedPractice.getName());
        practice.setGroupNPI(linkedPractice.getNpi());
        AddressType address = XMLUtility.nsGetAddress(practice);
        address.setAddressLine1(linkedPractice.getAddressLine1());
        address.setAddressLine2(linkedPractice.getAddressLine2());
        address.setCity(linkedPractice.getCity());
        address.setState(linkedPractice.getState());
        address.setZipCode(linkedPractice.getZip());
        address.setCounty(linkedPractice.getCounty());

        ContactInformationType contact = XMLUtility.nsGetContactInformation(practice);
        contact.setPhoneNumber(linkedPractice.getPhoneNumber());
        contact.setFaxNumber(linkedPractice.getFaxNumber());
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
        attr(mv, "bound", "Y");

        attr(mv, "objectId", practice.getObjectId());
        if (Util.isNotBlank(practice.getObjectId())) {
            attr(mv, "objectIdHash", Util.hash(practice.getObjectId(), getServerHashKey()));
        }

        attr(mv, "name", practice.getName());
        attr(mv, "npi", practice.getGroupNPI());

        attr(mv, XMLUtility.nsGetAddress(practice));

        ContactInformationType contact = XMLUtility.nsGetContactInformation(practice);
        String[] phone = BinderUtils.splitPhone(contact.getPhoneNumber());
        attr(mv, "phone1", phone[0]);
        attr(mv, "phone2", phone[1]);
        attr(mv, "phone3", phone[2]);
        attr(mv, "phone4", phone[3]);

        String[] fax = BinderUtils.splitPhone(contact.getFaxNumber());
        attr(mv, "fax1", fax[0]);
        attr(mv, "fax2", fax[1]);
        attr(mv, "fax3", fax[2]);
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

                if (path.equals("/ProviderInformation/PracticeInformation")) {
                    errors.add(createError("practiceInformation", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "Name")) {
                    errors.add(createError("name", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "GroupNPI")) {
                    errors.add(createError("npi", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address")) {
                    String[] addressLines = new String[]{"addressLine1", "addressLine2"};
                    errors.add(createError(addressLines, ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/AddressLine1")) {
                    errors.add(createError("addressLine1", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/AddressLine2")) {
                    errors.add(createError("addressLine2", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/City")) {
                    errors.add(createError("city", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/State")) {
                    errors.add(createError("state", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/ZipCode")) {
                    errors.add(createError("zip", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/Address/County")) {
                    errors.add(createError("county", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/FaxNumber")) {
                    String[] faxGroup = new String[]{"fax1", "fax2", "fax3"};
                    errors.add(createError(faxGroup, ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ContactInformation/PhoneNumber")) {
                    String[] phoneGroup = new String[]{"phone1", "phone2", "phone3", "phone4"};
                    errors.add(createError(phoneGroup, ruleError.getMessage()));
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
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
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
        primary.setObjectType(ViewStatics.DISCRIMINATOR_LOCATION);
        primary.setPrimaryInd("Y");

        if (Util.isNotBlank(practice.getObjectId())) {
            // we only need the profile id
            long employerProfileId = Long.parseLong(practice.getObjectId());
            primary.setTargetProfileId(employerProfileId);
        } else {
            Organization employer = new Organization();
            employer.setName(practice.getName());
            employer.setNpi(practice.getGroupNPI());

            AddressType xAddress = XMLUtility.nsGetAddress(practice);
            ContactInformation hContact = new ContactInformation();
            employer.setContactInformation(hContact);
            hContact.setAddress(BinderUtils.bindAddress(xAddress));

            ContactInformationType xContact = XMLUtility.nsGetContactInformation(practice);
            hContact.setPhoneNumber(xContact.getPhoneNumber());
            hContact.setFaxNumber(xContact.getFaxNumber());
            primary.setEntity(employer);

        }
        groups.add(primary);
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
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

        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        Organization employer = (Organization) primary.getEntity();
        if ("Y".equals(employer.getEnrolled())) {
            // do not show organization's private information
            practice.setObjectId(String.valueOf(employer.getProfileId()));
        }

        ContactInformation hContact = employer.getContactInformation();
        if (hContact != null) {
            ContactInformationType xContact = XMLUtility.nsGetContactInformation(practice);
            xContact.setPhoneNumber(hContact.getPhoneNumber());
            xContact.setFaxNumber(hContact.getFaxNumber());
        }

        practice.setName(employer.getName());
        practice.setGroupNPI(employer.getNpi());
        ContactInformationType xContact = XMLUtility.nsGetContactInformation(practice);
        if (hContact != null) {
            xContact.setAddress(BinderUtils.bindAddress(hContact.getAddress()));
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
                if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())) {
                    if ("Y".equals(affiliation.getPrimaryInd())) {
                        return affiliation;
                    }
                }
            }
        }
        return null;
    }

    /**
     * For external users with RoleView = EMPLOYER, they cannot touch any information with NPI is not their own
     *
     * @param user       the current request user
     * @param application the
     * @return
     */
    protected boolean canModifyExistingPractice(
            CMSUser user,
            ApplicationType applicationType
    ) {
        if (user.getExternalRoleView() == RoleView.EMPLOYER) {
            PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
            if (user.getExternalAccountLink().getExternalUserId().equals(practice.getGroupNPI())) {
                return true;
            }
            return false;
        }
        return true;
    }
}
