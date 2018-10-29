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

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import javax.servlet.http.HttpServletRequest;

import java.util.List;
import java.util.Map;

/**
 * A form binder is a delegate that processes fields specific to the form.
 */
public interface FormBinder {

    /**
     * Binds the request to the model.
     * @param user TODO
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     * @throws PortalServiceException for any errors encountered
     */
    List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) throws PortalServiceException;

    /**
     * Binds the model to the request attributes.
     * @param user TODO
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly);

    /**
     * Translates the validation results to form error messages where applicable.
     * @param application the application that was validated
     * @param validationResult the validation result
     *
     * @return the list of errors related to this form
     */
    List<FormError> translateErrors(ApplicationType applicationType, ValidationResultType validationResult);

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param applicationType the front end model
     * @param application the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException;

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application the persistent model
     * @param applicationType the front end model
     */
    void bindFromHibernate(Application application, ApplicationType applicationType);

    /**
     * Renders the PDF representation of the form.
     *
     * @param application the application to be rendered
     * @param document the PDF document to render on
     * @param model the view model
     * @throws DocumentException if the document could not be written
     */
    void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model) throws DocumentException;
}
