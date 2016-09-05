/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * Represents a lookup entity.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class LegacySystemMapping extends IdentifiableEntity implements Serializable {

    /**
     * The external system name.
     */
    private String systemName;
    
    /**
     * The code type.
     */
    private String codeType;
    
    /**
     * The external code.
     */
    private String externalCode;
    
    /**
     * The internal code.
     */
    private String internalCode;
    
    /**
     * Empty constructor.
     */
    public LegacySystemMapping() {
    }

    /**
     * Gets the value of the field <code>systemName</code>.
     * @return the systemName
     */
    public String getSystemName() {
        return systemName;
    }

    /**
     * Sets the value of the field <code>systemName</code>.
     * @param systemName the systemName to set
     */
    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }

    /**
     * Gets the value of the field <code>codeType</code>.
     * @return the codeType
     */
    public String getCodeType() {
        return codeType;
    }

    /**
     * Sets the value of the field <code>codeType</code>.
     * @param codeType the codeType to set
     */
    public void setCodeType(String codeType) {
        this.codeType = codeType;
    }

    /**
     * Gets the value of the field <code>externalCode</code>.
     * @return the externalCode
     */
    public String getExternalCode() {
        return externalCode;
    }

    /**
     * Sets the value of the field <code>externalCode</code>.
     * @param externalCode the externalCode to set
     */
    public void setExternalCode(String externalCode) {
        this.externalCode = externalCode;
    }

    /**
     * Gets the value of the field <code>internalCode</code>.
     * @return the internalCode
     */
    public String getInternalCode() {
        return internalCode;
    }

    /**
     * Sets the value of the field <code>internalCode</code>.
     * @param internalCode the internalCode to set
     */
    public void setInternalCode(String internalCode) {
        this.internalCode = internalCode;
    }
}
