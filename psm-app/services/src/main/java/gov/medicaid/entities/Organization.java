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
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@javax.persistence.Entity
@Table(name = "organizations")
public class Organization extends Entity {

    /**
     * The Federal Employer Identification Number (FEIN) is a unique nine-digit
     * number written in the form 00-0000000.
     *
     * @see <a href="https://en.wikipedia.org/wiki/Employer_Identification_Number">
     * Wikipedia: Employer Identification Number</a>
     */
    private String fein;

    /**
     * For agencies.
     */
    @Column(name = "agency_id")
    private String agencyId;

    /**
     * Indicates that the billing address is the same as the primary address.
     */
    @Column(name = "billing_same_as_primary")
    private String billingSameAsPrimary;

    /**
     * Indicates that the reimbursement address is the same as the primary address.
     */
    @Column(name = "reimbursement_same_as_primary")
    private String reimbursementSameAsPrimary;

    /**
     * Indicates that the ten99 address is the same as the primary address.
     */
    @Column(name = "ten99_same_as_primary")
    private String ten99SameAsPrimary;

    /**
     * Practice secondary address.
     */
    @ManyToOne
    @JoinColumn(name = "billing_address_id")
    private Address billingAddress;

    /**
     * Practice secondary address.
     */
    @ManyToOne
    @JoinColumn(name = "reimbursement_address_id")
    private Address reimbursementAddress;

    /**
     * Practice secondary address.
     */
    @ManyToOne
    @JoinColumn(name = "ten99_address_id")
    private Address ten99Address;

    /**
     * Practice minnesotaTaxId.
     */
    @Column(name = "state_tax_id")
    private String stateTaxId;

    @Column(name = "state_medicaid_id")
    private String stateMedicaidId;

    /**
     * Practice fiscal year end.
     */
    @Column(name = "fiscal_year_end")
    private String fiscalYearEnd;

    @Enumerated(EnumType.STRING)
    @Column(name = "remittance_sequence_order")
    private RemittanceSequenceOrder remittanceSequenceOrder;

    @Column(name = "eft_accepted")
    private Boolean eftAccepted;

    /**
     * Empty constructor.
     */
    public Organization() {
    }

    public String getFein() {
        return fein;
    }

    public void setFein(String fein) {
        this.fein = fein;
    }

    public Address getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(Address billingAddress) {
        this.billingAddress = billingAddress;
    }

    public Address getReimbursementAddress() {
        return reimbursementAddress;
    }

    public void setReimbursementAddress(Address reimbursementAddress) {
        this.reimbursementAddress = reimbursementAddress;
    }

    public Address getTen99Address() {
        return ten99Address;
    }

    public void setTen99Address(Address ten99Address) {
        this.ten99Address = ten99Address;
    }

    public String getStateTaxId() {
        return stateTaxId;
    }

    public void setStateTaxId(String stateTaxId) {
        this.stateTaxId = stateTaxId;
    }

    public String getStateMedicaidId() {
        return stateMedicaidId;
    }

    public void setStateMedicaidId(String stateMedicaidId) {
        this.stateMedicaidId = stateMedicaidId;
    }

    public String getFiscalYearEnd() {
        return fiscalYearEnd;
    }

    public void setFiscalYearEnd(String fiscalYearEnd) {
        this.fiscalYearEnd = fiscalYearEnd;
    }

    public RemittanceSequenceOrder getRemittanceSequenceOrder() {
        return remittanceSequenceOrder;
    }

    public void setRemittanceSequenceOrder(RemittanceSequenceOrder remittanceSequenceOrder) {
        this.remittanceSequenceOrder = remittanceSequenceOrder;
    }

    public String getBillingSameAsPrimary() {
        return billingSameAsPrimary;
    }

    public void setBillingSameAsPrimary(String billingSameAsPrimary) {
        this.billingSameAsPrimary = billingSameAsPrimary;
    }

    public String getReimbursementSameAsPrimary() {
        return reimbursementSameAsPrimary;
    }

    public void setReimbursementSameAsPrimary(String reimbursementSameAsPrimary) {
        this.reimbursementSameAsPrimary = reimbursementSameAsPrimary;
    }

    public String getTen99SameAsPrimary() {
        return ten99SameAsPrimary;
    }

    public void setTen99SameAsPrimary(String ten99SameAsPrimary) {
        this.ten99SameAsPrimary = ten99SameAsPrimary;
    }

    public String getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }

    public Boolean isEftAccepted() {
        return eftAccepted;
    }

    public void setEftAccepted(Boolean eftAccepted) {
        this.eftAccepted = eftAccepted;
    }
}
