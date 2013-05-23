/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.UserRequest;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * This represents the service API to export enrollment data for the given user
 * 
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface ExportService {

    /**
     * Exports the search results into PDF.
     * 
     * @param requests
     *            the list to be exported
     * @param status
     *            the status filter
     * @param outputStream
     *            the stream to export to
     * @throws PortalServiceException
     *             for any errors encountered
     */
    void export(List<UserRequest> requests, String status, OutputStream outputStream) throws PortalServiceException;

    /**
     * Exports the profile into PDF.
     * 
     * @param currentUser
     *            the current user
     * @param enrollment
     *            the enrollment model
     * @param model
     *            the view model
     * @param outputStream
     *            the stream to export to
     * @throws IOException
     *             for read/write errors
     * @throws PortalServiceException
     *             for any other errors encountered
     */
    void export(CMSUser currentUser, EnrollmentType enrollment, Map<String, Object> model, OutputStream outputStream)
            throws PortalServiceException, IOException;

    /**
     * Exports the pdf file for FileNet.
     * 
     * @param currentUser
     *            the current user
     * @param enrollment
     *            the enrollment model
     * @param model
     *            the view model
     * @param outputStream
     *            the stream to export to
     * @throws PortalServiceException
     *             for any other errors encountered
     */
    void exportPDFFileNet(CMSUser currentUser, EnrollmentType enrollment, String fileName, Map<String, Object> model)
            throws PortalServiceException, IOException;
}
