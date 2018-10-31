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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@javax.persistence.Entity
@Table(name = "accepted_agreements")
public class AcceptedAgreements implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "accepted_agreement_id")
    private long id;

    @Column(name = "application_id")
    private long applicationId;

    @Column(name = "accepted_date")
    private Date acceptedDate;

    @ManyToOne
    @JoinColumn(name = "agreement_document_id")
    private AgreementDocument agreementDocument;

    public AcceptedAgreements() { }

    public AcceptedAgreements(AgreementDocument agreementDocument) {
        this.acceptedDate = new Date();
        this.agreementDocument = agreementDocument;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(long applicationId) {
        this.applicationId = applicationId;
    }

    public Date getAcceptedDate() {
        return acceptedDate;
    }

    public void setAcceptedDate(Date acceptedDate) {
        this.acceptedDate = acceptedDate;
    }

    public AgreementDocument getAgreementDocument() {
        return agreementDocument;
    }

    public void setAgreementDocument(AgreementDocument agreementDocument) {
        this.agreementDocument = agreementDocument;
    }
}
