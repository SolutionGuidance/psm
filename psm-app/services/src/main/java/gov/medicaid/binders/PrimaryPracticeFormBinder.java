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

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.PracticeInformationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.PDFHelper;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.pdf.PdfPTable;

/**
 * This binder handles the provider type selection form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @param enrollment
     *            the model to bind to
     * @param request
     *            the request containing the form fields
     *
     * @throws BinderException
     *             if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        if (!canModifyExistingPractice(user, enrollment)) {
            return new ArrayList<BinderException>();
        }
        List<BinderException> exceptions = super.bindFromPage(user, enrollment, request);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
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
     * @param enrollment
     *            the model to bind from
     * @param mv
     *            the model and view to bind to
     * @param readOnly
     *            true if the binding is for a read only view
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        if (!canModifyExistingPractice(user, enrollment)) {
            return;
        }
        super.bindToPage(user, enrollment, mv, readOnly);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);

        attr(mv, "stateMedicaidId", practice.getStateMedicaidId());
        attr(mv, "reimbursementSameAsPrimary", practice.getReimbursementSameAsPrimary());

        if (!"Y".equals(practice.getReimbursementSameAsPrimary())) {
            AddressType reimbursementAddress = practice.getReimbursementAddress();
            if (reimbursementAddress != null) {
                String line1 = reimbursementAddress.getAddressLine1();
                String line2 = reimbursementAddress.getAddressLine2();
                if (Util.isBlank(line1)) {
                    line1 = line2;
                    line2 = null;
                }
                attr(mv, "reimbursementAddressLine1", line1);
                attr(mv, "reimbursementAddressLine2", line2);
                attr(mv, "reimbursementCity", reimbursementAddress.getCity());
                attr(mv, "reimbursementState", reimbursementAddress.getState());
                attr(mv, "reimbursementZip", reimbursementAddress.getZipCode());
                attr(mv, "reimbursementCounty", reimbursementAddress.getCounty());
            }
        }
        attr(mv, "effectiveDate", practice.getEffectiveDate());
    }

    /**
     * Captures the error messages related to the form.
     *
     * @param enrollment
     *            the enrollment that was validated
     * @param messages
     *            the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>(super.selectErrors(enrollment, messages));

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);

        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();

                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                boolean switchAddressLines = false;
                if (practice.getReimbursementAddress() == null
                        || Util.isBlank(practice.getReimbursementAddress().getAddressLine1())) {
                    switchAddressLines = true;
                }

                if (path.equals(PRACTICE_INFO + "ReimbursementAddress")) {
                    errors.add(createError(new String[] { "reimbursementAddressLine1", "reimbursementAddressLine2" },
                            ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "EffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/AddressLine1")) {
                    errors.add(createError(switchAddressLines ? "reimbursementAddressLine2"
                            : "reimbursementAddressLine1", ruleError.getMessage()));
                } else if (path.equals(PRACTICE_INFO + "ReimbursementAddress/AddressLine2")) {
                    errors.add(createError(switchAddressLines ? "reimbursementAddressLine1"
                            : "reimbursementAddressLine2", ruleError.getMessage()));
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
     * @param enrollment
     *            the front end model
     * @param ticket
     *            the persistent model
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        super.bindToHibernate(enrollment, ticket);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);

        ProviderProfile profile = ticket.getDetails();
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
     * @param ticket
     *            the persistent model
     * @param enrollment
     *            the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        super.bindFromHibernate(ticket, enrollment);
        PracticeInformationType practice = XMLUtility.nsGetPracticeInformation(enrollment);
        ProviderProfile profile = ticket.getDetails();
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
    public void renderPDF(EnrollmentType enrollment, Document document, Map<String, Object> model)
            throws DocumentException {
        super.renderPDF(enrollment, document, model);
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
        AddressType address = new AddressType();
        String line1 = param(request, "reimbursementAddressLine1");
        String line2 = param(request, "reimbursementAddressLine2");
        if (Util.isBlank(line2)) { // prioritize line 2 usage
            line2 = line1;
            line1 = null;
        }
        address.setAddressLine1(line1);
        address.setAddressLine2(line2);
        address.setCity(param(request, "reimbursementCity"));
        address.setState(param(request, "reimbursementState"));
        address.setZipCode(param(request, "reimbursementZip"));
        address.setCounty(param(request, "reimbursementCounty"));
        return address;
    }

}
