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

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.DesignatedContactInformationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the personal information form.
 */
public class PCABillingContactFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_24_";

    /**
     * Creates a new instance.
     */
    public PCABillingContactFormBinder() {
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
        gov.medicaid.domain.model.DesignatedContactType billingContact = findPCABillingContact(provider);
        if (billingContact != null) {
            provider.getDesignatedContactInformation().getDesignatedContact().remove(billingContact);
        }

        billingContact = new gov.medicaid.domain.model.DesignatedContactType();
        billingContact.setFullName(param(request, "billingContactName"));
        billingContact.setPrefix(param(request, "billingContactTitle"));
        billingContact.setDesignationType(DesignatedContactType.PCA_BILLING.toString());
        try {
            billingContact.setHireDate(BinderUtils.getAsCalendar(param(request, "billingContactHireDate")));
        } catch (BinderException e) {
            e.setAttribute(name("billingContactHireDate"), param(request, "billingContactHireDate"));
            exceptions.add(e);
        }
        billingContact.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "billingContactSSN")));
        try {
            billingContact.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "billingContactDOB")));
        } catch (BinderException e) {
            e.setAttribute(name("billingContactDOB"), param(request, "billingContactDOB"));
            exceptions.add(e);
        }

        if (provider.getDesignatedContactInformation() == null) {
            provider.setDesignatedContactInformation(new DesignatedContactInformationType());
        }
        provider.getDesignatedContactInformation().getDesignatedContact().add(billingContact);
        return exceptions;
    }

    /**
     * @param contacts
     * @param billingContact
     * @return
     */
    private gov.medicaid.domain.model.DesignatedContactType findPCABillingContact(ProviderInformationType provider) {
        DesignatedContactInformationType designatedContact = provider.getDesignatedContactInformation();
        if (designatedContact == null) {
            return null;
        }
        List<gov.medicaid.domain.model.DesignatedContactType> contacts = designatedContact.getDesignatedContact();
        if (contacts == null) {
            return null;
        }

        gov.medicaid.domain.model.DesignatedContactType billingContact = null;
        for (gov.medicaid.domain.model.DesignatedContactType designatedContactType : contacts) {
            String type = designatedContactType.getDesignationType();
            if (DesignatedContactType.PCA_BILLING.toString().equals(type)) {
                billingContact = designatedContactType;
                break;
            }
        }
        return billingContact;
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
        gov.medicaid.domain.model.DesignatedContactType billingContact = findPCABillingContact(provider);
        if (billingContact != null) {
            attr(mv, "billingContactName", billingContact.getFullName());
            attr(mv, "billingContactTitle", billingContact.getPrefix());
            attr(mv, "billingContactHireDate", billingContact.getHireDate());
            attr(mv, "billingContactSSN", BinderUtils.formatSSN(billingContact.getSocialSecurityNumber()));
            attr(mv, "billingContactDOB", billingContact.getDateOfBirth());
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        gov.medicaid.domain.model.DesignatedContactType contact = findPCABillingContact(provider);
        int pcaIndex = -1;
        if (contact != null) {
            pcaIndex = provider.getDesignatedContactInformation().getDesignatedContact().indexOf(contact);
        }
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals("/ProviderInformation/DesignatedContactInformation")) {
                    errors.add(createError("lastName", ruleError.getMessage()));
                } else if (path.startsWith("/ProviderInformation/DesignatedContactInformation/DesignatedContact[" + pcaIndex + "]")) {
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

        return errors.isEmpty() ? NO_ERRORS : errors;
    }

    /**
     * Resolves the specific license that is causing the error from the license list.
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        String message = ruleError.getMessage();

        if (path.endsWith("DateOfBirth")) {
            return createError("billingContactDOB", message);
        } else if (path.endsWith("FullName")) {
            return createError("billingContactName", message);
        } else if (path.endsWith("HireDate")) {
            return createError("billingContactHireDate", message);
        } else if (path.endsWith("SocialSecurityNumber")) {
            return createError("billingContactSSN", message);
        } else if (path.endsWith("Prefix")) {
            return createError("billingContactTitle", message);
        }

        // general location error
        return createError("group", message);
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
        ProviderInformationType providerInfo = applicationType.getProviderInformation();
        if (providerInfo != null) {
            List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
            if (designatedContacts == null) {
                designatedContacts = new ArrayList<DesignatedContact>();
                profile.setDesignatedContacts(designatedContacts);
            }

            gov.medicaid.domain.model.DesignatedContactType billingContact = findPCABillingContact(providerInfo);

            DesignatedContact hbContact = null;
            for (Iterator<DesignatedContact> iter = designatedContacts.iterator(); iter.hasNext();) {
                DesignatedContact designatedContact = iter.next();
                if (designatedContact.getType() == DesignatedContactType.PCA_BILLING) {
                    hbContact = designatedContact;
                }
            }

            if (hbContact != null) {
                designatedContacts.remove(hbContact);
            }

            if (billingContact != null) {
                DesignatedContact designatedContact = new DesignatedContact();
                designatedContact.setType(DesignatedContactType.PCA_BILLING);
                Person person = new Person();
                designatedContact.setPerson(person);

                designatedContact.setHireDate(BinderUtils.toDate(billingContact.getHireDate()));
                person.setName(billingContact.getFullName());
                person.setPrefix(billingContact.getPrefix());
                person.setSsn(billingContact.getSocialSecurityNumber());
                person.setDob(BinderUtils.toDate(billingContact.getDateOfBirth()));
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

            DesignatedContact hbContact = null;
            List<DesignatedContact> designatedContacts = profile.getDesignatedContacts();
            if (designatedContacts != null) {
                for (Iterator<DesignatedContact> iter = designatedContacts.iterator(); iter.hasNext();) {
                    DesignatedContact designatedContact = iter.next();
                    if (designatedContact.getType() == DesignatedContactType.PCA_BILLING) {
                        hbContact = designatedContact;
                    }
                }

                if (hbContact != null) {
                    ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
                    gov.medicaid.domain.model.DesignatedContactType billingContact = findPCABillingContact(provider);
                    if (billingContact != null) {
                        provider.getDesignatedContactInformation().getDesignatedContact().remove(billingContact);
                    }

                    if (provider.getDesignatedContactInformation() == null) {
                        provider.setDesignatedContactInformation(new DesignatedContactInformationType());
                    }

                    billingContact = new gov.medicaid.domain.model.DesignatedContactType();
                    billingContact.setFullName(hbContact.getPerson().getName());
                    billingContact.setPrefix(hbContact.getPerson().getPrefix());
                    billingContact.setDesignationType(DesignatedContactType.PCA_BILLING.toString());
                    billingContact.setHireDate(BinderUtils.toCalendar(hbContact.getHireDate()));
                    billingContact.setSocialSecurityNumber(hbContact.getPerson().getSsn());
                    billingContact.setDateOfBirth(BinderUtils.toCalendar(hbContact.getPerson().getDob()));
                    provider.getDesignatedContactInformation().getDesignatedContact().add(billingContact);
                }
            }
        }
    }
}
