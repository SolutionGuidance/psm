/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.DayTrainingAndHabilitationCenterSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.DayTrainingAndHabilitationCenterDAO;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This class provides an EJB implementation of the DayTrainingAndHabilitationCenterDAO interface. It is a
 * stateless, local bean.
 * 
 * <p>
 * <strong>This is an stateless EJB and is thread safe.</strong>
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@Stateless
@Local(DayTrainingAndHabilitationCenterDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class DayTrainingAndHabilitationCenterDAOBean extends LicensedProviderCommonDAO implements
        DayTrainingAndHabilitationCenterDAO {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = DayTrainingAndHabilitationCenterDAOBean.class.getName();

    /**
     * Represent the license type id.
     */
    private static final String licenseTypeId = "24";

    /**
     * Default empty constructor.
     */
    public DayTrainingAndHabilitationCenterDAOBean() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search
     * result will be empty.
     * 
     * @param criteria
     *            the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException
     *             if the criteria is null, if criteria.pageNumber < 0; if criteria.pageSize < 1 unless
     *             criteria.pageNumber <= 0
     * @throws ParsingException
     *             if the parsing of the responses caused an error
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(DayTrainingAndHabilitationCenterSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = CLASS_NAME + "#search(DayTrainingAndHabilitationCenterSearchCriteria criteria)";
        return search(signature, criteria, licenseTypeId);
    }
}