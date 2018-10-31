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
import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.ProviderTypeService;

import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;

import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Base class for the form binders.
 */
public abstract class BaseFormBinder implements FormBinder {

    /**
     * Empty list of errors.
     */
    static final List<FormError> NO_ERRORS = Collections.emptyList();

    /**
     * Hash key for hidden input security.
     */
    private String serverHashKey;

    /**
     * Lookup service.
     */
    private LookupService lookupService;

    /**
     * The system user.
     */
    private CMSUser systemUser;


    /**
     * Application service.
     */
    private ProviderApplicationService applicationService;

    /**
     * ProviderType service.
     */
    private ProviderTypeService providerTypeService;

    /**
     * The form namespace.
     */
    private final String formId;

    /**
     * Creates a new instance with the namespace provided.
     *
     * @param id the form namespace
     */
    public BaseFormBinder(String id) {
        formId = id;
    }

    /**
     * Retrieves the form namespace.
     *
     * @return the form id
     */
    public String id() {
        return formId;
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param application the application that was validated
     * @param validationResult the validation result
     *
     * @return the list of errors related to this form
     */
    public List<FormError> translateErrors(ApplicationType applicationType, ValidationResultType validationResult) {
        OperationStatusType status = validationResult.getStatus();
        if ("SUCCESS".equals(status.getStatusCode())) {
            return NO_ERRORS;
        }

        StatusMessagesType messages = status.getStatusMessages();
        if (messages == null) {
            return NO_ERRORS;
        }

        return selectErrors(applicationType, messages);
    }

    /**
     * Captures the error messages related to the form.
     * @param application the application that was validated
     * @param messages the messages to select from
     *
     * @return the list of errors related to the form
     */
    protected abstract List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages);

    /**
     * Retrieves the simple string parameter with the given name.
     *
     * @param request the current request
     * @param name the parameter name
     * @return the trimmed value or null if not found
     */
    protected String param(HttpServletRequest request, String name) {
        String val = request.getParameter(id() + name);
        if (val != null) {
            return val.trim();
        }
        return val;
    }

    /**
     * Retrieves an indexed parameter.
     * @param request the request
     * @param name the name of the parameter
     * @param idx the index to get
     * @return the indexed parameter value
     */
    protected String param(HttpServletRequest request, String name, int idx) {
        String val = request.getParameter(name(name, idx));
        if (val != null) {
            return val.trim();
        }
        return val;
    }

    /**
     * Retrieves the indexed name of the parameter.
     *
     * @param key the base name
     * @return the generated key
     */
    protected String name(String key) {
        return id() + key;
    }

    /**
     * Retrieves the indexed name of the parameter.
     * @param key the base name
     * @param idx the parameter index
     * @return the generated key
     */
    protected String name(String key, int idx) {
        return name(key) + "_" + idx;
    }

    /**
     * Sets the given values to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param value the value to be set
     */
    protected void attr(Map<String, Object> mv, String key, String value) {
        mv.put(name(key), HtmlUtils.htmlEscape(value));
    }

    /**
     * Sets the given values to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param value the value to be set
     */
    protected void attr(Map<String, Object> mv, String key, Integer value) {
        if (value != null) {
            mv.put(name(key), String.valueOf(value));
        } else {
            mv.put(name(key), "");
        }
    }

    /**
     * Sets the given indexed value to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param idx the index
     * @param value the value to be set
     */
    protected void attr(Map<String, Object> mv, String key, int idx, String value) {
        mv.put(name(key, idx), HtmlUtils.htmlEscape(value));
    }

    /**
     * Sets the given indexed date to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param idx the index
     * @param value the value to be set
     */
    protected void attr(Map<String, Object> mv, String key, int idx, Calendar value) {
        mv.put(name(key, idx), BinderUtils.formatCalendar(value));
    }

    /**
     * Sets the given values to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param value the date value to be set (converted to the default date format)
     */
    protected void attr(Map<String, Object> mv, String key, Calendar value) {
        attr(mv, key, BinderUtils.formatCalendar(value));
    }

    /**
     * Sets the given values to the model.
     *
     * @param mv the model and view to add to
     * @param key the attribute key (this will prepend the namespace)
     * @param values the values to be set
     */
    protected void attr(Map<String, Object> mv, String key, Collection<? extends LookupEntity> values) {
        mv.put(name(key), values);
    }


    /**
     * Adds an address to the model.
     *
     * @param mv the model and view to add to
     * @param address the address to add
     */
    protected void attr(Map<String, Object> mv, AddressType address) {
        attr(mv, "addressLine1", address.getAddressLine1());
        attr(mv, "addressLine2", address.getAddressLine2());
        attr(mv, "city", address.getCity());
        attr(mv, "state", address.getState());
        attr(mv, "zip", address.getZipCode());
        attr(mv, "county", address.getCounty());
    }

    protected void attr(
            Map<String, Object> mv,
            String prefix,
            AddressType address
    ) {
        attr(mv, prefix + "Attention", address.getAttentionTo());
        attr(mv, prefix + "AddressLine1", address.getAddressLine1());
        attr(mv, prefix + "AddressLine2", address.getAddressLine2());
        attr(mv, prefix + "City", address.getCity());
        attr(mv, prefix + "State", address.getState());
        attr(mv, prefix + "Zip", address.getZipCode());
        attr(mv, prefix + "County", address.getCounty());
    }

    protected void attr(Map<String, Object> mv, int i, AddressType address) {
        attr(mv, "addressLine1", i, address.getAddressLine1());
        attr(mv, "addressLine2", i, address.getAddressLine2());
        attr(mv, "city", i, address.getCity());
        attr(mv, "state", i, address.getState());
        attr(mv, "zip", i, address.getZipCode());
        attr(mv, "county", i, address.getCounty());
    }

    protected void attr(Map<String, Object> mv, String key, Boolean value) {
        mv.put(name(key), value);
    }

    /**
     * Instantiates the correct entity type based on the provider type.
     *
     * @param profile the profile to create the entity for
     * @param providerType the provider type
     * @return the provider type from the persistent model
     */
    protected ProviderType ensurePersonOrOrg(ProviderProfile profile, String providerType) {
        ProviderType type = lookupService.findLookupByDescription(ProviderType.class, providerType);
        if (type.getApplicantType() == ApplicantType.INDIVIDUAL) {
            if (profile.getEntity() == null || profile.getEntity() instanceof Organization) {
                profile.setEntity(new Person());
            }
        } else {
            if (profile.getEntity() == null || profile.getEntity() instanceof Person) {
                profile.setEntity(new Organization());
            }
        }
        return type;
    }

    /**
     * Sets the value of the field <code>lookupService</code>.
     *
     * @param lookupService the lookupService to set
     */
    public void setLookupService(LookupService lookupService) {
        this.lookupService = lookupService;
    }

    /**
     * Gets the value of the field <code>lookupService</code>.
     *
     * @return the lookupService
     */
    public LookupService getLookupService() {
        return lookupService;
    }

    /**
     * Self configures this bean.
     */
    public void init() {
        CMSConfigurator config = new CMSConfigurator();
        lookupService = config.getLookupService();
        applicationService = config.getApplicationService();
        providerTypeService = config.getProviderTypeService();
        serverHashKey = config.getServerHashKey();
        systemUser = config.getSystemUser();
    }

    /**
     * Gets the value of the field <code>applicationService</code>.
     *
     * @return the applicationService
     */
    public ProviderApplicationService getApplicationService() {
        return applicationService;
    }

    /**
     * Sets the value of the field <code>applicationService</code>.
     *
     * @param applicationService the applicationService to set
     */
    public void setApplicationService(ProviderApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    /**
     * Gets the value of the field <code>providerTypeService</code>.
     *
     * @return the providerTypeService
     */
    public ProviderTypeService getProviderTypeService() {
        return providerTypeService;
    }

    /**
     * Sets the value of the field <code>providerTypeService</code>.
     *
     * @param providerTypeService the providerTypeService to set
     */
    public void setProviderTypeService(ProviderTypeService providerTypeService) {
        this.providerTypeService = providerTypeService;
    }

    /**
     * Gets the value of the field <code>serverHashKey</code>.
     *
     * @return the serverHashKey
     */
    public String getServerHashKey() {
        return serverHashKey;
    }

    /**
     * Sets the value of the field <code>serverHashKey</code>.
     *
     * @param serverHashKey the serverHashKey to set
     */
    public void setServerHashKey(String serverHashKey) {
        this.serverHashKey = serverHashKey;
    }

    /**
     * Gets the value of the field <code>systemUser</code>.
     * @return the systemUser
     */
    public CMSUser getSystemUser() {
        return systemUser;
    }

    /**
     * Sets the value of the field <code>systemUser</code>.
     * @param systemUser the systemUser to set
     */
    public void setSystemUser(CMSUser systemUser) {
        this.systemUser = systemUser;
    }

    /**
     * Creates an error for the given field.
     *
     * @param field the field
     * @param message the error message
     * @return the form error
     */
    protected FormError createError(String field, String message) {
        FormError error = new FormError();
        error.setFieldId(id() + field);
        error.setMessage(message);
        return error;
    }

    /**
     * Creates an error for the given fields.
     *
     * @param fields the fields
     * @param message the error message
     * @return the form error
     */
    protected FormError createError(String[] fields, String message) {
        StringBuilder field = new StringBuilder();
        for (String fld : fields) {
            field.append(id() + fld + " ");
        }
        FormError error = new FormError();
        error.setFieldId(field.toString());
        error.setMessage(message);
        return error;
    }

    /**
     * Creates an error for the given fields.
     *
     * @param fields the fields
     * @param message the error message
     * @return the form error
     */
    protected FormError createError(String[] fields, int idx, String message) {
        StringBuilder field = new StringBuilder();
        for (String fld : fields) {
            field.append(name(fld, idx) + " ");
        }
        FormError error = new FormError();
        error.setFieldId(field.toString());
        error.setMessage(message);
        return error;
    }

    /**
     * Creates an error for the given field.
     *
     * @param field the field
     * @param idx the field index
     * @param message the error message
     * @return the form error
     */
    protected FormError createError(String field, int idx, String message) {
        FormError error = new FormError();
        error.setFieldId(name(field, idx));
        error.setMessage(message);
        return error;
    }

    /**
     * Maps the model index for the credentials to the license index.
     * @param credentials the credentials
     * @param licenses the licenses
     * @return a mapping from the actual index to the subset index
     */
    protected Map<Integer, Integer> mapIndexes(List<LicenseType> credentials, List<LicenseType> licenses) {
        HashMap<Integer, Integer> mapping = new HashMap<Integer, Integer>();
        int i = 0;
        for (LicenseType credential : credentials) {
            int j = 0;
            for (LicenseType license : licenses) {
                if (license == credential) {
                    mapping.put(i, j);
                    break;
                }
                j++;
            }
            if (mapping.size() == licenses.size()) {
                break;
            }
            i++;
        }
        return mapping;
    }

    /**
     * Empty implementation by default.
     *
     * @param application the application to be rendered
     * @param document the PDF document to render on
     * @param model the view model
     * @throws DocumentException
     */
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model) throws DocumentException {
    }

    /**
     * Reads the primary practice address from the request.
     *
     * @param request the request to read from
     * @return the bound address
     */
    protected AddressType readPrimaryAddress(HttpServletRequest request) {
        AddressType address = new AddressType();
        address.setAddressLine1(param(request, "addressLine1"));
        address.setAddressLine2(param(request, "addressLine2"));
        address.setCity(param(request, "city"));
        address.setState(param(request, "state"));
        address.setZipCode(param(request, "zip"));
        address.setCounty(param(request, "county"));
        return address;
    }

    AddressType readPrefixedAddress(
            HttpServletRequest request,
            String prefix
    ) {
        AddressType address = new AddressType();
        address.setAddressLine1(param(request, prefix + "AddressLine1"));
        address.setAddressLine2(param(request, prefix + "AddressLine2"));
        address.setAttentionTo(param(request, prefix + "Attention"));
        address.setCity(param(request, prefix + "City"));
        address.setState(param(request, prefix + "State"));
        address.setZipCode(param(request, prefix + "Zip"));
        address.setCounty(param(request, prefix + "County"));
        return address;
    }

    AddressType readIndexedAddress(
            HttpServletRequest request,
            int index
    ) {
        AddressType address = new AddressType();
        address.setAddressLine1(param(request, "addressLine1", index));
        address.setAddressLine2(param(request, "addressLine2", index));
        address.setCity(param(request, "city", index));
        address.setState(param(request, "state", index));
        address.setZipCode(param(request, "zip", index));
        address.setCounty(param(request, "county", index));
        return address;
    }
}
