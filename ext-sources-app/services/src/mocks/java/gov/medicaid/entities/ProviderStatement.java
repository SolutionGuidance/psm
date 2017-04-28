/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Represents a provider statement.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class ProviderStatement extends AuditableEntity {

    /**
     * Statement name.
     */
    private String name;

    /**
     * Statement title.
     */
    private String title;

    /**
     * Statement date.
     */
    private Date date;

    /**
     * Statement signature.
     */
    @XmlElement
    private byte[] signature;

    /**
     * Default empty constructor.
     */
    public ProviderStatement() {
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
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
     * Gets the value of the field <code>signature</code>.
     *
     * @return the signature
     */
    @XmlTransient
    public byte[] getSignature() {
        return signature;
    }

    /**
     * Sets the value of the field <code>signature</code>.
     *
     * @param signature the signature to set
     */
    public void setSignature(byte[] signature) {
        this.signature = signature;
    }
}
