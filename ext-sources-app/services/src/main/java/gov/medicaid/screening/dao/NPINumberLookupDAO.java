/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.NPIResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the logic for searching for NPI record.
 *
 * @author flexme
 * @version 1.0
 */
public interface NPINumberLookupDAO {
    /**
     * Search the NPI record using the NPI number.
     *
     * @param npi the NPI number.
     * @return the NPI record result.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    public NPIResult getNPINumber(String npi) throws ParsingException, ServiceException;
}
