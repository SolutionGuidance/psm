/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.services;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSetting;
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
     * @return all provider types
     */
    List<ProviderType> getAllProviderTypes();

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
     * @return the mapped value, or the internal code if not found
     */
    public String findLegacyMapping(String name, String codeType, String internalCodeValue);
    
    /**
     * Retrieves the mapped code for the given external lookup.
     * @param name the system name
     * @param codeType the code type name
     * @param externalCodeValue the external code value
     * @return the mapped value, or the external code if not found
     */
    public String findInternalMapping(String name, String codeType, String externalCodeValue);
    
    /**
     * Finds the provider type setting based on the given parameters.
     * 
     * @param providerTypeCode provider type code
     * @param relatedEntityType related entity type
     * @param relatedEntityCode related entity code
     * 
     * @return the list of settings
     */
	public List<ProviderTypeSetting> findProviderTypeSetting(String providerTypeCode, String relatedEntityType);

	/**
	 * Updates the ProviderTypeSettings for agreements.
	 * 
	 * @param providerTypeCode providerTypeCode
	 * @param agreementIds agreement ids
	 */
	public void updateProviderTypeAgreementSettings(String providerTypeCode, long[] agreementIds);
}