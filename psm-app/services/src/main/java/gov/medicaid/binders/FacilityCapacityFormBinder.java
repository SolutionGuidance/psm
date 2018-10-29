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
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization disclosure.
 */
public class FacilityCapacityFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_27_";

    /**
     * Creates a new binder.
     */
    public FacilityCapacityFormBinder() {
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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        String beds = param(request, "numberOfBeds");
        if (StringUtils.isNumeric(beds)) {
            creds.setNumberOfBeds((int) BinderUtils.getAsLong(beds));
        }

        try {
            creds.setNumberOfBedsEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate")));
        } catch (BinderException e) {
            e.setAttribute(name("effectiveDate"), param(request, "effectiveDate"));
            exceptions.add(e);
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        if (creds.getNumberOfBeds() != null) {
            attr(mv, "numberOfBeds", creds.getNumberOfBeds());
        }
        attr(mv, "effectiveDate", creds.getNumberOfBedsEffectiveDate());
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

                if (path.equals("/ProviderInformation/FacilityCredentials/NumberOfBeds")) {
                    errors.add(createError("numberOfBeds", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/FacilityCredentials/NumberOfBedsEffectiveDate")) {
                    errors.add(createError("effectiveDate", ruleError.getMessage()));
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
        ProviderProfile profile = application.getDetails();
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        profile.setNumberOfBeds(creds.getNumberOfBeds());
        profile.setNumberOfBedsEffectiveDate(BinderUtils.toDate(creds.getNumberOfBedsEffectiveDate()));
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        creds.setNumberOfBeds(profile.getNumberOfBeds());
        creds.setNumberOfBedsEffectiveDate(BinderUtils.toCalendar(profile.getNumberOfBedsEffectiveDate()));
    }
}
