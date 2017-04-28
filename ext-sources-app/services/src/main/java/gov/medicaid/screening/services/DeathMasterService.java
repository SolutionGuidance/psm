/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.DeathMasterRecord;

/**
 * This service defines a method to get death master record by social security number.
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface DeathMasterService {
    /**
     * Get death master record by social security number.
     * Return null if none is found.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws ServiceException If an error occurs while performing the operation
     *
     * @param ssn the social security number
     * @return the death master record
     */
    public DeathMasterRecord getDeathMasterRecord(String ssn) throws ServiceException;
}

