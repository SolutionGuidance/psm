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

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.PDFHelper;

import java.util.ArrayList;
import java.util.Collections;
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
public class PracticeTypeFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_04_";

    /**
     * The XML path that maps to private practice question.
     */
    private static final String PRIV_PRACTICE_PATH = "/ProviderInformation/MaintainsOwnPrivatePractice";

    /**
     * The XML path that maps to additional practice question.
     */
    private static final String ADD_PRACTICE_PATH = "/ProviderInformation/EmployedOrContractedByGroup";

    /**
     * Creates a new binder.
     */
    public PracticeTypeFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        provider.setMaintainsOwnPrivatePractice(param(request, "maintainsOwnPrivatePractice"));
        provider.setEmployedOrContractedByGroup(param(request, "employedOrContractedByGroup"));
        return Collections.EMPTY_LIST;
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
        attr(mv, "maintainsOwnPrivatePractice", provider.getMaintainsOwnPrivatePractice());
        attr(mv, "employedOrContractedByGroup", provider.getEmployedOrContractedByGroup());
    }

    /**
     * Captures the error messages related to the form.
     * @param enrollment the enrollment that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
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

                if (path.equals(PRIV_PRACTICE_PATH)) {
                    errors.add(createError("maintainsOwnPrivatePractice", ruleError.getMessage()));
                } else if (path.equals(ADD_PRACTICE_PATH)) {
                    errors.add(createError("employedOrContractedByGroup", ruleError.getMessage()));
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
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        if (enrollment.getProviderInformation() != null) {
            ProviderInformationType provider = enrollment.getProviderInformation();
            ProviderProfile profile = ticket.getDetails();
            profile.setMaintainsOwnPrivatePractice(provider.getMaintainsOwnPrivatePractice());
            profile.setEmployedOrContractedByGroup(provider.getEmployedOrContractedByGroup());
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
            ProviderInformationType pInfo = XMLUtility.nsGetProvider(enrollment);
            pInfo.setMaintainsOwnPrivatePractice(profile.getMaintainsOwnPrivatePractice());
            pInfo.setEmployedOrContractedByGroup(profile.getEmployedOrContractedByGroup());
        }
    }


    @Override
    public void renderPDF(EnrollmentType enrollment, Document document, Map<String, Object> model)
        throws DocumentException {
        String ns = NAMESPACE;
        PdfPTable practiceInfo = new PdfPTable(2);
        PDFHelper.setTableAsFullPage(practiceInfo);
        if ("Y".equals(PDFHelper.value(model, ns, "bound"))) {
            PDFHelper.addLabelValueCell(practiceInfo, "Do you maintain your own private practice?",
                PDFHelper.formatBoolean(PDFHelper.value(model, ns, "maintainsOwnPrivatePractice")));
            PDFHelper.addLabelValueCell(practiceInfo, "Are you employed and/or independently contracted by a group practice?",
                PDFHelper.formatBoolean(PDFHelper.value(model, ns, "employedOrContractedByGroup")));
        }

        document.add(practiceInfo);
    }
}
