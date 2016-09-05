/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.domain.model.EnrollmentProcess;

/**
 * This service copies the license files uploaded during enrollment for FileNet.
 * 
 * @author cyberjag
 * @version 1.0
 */
public interface FileNetService {

    /**
     * Export the files after enrollment process is completed.
     * 
     * @param model
     *            enrollment model
     * @param ticketId
     *            ticket id
     * @throws PortalServiceException
     *             if any error occurs
     */
    void exportFiles(EnrollmentProcess model, long ticketId) throws PortalServiceException;
}
