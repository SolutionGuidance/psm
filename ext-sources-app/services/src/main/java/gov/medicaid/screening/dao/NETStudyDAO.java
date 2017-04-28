/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.NETStudyResponse;
import gov.medicaid.screening.services.PersistenceException;

/**
 * This DAO defines a method to get NETStudy web service response by LISStudyID.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface NETStudyDAO {
    /**
     * Get NETStudy web service response by LISStudyID.
     *
     * @param lisStudyID the list study id to get the response.
     * @throws PersistenceException If an error occurs while performing the operation.
     * @return the net study response.
     */
    NETStudyResponse getNETStudyResponse(int lisStudyID) throws PersistenceException;
}

