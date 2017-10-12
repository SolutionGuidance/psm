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

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the provider type selection form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
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

        return Collections.EMPTY_LIST;
    }

    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        attr(mv, "providerType", provider.getProviderType());

        if (readOnly) {
            return;
        }

        if (Util.isBlank(provider.getProviderType()) || enrollment.getRequestType() == null
            || enrollment.getRequestType() == RequestType.ENROLLMENT) {
            // can still change applicant type.
            mv.put("individualProviderTypes", sortCollection(getLookupService().getProviderTypes(ApplicantType.INDIVIDUAL)));
            mv.put("organizationProviderTypes", sortCollection(getLookupService().getProviderTypes(ApplicantType.ORGANIZATION)));
        } else {
            // already set as org or individual
            ProviderType pt = getLookupService()
                .findLookupByDescription(ProviderType.class, provider.getProviderType());
            if (pt.getApplicantType() == ApplicantType.INDIVIDUAL) {
                mv.put("individualProviderTypes", sortCollection(getLookupService().getProviderTypes(ApplicantType.INDIVIDUAL)));
            } else {
                mv.put("organizationProviderTypes", sortCollection(getLookupService().getProviderTypes(ApplicantType.ORGANIZATION)));
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
     * @param enrollment the enrollment that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
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
     * @param enrollment the front end model
     * @param ticket the persistent model
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) {
        if (enrollment.getProviderInformation() != null) {
            String providerType = enrollment.getProviderInformation().getProviderType();
            if (ticket.getDetails() == null) {
                ticket.setDetails(new ProviderProfile());
            }

            ProviderProfile profile = ticket.getDetails();
            ProviderType type = ensurePersonOrOrg(profile, providerType);
            profile.getEntity().setProviderType(type);
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
