/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.NETStudyResponse;
import gov.medicaid.screening.dao.NETStudyDAO;
import gov.medicaid.screening.dao.impl.ws.Service1;
import gov.medicaid.screening.dao.impl.ws.Service1Soap;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.topcoder.util.log.Log;

/**
 * This DAO defines a method to get NETStudy web service response by LISStudyID.
 * 
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(NETStudyDAO.class)
public class NETStudyDAOBean implements NETStudyDAO {
    /**
     * This is used for logging.
     */
    private final Log log = LogUtil.getLog(getClass().getName());

    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = NETStudyDAOBean.class.getName();

    /**
     * The NETSTudy web service URL.
     */
    @Resource(name = "mita/config/netStudyWebServiceUrl")
    private String netStudyWebServiceUrl;

    /**
     * The denial statuses in one string.
     */
    @Resource(name = "mita/config/denialStatusesConfig")
    private String denialStatusesConfig;

    /**
     * The denial result statuses.
     */
    private List<String> denialStatuses;

    /**
     * Empty constructor, it does nothing.
     */
    public NETStudyDAOBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             If there are required injection fields that are not properly injected.
     */
    @PostConstruct
    protected void init() {
        if (Util.isBlank(netStudyWebServiceUrl)) {
            throw new ConfigurationException("The netStudyWebServiceUrl must be not be empty.");
        }
        if (denialStatusesConfig == null) {
            throw new ConfigurationException("The denialStatusesConfig must be not be null.");
        }
        String[] sp = denialStatusesConfig.split(";");
        denialStatuses = Arrays.asList(sp);
        for (String status : denialStatuses) {
            if (Util.isBlank(status)) {
                throw new ConfigurationException("The status in denialStatuses must be not be empty.");
            }
        }
    }

    /**
     * Get NETStudy web service response by LISStudyID.
     * 
     * @param lisStudyID
     *            the list study id to get the response.
     * @throws PersistenceException
     *             If an error occurs while performing the operation.
     * @return the net study response.
     */
    public NETStudyResponse getNETStudyResponse(int lisStudyID) throws PersistenceException {
        String signature = CLASS_NAME + "#getNETStudyResponse(int lisStudyID)";
        LogUtil.traceEntry(log, signature, new String[] { "lisStudyID" }, new Object[] { lisStudyID });
        URL url;
        try {
            url = new URL(getNetStudyWebServiceUrl());
            Service1Soap soap = new Service1(url).getService1Soap();
            String result = soap.getNETStudyInfo(lisStudyID);
            NETStudyResponse response = new NETStudyResponse();
            response.setResponse(result);
            String status = Util.getStringInBetween(result, "<ResultStatus>", "</ResultStatus>");
            response.setDenied(getDenialStatuses().contains(status));
            return LogUtil.traceExit(log, signature, response);
        } catch (MalformedURLException e) {
            throw new PersistenceException("failed to call the webservice", e);
        }
    }

    private List<String> getDenialStatuses() {
        if (denialStatuses == null) {
            String[] sp = getDenialStatusesConfig().split(";");
            denialStatuses = Arrays.asList(sp);
            for (String status : denialStatuses) {
                if (Util.isBlank(status)) {
                    throw new ConfigurationException("The status in denialStatuses must be not be empty.");
                }
            }
        }
        return denialStatuses;
    }

    private String getNetStudyWebServiceUrl() {
        return netStudyWebServiceUrl != null ? netStudyWebServiceUrl
                : jndiGet("java:comp/env/mita/config/netStudyWebServiceUrl");
    }

    private String getDenialStatusesConfig() {
        return denialStatusesConfig != null ? denialStatusesConfig
                : jndiGet("java:comp/env/mita/config/denialStatusesConfig");
    }

    private String jndiGet(String name) {
        try {
            return (String) new InitialContext().lookup(name);
        } catch (NamingException e) {
            return null;
        }
    }
}
