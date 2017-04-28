/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.PECOSRecord;
import gov.medicaid.screening.dao.PECOSDAO;
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
 * This DAO defines methods to manage PECOS records.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(PECOSDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PECOSDAOBean extends PersistenceBaseDAO implements PECOSDAO {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PECOSDAOBean.class.getName();

    /**
     * Empty constructor, it does nothing.
     */
    public PECOSDAOBean() {
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
     * Get PECOS record by National Provider Identifier (NPI). Return null if none is found.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null or empty string
     * @throws PersistenceException
     *             If an error occurs while performing the operation
     * 
     * @param npi
     *            the national provider identifier
     * @return the PECOS record
     */
    @SuppressWarnings("unchecked")
    public PECOSRecord getPECOSRecord(String npi) throws PersistenceException {
        String signature = CLASS_NAME + "#getPECOSRecord(String npi)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "npi" }, new Object[] { npi });
        if (npi == null || npi.trim().length() == 0) {
            throw new IllegalArgumentException("npi should not be null or empty");
        }
        try {
            Query query = getEntityManager().createQuery("SELECT p FROM PECOSRecord p WHERE p.npi = :npi");
            query.setParameter("npi", npi);
            PECOSRecord result = null;
            List<PECOSRecord> records = query.getResultList();
            if (records.size() > 0) {
                result = records.get(0);
            }
            return LogUtil.traceExit(getLog(), signature, result);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to get the pecos record", e);
        }
    }

    /**
     * Clear all PECOS records.
     * 
     * @throws PersistenceException
     *             - If an error occurs while performing the operation
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void clearPECOSRecords() throws PersistenceException {
        String signature = CLASS_NAME + "#clearPECOSRecords()";
        LogUtil.traceEntry(getLog(), signature, null, null);
        try {
            getEntityManager().createQuery("DELETE FROM PECOSRecord").executeUpdate();
            LogUtil.traceExit(getLog(), signature, null);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to delete pecos records", e);
        }
    }

    /**
     * Add PECOS records.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null or empty string
     * @throws PersistenceException
     *             If an error occurs while performing the operation
     * @param records
     *            the PECOS records
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void addPECOSRecords(List<PECOSRecord> records) throws PersistenceException {
        String signature = CLASS_NAME + "#addPECOSRecords(List<PECOSRecord> records)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "records" }, new Object[] { records });
        if (records == null) {
            throw new IllegalArgumentException("records should not be null");
        }
        for (PECOSRecord record : records) {
            if (record == null) {
                throw new IllegalArgumentException("records should not contain null elements");
            }
        }
        try {
            for (PECOSRecord record : records) {
                getEntityManager().persist(record);
            }
            LogUtil.traceExit(getLog(), signature, null);
        } catch (javax.persistence.PersistenceException e) {
            throw new PersistenceException("Failed to delete pecos records", e);
        }
    }
}
