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
import gov.medicaid.domain.model.PayToProviderType;
import gov.medicaid.domain.model.ProviderSetupInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.PayToProvider;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization information form.
 */
public class ProviderSetupFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_20_";

    /**
     * Creates a new instance.
     */
    public ProviderSetupFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @return
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderSetupInformationType setup = XMLUtility.nsGetProviderSetup(applicationType);
        setup.getPayToProvider().clear();

        int i = 0;
        while (param(request, "objectId", i) != null) {
            PayToProviderType payTo = new PayToProviderType();
            payTo.setObjectId(param(request, "objectId", i));
            payTo.setNPI(param(request, "npi", i));
            payTo.setName(param(request, "name", i));
            payTo.setContactName(param(request, "contactName", i));
            try {
                payTo.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "effectiveDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("effectiveDate", i), param(request, "effectiveDate", i));
                exceptions.add(e);
            }
            payTo.setPhoneNumber(BinderUtils.concatPhone(param(request, "phone1", i), param(request, "phone2", i),
                param(request, "phone3", i), param(request, "phone4", i)));

            payTo.setType(param(request, "type", i));
            setup.getPayToProvider().add(payTo);
            i++;
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
        attr(mv, "bound", "Y");
        ProviderSetupInformationType setup = XMLUtility.nsGetProviderSetup(applicationType);

        List<PayToProviderType> payTos = setup.getPayToProvider();
        int i = 0;
        for (PayToProviderType payTo : payTos) {
            attr(mv, "objectId", i, payTo.getObjectId());
            attr(mv, "npi", i, payTo.getNPI());
            attr(mv, "name", i, payTo.getName());
            attr(mv, "contactName", i, payTo.getContactName());
            attr(mv, "effectiveDate", i, payTo.getEffectiveDate());
            attr(mv, "type", i, payTo.getType());
            String[] phone = BinderUtils.splitPhone(payTo.getPhoneNumber());
            attr(mv, "phone1", i, phone[0]);
            attr(mv, "phone2", i, phone[1]);
            attr(mv, "phone3", i, phone[2]);
            attr(mv, "phone4", i, phone[3]);
            i++;
        }
        attr(mv, "payToSize", payTos.size());
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param application the application that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
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

                if (path.equals("/ProviderInformation/ProviderSetupInformation")) {
                    errors.add(createError("setupInformation", ruleError.getMessage()));
                } else if (path.startsWith("/ProviderInformation/ProviderSetupInformation/PayToProvider[")) {
                    FormError error = resolveFieldError(ruleError);
                    errors.add(error);
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
     * Resolves the specific license that is causing the error from the license list.
     * @param ruleError the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        String message = ruleError.getMessage();

        if (index != null) {
            if (path.endsWith("/Type")) {
                return createError("type", index, message);
            } else if (path.endsWith("/PhoneNumber")) {
                return createError(new String[]{"phone1", "phone2", "phone3", "phone4"}, index, message);
            } else if (path.endsWith("/Name")) {
                return createError("name", index, message);
            } else if (path.endsWith("/EffectiveDate")) {
                return createError("effectiveDate", index, message);
            } else if (path.endsWith("/ContactName")) {
                return createError("contactName", index, message);
            } else if (path.endsWith("/NPI")) {
                return createError("npi", index, message);
            }
        }

        // general location error
        return createError("group", message);
    }

    /**
     * Resolves the index of the field that caused the error.
     * @param path the field path
     * @return the index of the field, null if cannot be resolved
     */
    private Integer resolveIndex(String path) {
        String strIdx = Util.getStringInBetween(path, "[", "]");
        if (!Util.isBlank(strIdx)) {
            return Integer.parseInt(strIdx);
        }
        return null;
    }


    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param applicationType the front end model
     * @param application the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();

        ProviderSetupInformationType setup = XMLUtility.nsGetProviderSetup(applicationType);
        profile.setPayToProviders(new ArrayList<PayToProvider>());
        List<PayToProvider> providers = profile.getPayToProviders();

        for (PayToProviderType payTo : setup.getPayToProvider()) {
            PayToProvider p = new PayToProvider();
            p.setEffectiveDate(BinderUtils.toDate(payTo.getEffectiveDate()));
            p.setTargetProfileId(BinderUtils.getAsLong(payTo.getObjectId()));
            p.setType(getLookupService().findLookupByDescription(gov.medicaid.entities.PayToProviderType.class, payTo.getType()));
            p.setNpi(payTo.getNPI());
            p.setPhone(payTo.getPhoneNumber());
            p.setContactName(payTo.getContactName());
            p.setName(payTo.getName());
            providers.add(p);
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
            List<PayToProvider> payToProviders = profile.getPayToProviders();
            if (payToProviders != null) {
                ProviderSetupInformationType setup = XMLUtility.nsGetProviderSetup(applicationType);
                setup.getPayToProvider().clear();

                for (PayToProvider payToProvider : payToProviders) {
                    PayToProviderType payTo = new PayToProviderType();
                    payTo.setObjectId("" + payToProvider.getTargetProfileId());
                    payTo.setEffectiveDate(BinderUtils.toCalendar(payToProvider.getEffectiveDate()));
                    payTo.setPhoneNumber(payToProvider.getPhone());
                    payTo.setContactName(payToProvider.getContactName());
                    payTo.setName(payToProvider.getName());
                    payTo.setNPI(payToProvider.getNpi());

                    if (payToProvider.getType() != null) {
                        payTo.setType(payToProvider.getType().getDescription());
                    }

                    setup.getPayToProvider().add(payTo);
                }
            }
        }
    }
}
