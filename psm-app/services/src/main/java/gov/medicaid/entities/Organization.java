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

public class Organization extends Entity {

    /**
     * Employer number.
     */
    private String fein;

    /**
     * For agencies.
     */
    private String agencyId;

    /**
     * Indicates that the billing address is the same as the primary address.
     */
    private String billingSameAsPrimary;

    /**
     * Indicates that the reimbursement address is the same as the primary address.
     */
    private String reimbursementSameAsPrimary;

    /**
     * Indicates that the ten99 address is the same as the primary address.
     */
    private String ten99SameAsPrimary;

    /**
     * Practice secondary address.
     */
    private Address billingAddress;

    /**
     * Practice secondary address.
     */
    private Address reimbursementAddress;

    /**
     * Practice secondary address.
     */
    private Address ten99Address;

    /**
     * Practice minnesotaTaxId.
     */
    private String stateTaxId;

    /**
     * Practice fiscal year end.
     */
    private String fiscalYearEnd;

    private RemittanceSequenceOrder remittanceSequenceOrder;

    private String eftVendorNumber;

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

    public String getEftVendorNumber() {
        return eftVendorNumber;
    }

    public void setEftVendorNumber(String eftVendorNumber) {
        this.eftVendorNumber = eftVendorNumber;
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
}
