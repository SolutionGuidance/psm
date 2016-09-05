/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NETStudyResponse;
import gov.medicaid.screening.dao.NETStudyDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.NETStudyService;
import gov.medicaid.screening.services.NETStudyServiceLocal;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This service defines a method to get NETStudy web service response by LISStudyID.
 * It is EJB based web service.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(NETStudyServiceLocal.class)
@Remote(NETStudyService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NETStudyServiceBean extends BaseService implements NETStudyService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = NETStudyServiceBean.class.getName();
    
    /**
     * This is NETStudy DAO.
     */
    @EJB
    private NETStudyDAO netStudyDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public NETStudyServiceBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * @throws ConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (netStudyDAO == null) {
            throw new ConfigurationException("The netStudyDAO must be not be null.");
        }
    }

    /**
     * Get NETStudy web service response by LISStudyID.
     *
     * @param lisStudyID the list study id to get the response.
     * @throws ServiceException If an error occurs while performing the operation.
     * @return the net study response.
     */
    public NETStudyResponse getNETStudyResponse(int lisStudyID) throws ServiceException {
        String signature = CLASS_NAME + "#getNETStudyResponse(int lisStudyID)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "lisStudyID" }, new Object[] { lisStudyID });
        try {
            NETStudyResponse result = netStudyDAO.getNETStudyResponse(lisStudyID);
            return LogUtil.traceExit(getLog(), signature, result);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }
}

