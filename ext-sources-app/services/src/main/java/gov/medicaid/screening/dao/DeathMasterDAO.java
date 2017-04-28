/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.DeathMasterRecord;
import gov.medicaid.screening.services.PersistenceException;

/**
 * This DAO defines methods to manage death master records.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface DeathMasterDAO {
    /**
     * Get death master record by social security number.
     * Return null if none is found.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws PersistenceException If an error occurs while performing the operation
     *
     * @param ssn the social security number
     * @return the death master record
     */
    DeathMasterRecord getDeathMasterRecord(String ssn) throws PersistenceException;

    /**
     * Create (if not present by SSN) or update (if present by SSN) death master record.
     *
     * @throws IllegalArgumentException if the argument is null
     * @throws PersistenceException - If an error occurs while performing the operation
     * @param record the record to create or update
     */
    void saveDeathMasterRecord(DeathMasterRecord record) throws PersistenceException;

    /**
     * Delete death master record by social security number.
     * It does nothing if no record is deleted.
     * 
     * @throws IllegalArgumentException if the argument is null
     * @throws PersistenceException - If an error occurs while performing the operation
     * @param ssn the social security number
     */
    void deleteDeathMasterRecord(String ssn) throws PersistenceException;
}

