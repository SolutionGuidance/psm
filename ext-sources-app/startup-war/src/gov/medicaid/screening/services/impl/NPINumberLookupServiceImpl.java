/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NPIResult;
import gov.medicaid.screening.dao.NPINumberLookupDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.NPINumberLookupService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This defines the services for searching for NPI record.
 * 
 * @author flexme
 * @version 1.0
 */
@WebService
public class NPINumberLookupServiceImpl extends AbstractBaseService implements NPINumberLookupService {
    /**
     * NPI Number data access.
     */
    private NPINumberLookupDAO dataAccess;

    /**
     * Empty constructor.
     */
    public NPINumberLookupServiceImpl() {
    }

    /**
     * Search the NPI record using the NPI number.
     * 
     * @param npi
     *            the NPI number.
     * @return the NPI record result.
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public NPIResult getNPINumber(String npi) throws ParsingException, ServiceException {
        String signature = "NPINumberLookupServiceBean#getNPINumber";
        LogUtility.traceEntry(getLog(), signature, new String[] { "npi" }, new Object[] { npi });
        try {
            NPIResult result = dataAccess.getNPINumber(npi);
            return LogUtility.traceExit(getLog(), signature, result);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataAccess = (NPINumberLookupDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.NPINumberLookupDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}
