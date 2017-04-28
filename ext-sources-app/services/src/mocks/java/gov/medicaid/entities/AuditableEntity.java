/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * This serves as the base class for all audited entities.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class AuditableEntity extends IdentifiableEntity {

    /**
     * The create timestamp.
     */
    private Date createTime;

    /**
     * The create user.
     */
    private User createdBy;

    /**
     * The update timestamp.
     */
    private Date modifiedTime;

    /**
     * The update user.
     */
    private User modifiedBy;

    /**
     * Default empty constructor.
     */
    public AuditableEntity() {
    }

    /**
     * Gets the value of the field <code>createTime</code>.
     * @return the createTime
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * Sets the value of the field <code>createTime</code>.
     * @param createTime the createTime to set
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     * @return the createdBy
     */
    public User getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     * @param createdBy the createdBy to set
     */
    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>modifiedTime</code>.
     * @return the modifiedTime
     */
    public Date getModifiedTime() {
        return modifiedTime;
    }

    /**
     * Sets the value of the field <code>modifiedTime</code>.
     * @param modifiedTime the modifiedTime to set
     */
    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    /**
     * Gets the value of the field <code>modifiedBy</code>.
     * @return the modifiedBy
     */
    public User getModifiedBy() {
        return modifiedBy;
    }

    /**
     * Sets the value of the field <code>modifiedBy</code>.
     * @param modifiedBy the modifiedBy to set
     */
    public void setModifiedBy(User modifiedBy) {
        this.modifiedBy = modifiedBy;
    }
}