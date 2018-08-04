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

package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.Date;
import java.util.List;

/**
 * Represents an audit record header.
 */
@javax.persistence.Entity
@Table(name = "audit_records")
public class AuditRecord {
    @Id
    @GeneratedValue(
            strategy = GenerationType.AUTO
    )
    @Column(name = "audit_record_id")
    private long id;

    /**
     * Username.
     */
    private String username;

    /**
     * Date.
     */
    private Date date;

    /**
     * Audit action A-ADD, D-DELETE, U-UPDATE.
     */
    private String action;

    /**
     * The system that made the changes.
     */
    @Column(name = "system_id")
    private String systemId;

    /**
     * Change details.
     */
    @OneToMany(mappedBy = "auditRecordId")
    private List<AuditDetail> details;

    /**
     * Default empty constructor.
     */
    public AuditRecord() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    /**
     * Gets the value of the field <code>username</code>.
     *
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the value of the field <code>username</code>.
     *
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the value of the field <code>date</code>.
     *
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * Sets the value of the field <code>date</code>.
     *
     * @param date the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }

    /**
     * Gets the value of the field <code>systemId</code>.
     *
     * @return the systemId
     */
    public String getSystemId() {
        return systemId;
    }

    /**
     * Sets the value of the field <code>systemId</code>.
     *
     * @param systemId the systemId to set
     */
    public void setSystemId(String systemId) {
        this.systemId = systemId;
    }

    /**
     * Gets the value of the field <code>details</code>.
     *
     * @return the details
     */
    public List<AuditDetail> getDetails() {
        return details;
    }

    /**
     * Sets the value of the field <code>details</code>.
     *
     * @param details the details to set
     */
    public void setDetails(List<AuditDetail> details) {
        this.details = details;
    }

    /**
     * Gets the value of the field <code>action</code>.
     * @return the action
     */
    public String getAction() {
        return action;
    }

    /**
     * Sets the value of the field <code>action</code>.
     * @param action the action to set
     */
    public void setAction(String action) {
        this.action = action;
    }
}
