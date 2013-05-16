/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;

/**
 * A form binder is a delegate that processes fields specific to the form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface FormBinder {

    /**
     * Binds the request to the model.
     *
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     * @throws BinderException if the format of the fields could not be bound properly
     * @throws PortalServiceException for any errors encountered
     */
    List<BinderException> bindFromPage(EnrollmentType enrollment, HttpServletRequest request) throws PortalServiceException;

    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly true if the binding is for a read only view
     */
    void bindToPage(EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly);

    /**
     * Translates the validation results to form error messages where applicable.
     * @param enrollment the enrollment that was validated
     * @param validationResult the validation result
     *
     * @return the list of errors related to this form
     */
    List<FormError> translateErrors(EnrollmentType enrollment, ValidationResultType validationResult);

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param enrollment the front end model
     * @param ticket the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException;

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment);

    
    /**
     * Renders the PDF representation of the form.
     *
     * @param enrollment the enrollment to be rendered
     * @param document the PDF document to render on
     * @param model the view model
     * @throws DocumentException if the document could not be written 
     */
    void renderPDF(EnrollmentType enrollment, Document document, Map<String, Object> model) throws DocumentException;
}