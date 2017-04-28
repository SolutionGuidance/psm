/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.NPIResult;

/**
 * This defines the services for searching for NPI record.
 *
 * @author flexme
 * @version 1.0
 */
public interface NPINumberLookupService {
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
