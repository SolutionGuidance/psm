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

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.AlternateAddressesType;
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.OrganizationApplicantType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.PDFHelper;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization information form.
 */
public class OrganizationInfoFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_15_";

    /**
     * Creates a new instance.
     */
    public OrganizationInfoFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollmentType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollmentType);

        provider.setNPI(param(request, "npi"));
        try {
            enrollmentType.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate")));
        } catch (BinderException e) {
            e.setAttribute(name("effectiveDate"), param(request, "effectiveDate"));
            exceptions.add(e);
        }
        enrollmentType.setPersonWhoAccomplishedForm(param(request, "personCompletingForm"));

        OrganizationApplicantType org = XMLUtility.nsGetOrganization(enrollmentType);
        org.setName(param(request, "name"));
        org.setLegalName(param(request, "legalName"));
        org.setFEIN(param(request, "fein"));
        org.setStateTaxID(param(request, "stateTaxId"));

        // optional elements (can be set by other forms)
        if (param(request, "fye1") != null) {
            org.setFiscalYearEnd(BinderUtils.concatFiscalYearEnd(param(request, "fye1"), param(request, "fye2")));
            provider.setFiscalYearEnd(BinderUtils.concatFiscalYearEnd(param(request, "fye1"), param(request, "fye2")));
        }

        if (param(request, "orgCountyName") != null) {
            provider.setCounty(param(request, "orgCountyName"));
        }

        if (param(request, "subType") != null) {
            org.setSubType(param(request, "subType"));
        }

        ContactInformationType contact = XMLUtility.nsGetContactInformation(org);
        contact.setPhoneNumber(BinderUtils.concatPhone(param(request, "phone1"), param(request, "phone2"),
            param(request, "phone3"), param(request, "phone4")));
        contact.setFaxNumber(BinderUtils.concatPhone(param(request, "fax1"), param(request, "fax2"),
            param(request, "fax3"), ""));

        // practice address
        AddressType address = readPrimaryAddress(request);
        contact.setAddress(address);

        // alternate addresses
        AlternateAddressesType alternateAddresses = new AlternateAddressesType();
        provider.setAlternateAddresses(alternateAddresses);

        if (param(request, "billingSameAsPrimary") != null) {
            org.setBillingAddressIndex(0);
        } else {
            org.setBillingAddressIndex(alternateAddresses.getAddress().size() + 1);
            AddressType billingAddress = readBillingAddress(request);
            alternateAddresses.getAddress().add(billingAddress);
        }

        if (param(request, "ten99SameAsPrimary") != null) {
            org.setTen99AddressIndex(0);
        } else {
            org.setTen99AddressIndex(alternateAddresses.getAddress().size() + 1);
            AddressType ten99Address = readTen99Address(request);
            alternateAddresses.getAddress().add(ten99Address);
        }

        ContactInformationType enrollmentContact = XMLUtility.nsGetContactInformation(enrollmentType);
        enrollmentContact.setPhoneNumber(BinderUtils.concatPhone(param(request, "contactPhone1"), param(request, "contactPhone2"),
            param(request, "contactPhone3"), param(request, "contactPhone4")));
        enrollmentContact.setFaxNumber(BinderUtils.concatPhone(param(request, "contactFax1"), param(request, "contactFax2"),
            param(request, "contactFax3"), ""));
        enrollmentContact.setName(param(request, "contactName"));
        enrollmentContact.setEmailAddress(param(request, "contactEmail"));

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollmentType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollmentType);
        attr(mv, "npi", provider.getNPI());
        attr(mv, "orgCountyName", provider.getCounty());

        attr(mv, "effectiveDate", enrollmentType.getEffectiveDate());
        attr(mv, "personCompletingForm", enrollmentType.getPersonWhoAccomplishedForm());

        OrganizationApplicantType org = XMLUtility.nsGetOrganization(enrollmentType);
        attr(mv, "name", org.getName());
        attr(mv, "legalName", org.getLegalName());
        attr(mv, "fein", org.getFEIN());
        attr(mv, "stateTaxId", org.getStateTaxID());
        String[] fye = BinderUtils.splitFiscalYear(org.getFiscalYearEnd());
        attr(mv, "fye1", fye[0]);
        attr(mv, "fye2", fye[1]);
        attr(mv, "subType", org.getSubType());
        ContactInformationType contact = XMLUtility.nsGetContactInformation(org);
        if (contact.getAddress() != null) {
            attr(mv, contact.getAddress());
        }

        String[] phone = BinderUtils.splitPhone(contact.getPhoneNumber());
        attr(mv, "phone1", phone[0]);
        attr(mv, "phone2", phone[1]);
        attr(mv, "phone3", phone[2]);
        attr(mv, "phone4", phone[3]);

        String[] fax = BinderUtils.splitPhone(contact.getFaxNumber());
        attr(mv, "fax1", fax[0]);
        attr(mv, "fax2", fax[1]);
        attr(mv, "fax3", fax[2]);

        AlternateAddressesType alternateAddresses = provider.getAlternateAddresses();
        attr(mv, "billingSameAsPrimary", "Y"); // default to true
        attr(mv, "ten99SameAsPrimary", "Y"); // default to true
        if (alternateAddresses != null) {
            String billingSameAsPrimary = (org.getBillingAddressIndex() == null || org.getBillingAddressIndex() == 0) ? "Y" : "N";
            attr(mv, "billingSameAsPrimary", billingSameAsPrimary);
            if ("N".equals(billingSameAsPrimary)) {
                if (org.getBillingAddressIndex() != null) {
                    if (alternateAddresses.getAddress().size() >= org.getBillingAddressIndex()) {
                        AddressType billingAddress = alternateAddresses.getAddress().get(org.getBillingAddressIndex() - 1);
                        attr(mv, "billing", billingAddress);
                    }
                }
            }

            String ten99SameAsPrimary = (org.getTen99AddressIndex() == null || org.getTen99AddressIndex() == 0) ? "Y" : "N";
            attr(mv, "ten99SameAsPrimary", ten99SameAsPrimary);
            if ("N".equals(ten99SameAsPrimary)) {
                if (org.getTen99AddressIndex() != null) {
                    if (alternateAddresses.getAddress().size() >= org.getTen99AddressIndex()) {
                        AddressType ten99Address = alternateAddresses.getAddress().get(org.getTen99AddressIndex() - 1);
                        attr(mv, "ten99", ten99Address);
                    }
                }
            }
        }

        ContactInformationType enrollmentContact = XMLUtility.nsGetContactInformation(enrollmentType);
        attr(mv, "contactName", enrollmentContact.getName());
        attr(mv, "contactEmail", enrollmentContact.getEmailAddress());
        String[] contactPhone = BinderUtils.splitPhone(enrollmentContact.getPhoneNumber());
        attr(mv, "contactPhone1", contactPhone[0]);
        attr(mv, "contactPhone2", contactPhone[1]);
        attr(mv, "contactPhone3", contactPhone[2]);
        attr(mv, "contactPhone4", contactPhone[3]);

        String[] contactFax = BinderUtils.splitPhone(enrollmentContact.getFaxNumber());
        attr(mv, "contactFax1", contactFax[0]);
        attr(mv, "contactFax2", contactFax[1]);
        attr(mv, "contactFax3", contactFax[2]);

        if (!readOnly) {
            List<CountyType> counties = getLookupService().findAllLookups(CountyType.class);
            attr(mv, "counties", counties);
        }
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param enrollment the enrollment that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollmentType, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        OrganizationApplicantType org = XMLUtility.nsGetOrganization(enrollmentType);

        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals("/ProviderInformation/NPI")) {
                    errors.add(createError("npi", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/County")) {
                    errors.add(createError("orgCountyName", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/FiscalYearEnd")) {
                    errors.add(createError(new String[]{"fye1", "fye2"}, ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/SubType")) {
                    errors.add(createError("subType", ruleError.getMessage()));
                } else if (path.equals("/ContactInformation/Name")) {
                    errors.add(createError("contactName", ruleError.getMessage()));
                } else if (path.equals("/ContactInformation/EmailAddress")) {
                    errors.add(createError("contactEmail", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/LegalName")) {
                    errors.add(createError("legalName", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/Name")) {
                    errors.add(createError("name", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/AddressLine1")) {
                    errors.add(createError("addressLine1", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/AddressLine2")) {
                    errors.add(createError("addressLine2", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/City")) {
                    errors.add(createError("city", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/State")) {
                    errors.add(createError("state", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/ZipCode")) {
                    errors.add(createError("zip", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/Address/County")) {
                    errors.add(createError("county", ruleError.getMessage()));
                } else if (path.equals("/EffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/FEIN")) {
                    errors.add(createError("fein", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/PhoneNumber")) {
                    errors.add(createError(
                            new String[]{"phone1", "phone2", "phone3", "phone4"},
                            ruleError.getMessage()
                    ));
                } else if (path.equals("/ProviderInformation/ApplicantInformation/OrganizationInformation/ContactInformation/FaxNumber")) {
                    errors.add(createError(
                            new String[]{"fax1", "fax2", "fax3"},
                            ruleError.getMessage()
                    ));
                } else if (path.equals("/ContactInformation/PhoneNumber")) {
                    errors.add(createError(
                            new String[]{"contactPhone1", "contactPhone2", "contactPhone3", "contactPhone4"},
                            ruleError.getMessage()
                    ));
                } else if (path.startsWith("/ProviderInformation/AlternateAddresses/Address")) {
                    Integer addressIndex = resolveIndex(path);
                    if (addressIndex != null) {
                        if (org.getTen99AddressIndex() != null) {
                            if (org.getTen99AddressIndex() - 1 == addressIndex) {
                                errors.add(resolveAddressFieldError("ten99", path, ruleError));
                            }
                        }
                        if (org.getBillingAddressIndex() != null) {
                            if (org.getBillingAddressIndex() - 1 == addressIndex) {
                                errors.add(resolveAddressFieldError("billing", path, ruleError));
                            }
                        }
                    }
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

    private FormError resolveAddressFieldError(
            String prefix,
            String path,
            StatusMessageType ruleError
    ) {
        if (path.endsWith("/AddressLine1")) {
            return createError(prefix + "AddressLine1", ruleError.getMessage());
        } else if (path.endsWith("/AddressLine2")) {
            return createError(prefix + "AddressLine2", ruleError.getMessage());
        } else if (path.endsWith("/City")) {
            return createError(prefix + "City", ruleError.getMessage());
        } else if (path.endsWith("/State")) {
            return createError(prefix + "State", ruleError.getMessage());
        } else if (path.endsWith("/ZipCode")) {
            return createError(prefix + "Zip", ruleError.getMessage());
        } else if (path.endsWith("/County")) {
            return createError(prefix + "County", ruleError.getMessage());
        } else if (path.endsWith("/AttentionTo")) {
            return createError(prefix + "Attention", ruleError.getMessage());
        }

        return createError(prefix + "Address", ruleError.getMessage());
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
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(EnrollmentType enrollmentType, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Organization)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        profile.setEffectiveDate(BinderUtils.toDate(enrollmentType.getEffectiveDate()));
        profile.setAccomplishedBy(enrollmentType.getPersonWhoAccomplishedForm());

        ProviderInformationType providerInfo = enrollmentType.getProviderInformation();
        if (providerInfo != null) {
            Organization organization = (Organization) profile.getEntity();
            organization.setNpi(providerInfo.getNPI());
            profile.setCounty(providerInfo.getCounty());

            ApplicantInformationType ai = providerInfo.getApplicantInformation();
            if (ai != null && ai.getOrganizationInformation() != null) {
                OrganizationApplicantType oInfo = ai.getOrganizationInformation();
                organization.setProviderSubType(oInfo.getSubType());
                organization.setName(oInfo.getName());
                organization.setLegalName(oInfo.getLegalName());
                organization.setFein(oInfo.getFEIN());
                organization.setStateTaxId(oInfo.getStateTaxID());
                organization.setStateMedicaidId(oInfo.getStateMedicaidID());
                organization.setFiscalYearEnd(oInfo.getFiscalYearEnd());

                ContactInformationType cInfo = oInfo.getContactInformation();
                if (organization.getContactInformation() == null) {
                    organization.setContactInformation(new ContactInformation());
                }

                ContactInformation oContact = organization.getContactInformation();
                oContact.setPhoneNumber(cInfo.getPhoneNumber());
                oContact.setFaxNumber(cInfo.getFaxNumber());
                oContact.setAddress(BinderUtils.bindAddress(cInfo.getAddress()));

                if (oInfo.getBillingAddressIndex() != null && oInfo.getBillingAddressIndex() > 0) {
                    organization.setBillingSameAsPrimary("N");
                    AlternateAddressesType alternateAddresses = providerInfo.getAlternateAddresses();
                    organization.setBillingAddress(BinderUtils.bindAddress(alternateAddresses.getAddress().get(oInfo.getBillingAddressIndex() - 1)));
                } else {
                    organization.setBillingSameAsPrimary("Y");
                    organization.setBillingAddress(BinderUtils.bindAddress(cInfo.getAddress()));
                }

                if (oInfo.getTen99AddressIndex() != null && oInfo.getTen99AddressIndex() > 0) {
                    organization.setTen99SameAsPrimary("N");
                    AlternateAddressesType alternateAddresses = providerInfo.getAlternateAddresses();
                    organization.setTen99Address(BinderUtils.bindAddress(alternateAddresses.getAddress().get(oInfo.getTen99AddressIndex() - 1)));
                } else {
                    organization.setTen99SameAsPrimary("Y");
                    organization.setTen99Address(BinderUtils.bindAddress(cInfo.getAddress()));
                }
            }

            bindEnrollmentContactToHibernate(enrollmentType, profile);
        }

    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollmentType) {
        ProviderProfile profile = ticket.getDetails();
        if (profile != null) {
            enrollmentType.setEffectiveDate(BinderUtils.toCalendar(profile.getEffectiveDate()));
            enrollmentType.setPersonWhoAccomplishedForm(profile.getAccomplishedBy());

            Entity entity = profile.getEntity();
            if (entity != null) {
                Organization organization = (Organization) entity;
                OrganizationApplicantType org = XMLUtility.nsGetOrganization(enrollmentType);
                org.setName(organization.getName());
                org.setLegalName(organization.getLegalName());
                org.setFEIN(organization.getFein());
                org.setStateTaxID(organization.getStateTaxId());
                org.setStateMedicaidID(organization.getStateMedicaidId());
                org.setFiscalYearEnd(organization.getFiscalYearEnd());
                org.setSubType(organization.getProviderSubType());
                enrollmentType.getProviderInformation().setNPI(organization.getNpi());
                enrollmentType.getProviderInformation().setCounty(profile.getCounty());
                enrollmentType.setEffectiveDate(BinderUtils.toCalendar(profile.getEffectiveDate()));

                ContactInformation hContact = organization.getContactInformation();
                if (hContact != null) {
                    ContactInformationType contact = XMLUtility.nsGetContactInformation(org);
                    contact.setPhoneNumber(hContact.getPhoneNumber());
                    contact.setFaxNumber(hContact.getFaxNumber());
                    contact.setAddress(BinderUtils.bindAddress(hContact.getAddress()));
                }

                AlternateAddressesType alternateAddresses = new AlternateAddressesType();
                enrollmentType.getProviderInformation().setAlternateAddresses(alternateAddresses);
                if ("N".equals(organization.getBillingSameAsPrimary())) {
                    alternateAddresses.getAddress().add(BinderUtils.bindAddress(organization.getBillingAddress()));
                    org.setBillingAddressIndex(alternateAddresses.getAddress().size());
                } else {
                    org.setBillingAddressIndex(0);
                }

                if ("N".equals(organization.getTen99SameAsPrimary())) {
                    alternateAddresses.getAddress().add(BinderUtils.bindAddress(organization.getTen99Address()));
                    org.setTen99AddressIndex(alternateAddresses.getAddress().size());
                } else {
                    org.setTen99AddressIndex(0);
                }
            }

            List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
            if (designatedContacts != null) {
                for (DesignatedContact designatedContact : designatedContacts) {
                    if (designatedContact.getType() == DesignatedContactType.ENROLLMENT) {
                        ContactInformationType xContact = XMLUtility.nsGetContactInformation(enrollmentType);
                        Person hPerson = designatedContact.getPerson();
                        xContact.setName(hPerson.getName());
                        if (hPerson.getContactInformation() != null) {
                            xContact.setEmailAddress(hPerson.getContactInformation().getEmail());
                            xContact.setPhoneNumber(hPerson.getContactInformation().getPhoneNumber());
                            xContact.setFaxNumber(hPerson.getContactInformation().getFaxNumber());
                        }
                    }
                }
            }
        }
    }

    /**
     * Binds the designated enrollment contact to the hibernate model.
     * @param enrollment the frontend model
     * @param profile the hibernate model
     */
    private void bindEnrollmentContactToHibernate(EnrollmentType enrollmentType, ProviderProfile profile) {
        List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
        if ("Y".equals(enrollmentType.getContactSameAsApplicant())) {
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
                    person.setName(enrollmentType.getContactInformation().getName());

                    if (person.getContactInformation() == null) {
                        person.setContactInformation(new ContactInformation());
                    }
                    person.getContactInformation().setEmail(enrollmentType.getContactInformation().getEmailAddress());
                    person.getContactInformation().setPhoneNumber(enrollmentType.getContactInformation().getPhoneNumber());
                    person.getContactInformation().setFaxNumber(enrollmentType.getContactInformation().getFaxNumber());
                    found = true;
                }
            }

            if (!found) {
                DesignatedContact designatedContact = new DesignatedContact();
                designatedContact.setType(DesignatedContactType.ENROLLMENT);
                Person person = new Person();
                designatedContact.setPerson(person);

                person.setName(enrollmentType.getContactInformation().getName());
                person.setContactInformation(new ContactInformation());
                person.getContactInformation().setEmail(enrollmentType.getContactInformation().getEmailAddress());
                person.getContactInformation().setPhoneNumber(enrollmentType.getContactInformation().getPhoneNumber());
                person.getContactInformation().setFaxNumber(enrollmentType.getContactInformation().getFaxNumber());
                profile.getDesignatedContacts().add(designatedContact);
            }
        }
    }

    @Override
    public void renderPDF(EnrollmentType enrollmentType, Document document, Map<String, Object> model)
        throws DocumentException {

        String ns = NAMESPACE;
        if (!"Y".equals(PDFHelper.value(model, ns, "bound"))) {
            return;
        }

        ViewModel viewModel = (ViewModel) model.get("viewModel");
        UITabModel tabModel = viewModel.getTabModels().get(ViewStatics.ORGANIZATION_INFO);
        Map<String, Object> settings = tabModel.getFormSettings().get(ViewStatics.ORG_INFO_FORM).getSettings();
        boolean useEDILayout = false;
        if (settings != null && settings.get("useEDILayout") instanceof Boolean) {
            useEDILayout = (Boolean) settings.get("useEDILayout");
        }

        // Personal Info Section
        PdfPTable personalInfo = new PdfPTable(2);
        PDFHelper.setTableAsFullPage(personalInfo);

        if (useEDILayout) {
            PDFHelper.addLabelValueCell(personalInfo, "EDI Type", PDFHelper.value(model, ns, "subType"));
        }

        PDFHelper.addLabelValueCell(personalInfo, "NPI/UMPI", PDFHelper.value(model, ns, "npi"));
        PDFHelper.addLabelValueCell(personalInfo, "Effective Date", PDFHelper.value(model, ns, "effectiveDate"));
        PDFHelper.addLabelValueCell(personalInfo, "Organization Name", PDFHelper.value(model, ns, "name"));
        PDFHelper.addLabelValueCell(personalInfo, "Legal Name", PDFHelper.value(model, ns, "legalName"));
        PDFHelper.addLabelValueCell(personalInfo, "FEIN", PDFHelper.value(model, ns, "fein"));
        PDFHelper.addLabelValueCell(personalInfo, "State Tax ID", PDFHelper.value(model, ns, "stateTaxId"));
        PDFHelper.addLabelValueCell(personalInfo, "Fiscal Year End", PDFHelper.getFiscalYear(model, ns));

        PDFHelper.addLabelValueCell(personalInfo, "Address", PDFHelper.getAddress(model, ns, null));
        PDFHelper.addLabelValueCell(personalInfo, "Phone Number", PDFHelper.getPhone(model, ns, "phone"));
        PDFHelper.addLabelValueCell(personalInfo, "Fax Number", PDFHelper.getPhone(model, ns, "fax"));
        PDFHelper.addLabelValueCell(personalInfo, "Name Of Person Completing Form", PDFHelper.value(model, ns, "personCompletingForm"));

        if (!useEDILayout) {
            if ("Y".equals(PDFHelper.value(model, ns, "billingSameAsPrimary"))) {
                PDFHelper.addLabelValueCell(personalInfo, "Billing Address", "Same As Above");
            } else {
                PDFHelper.addLabelValueCell(personalInfo, "Billing Address", PDFHelper.getAddress(model, ns, "billing"));
            }

            if ("Y".equals(PDFHelper.value(model, ns, "ten99SameAsPrimary"))) {
                PDFHelper.addLabelValueCell(personalInfo, "1099 Address", "Same As Above");
            } else {
                PDFHelper.addLabelValueCell(personalInfo, "1099 Address", PDFHelper.getAddress(model, ns, "ten99"));
            }
        }

        document.add(personalInfo);

        PdfPTable contactInfo = new PdfPTable(2); // 2 columns of key value pairs
        PDFHelper.setTableAsFullPage(contactInfo);

        contactInfo.addCell(PDFHelper.createHeaderCell("Contact Information", 2));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Name", PDFHelper.value(model, ns, "contactName"));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Phone Number", PDFHelper.getPhone(model, ns, "contactPhone"));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Fax Number", PDFHelper.getPhone(model, ns, "contactFax"));
        PDFHelper.addLabelValueCell(contactInfo, "Contact Email Address", PDFHelper.value(model, ns, "contactEmail"));

        document.add(contactInfo);
    }

    /**
     * Reads the billing address from the request.
     *
     * @param request the request to read from
     * @return the bound address
     */
    private AddressType readBillingAddress(HttpServletRequest request) {
        return readPrefixedAddress(request, "billing");
    }

    /**
     * Reads the billing address from the request.
     *
     * @param request the request to read from
     * @return the bound address
     */
    private AddressType readTen99Address(HttpServletRequest request) {
        return readPrefixedAddress(request, "ten99");
    }
}
