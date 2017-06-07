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
