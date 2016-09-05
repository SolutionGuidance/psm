/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.PECOSRecord;
import gov.medicaid.screening.dao.PECOSDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PECOSService;
import gov.medicaid.screening.services.PECOSServiceLocal;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 * This service defines a method to get PECOS record by National Provider Identifier (NPI).
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@WebService
@Stateless
@Local(PECOSServiceLocal.class)
@Remote(PECOSService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PECOSServiceBean extends BaseService implements PECOSService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PECOSServiceBean.class.getName();
    
    /**
     * This is PECOS DAO.
     */
    @EJB
    private PECOSDAO pecosDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public PECOSServiceBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * @throws ConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (pecosDAO == null) {
            throw new ConfigurationException("The pecosDAO must be not be null.");
        }
    }

    /**
     * Get PECOS record by National Provider Identifier (NPI). Return null if none is found.
     * 
     * @throws IllegalArgumentException if the argument is null or empty string
     * @throws ServiceException If an error occurs while performing the operation
     * 
     * @param npi the national provider identifier
     * @return the PECOS record
     */
    @WebMethod
    public PECOSRecord getPECOSRecord(String npi) throws ServiceException {
        String signature = CLASS_NAME + "#getPECOSRecord(String npi)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"npi"}, new Object[]{npi});
        try {
            PECOSRecord record = pecosDAO.getPECOSRecord(npi);
            return LogUtil.traceExit(getLog(), signature, record);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } 
    }
}

