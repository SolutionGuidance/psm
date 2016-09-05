/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents an agreement document.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AgreementDocument extends IdentifiableEntity {

    /**
     * Document type.
     */
    private String type;

    /**
     * Document title.
     */
    private String title;

    /**
     * Revision number.
     */
    private int version;

    /**
     * Document data.
     */
    private String text;

    /**
     * Creator.
     */
    private String createdBy;

    /**
     * Timestamp.
     */
    private Date createdOn;

    /**
     * If the agreement can be deleted.
     */
    private boolean canDelete;

    /**
     * Empty constructor.
     */
    public AgreementDocument() {
    }

    /**
     * Gets the value of the field <code>title</code>.
     *
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the value of the field <code>title</code>.
     *
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the value of the field <code>version</code>.
     *
     * @return the version
     */
    public int getVersion() {
        return version;
    }

    /**
     * Sets the value of the field <code>version</code>.
     *
     * @param version the version to set
     */
    public void setVersion(int version) {
        this.version = version;
    }

    /**
     * Gets the value of the field <code>text</code>.
     *
     * @return the text
     */
    public String getText() {
        return text;
    }

    /**
     * Sets the value of the field <code>text</code>.
     *
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     *
     * @return the createdBy
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     *
     * @param createdBy the createdBy to set
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>createdOn</code>.
     *
     * @return the createdOn
     */
    public Date getCreatedOn() {
        return createdOn;
    }

    /**
     * Sets the value of the field <code>createdOn</code>.
     *
     * @param createdOn the createdOn to set
     */
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>canDelete</code>.
     * @return the canDelete
     */
    public boolean isCanDelete() {
        return canDelete;
    }

    /**
     * Sets the value of the field <code>canDelete</code>.
     * @param canDelete the canDelete to set
     */
    public void setCanDelete(boolean canDelete) {
        this.canDelete = canDelete;
    }
}
