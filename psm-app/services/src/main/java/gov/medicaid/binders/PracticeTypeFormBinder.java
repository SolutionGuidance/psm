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

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.PDFHelper;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
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
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @return
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        provider.setMaintainsOwnPrivatePractice(param(request, "maintainsOwnPrivatePractice"));
        provider.setEmployedOrContractedByGroup(param(request, "employedOrContractedByGroup"));
        return Collections.emptyList();
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
        attr(mv, "maintainsOwnPrivatePractice", provider.getMaintainsOwnPrivatePractice());
        attr(mv, "employedOrContractedByGroup", provider.getEmployedOrContractedByGroup());
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
     * @param applicationType the front end model
     * @param application the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        if (applicationType.getProviderInformation() != null) {
            ProviderInformationType provider = applicationType.getProviderInformation();
            ProviderProfile profile = application.getDetails();
            profile.setMaintainsOwnPrivatePractice(provider.getMaintainsOwnPrivatePractice());
            profile.setEmployedOrContractedByGroup(provider.getEmployedOrContractedByGroup());
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
            ProviderInformationType pInfo = XMLUtility.nsGetProvider(applicationType);
            pInfo.setMaintainsOwnPrivatePractice(profile.getMaintainsOwnPrivatePractice());
            pInfo.setEmployedOrContractedByGroup(profile.getEmployedOrContractedByGroup());
        }
    }

    @Override
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model)
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
