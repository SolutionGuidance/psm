/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents provider type settings.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderTypeSetting extends IdentifiableEntity {

    /**
     * The provider type code.
     */
    private String providerTypeCode;

    /**
     * The setting relationship type.
     */
    private String relationshipType;

    /**
     * The related entity type.
     */
    private String relatedEntityType;

    /**
     * The related entity code.
     */
    private String relatedEntityCode;

    /**
     * Empty constructor.
     */
    public ProviderTypeSetting() {

    }

    /**
     * Gets the value of the field <code>providerTypeCode</code>.
     *
     * @return the providerTypeCode
     */
    public String getProviderTypeCode() {
        return providerTypeCode;
    }

    /**
     * Sets the value of the field <code>providerTypeCode</code>.
     *
     * @param providerTypeCode the providerTypeCode to set
     */
    public void setProviderTypeCode(String providerTypeCode) {
        this.providerTypeCode = providerTypeCode;
    }

    /**
     * Gets the value of the field <code>relatedEntityType</code>.
     *
     * @return the relatedEntityType
     */
    public String getRelatedEntityType() {
        return relatedEntityType;
    }

    /**
     * Sets the value of the field <code>relatedEntityType</code>.
     *
     * @param relatedEntityType the relatedEntityType to set
     */
    public void setRelatedEntityType(String relatedEntityType) {
        this.relatedEntityType = relatedEntityType;
    }

    /**
     * Gets the value of the field <code>relatedEntityCode</code>.
     *
     * @return the relatedEntityCode
     */
    public String getRelatedEntityCode() {
        return relatedEntityCode;
    }

    /**
     * Sets the value of the field <code>relatedEntityCode</code>.
     *
     * @param relatedEntityCode the relatedEntityCode to set
     */
    public void setRelatedEntityCode(String relatedEntityCode) {
        this.relatedEntityCode = relatedEntityCode;
    }

    /**
     * Gets the value of the field <code>relationshipType</code>.
     * @return the relationshipType
     */
    public String getRelationshipType() {
        return relationshipType;
    }

    /**
     * Sets the value of the field <code>relationshipType</code>.
     * @param relationshipType the relationshipType to set
     */
    public void setRelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }
}
