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

    /**
     * To string method.
     */
    @Override
    public String toString() {
        return "LegacySystemMapping [systemName=" + systemName + ", codeType=" + codeType + ", externalCode="
            + externalCode + ", internalCode=" + internalCode + "]";
    }
}
