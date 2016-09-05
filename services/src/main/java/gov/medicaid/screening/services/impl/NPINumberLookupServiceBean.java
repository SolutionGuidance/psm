/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NPIResult;
import gov.medicaid.screening.dao.NPINumberLookupDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.NPINumberLookupService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This defines the services for searching for NPI record.
 *
 * @author flexme
 * @version 1.0
 */
@Stateless
@Remote(NPINumberLookupService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NPINumberLookupServiceBean extends BaseService implements NPINumberLookupService {
    /**
     * NPI Number data access.
     */
    @EJB
    private NPINumberLookupDAO dataAccess;

    /**
     * Empty constructor.
     */
    public NPINumberLookupServiceBean() {
    }

    /**
     * Search the NPI record using the NPI number.
     *
     * @param npi the NPI number.
     * @return the NPI record result.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public NPIResult getNPINumber(String npi) throws ParsingException, ServiceException {
        String signature = "NPINumberLookupServiceBean#getNPINumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"npi"}, new Object[]{npi});
        try {
            NPIResult result = dataAccess.getNPINumber(npi);
            return LogUtil.traceExit(getLog(), signature, result);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }
}
