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

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the provider type selection form.
 */
public class ProviderTypeFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_01_";

    /**
     * The XML path that maps to provider type errors.
     */
    private static final String PROVIDER_TYPE_PATH = "/ProviderInformation/ProviderType";

    /**
     * Creates a new binder.
     */
    public ProviderTypeFormBinder() {
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
        provider.setProviderType(param(request, "providerType"));

        ProviderType pt = getLookupService()
            .findLookupByDescription(ProviderType.class, provider.getProviderType());
        if (pt != null) {
            if (pt.getApplicantType() == ApplicantType.INDIVIDUAL) {
                provider.setApplicantType(ApplicantType.INDIVIDUAL);
            } else {
                provider.setApplicantType(ApplicantType.ORGANIZATION);
            }
        }

        return Collections.emptyList();
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        attr(mv, "providerType", provider.getProviderType());

        if (readOnly) {
            return;
        }

        if (Util.isBlank(provider.getProviderType()) || applicationType.getRequestType() == null
            || applicationType.getRequestType() == RequestType.APPLICATION) {
            // can still change applicant type.
            mv.put("individualProviderTypes", sortCollection(getProviderTypeService().getProviderTypes(ApplicantType.INDIVIDUAL)));
            mv.put("organizationProviderTypes", sortCollection(getProviderTypeService().getProviderTypes(ApplicantType.ORGANIZATION)));
        } else {
            // already set as org or individual
            ProviderType pt = getLookupService()
                .findLookupByDescription(ProviderType.class, provider.getProviderType());
            if (pt.getApplicantType() == ApplicantType.INDIVIDUAL) {
                mv.put("individualProviderTypes", sortCollection(getProviderTypeService().getProviderTypes(ApplicantType.INDIVIDUAL)));
            } else {
                mv.put("organizationProviderTypes", sortCollection(getProviderTypeService().getProviderTypes(ApplicantType.ORGANIZATION)));
            }
        }
    }

    /**
     * Sorts the displayed provider types (PESP-252_
     * @param providerTypes the provider types to sort
     * @return the sorted types
     */
    private List<ProviderType> sortCollection(List<ProviderType> providerTypes) {
        List<ProviderType> sortedList = new ArrayList<ProviderType>(providerTypes);
        Collections.sort(sortedList, new Comparator<ProviderType>() {
            @Override
            public int compare(ProviderType o1, ProviderType o2) {
                return o1.getDescription().compareTo(o2.getDescription());
            }
        });
        return sortedList;
    }


    /**
     * Captures the error messages related to the form.
     * @param application the application that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages) {
        List<FormError> errors = null;
        List<StatusMessageType> messageList = messages.getStatusMessage();
        for (StatusMessageType statusMessageType : messageList) {
            if (PROVIDER_TYPE_PATH.equals(statusMessageType.getRelatedElementPath())) {
                FormError err = new FormError();
                err.setFieldId(id() + "providerType");
                err.setMessage(statusMessageType.getMessage());

                if (errors == null) {
                    errors = new ArrayList<FormError>();
                }
                errors.add(err);
            }
        }
        return errors == null ? NO_ERRORS : errors;
    }

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param applicationType the front end model
     * @param application the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        if (applicationType.getProviderInformation() != null) {
            String providerType = applicationType.getProviderInformation().getProviderType();
            if (application.getDetails() == null) {
                application.setDetails(new ProviderProfile());
            }

            ProviderProfile profile = application.getDetails();
            ProviderType type = ensurePersonOrOrg(profile, providerType);
            profile.getEntity().setProviderType(type);
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
            if (profile.getEntity() != null && profile.getEntity().getProviderType() != null) {
                ProviderType pt = profile.getEntity().getProviderType();
                pInfo.setProviderType(pt.getDescription());
                if (pt.getApplicantType() == ApplicantType.INDIVIDUAL) {
                    pInfo.setApplicantType(ApplicantType.INDIVIDUAL);
                } else {
                    pInfo.setApplicantType(ApplicantType.ORGANIZATION);
                }
            }
        }
    }
}
