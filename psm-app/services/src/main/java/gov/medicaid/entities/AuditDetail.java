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

/**
 * Audit record details.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AuditDetail extends IdentifiableEntity {

    /**
     * The header record id.
     */
    private long auditRecordId;

    /**
     * The table name.
     */
    private String tableName;

    /**
     * The column name.
     */
    private String columnName;

    /**
     * The old value.
     */
    private String oldValue;

    /**
     * The new value.
     */
    private String newValue;

    /**
     * Empty constructor.
     */
    public AuditDetail() {
    }

    /**
     * Gets the value of the field <code>tableName</code>.
     * @return the tableName
     */
    public String getTableName() {
        return tableName;
    }

    /**
     * Sets the value of the field <code>tableName</code>.
     * @param tableName the tableName to set
     */
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    /**
     * Gets the value of the field <code>columnName</code>.
     * @return the columnName
     */
    public String getColumnName() {
        return columnName;
    }

    /**
     * Sets the value of the field <code>columnName</code>.
     * @param columnName the columnName to set
     */
    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    /**
     * Gets the value of the field <code>oldValue</code>.
     * @return the oldValue
     */
    public String getOldValue() {
        return oldValue;
    }

    /**
     * Sets the value of the field <code>oldValue</code>.
     * @param oldValue the oldValue to set
     */
    public void setOldValue(String oldValue) {
        this.oldValue = oldValue;
    }

    /**
     * Gets the value of the field <code>newValue</code>.
     * @return the newValue
     */
    public String getNewValue() {
        return newValue;
    }

    /**
     * Sets the value of the field <code>newValue</code>.
     * @param newValue the newValue to set
     */
    public void setNewValue(String newValue) {
        this.newValue = newValue;
    }

    /**
     * Gets the value of the field <code>auditRecordId</code>.
     * @return the auditRecordId
     */
    public long getAuditRecordId() {
        return auditRecordId;
    }

    /**
     * Sets the value of the field <code>auditRecordId</code>.
     * @param auditRecordId the auditRecordId to set
     */
    public void setAuditRecordId(long auditRecordId) {
        this.auditRecordId = auditRecordId;
    }

}
