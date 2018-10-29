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
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.PracticeInformationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RemittanceSequenceOrder;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.PDFHelper;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
 */
public class PrivatePracticeFormBinder extends AbstractPracticeFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_05_";

    /**
     * Creates a new binder.
     */
    public PrivatePracticeFormBinder() {
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
        if (!canModifyExistingPractice(user, applicationType)) {
            return new ArrayList<BinderException>();
        }
        List<BinderException> exceptions = new ArrayList<BinderException>(super.bindFromPage(user, applicationType, request));

        ProviderInformationType provider = applicationType.getProviderInformation();
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        if ("Y".equals(provider.getMaintainsOwnPrivatePractice())) { // assumes practice type is bound first
            try {
                practice.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate")));
            } catch (BinderException e) {
                e.setAttribute(name("effectiveDate"), param(request, "effectiveDate"));
                exceptions.add(e);
            }

            if (param(request, "billingSameAsPrimary") != null) {
                practice.setBillingSameAsPrimary("Y");
                AddressType billingAddress = readPrimaryAddress(request);
                practice.setBillingAddress(billingAddress);
            } else {
                practice.setBillingSameAsPrimary("N");
                AddressType billingAddress = readBillingAddress(request);
                practice.setBillingAddress(billingAddress);
            }

            practice.setFEIN(param(request, "fein"));
            practice.setStateTaxId(param(request, "stateTaxId"));
            practice.setFiscalYearEnd(BinderUtils.concatFiscalYearEnd(param(request, "fye1"), param(request, "fye2")));
            if (param(request, "eftAccepted") != null) {
                practice.setEftAccepted(
                        Boolean.valueOf(param(request, "eftAccepted"))
                );
            }
            provider.setRemittanceSequenceNumber(param(request, "remittanceSequence"));
        } else {
            practice.setEffectiveDate(null);
            practice.setBillingSameAsPrimary(null);
            practice.setBillingAddress(null);
            practice.setFEIN(null);
            practice.setStateTaxId(null);
            practice.setFiscalYearEnd(null);
            practice.setEftAccepted(null);
            provider.setRemittanceSequenceNumber(null);
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
        if (!canModifyExistingPractice(user, applicationType)) {
            return;
        }
        super.bindToPage(user, applicationType, mv, readOnly);
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        attr(mv, "effectiveDate", BinderUtils.formatCalendar(practice.getEffectiveDate()));

        if (Util.isBlank(practice.getObjectId())) { // do not display private data from linked profile
            attr(mv, "billingSameAsPrimary", practice.getBillingSameAsPrimary());

            AddressType billingAddress = practice.getBillingAddress();
            if (billingAddress != null && !"Y".equals(practice.getBillingSameAsPrimary())) {
                attr(mv, "billing", billingAddress);
            }

            attr(mv, "fein", practice.getFEIN());
            attr(mv, "stateTaxId", practice.getStateTaxId());
            String[] fye = BinderUtils.splitFiscalYear(practice.getFiscalYearEnd());
            attr(mv, "fye1", fye[0]);
            attr(mv, "fye2", fye[1]);
            attr(mv, "eftAccepted", practice.isEftAccepted());
            attr(mv, "remittanceSequence", provider.getRemittanceSequenceNumber());
        }
    }

    /**
     * Captures the error messages related to the form.
     * @param application the application that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>(super.selectErrors(applicationType, messages));

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();

                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals(PRACTICE_INFO + "EffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress")) {
                    errors.add(createError(new String[]{"billingAddressLine1", "billingAddressLine2"}, ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/AddressLine1")) {
                    errors.add(createError("billingAddressLine1", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/AddressLine2")) {
                    errors.add(createError("billingAddressLine2", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/City")) {
                    errors.add(createError("billingCity", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/State")) {
                    errors.add(createError("billingState", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/ZipCode")) {
                    errors.add(createError("billingZip", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "BillingAddress/County")) {
                    errors.add(createError("billingCounty", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "FEIN")) {
                    errors.add(createError("fein", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "StateTaxId")) {
                    errors.add(createError("stateTaxId", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/RemittanceSequenceNumber")) {
                    errors.add(createError("remittanceSequence", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "EftAccepted")) {
                    errors.add(createError("EftAccepted", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "FiscalYearEnd")) {
                    String[] fiscalYearGroup = new String[]{"fye1", "fye2"};
                    errors.add(createError(fiscalYearGroup, ruleError.getMessage()));
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
        super.bindToHibernate(applicationType, application);
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        ProviderProfile profile = application.getDetails();
        Affiliation primary = findPrimaryGroup(profile.getAffiliations());

        primary.setEffectiveDate(BinderUtils.toDate(practice.getEffectiveDate()));

        if (Util.isBlank(practice.getObjectId())) {
            Organization employer = (Organization) primary.getEntity();
            employer.setFein(practice.getFEIN());
            employer.setEftAccepted(practice.isEftAccepted());
            employer.setStateTaxId(practice.getStateTaxId());
            employer.setFiscalYearEnd(practice.getFiscalYearEnd());
            if (Util.isNotBlank(provider.getRemittanceSequenceNumber())) {
                employer.setRemittanceSequenceOrder(RemittanceSequenceOrder.valueOf(provider
                    .getRemittanceSequenceNumber()));
            }

            employer.setBillingSameAsPrimary(practice.getBillingSameAsPrimary());
            if ("Y".equals(practice.getBillingSameAsPrimary())) {
                employer.setBillingAddress(null);
            } else {
                employer.setBillingAddress(BinderUtils.bindAddress(practice.getBillingAddress()));
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
        super.bindFromHibernate(application, applicationType);
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
        ProviderProfile profile = application.getDetails();
        Affiliation primary = findPrimaryGroup(profile.getAffiliations());
        if (primary == null) {
            return;
        }

        Organization employer = (Organization) primary.getEntity();
        if (!"Y".equals(employer.getEnrolled())) {
            // user owned employer record, show everything
            practice.setFEIN(employer.getFein());
            practice.setEftAccepted(employer.isEftAccepted());
            practice.setStateTaxId(employer.getStateTaxId());
            practice.setFiscalYearEnd(employer.getFiscalYearEnd());
            if (employer.getRemittanceSequenceOrder() != null) {
                provider.setRemittanceSequenceNumber(employer.getRemittanceSequenceOrder().name());
            }

            ContactInformation hContact = employer.getContactInformation();
            practice.setBillingSameAsPrimary(employer.getBillingSameAsPrimary());
            if (hContact != null) {
                if ("Y".equals(employer.getBillingSameAsPrimary())) {
                    practice.setBillingAddress(BinderUtils.bindAddress(hContact.getAddress()));
                } else {
                    practice.setBillingAddress(BinderUtils.bindAddress(employer.getBillingAddress()));
                }
            }
        }

        practice.setEffectiveDate(BinderUtils.toCalendar(primary.getEffectiveDate()));
    }

    @Override
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model)
        throws DocumentException {
        super.renderPDF(applicationType, document, model);

        PdfPTable practiceInfo = new PdfPTable(2);
        PDFHelper.setTableAsFullPage(practiceInfo);

        String ns = NAMESPACE;
        if ("Y".equals(PDFHelper.value(model, ns, "bound"))) {
            PDFHelper.addLabelValueCell(practiceInfo, "Private Practice Name", PDFHelper.value(model, ns, "name"));
            PDFHelper.addLabelValueCell(practiceInfo, "Group NPI/UMPI", PDFHelper.value(model, ns, "npi"));
            PDFHelper.addLabelValueCell(practiceInfo, "Effective Date", PDFHelper.value(model, ns, "effectiveDate"));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Address", PDFHelper.getAddress(model, ns, null));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Phone Number", PDFHelper.getPhone(model, ns, "phone"));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Fax Number", PDFHelper.getPhone(model, ns, "fax"));
            PDFHelper.addLabelValueCell(practiceInfo, "Billing Address", PDFHelper.getAddress(model, ns, "billing"));
            PDFHelper.addLabelValueCell(practiceInfo, "FEIN", PDFHelper.value(model, ns, "fein"));
            PDFHelper.addLabelValueCell(practiceInfo, "State Tax ID", PDFHelper.value(model, ns, "stateTaxId"));
            PDFHelper.addLabelValueCell(practiceInfo, "Fiscal Year End", PDFHelper.getFiscalYear(model, ns));
            PDFHelper.addLabelValueCell(practiceInfo, "Accepts EFT", PDFHelper.getBoolean(model, ns, "eftAccepted"));
            PDFHelper.addLabelValueCell(practiceInfo, "Remittance Sequence", RemittanceSequenceOrder.
                    valueOf(PDFHelper.value(model, ns, "remittanceSequence")).getDescription());
        }

        document.add(practiceInfo);
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
}
