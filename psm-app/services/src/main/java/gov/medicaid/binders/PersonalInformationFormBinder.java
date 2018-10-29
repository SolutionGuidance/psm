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
import com.lowagie.text.pdf.PdfPTable;

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
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.PDFHelper;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the personal information form.
 */
public class PersonalInformationFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_02_";

    /**
     * Personal information path.
     */
    private static final String PERSONAL_INFO = "/ProviderInformation/ApplicantInformation/PersonalInformation/";

    /**
     * Creates a new instance.
     */
    public PersonalInformationFormBinder() {
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
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        individual.setLastName(param(request, "lastName"));
        individual.setFirstName(param(request, "firstName"));
        individual.setMiddleName(param(request, "middleName"));
        provider.setNPI(param(request, "npi"));
        individual.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "ssn")));
        try {
            individual.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "dob")));
        } catch (BinderException e) {
            e.setAttribute(name("dob"), param(request, "dob"));
            exceptions.add(e);
        }

        ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
        contact.setEmailAddress(param(request, "email"));

        ContactInformationType applicationContact = XMLUtility.nsGetContactInformation(applicationType);
        if (param(request, "useProviderAsContact") != null) {
            applicationType.setContactSameAsApplicant("Y");
            applicationContact.setName(BinderUtils.getFullName(individual));
            applicationContact.setEmailAddress(contact.getEmailAddress());
        } else {
            applicationType.setContactSameAsApplicant("N");
            applicationContact.setName(param(request, "contactName"));
            applicationContact.setEmailAddress(param(request, "contactEmail"));
            applicationContact.setPhoneNumber(
                    BinderUtils.concatPhone(
                            param(request, "contactPhone1"),
                            param(request, "contactPhone2"),
                            param(request, "contactPhone3"),
                            param(request, "contactPhone4")
                    )
            );
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
        attr(mv, "npi", provider.getNPI());

        IndividualApplicantType individual = XMLUtility.nsGetIndividual(applicationType);
        attr(mv, "lastName", individual.getLastName());
        attr(mv, "firstName", individual.getFirstName());
        attr(mv, "middleName", individual.getMiddleName());
        attr(mv, "ssn", BinderUtils.formatSSN(individual.getSocialSecurityNumber()));
        attr(mv, "dob", individual.getDateOfBirth());

        ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
        attr(mv, "email", contact.getEmailAddress());

        ContactInformationType applicationContact = XMLUtility.nsGetContactInformation(applicationType);
        if ("Y".equals(applicationType.getContactSameAsApplicant())) {
            attr(mv, "useProviderAsContact", "Y");
            attr(mv, "showEmailRequired", Boolean.TRUE);
        } else {
            attr(mv, "contactName", applicationContact.getName());
            attr(mv, "contactEmail", applicationContact.getEmailAddress());
            String[] phone = BinderUtils.splitPhone(applicationContact.getPhoneNumber());
            attr(mv, "contactPhone1", phone[0]);
            attr(mv, "contactPhone2", phone[1]);
            attr(mv, "contactPhone3", phone[2]);
            attr(mv, "contactPhone4", phone[3]);
            attr(mv, "showEmailRequired", Boolean.FALSE);
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
                } else if (path.equals(PERSONAL_INFO + "ContactInformation/EmailAddress")) {
                    errors.add(createError("email", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/NPI")) {
                    errors.add(createError("npi", ruleError.getMessage()));
                } else if (path.equals("/ContactInformation/Name")) {
                    errors.add(createError("contactName", ruleError.getMessage()));
                } else if (path.equals("/ContactInformation/EmailAddress")) {
                    errors.add(createError("contactEmail", ruleError.getMessage()));
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

            ApplicantInformationType ai = providerInfo.getApplicantInformation();
            if (ai != null && ai.getPersonalInformation() != null) {
                IndividualApplicantType pInfo = ai.getPersonalInformation();
                person.setFirstName(pInfo.getFirstName());
                person.setLastName(pInfo.getLastName());
                person.setMiddleName(pInfo.getMiddleName());
                person.setDob(BinderUtils.toDate(pInfo.getDateOfBirth()));
                person.setSsn(pInfo.getSocialSecurityNumber());
                person.setName(pInfo.getFullName());

                ContactInformationType cInfo = pInfo.getContactInformation();
                if (cInfo != null) {
                    if (person.getContactInformation() == null) {
                        person.setContactInformation(new ContactInformation());
                    }

                    ContactInformation pContact = person.getContactInformation();
                    pContact.setEmail(cInfo.getEmailAddress());
                } else {
                    // erase if needed
                    ContactInformation pContact = person.getContactInformation();
                    if (pContact != null) {
                        pContact.setEmail(null);
                    }
                }
            }
        }

        bindApplicationContactToHibernate(applicationType, profile);
    }

    /**
     * Binds the designated application contact to the hibernate model.
     * @param applicationType the frontend model
     * @param profile the hibernate model
     */
    private void bindApplicationContactToHibernate(ApplicationType applicationType, ProviderProfile profile) {
        List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
        if ("Y".equals(applicationType.getContactSameAsApplicant())) {
            if (designatedContacts != null) {
                for (Iterator<DesignatedContact> iter = designatedContacts.iterator(); iter.hasNext();) {
                    DesignatedContact designatedContact = iter.next();
                    if (designatedContact.getType() == DesignatedContactType.APPLICATION) {
                        iter.remove();
                    }
                }
            }
        } else {
            if (designatedContacts == null) {
                designatedContacts = new ArrayList<DesignatedContact>();
                profile.setDesignatedContacts(designatedContacts);
            }

            boolean found = false;

            for (Iterator<DesignatedContact> iter = designatedContacts.iterator(); iter.hasNext();) {
                DesignatedContact designatedContact = iter.next();
                if (designatedContact.getType() == DesignatedContactType.APPLICATION) {
                    if (designatedContact.getPerson() == null) {
                        designatedContact.setPerson(new Person());
                    }

                    Person person = designatedContact.getPerson();
                    person.setName(applicationType.getContactInformation().getName());

                    if (person.getContactInformation() == null) {
                        person.setContactInformation(new ContactInformation());
                    }
                    person.getContactInformation().setEmail(applicationType.getContactInformation().getEmailAddress());
                    person.getContactInformation().setPhoneNumber(
                            applicationType.getContactInformation().getPhoneNumber()
                    );
                    found = true;
                }
            }

            if (!found) {
                DesignatedContact designatedContact = new DesignatedContact();
                designatedContact.setType(DesignatedContactType.APPLICATION);
                Person person = new Person();
                designatedContact.setPerson(person);

                person.setName(applicationType.getContactInformation().getName());
                person.setContactInformation(new ContactInformation());
                person.getContactInformation().setEmail(applicationType.getContactInformation().getEmailAddress());
                person.getContactInformation().setPhoneNumber(
                        applicationType.getContactInformation().getPhoneNumber()
                );
                profile.getDesignatedContacts().add(designatedContact);
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

                ContactInformation hContact = person.getContactInformation();
                if (hContact != null) {
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
                    contact.setEmailAddress(hContact.getEmail());
                    contact.setPhoneNumber(hContact.getPhoneNumber());
                }
            }

            boolean found = false;
            List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
            if (designatedContacts != null) {
                for (DesignatedContact designatedContact : designatedContacts) {
                    if (designatedContact.getType() == DesignatedContactType.APPLICATION) {
                        ContactInformationType xContact = XMLUtility.nsGetContactInformation(applicationType);
                        Person hPerson = designatedContact.getPerson();
                        xContact.setName(hPerson.getName());
                        if (hPerson.getContactInformation() != null) {
                            xContact.setEmailAddress(hPerson.getContactInformation().getEmail());
                            xContact.setPhoneNumber(hPerson.getContactInformation().getPhoneNumber());
                        }
                        found = true;
                    }
                }
            }

            applicationType.setContactSameAsApplicant(found ? "N" : "Y");
            if (!found) {
                // copy if same as applicant
                if (entity != null) {
                    Person person = (Person) entity;
                    ContactInformation hContact = person.getContactInformation();
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(applicationType);
                    if (hContact != null) {
                        contact.setEmailAddress(hContact.getEmail());
                    }
                    contact.setName(person.getName());
                }
            }
        }
    }

    /**
     * Renders this form as a PDF.
     *
     * @param application the application to be rendered
     * @param document the PDF document to render on
     * @param model the view model
     */
    @Override
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model) throws DocumentException {
        String ns = NAMESPACE;
        if (!"Y".equals(PDFHelper.value(model, ns, "bound"))) {
            return;
        }

        // Personal Info Section
        PdfPTable personalInfo = new PdfPTable(2);
        PDFHelper.setTableAsFullPage(personalInfo);

        PDFHelper.addLabelValueCell(personalInfo, "Last Name", PDFHelper.value(model, ns, "lastName"));
        PDFHelper.addLabelValueCell(personalInfo, "First Name", PDFHelper.value(model, ns, "firstName"));
        PDFHelper.addLabelValueCell(personalInfo, "Middle Name", PDFHelper.value(model, ns, "middleName"));

        PDFHelper.addLabelValueCell(personalInfo, "NPI", PDFHelper.value(model, ns, "npi"));
        PDFHelper.addLabelValueCell(personalInfo, "Social Security Number", PDFHelper.value(model, ns, "ssn"));
        PDFHelper.addLabelValueCell(personalInfo, "Date of Birth", PDFHelper.value(model, ns, "dob"));
        PDFHelper.addLabelValueCell(personalInfo, "Individual Practitioner's Email", PDFHelper.value(model, ns, "email"));
        document.add(personalInfo);

        if (!"Y".equals(applicationType.getContactSameAsApplicant())) {
            PdfPTable contactInfo = new PdfPTable(2); // 2 columns of key value pairs
            PDFHelper.setTableAsFullPage(contactInfo);

            contactInfo.addCell(PDFHelper.createHeaderCell("Contact Information", 2));
            PDFHelper.addLabelValueCell(contactInfo, "Contact Name", PDFHelper.value(model, ns, "contactName"));
            PDFHelper.addLabelValueCell(contactInfo, "Contact Email Address", PDFHelper.value(model, ns, "contactEmail"));
            PDFHelper.addLabelValueCell(contactInfo, "Contact Phone Number", PDFHelper.getPhone(model, ns, "contactPhone"));

            document.add(contactInfo);
        }
    }
}
