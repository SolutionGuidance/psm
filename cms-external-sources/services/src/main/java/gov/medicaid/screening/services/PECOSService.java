/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.PECOSRecord;

/**
 * This service defines a method to get PECOS record by National Provider Identifier (NPI).
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface PECOSService {
    /**
     * Get PECOS record by National Provider Identifier (NPI). Return null if none is found.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws ServiceException If an error occurs while performing the operation
     * 
     * @param npi the national provider identifier
     * @return the PECOS record
     */
    public PECOSRecord getPECOSRecord(String npi) throws ServiceException;
}
