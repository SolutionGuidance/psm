/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.NETStudyResponse;

/**
 * This service defines a method to get net study response by lisStudyID.
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface NETStudyService {
    /**
     * Get NETStudy web service response by LISStudyID.
     *
     * @param lisStudyID the list study id to get the response.
     * @throws ServiceException If an error occurs while performing the operation.
     * @return the net study response.
     */
    public NETStudyResponse getNETStudyResponse(int lisStudyID) throws ServiceException;
}
