/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a provider statement.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderStatement extends IdentifiableEntity {

    /**
     * If enrolled, the profile identifier.
     */
    private long profileId;

    /**
     * References the ticket for this request.
     */
    private long ticketId;

    /**
     * Statement name.
     */
    private String name;

    /**
     * Statement title.
     */
    private String title;

    /**
     * Reference to an attachment with the signature.
     */
    private long signatureAttachmentId;

    /**
     * Statement date.
     */
    private Date date;

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
     * Gets the value of the field <code>profileId</code>.
     *
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     *
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     *
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     *
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * Gets the value of the field <code>signatureAttachmentId</code>.
     *
     * @return the signatureAttachmentId
     */
    public long getSignatureAttachmentId() {
        return signatureAttachmentId;
    }

    /**
     * Sets the value of the field <code>signatureAttachmentId</code>.
     *
     * @param signatureAttachmentId the signatureAttachmentId to set
     */
    public void setSignatureAttachmentId(long signatureAttachmentId) {
        this.signatureAttachmentId = signatureAttachmentId;
    }
}
