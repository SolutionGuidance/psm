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

import java.util.List;

/**
 * Represents a provider type.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ProviderType extends LookupEntity {

    /**
     * Individual or organization.
     */
    private int applicantType;

    /**
     * The flag to indicate whether this entity can be deleted.
     */
    private boolean canDelete;

    /**
     * Private office flag.
     */
    private boolean hasPrivateOffice;

    /**
     * Employed or contracted flag.
     */
    private boolean employedAndOrContracted;

    /**
     * Additional practice flag.
     */
    private boolean hasAdditionalPractice;

    /**
     * Payment required.
     */
    private boolean paymentRequired;

    /**
     * Required fields.
     */
    private List<RequiredField> requiredFields;

    /**
     * The agreement.
     */
    private AgreementDocument agreement;

    /**
     * The addendum.
     */
    private AgreementDocument addendum;


    /**
     * Agreement flag.
     */
    private boolean hasAgreement;


    /**
     * Addendum flag.
     */
    private boolean hasAddendum;

    /**
     * Default empty constructor.
     */
    public ProviderType() {
    }

    /**
     * Gets the value of the field <code>hasPrivateOffice</code>.
     *
     * @return the hasPrivateOffice
     */
    public boolean isHasPrivateOffice() {
        return hasPrivateOffice;
    }

    /**
     * Sets the value of the field <code>hasPrivateOffice</code>.
     *
     * @param hasPrivateOffice the hasPrivateOffice to set
     */
    public void setHasPrivateOffice(boolean hasPrivateOffice) {
        this.hasPrivateOffice = hasPrivateOffice;
    }

    /**
     * Gets the value of the field <code>employedAndOrContracted</code>.
     *
     * @return the employedAndOrContracted
     */
    public boolean isEmployedAndOrContracted() {
        return employedAndOrContracted;
    }

    /**
     * Sets the value of the field <code>employedAndOrContracted</code>.
     *
     * @param employedAndOrContracted the employedAndOrContracted to set
     */
    public void setEmployedAndOrContracted(boolean employedAndOrContracted) {
        this.employedAndOrContracted = employedAndOrContracted;
    }

    /**
     * Gets the value of the field <code>hasAdditionalPractice</code>.
     *
     * @return the hasAdditionalPractice
     */
    public boolean isHasAdditionalPractice() {
        return hasAdditionalPractice;
    }

    /**
     * Sets the value of the field <code>hasAdditionalPractice</code>.
     *
     * @param hasAdditionalPractice the hasAdditionalPractice to set
     */
    public void setHasAdditionalPractice(boolean hasAdditionalPractice) {
        this.hasAdditionalPractice = hasAdditionalPractice;
    }

    /**
     * Gets the value of the field <code>paymentRequired</code>.
     *
     * @return the paymentRequired
     */
    public boolean isPaymentRequired() {
        return paymentRequired;
    }

    /**
     * Sets the value of the field <code>paymentRequired</code>.
     *
     * @param paymentRequired the paymentRequired to set
     */
    public void setPaymentRequired(boolean paymentRequired) {
        this.paymentRequired = paymentRequired;
    }

    /**
     * Gets the value of the field <code>requiredFields</code>.
     *
     * @return the requiredFields
     */
    public List<RequiredField> getRequiredFields() {
        return requiredFields;
    }

    /**
     * Sets the value of the field <code>requiredFields</code>.
     *
     * @param requiredFields the requiredFields to set
     */
    public void setRequiredFields(List<RequiredField> requiredFields) {
        this.requiredFields = requiredFields;
    }


    /**
       The getter for the agreement instance variable.
     * @return the agreement
     */
    public AgreementDocument getAgreement() {
        return agreement;
    }


    /**
     * The setter for the agreement instance variable.
     * @param agreement the agreement to set
     */
    public void setAgreement(AgreementDocument agreement) {
        this.agreement = agreement;
    }


    /**
       The getter for the addendum instance variable.
     * @return the addendum
     */
    public AgreementDocument getAddendum() {
        return addendum;
    }


    /**
     * The setter for the addendum instance variable.
     * @param addendum the addendum to set
     */
    public void setAddendum(AgreementDocument addendum) {
        this.addendum = addendum;
    }


    /**
       The getter for the hasAgreement instance variable.
     * @return the hasAgreement
     */
    public boolean isHasAgreement() {
        return hasAgreement;
    }


    /**
     * The setter for the hasAgreement instance variable.
     * @param hasAgreement the hasAgreement to set
     */
    public void setHasAgreement(boolean hasAgreement) {
        this.hasAgreement = hasAgreement;
    }


    /**
       The getter for the hasAddendum instance variable.
     * @return the hasAddendum
     */
    public boolean isHasAddendum() {
        return hasAddendum;
    }


    /**
     * The setter for the hasAddendum instance variable.
     * @param hasAddendum the hasAddendum to set
     */
    public void setHasAddendum(boolean hasAddendum) {
        this.hasAddendum = hasAddendum;
    }

    /**
       The getter for the canDelete instance variable.
     * @return the canDelete
     */
    public boolean isCanDelete() {
        return canDelete;
    }

    /**
     * The setter for the canDelete instance variable.
     * @param canDelete the canDelete to set
     */
    public void setCanDelete(boolean canDelete) {
        this.canDelete = canDelete;
    }

    /**
     * Gets the value of the field <code>applicantType</code>.
     * @return the applicantType
     */
    public int getApplicantType() {
        return applicantType;
    }

    /**
     * Sets the value of the field <code>applicantType</code>.
     * @param applicantType the applicantType to set
     */
    public void setApplicantType(int applicantType) {
        this.applicantType = applicantType;
    }

}
