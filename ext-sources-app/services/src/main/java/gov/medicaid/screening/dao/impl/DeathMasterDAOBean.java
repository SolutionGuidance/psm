/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.DeathMasterRecord;
import gov.medicaid.screening.dao.DeathMasterDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.Query;

/**
 * This DAO defines methods to manage death master records.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(DeathMasterDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class DeathMasterDAOBean extends PersistenceBaseDAO implements DeathMasterDAO {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = DeathMasterDAOBean.class.getName();

    /**
     * Empty constructor, it does nothing.
     */
    public DeathMasterDAOBean() {
    }
    
    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             If there are required injection fields that are not properly injected.
     */
    @PostConstruct
    protected void init() {
        super.init();
    }

    /**
     * Get death master record by social security number. Return null if none is found.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null or empty string
     * @throws PersistenceException
     *             If an error occurs while performing the operation
     * 
     * @param ssn
     *            the social security number
     * @return the death master record
     */
    @SuppressWarnings("unchecked")
    public DeathMasterRecord getDeathMasterRecord(String ssn) throws PersistenceException {
        String signature = CLASS_NAME + "#getDeathMasterRecord(String ssn)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "ssn" }, new Object[] { ssn });
        checkNullEmpty(ssn, "ssn");
        try {
            Query query = getEntityManager().createQuery(
                    "SELECT d FROM DeathMasterRecord d WHERE d.ssn = :ssn");
            query.setParameter("ssn", ssn);
            DeathMasterRecord result = null;
            List<DeathMasterRecord> records = query.getResultList();
            if (records.size() > 0) {
                result = records.get(0);
            }
            return LogUtil.traceExit(getLog(), signature, result);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to get the death master record", e);
        }
    }

    /**
     * Create (if not present by SSN) or update (if present by SSN) death master record.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null
     * @throws PersistenceException
     *             - If an error occurs while performing the operation
     * @param record
     *            the record to create or update
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveDeathMasterRecord(DeathMasterRecord record) throws PersistenceException {
        String signature = CLASS_NAME + "#saveDeathMasterRecord(DeathMasterRecord record)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "record" }, new Object[] { record });
        checkNull(record, "record");
        checkNull(record.getFirstName(), "record.firstName");
        checkNull(record.getLastName(), "record.lastName");
        checkNull(record.getMiddleName(), "record.middleName");
        checkNull(record.getNameSuffix(), "record.nameSuffix");
        try {
            DeathMasterRecord existingRecord = getDeathMasterRecord(record.getSsn());
            if (existingRecord != null) {
                existingRecord.setLastName(record.getLastName());
                existingRecord.setNameSuffix(record.getNameSuffix());
                existingRecord.setFirstName(record.getFirstName());
                existingRecord.setMiddleName(record.getMiddleName());
                existingRecord.setVpCode(record.getVpCode());
                existingRecord.setDateOfDeath(record.getDateOfDeath());
                existingRecord.setDateOfBirth(record.getDateOfBirth());
                getEntityManager().merge(existingRecord);
            } else {
                getEntityManager().persist(record);
            }
            LogUtil.traceExit(getLog(), signature, null);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to save the death master record", e);
        }

    }

    /**
     * Delete death master record by social security number. It does nothing if no record is deleted.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null
     * @throws PersistenceException
     *             - If an error occurs while performing the operation
     * @param ssn
     *            the social security number
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void deleteDeathMasterRecord(String ssn) throws PersistenceException {
        String signature = CLASS_NAME + "#deleteDeathMasterRecord(String ssn)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "ssn" }, new Object[] { ssn });
        checkNullEmpty(ssn, "ssn");
        try {
            Query query = getEntityManager().createQuery(
                    "DELETE FROM DeathMasterRecord d WHERE d.ssn = :ssn");
            query.setParameter("ssn", ssn);
            query.executeUpdate();
            LogUtil.traceExit(getLog(), signature, null);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to delete the death master record", e);
        }
    }

    /**
     * Check the value is not null.
     * 
     * @param value
     *            the value.
     * @param name
     *            the name.
     * @throws IllegalArgumentException
     *             if value is null.
     */
    private void checkNull(Object value, String name) {
        if (value == null) {
            throw new IllegalArgumentException(name + " should not be null");
        }
    }

    /**
     * Check the value is not null or empty.
     * 
     * @param value
     *            the value.
     * @param name
     *            the name.
     * @throws IllegalArgumentException
     *             if value is null or empty.
     */
    private void checkNullEmpty(String value, String name) {
        checkNull(value, name);
        if (value.trim().length() == 0) {
            throw new IllegalArgumentException(name + " should not be empty");
        }
    }
}
