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
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization disclosure.
 */
public class OrganizationDisclosureFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_18_";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_1 = "/ProviderInformation/HasCriminalConviction";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_2 = "/ProviderInformation/HasCivilPenalty";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_3 = "/ProviderInformation/HasPreviousExclusion";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_4 = "/ProviderInformation/EmployeeHasCriminalConviction";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_5 = "/ProviderInformation/EmployeeHasCivilPenalty";

    /**
     * Disclosure Path.
     */
    private static final String QUESTION_6 = "/ProviderInformation/EmployeeHasPreviousExclusion";

    /**
     * Creates a new binder.
     */
    public OrganizationDisclosureFormBinder() {
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        provider.setHasCriminalConviction(param(request, "criminalConvictionInd"));
        provider.setHasCivilPenalty(param(request, "civilPenaltyInd"));
        provider.setHasPreviousExclusion(param(request, "previousExclusionInd"));
        provider.setEmployeeHasCriminalConviction(param(request, "empCriminalConvictionInd"));
        provider.setEmployeeHasCivilPenalty(param(request, "empCivilPenaltyInd"));
        provider.setEmployeeHasPreviousExclusion(param(request, "empPreviousExclusionInd"));
        provider.setRenewalShowBlankStatement(param(request, "renewalBlankInit"));
        return Collections.emptyList();
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        // for renewal the form should be blank
        if (applicationType.getRequestType() == RequestType.RENEWAL && provider.getRenewalShowBlankStatement() == null) {
            attr(mv, "renewalBlankInit", "Y");
        } else {
            attr(mv, "criminalConvictionInd", provider.getHasCriminalConviction());
            attr(mv, "civilPenaltyInd", provider.getHasCivilPenalty());
            attr(mv, "previousExclusionInd", provider.getHasPreviousExclusion());
            attr(mv, "empCriminalConvictionInd", provider.getEmployeeHasCriminalConviction());
            attr(mv, "empCivilPenaltyInd", provider.getEmployeeHasCivilPenalty());
            attr(mv, "empPreviousExclusionInd", provider.getEmployeeHasPreviousExclusion());
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

                if (path.equals(QUESTION_1)) {
                    errors.add(createError("criminalConvictionInd", ruleError.getMessage()));
                } else if (path.equals(QUESTION_2)) {
                    errors.add(createError("civilPenaltyInd", ruleError.getMessage()));
                } else if (path.equals(QUESTION_3)) {
                    errors.add(createError("previousExclusionInd", ruleError.getMessage()));
                } else if (path.equals(QUESTION_4)) {
                    errors.add(createError("empCriminalConvictionInd", ruleError.getMessage()));
                } else if (path.equals(QUESTION_5)) {
                    errors.add(createError("empCivilPenaltyInd", ruleError.getMessage()));
                } else if (path.equals(QUESTION_6)) {
                    errors.add(createError("empPreviousExclusionInd", ruleError.getMessage()));
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
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ProviderProfile profile = application.getDetails();

        profile.setCriminalConvictionInd(provider.getHasCriminalConviction());
        profile.setCivilPenaltyInd(provider.getHasCivilPenalty());
        profile.setPreviousExclusionInd(provider.getHasPreviousExclusion());
        profile.setEmployeeCriminalConvictionInd(provider.getEmployeeHasCriminalConviction());
        profile.setEmployeeCivilPenaltyInd(provider.getEmployeeHasCivilPenalty());
        profile.setEmployeePreviousExclusionInd(provider.getEmployeeHasPreviousExclusion());
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        ProviderProfile profile = application.getDetails();

        provider.setHasCriminalConviction(profile.getCriminalConvictionInd());
        provider.setHasCivilPenalty(profile.getCivilPenaltyInd());
        provider.setHasPreviousExclusion(profile.getPreviousExclusionInd());
        provider.setEmployeeHasCriminalConviction(profile.getEmployeeCriminalConvictionInd());
        provider.setEmployeeHasCivilPenalty(profile.getEmployeeCivilPenaltyInd());
        provider.setEmployeeHasPreviousExclusion(profile.getEmployeePreviousExclusionInd());
    }
}
