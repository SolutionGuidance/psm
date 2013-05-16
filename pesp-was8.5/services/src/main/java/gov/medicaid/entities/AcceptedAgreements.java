/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents user accepted agreements.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AcceptedAgreements extends IdentifiableEntity {

    /**
     * Owning profile id.
     */
    private long profileId;

    /**
     * Owning ticket id.
     */
    private long ticketId;

    /**
     * Date accepted.
     */
    private Date acceptedDate;

    /**
     * Related document.
     */
    private AgreementDocument agreementDocument;

    /**
     * Empty constructor.
     */
    public AcceptedAgreements() {
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
     * Gets the value of the field <code>acceptedDate</code>.
     *
     * @return the acceptedDate
     */
    public Date getAcceptedDate() {
        return acceptedDate;
    }

    /**
     * Sets the value of the field <code>acceptedDate</code>.
     *
     * @param acceptedDate the acceptedDate to set
     */
    public void setAcceptedDate(Date acceptedDate) {
        this.acceptedDate = acceptedDate;
    }

    /**
     * Gets the value of the field <code>agreementDocument</code>.
     *
     * @return the agreementDocument
     */
    public AgreementDocument getAgreementDocument() {
        return agreementDocument;
    }

    /**
     * Sets the value of the field <code>agreementDocument</code>.
     *
     * @param agreementDocument the agreementDocument to set
     */
    public void setAgreementDocument(AgreementDocument agreementDocument) {
        this.agreementDocument = agreementDocument;
    }
}
