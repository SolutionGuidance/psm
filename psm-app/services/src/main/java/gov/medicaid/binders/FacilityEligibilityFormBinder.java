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
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the facility eligibility.
 */
public class FacilityEligibilityFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_38_";

    /**
     * Creates a new binder.
     */
    public FacilityEligibilityFormBinder() {
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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        creds.setPhysicalAndOccupationTherapyServices(param(request, "therapyIndicator"));

        creds.setTitle18NumberOfBeds((int) BinderUtils.getAsLong(param(request, "title18BedCount")));
        creds.setTitle19NumberOfBeds((int) BinderUtils.getAsLong(param(request, "title19BedCount")));
        creds.setDualCertifiedNumberOfBeds((int) BinderUtils.getAsLong(param(request, "dualCertBedCount")));
        creds.setICFNumberOfBeds((int) BinderUtils.getAsLong(param(request, "icfBedCount")));

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
        FacilityCredentialsType creds = XMLUtility.nsGetFacilityCredentials(applicationType);
        attr(mv, "therapyIndicator", creds.getPhysicalAndOccupationTherapyServices());
        attr(mv, "title18BedCount", creds.getTitle18NumberOfBeds());
        attr(mv, "title19BedCount", creds.getTitle19NumberOfBeds());
        attr(mv, "dualCertBedCount", creds.getDualCertifiedNumberOfBeds());
        attr(mv, "icfBedCount", creds.getICFNumberOfBeds());
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
     * @throws PortalServiceException
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        if (profile == null || !(profile.getEntity() instanceof Organization)) {
            throw new PortalServiceException("Provider type should be bound first.");
        }

        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
        profile.setPhysicalAndOccupationalTherapyInd(credentials.getPhysicalAndOccupationTherapyServices());
        profile.setTitle18NumberOfBeds(credentials.getTitle18NumberOfBeds());
        profile.setTitle19NumberOfBeds(credentials.getTitle19NumberOfBeds());
        profile.setDualCertifiedNumberOfBeds(credentials.getDualCertifiedNumberOfBeds());
        profile.setIcfNumberOfBeds(credentials.getICFNumberOfBeds());
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(applicationType);
        credentials.setPhysicalAndOccupationTherapyServices(profile.getPhysicalAndOccupationalTherapyInd());
        credentials.setTitle18NumberOfBeds(profile.getTitle18NumberOfBeds());
        credentials.setTitle19NumberOfBeds(profile.getTitle19NumberOfBeds());
        credentials.setDualCertifiedNumberOfBeds(profile.getDualCertifiedNumberOfBeds());
        credentials.setICFNumberOfBeds(profile.getIcfNumberOfBeds());
    }
}
