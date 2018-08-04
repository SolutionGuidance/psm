/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.impl;

import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.EntityStructureType;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.util.Util;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Collections;
import java.util.List;

/**
 * Defines the UI related services.
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
    public <T extends LookupEntity> T findLookupByDescription(Class<T> cls, String description) {
        if (Util.isBlank(description)) {
            return null;
        }
        List<T> rs = em.createQuery(
            "FROM " + cls.getName() + " WHERE description = :description",
            cls)
            .setParameter("description", description)
            .getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        if (rs.size() > 1) {
            throw new IllegalStateException("Lookup table contains non unique element.");
        }
        return rs.get(0);
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
    public <T extends LookupEntity> T findLookupByCode(Class<T> cls, String code) {
        if (Util.isBlank(code)) {
            return null;
        }
        List<T> rs = em
            .createQuery("FROM " + cls.getName() + " WHERE code = :code", cls)
            .setParameter("code", code)
            .getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        if (rs.size() > 1) {
            throw new IllegalStateException("Lookup table contains non unique element.");
        }
        return rs.get(0);
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
     * @param cls          the class to search for
     * @param providerType the provider type to filter on
     * @param relType      the relationship mapping
     * @param <T>          the return type
     * @return the related types
     */
    public <T extends LookupEntity> List<T> findRelatedLookup(
            Class<T> cls,
            String providerType,
            String relType
    ) {
        return em.createQuery("Select l FROM " + cls.getName() + " l, " +
                        "ProviderTypeSetting s " +
                        "WHERE s.providerTypeCode = :providerType" +
                        " AND l.code = s.relatedEntityCode" +
                        " AND s.relationshipType = :relationshipType" +
                        " AND s.relatedEntityType = :entityType " +
                        "order by l.description",
                cls)
                .setParameter("providerType", providerType)
                .setParameter("relationshipType", relType)
                .setParameter("entityType", cls.getSimpleName())
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
    public <T extends LookupEntity> List<T> findAllLookups(Class<T> cls) {
        String query = "FROM " + cls.getName() + " ORDER BY description";
        return em.createQuery(query, cls).getResultList();
    }

    /**
     * Retrieves all the owner types allowed for the given structure.
     *
     * @param entityType
     *            the corporate structure type
     * @return the matched lookups
     */
    public List<BeneficialOwnerType> findBeneficialOwnerTypes(String entityType) {
        EntityStructureType entity = findLookupByDescription(EntityStructureType.class, entityType);
        List<BeneficialOwnerType> results = Collections.emptyList();
        if (entity != null) {
            results = findRelatedLookup(BeneficialOwnerType.class, entity.getCode(),
                    ViewStatics.REL_BENEFICIAL_OWNER_TYPE);
        }

        if (results.isEmpty()) {
            results = findAllLookups(gov.medicaid.entities.BeneficialOwnerType.class);
        }
        return results;
    }
}
