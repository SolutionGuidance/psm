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
public class PrimaryPracticeFormBinder extends AbstractPracticeFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_06_";

    /**
     * Creates a new binder.
     */
    public PrimaryPracticeFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param user
     *            the requesting user, for user based data view control
     * @param application
     *            the model to bind to
     * @param request
     *            the request containing the form fields
     *
     * @throws BinderException
     *             if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        if (!canModifyExistingPractice(user, applicationType)) {
            return new ArrayList<BinderException>();
        }
        List<BinderException> exceptions = super.bindFromPage(user, applicationType, request);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        if (!"Y".equals(provider.getMaintainsOwnPrivatePractice())) { // assumes practice type is bound first
            practice.setStateMedicaidId(param(request, "stateMedicaidId"));
            if (param(request, "reimbursementSameAsPrimary") != null) {
                practice.setReimbursementSameAsPrimary("Y");
                AddressType reimbursementAddress = readPrimaryAddress(request);
                practice.setReimbursementAddress(reimbursementAddress);
            } else {
                if (!Util.isBlank(param(request, "objectId"))) {
                    // means the reimbursementSameAsPrimary is disabled in the form and the practice lookup is copied
                    practice.setReimbursementSameAsPrimary("Y");
                    // no need to set reimbursement address
                } else {
                    practice.setReimbursementSameAsPrimary("N");
                    AddressType reimbursementAddress = readReimbursementAddress(request);
                    practice.setReimbursementAddress(reimbursementAddress);
                }
            }

            try {
                practice.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate")));
            } catch (BinderException e) {
                e.setAttribute(name("effectiveDate"), param(request, "effectiveDate"));
                exceptions.add(e);
            }
        } else {
            practice.setReimbursementAddress(null);
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param user
     *            the requesting user, for user based data update control
     * @param application
     *            the model to bind from
     * @param mv
     *            the model and view to bind to
     * @param readOnly
     *            true if the binding is for a read only view
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        if (!canModifyExistingPractice(user, applicationType)) {
            return;
        }
        super.bindToPage(user, applicationType, mv, readOnly);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        attr(mv, "stateMedicaidId", practice.getStateMedicaidId());
        attr(mv, "reimbursementSameAsPrimary", practice.getReimbursementSameAsPrimary());

        if (!"Y".equals(practice.getReimbursementSameAsPrimary())) {
            AddressType reimbursementAddress = practice.getReimbursementAddress();
            if (reimbursementAddress != null) {
                attr(mv, "reimbursement", reimbursementAddress);
            }
        }
        attr(mv, "effectiveDate", practice.getEffectiveDate());
    }

    /**
     * Captures the error messages related to the form.
     *
     * @param application
     *            the application that was validated
     * @param messages
     *            the messages to select from
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

                if (path.equals(PRACTICE_INFO + "ReimbursementAddress")) {
                    errors.add(createError(new String[] { "reimbursementAddressLine1", "reimbursementAddressLine2" },
                            ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "EffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/AddressLine1")) {
                    errors.add(createError("reimbursementAddressLine1", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/AddressLine2")) {
                    errors.add(createError("reimbursementAddressLine2", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/City")) {
                    errors.add(createError("reimbursementCity", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/State")) {
                    errors.add(createError("reimbursementState", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/ZipCode")) {
                    errors.add(createError("reimbursementZip", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/County")) {
                    errors.add(createError("reimbursementCounty", ruleError.getMessage()));
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
     * @param application
     *            the front end model
     * @param application
     *            the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        super.bindToHibernate(applicationType, application);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);

        ProviderProfile profile = application.getDetails();
        Affiliation primary = findPrimaryGroup(profile.getAffiliations());

        if (Util.isBlank(practice.getObjectId())) {
            Organization employer = (Organization) primary.getEntity();

            employer.setStateMedicaidId(practice.getStateMedicaidId());

            employer.setReimbursementSameAsPrimary(practice.getReimbursementSameAsPrimary());
            if ("Y".equals(practice.getReimbursementSameAsPrimary())) {
                employer.setReimbursementAddress(null);
            } else {
                employer.setReimbursementAddress(BinderUtils.bindAddress(practice.getReimbursementAddress()));
            }
        }

        primary.setEffectiveDate(BinderUtils.toDate(practice.getEffectiveDate()));
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application
     *            the persistent model
     * @param application
     *            the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        super.bindFromHibernate(application, applicationType);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(applicationType);
        ProviderProfile profile = application.getDetails();
        Affiliation primary = findPrimaryGroup(profile.getAffiliations());
        if (primary == null) {
            return;
        }

        Organization employer = (Organization) primary.getEntity();
        if (!"Y".equals(employer.getEnrolled())) {
            practice.setStateMedicaidId(employer.getStateMedicaidId());

            // user owned employer record, show everything
            ContactInformation hContact = employer.getContactInformation();
            practice.setReimbursementSameAsPrimary(employer.getReimbursementSameAsPrimary());
            if (hContact != null) {
                if ("Y".equals(employer.getReimbursementSameAsPrimary())) {
                    practice.setReimbursementAddress(BinderUtils.bindAddress(hContact.getAddress()));
                } else {
                    practice.setReimbursementAddress(BinderUtils.bindAddress(employer.getReimbursementAddress()));
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
            PDFHelper.addLabelValueCell(practiceInfo, "Primary Practice Name", PDFHelper.value(model, ns, "name"));
            PDFHelper.addLabelValueCell(practiceInfo, "Group NPI/UMPI", PDFHelper.value(model, ns, "npi"));
            PDFHelper.addLabelValueCell(practiceInfo, "State Medicaid ID", PDFHelper.value(model, ns, "stateMedicaidId"));
            PDFHelper.addLabelValueCell(practiceInfo, "Requested Effective Date",
                    PDFHelper.value(model, ns, "effectiveDate"));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Address", PDFHelper.getAddress(model, ns, null));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Phone Number", PDFHelper.getPhone(model, ns, "phone"));
            PDFHelper.addLabelValueCell(practiceInfo, "Practice Fax Number", PDFHelper.getPhone(model, ns, "fax"));
            PDFHelper.addLabelValueCell(practiceInfo, "Reimbursement Address",
                    PDFHelper.getAddress(model, ns, "billing"));
        }

        document.add(practiceInfo);
    }

    /**
     * Reads the billing address from the request.
     *
     * @param request
     *            the request to read from
     * @return the bound address
     */
    private AddressType readReimbursementAddress(HttpServletRequest request) {
        return readPrefixedAddress(request, "reimbursement");
    }
}
