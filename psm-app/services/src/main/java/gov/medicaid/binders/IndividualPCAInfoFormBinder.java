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
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the personal information form.
 */
public class IndividualPCAInfoFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_10_";

    /**
     * Personal information path.
     */
    private static final String PERSONAL_INFO = "/ProviderInformation/ApplicantInformation/PersonalInformation/";

    /**
     * Creates a new instance.
     */
    public IndividualPCAInfoFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @return
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();

        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        individual.setLastName(param(request, "lastName"));
        individual.setFirstName(param(request, "firstName"));
        individual.setMiddleName(param(request, "middleName"));
        individual.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "ssn")));
        try {
            individual.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "dob")));
        } catch (BinderException e) {
            e.setAttribute(name("dob"), param(request, "dob"));
            exceptions.add(e);
        }

        ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
        contact.setPhoneNumber(BinderUtils.concatPhone(param(request, "phone1"), param(request, "phone2"),
            param(request, "phone3"), param(request, "phone4")));

        // residential address
        AddressType address = readPrimaryAddress(request);
        contact.setAddress(address);

        // reinstatement UMPI
        provider.setNPI(param(request, "umpi"));
        provider.setEighteenAndAbove(param(request, "adultInd"));

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
        attr(mv, "umpi", provider.getNPI());
        attr(mv, "adultInd", provider.getEighteenAndAbove());

        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        attr(mv, "lastName", individual.getLastName());
        attr(mv, "firstName", individual.getFirstName());
        attr(mv, "middleName", individual.getMiddleName());
        attr(mv, "ssn", BinderUtils.formatSSN(individual.getSocialSecurityNumber()));
        attr(mv, "dob", individual.getDateOfBirth());

        ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
        if (contact.getAddress() != null) {
            attr(mv, contact.getAddress());
        }

        String[] phone = BinderUtils.splitPhone(contact.getPhoneNumber());
        attr(mv, "phone1", phone[0]);
        attr(mv, "phone2", phone[1]);
        attr(mv, "phone3", phone[2]);
        attr(mv, "phone4", phone[3]);
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

                if (path.equals(PERSONAL_INFO + "LastName")) {
                    errors.add(createError("lastName", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "FirstName")) {
                    errors.add(createError("firstName", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "MiddleName")) {
                    errors.add(createError("middleName", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "SocialSecurityNumber")) {
                    errors.add(createError("ssn", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "DateOfBirth")) {
                    errors.add(createError("dob", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/NPI")) {
                    errors.add(createError("umpi", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/PhoneNumber")) {
                    String[] phoneGroup = new String[]{"phone1", "phone2", "phone3", "phone4"};
                    errors.add(createError(phoneGroup, ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address")) {
                    errors.add(createError(new String[] {"addressLine1", "addressLine2"}, ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/AddressLine1")) {
                    errors.add(createError("addressLine1", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/AddressLine2")) {
                    errors.add(createError("addressLine2", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/City")) {
                    errors.add(createError("city", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/State")) {
                    errors.add(createError("state", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/ZipCode")) {
                    errors.add(createError("zip", ruleError.getMessage()));
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/Address/County")) {
                    errors.add(createError("county", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/EighteenAndAbove")) {
                    errors.add(createError("adultInd", ruleError.getMessage()));
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
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Person)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        ProviderInformationType providerInfo = applicationType.getProviderInformation();
        if (providerInfo != null) {
            Person person = (Person) profile.getEntity();
            person.setNpi(providerInfo.getNPI());
            profile.setAdultInd(providerInfo.getEighteenAndAbove());

            ApplicantInformationType ai = providerInfo.getApplicantInformation();
            if (ai != null && ai.getPersonalInformation() != null) {
                IndividualApplicantType pInfo = ai.getPersonalInformation();
                person.setFirstName(pInfo.getFirstName());
                person.setLastName(pInfo.getLastName());
                person.setMiddleName(pInfo.getMiddleName());
                person.setDob(BinderUtils.toDate(pInfo.getDateOfBirth()));
                person.setSsn(pInfo.getSocialSecurityNumber());

                ContactInformationType cInfo = pInfo.getContactInformation();
                if (person.getContactInformation() == null) {
                    person.setContactInformation(new ContactInformation());
                }

                ContactInformation pContact = person.getContactInformation();
                pContact.setPhoneNumber(cInfo.getPhoneNumber());
                pContact.setAddress(BinderUtils.bindAddress(cInfo.getAddress()));
            }
        }
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        if (profile != null) {
            Entity entity = profile.getEntity();
            if (entity != null) {
                Person person = (Person) entity;
                IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
                individual.setLastName(person.getLastName());
                individual.setFirstName(person.getFirstName());
                individual.setMiddleName(person.getMiddleName());
                individual.setSocialSecurityNumber(person.getSsn());
                individual.setDateOfBirth(BinderUtils.toCalendar(person.getDob()));
                applicationType.getProviderInformation().setNPI(person.getNpi());
                applicationType.getProviderInformation().setEighteenAndAbove(profile.getAdultInd());

                ContactInformation hContact = person.getContactInformation();
                if (hContact != null) {
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
                    contact.setPhoneNumber(hContact.getPhoneNumber());
                    contact.setAddress(BinderUtils.bindAddress(hContact.getAddress()));
                }
            }
        }
    }
}
