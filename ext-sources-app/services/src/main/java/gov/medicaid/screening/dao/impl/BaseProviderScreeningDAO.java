/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.ProviderType;
import gov.medicaid.screening.services.ConfigurationException;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

/**
 * A base DAO class that other DAO classes in the module "Organizational Provider Screening External Datasources".
 * 
 * <p>
 * <strong>This is an stateless EJB and is thread safe.</strong>
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 1
 */
public abstract class BaseProviderScreeningDAO extends BaseDAO {
    /**
     * It will be used to populate the provider type for the specific profider profile being returned.
     */
    private ProviderType providerType;

    /**
     * The id of the provider type. should be injected.
     */
    @Resource(name = "mita/config/providerTypeId")
    private Long providerTypeId;

    /**
     * Empty constructor
     */
    protected BaseProviderScreeningDAO() {
    }

    /**
     * Checks if the container properly initialized the injected fields.
     * 
     * @throws ConfigurationException
     *             if any injected field is null
     */
    @PostConstruct
    protected void init() {
        if (providerTypeId == null) {
            throw new ConfigurationException("The providerTypeId must be configured.");
        }
        providerType = new ProviderType();
        providerType.setId(providerTypeId);
    }

    /**
     * Get the provider type.
     * 
     * @return the provider type.
     */
    public ProviderType getProviderType() {
        if (providerType == null) {
            providerType = new ProviderType();
            providerType.setId(getProviderTypeId());
        }
        return providerType;
    }

    public Long getProviderTypeId() {
        return providerTypeId != null ? providerTypeId : new Long(jndiGet("java:comp/env/mita/config/providerTypeId"));
    }
}
