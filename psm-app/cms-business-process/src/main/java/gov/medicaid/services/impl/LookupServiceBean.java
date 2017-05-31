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
package gov.medicaid.services.impl;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.rules.GlobalLookups;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.EntityStructureType;
import gov.medicaid.entities.LegacySystemMapping;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSetting;
import gov.medicaid.entities.ServiceAssuranceExtType;
import gov.medicaid.entities.ServiceAssuranceType;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.util.Util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 * Defines the UI related services.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(LookupService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class LookupServiceBean implements LookupService {

    /**
     * The entity manager.
     */
    @PersistenceContext(unitName = "cms")
    private EntityManager em;

    /**
     * Empty constructor.
     */
    public LookupServiceBean() {
    }

    public List<ProviderType> getAllProviderTypes() {
        return em.createQuery(
                "FROM ProviderType",
                ProviderType.class
        ).getResultList();
    }

    /**
     * Retrieves the provider types filtered by applicant type.
     * 
     * @param applicantType
     *            individual or organizations
     * @return the filtered provider types
     */
    public List<ProviderType> getProviderTypes(ApplicantType applicantType) {
        return em.createQuery(
                "FROM ProviderType WHERE applicantType = :type",
                ProviderType.class
        ).setParameter(
                "type",
                applicantType
        ).getResultList();
    }

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
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public <T extends LookupEntity> T findLookupByDescription(Class<T> cls, String description) {
        if (Util.isBlank(description)) {
            return null;
        }
        Query query = em.createQuery("FROM " + cls.getName() + " WHERE description = :description");
        query.setParameter("description", description);
        List rs = query.getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        if (rs.size() > 1) {
            throw new IllegalStateException("Lookup table contains non unique element.");
        }
        return (T) rs.get(0);
    }

    /**
     * Retrieves the lookup with the given code.
     * 
     * @param cls
     *            the class to lookup
     * @param description
     *            the filter
     * @param <T>
     *            the return type
     * @return the matched lookup
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public <T extends LookupEntity> T findLookupByCode(Class<T> cls, String code) {
        if (Util.isBlank(code)) {
            return null;
        }
        Query query = em.createQuery("FROM " + cls.getName() + " WHERE code = :code");
        query.setParameter("code", code);
        List rs = query.getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        if (rs.size() > 1) {
            throw new IllegalStateException("Lookup table contains non unique element.");
        }
        return (T) rs.get(0);
    }

    /**
     * Sets the value of the field <code>em</code>.
     * 
     * @param em
     *            the em to set
     */
    public void setEm(EntityManager em) {
        this.em = em;
    }

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
    @SuppressWarnings("unchecked")
    public <T extends LookupEntity> List<T> findRelatedLookup(Class<T> cls, String providerType, String relType) {
        Query query = em.createQuery("Select l FROM " + cls.getName() + " l, ProviderTypeSetting s WHERE "
                + "s.providerTypeCode = :providerType AND l.code = s.relatedEntityCode AND "
                + "s.relationshipType = :relationshipType  AND s.relatedEntityType = :entityType order by l.description");
        query.setParameter("providerType", providerType);
        query.setParameter("relationshipType", relType);
        query.setParameter("entityType", cls.getSimpleName());
        
        return query.getResultList();
    }

    /**
     * Finds all the required agreements for the given provider type.
     * 
     * @param providerType
     *            the provider type
     * @return the required documents
     */
    @SuppressWarnings("unchecked")
    public List<AgreementDocument> findRequiredDocuments(String providerType) {
        Query query = em.createQuery("Select d FROM AgreementDocument d, ProviderTypeSetting s WHERE "
                + "s.providerTypeCode = :providerType AND d.id = s.relatedEntityCode "
                + "AND s.relatedEntityType = 'AgreementDocument'");
        query.setParameter("providerType", providerType);
        return query.getResultList();
    }

    /**
     * Finds the provider type setting based on the given parameters.
     * 
     * @param providerTypeCode provider type code
     * @param relatedEntityType related entity type
     * @param relatedEntityCode related entity code
     * 
     * @return the list of settings
     */
    @SuppressWarnings("unchecked")
	public List<ProviderTypeSetting> findProviderTypeSetting(String providerTypeCode, String relatedEntityType) {
    	return em.createQuery("SELECT s from ProviderTypeSetting s WHERE s.providerTypeCode = :providerTypeCode " +
    			"AND s.relatedEntityType = :relatedEntityType")
    			.setParameter("providerTypeCode", providerTypeCode)
    			.setParameter("relatedEntityType", relatedEntityType)
    			.getResultList();
    }
    
    /**
     * Retrieves all the lookups of the given class.
     * 
     * @param cls
     *            the class to search for
     * @param <T>
     *            the return type
     * @return the matched lookups
     */
    @SuppressWarnings("unchecked")
    public <T extends LookupEntity> List<T> findAllLookups(Class<T> cls) {
        return em.createQuery("FROM " + cls.getName()).getResultList();
    }

    /**
     * Retrieves all the owner types allowed for the given structure.
     * 
     * @param entityType
     *            the corporate structure type
     * @return the matched lookups
     */
    @SuppressWarnings("unchecked")
    public List<BeneficialOwnerType> findBeneficialOwnerTypes(String entityType) {
        EntityStructureType entity = findLookupByDescription(EntityStructureType.class, entityType);
        List<BeneficialOwnerType> results = Collections.EMPTY_LIST;
        if (entity != null) {
            results = findRelatedLookup(BeneficialOwnerType.class, entity.getCode(),
                    ViewStatics.REL_BENEFICIAL_OWNER_TYPE);
        }

        if (results.isEmpty()) {
            results = findAllLookups(gov.medicaid.entities.BeneficialOwnerType.class);
        }
        return results;
    }

    /**
     * Retrieves all the service types based on indicator.
     * 
     * @param indicator
     *            in/out patient indicator
     * @return the matched lookups
     */
    @Override
    @SuppressWarnings("unchecked")
    public List<ServiceAssuranceType> findAssuredServiceTypes(String indicator) {
        return em.createQuery("from ServiceAssuranceType t where t.patientInd = :ind").setParameter("ind", indicator)
                .getResultList();
    }

    /**
     * Retrieves all the service types based on code.
     * 
     * @param code
     *            the parent service code
     * @return the matched lookups
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<ServiceAssuranceExtType> findAssuredServiceExtTypes(String code) {
        return em.createQuery("from ServiceAssuranceExtType t where t.serviceAssuranceCode = :code")
                .setParameter("code", code).getResultList();
    }


    /**
     * Retrieves the mapped code for the given internal lookup.
     * @param name the system name
     * @param codeType the code type name
     * @param internalCodeValue the internal code value
     * @return the mapped value, or null if not found
     */
    @SuppressWarnings("unchecked")
    public String findLegacyMapping(String name, String codeType, String internalCodeValue) {
        String query = "from LegacySystemMapping l where l.systemName = :systemName "
            + "AND l.codeType = :codeType AND l.internalCode = :internalCode";
        
        List<LegacySystemMapping> resultList = em.createQuery(query).setParameter("systemName", name)
            .setParameter("codeType", codeType).setParameter("internalCode", internalCodeValue).getResultList();
        if (resultList.isEmpty()) {
            return null;
        }
        return resultList.get(0).getExternalCode();
    }
    
    /**
     * Retrieves the mapped code for the given external lookup.
     * @param name the system name
     * @param codeType the code type name
     * @param externalCodeValue the external code value
     * @return the mapped value, or the external code if not found
     */
    @SuppressWarnings("unchecked")
    public String findInternalMapping(String name, String codeType, String externalCodeValue) {
       String query = "from LegacySystemMapping l where l.systemName = :systemName "
            + "AND l.codeType = :codeType AND l.externalCode = :externalCode";
        List<LegacySystemMapping> resultList = em.createQuery(query).setParameter("systemName", name)
            .setParameter("codeType", codeType).setParameter("externalCode", externalCodeValue).getResultList();
        if (resultList.isEmpty()) {
            return null;
        }
        return resultList.get(0).getInternalCode();
    }
    
    @Override
    public void updateProviderTypeAgreementSettings(String providerTypeCode,
    		long[] agreementIds) {
    	List<ProviderTypeSetting> selectedSettings = findProviderTypeSetting(providerTypeCode, "AgreementDocument");
        DecimalFormat format = new DecimalFormat("00");
        List<Long> persistedIds = new ArrayList<Long>();
        for (ProviderTypeSetting setting: selectedSettings) {
        	boolean keep = false;
        	for (long id: agreementIds) {
        		if (setting.getRelatedEntityCode().equals(format.format(id))) {
        			keep = true;
        			persistedIds.add(id);
        			break;
        		}
        	}
        	if (!keep) {
        		// delete the setting from DB
        		em.remove(setting);
        	}
        }
        
        for (long id: agreementIds) {
        	if (!persistedIds.contains(id)) {
        		// new addition
        		ProviderTypeSetting setting = new ProviderTypeSetting();
        		BigDecimal maxId = (BigDecimal) em.createNativeQuery("select max(provider_setting_id) from PROVIDER_SETTING").getSingleResult();
        		setting.setId(maxId.longValue() + 1);
        		setting.setProviderTypeCode(providerTypeCode);
        		setting.setRelatedEntityCode(format.format(id));
        		setting.setRelatedEntityType("AgreementDocument");
        		setting.setRelationshipType("RA");
        		
        		em.persist(setting);
        	}
        }
        
        GlobalLookups.refresh();
    }
}