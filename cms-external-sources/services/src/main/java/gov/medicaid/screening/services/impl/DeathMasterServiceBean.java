/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DeathMasterRecord;
import gov.medicaid.screening.dao.DeathMasterDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.DeathMasterService;
import gov.medicaid.screening.services.DeathMasterServiceLocal;
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
 * This service defines a method to get death master record by social security number.
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@WebService
@Stateless
@Local(DeathMasterServiceLocal.class)
@Remote(DeathMasterService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class DeathMasterServiceBean extends BaseService implements DeathMasterService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = DeathMasterServiceBean.class.getName();
    
    /**
     * This is death master DAO.
     */
    @EJB
    private DeathMasterDAO deathMasterDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public DeathMasterServiceBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * @throws ConfigurationException - If there are required injection fields that are not injected.
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (deathMasterDAO == null) {
            throw new ConfigurationException("The deathMasterDAO must be not be null.");
        }
    }

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
    @WebMethod
    public DeathMasterRecord getDeathMasterRecord(String ssn) throws ServiceException {
        String signature = CLASS_NAME + "#getDeathMasterRecord(String ssn)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"ssn"}, new Object[]{ssn});
        try {
            DeathMasterRecord record = deathMasterDAO.getDeathMasterRecord(ssn);
            return LogUtil.traceExit(getLog(), signature, record);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }
}

