/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.PECOSRecord;
import gov.medicaid.screening.services.PersistenceException;

import java.util.List;

/**
 * This DAO defines methods to manage PECOS records.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public interface PECOSDAO {
    /**
     * Get PECOS record by National Provider Identifier (NPI). Return null if none is found.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws PersistenceException If an error occurs while performing the operation
     * 
     * @param npi the national provider identifier
     * @return the PECOS record
     */
    PECOSRecord getPECOSRecord(String npi) throws PersistenceException;

    /**
     * Clear all PECOS records.
     * @throws PersistenceException - If an error occurs while performing the operation
     */
    void clearPECOSRecords()  throws PersistenceException;

    /**
     * Add PECOS records.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws PersistenceException If an error occurs while performing the operation
     * @param records the PECOS records
     */
    void addPECOSRecords(List<PECOSRecord> records) throws PersistenceException;
}

