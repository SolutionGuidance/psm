/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ServiceAssuranceExtType;
import gov.medicaid.entities.ServiceAssuranceType;

import java.util.List;

/**
 * Defines the lookup related services.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface LookupService {

    /**
     * Retrieves the provider types filtered by applicant type.
     * 
     * @param applicantType
     *            individual or organizations
     * @return the filtered provider types
     */
    public List<ProviderType> getProviderTypes(ApplicantType applicantType);

    /**
     * Retrieves the lookup with the given description.
     * 
     * @param cls
     *            the class to lookup
     * @param description
     *            the filter
     * @param <T>
     *            the return type
     * @return the matched lookup
     */
    <T extends LookupEntity> T findLookupByDescription(Class<T> cls, String description);

    /**
     * Retrieves the lookup with the given description.
     * 
     * @param cls
     *            the class to lookup
     * @param description
     *            the filter
     * @param <T>
     *            the return type
     * @return the matched lookup
     */
    <T extends LookupEntity> T findLookupByCode(Class<T> cls, String code);

    /**
     * Find the related lookups to the given provider.
     * 
     * @param cls
     *            the class to search for
     * @param providerType
     *            the provider type to filter on
     * @param relType
     *            the relationship mapping
     * @param <T>
     *            the return type
     * @return the related types
     */
    <T extends LookupEntity> List<T> findRelatedLookup(Class<T> cls, String providerType, String relType);

    /**
     * Finds all the required agreements for the given provider type.
     * 
     * @param providerType
     *            the provider type
     * @return the required documents
     */
    List<AgreementDocument> findRequiredDocuments(String providerType);

    /**
     * Retrieves all the lookups of the given class.
     * 
     * @param cls
     *            the class to search for
     * @param <T>
     *            the return type
     * @return the matched lookups
     */
    public <T extends LookupEntity> List<T> findAllLookups(Class<T> cls);

    /**
     * Retrieves all the owner types allowed for the given structure.
     * 
     * @param entityType
     *            the corporate structure types
     * @return the matched lookups
     */
    public List<BeneficialOwnerType> findBeneficialOwnerTypes(String entityType);

    /**
     * Retrieves all the service types based on indicator.
     * 
     * @param indicator
     *            in/out patient indicator
     * @return the matched lookups
     */
    public List<ServiceAssuranceType> findAssuredServiceTypes(String indicator);

    /**
     * Retrieves all the service types based on code.
     * 
     * @param code
     *            the parent service code
     * @return the matched lookups
     */
    public List<ServiceAssuranceExtType> findAssuredServiceExtTypes(String code);

    /**
     * Retrieves the mapped code for the given internal lookup.
     * @param name the system name
     * @param codeType the code type name
     * @param internalCodeValue the internal code value
     * @return the mapped value, or null if not found
     */
    public String findLegacyMapping(String name, String codeType, String internalCodeValue);
}