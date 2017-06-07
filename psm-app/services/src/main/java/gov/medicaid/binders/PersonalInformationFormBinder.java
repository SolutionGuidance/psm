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

import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.PDFHelper;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.PdfPTable;

/**
 * This binder handles the personal information form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
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

        ContactInformationType enrollmentContact = XMLUtility.nsGetContactInformation(enrollment);
        if (param(request, "useProviderAsContact") != null) {
            enrollment.setContactSameAsApplicant("Y");
            enrollmentContact.setName(BinderUtils.getFullName(individual));
            enrollmentContact.setEmailAddress(contact.getEmailAddress());
        } else {
            enrollment.setContactSameAsApplicant("N");
            enrollmentContact.setName(param(request, "contactName"));
            enrollmentContact.setEmailAddress(param(request, "contactEmail"));
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        attr(mv, "npi", provider.getNPI());

        IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
        attr(mv, "lastName", individual.getLastName());
        attr(mv, "firstName", individual.getFirstName());
        attr(mv, "middleName", individual.getMiddleName());
        attr(mv, "ssn", BinderUtils.formatSSN(individual.getSocialSecurityNumber()));
        attr(mv, "dob", individual.getDateOfBirth());

        ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
        attr(mv, "email", contact.getEmailAddress());

        ContactInformationType enrollmentContact = XMLUtility.nsGetContactInformation(enrollment);
        if ("Y".equals(enrollment.getContactSameAsApplicant())) {
            attr(mv, "useProviderAsContact", "Y");
        } else {
            attr(mv, "contactName", enrollmentContact.getName());
            attr(mv, "contactEmail", enrollmentContact.getEmailAddress());
        }
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param enrollment the enrollment that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
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
     * @param enrollment the front end model
     * @param ticket the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Person)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        ProviderInformationType providerInfo = enrollment.getProviderInformation();
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

        bindEnrollmentContactToHibernate(enrollment, profile);
    }

    /**
     * Binds the designated enrollment contact to the hibernate model.
     * @param enrollment the frontend model
     * @param profile the hibernate model
     */
    private void bindEnrollmentContactToHibernate(EnrollmentType enrollment, ProviderProfile profile) {
        List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
        if ("Y".equals(enrollment.getContactSameAsApplicant())) {
            if (designatedContacts != null) {
                for (Iterator<DesignatedContact> iter = designatedContacts.iterator(); iter.hasNext();) {
                    DesignatedContact designatedContact = iter.next();
                    if (designatedContact.getType() == DesignatedContactType.ENROLLMENT) {
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
                if (designatedContact.getType() == DesignatedContactType.ENROLLMENT) {
                    if (designatedContact.getPerson() == null) {
                        designatedContact.setPerson(new Person());
                    }

                    Person person = designatedContact.getPerson();
                    person.setName(enrollment.getContactInformation().getName());

                    if (person.getContactInformation() == null) {
                        person.setContactInformation(new ContactInformation());
                    }
                    person.getContactInformation().setEmail(enrollment.getContactInformation().getEmailAddress());
                    found = true;
                }
            }

            if (!found) {
                DesignatedContact designatedContact = new DesignatedContact();
                designatedContact.setType(DesignatedContactType.ENROLLMENT);
                Person person = new Person();
                designatedContact.setPerson(person);

                person.setName(enrollment.getContactInformation().getName());
                person.setContactInformation(new ContactInformation());
                person.getContactInformation().setEmail(enrollment.getContactInformation().getEmailAddress());
                profile.getDesignatedContacts().add(designatedContact);
            }
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
        if (profile != null) {
            Entity entity = profile.getEntity();
            if (entity != null) {
                Person person = (Person) entity;
                IndividualApplicantType individual = XMLUtility.nsGetIndividual(enrollment);
                individual.setLastName(person.getLastName());
                individual.setFirstName(person.getFirstName());
                individual.setMiddleName(person.getMiddleName());
                individual.setSocialSecurityNumber(person.getSsn());
                individual.setDateOfBirth(BinderUtils.toCalendar(person.getDob()));
                enrollment.getProviderInformation().setNPI(person.getNpi());

                ContactInformation hContact = person.getContactInformation();
                if (hContact != null) {
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(individual);
                    contact.setEmailAddress(hContact.getEmail());
                }
            }

            boolean found = false;
            List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
            if (designatedContacts != null) {
                for (DesignatedContact designatedContact : designatedContacts) {
                    if (designatedContact.getType() == DesignatedContactType.ENROLLMENT) {
                        ContactInformationType xContact = XMLUtility.nsGetContactInformation(enrollment);
                        Person hPerson = designatedContact.getPerson();
                        xContact.setName(hPerson.getName());
                        if (hPerson.getContactInformation() != null) {
                            xContact.setEmailAddress(hPerson.getContactInformation().getEmail());
                        }
                        found = true;
                    }
                }
            }

            enrollment.setContactSameAsApplicant(found ? "N" : "Y");
            if (!found) {
                // copy if same as applicant
                if (entity != null) {
                    Person person = (Person) entity;
                    ContactInformation hContact = person.getContactInformation();
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(enrollment);
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
     * @param enrollment the enrollment to be rendered
     * @param document the PDF document to render on
     * @param model the view model
     */
    @Override
    public void renderPDF(EnrollmentType enrollment, Document document, Map<String, Object> model) throws DocumentException {
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

        PdfPTable contactInfo = new PdfPTable(2); // 2 columns of key value pairs
        PDFHelper.setTableAsFullPage(contactInfo);

        contactInfo.addCell(PDFHelper.createHeaderCell("Contact Information", 2));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Name", PDFHelper.value(model, ns, "contactName"));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Email Address", PDFHelper.value(model, ns, "contactEmail"));

        document.add(contactInfo);
    }
}
