/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.dto;

import java.util.List;

/**
 * This class is used to perform manual verification.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Medicaid Provider Screening Portal - Service Agent Controllers
 */
public class ApprovalDTO {

    /**
     * License ids that the approver set to verified.
     */
    private List<String> verifiedLicenses;

    /**
     * If Y, user has verified the PECOS NPI.
     */
    private String npiVerified;

    /**
     * If Y, user has verified the NPI Lookup.
     */
    private String npiLookupVerified;

    /**
     * If Y, user has verified the SSN.
     */
    private String ssnVerified;

    /**
     * If Y, user has verified that user is not in the exclusion list from OIG.
     */
    private String nonExclusionVerified;

    /**
     * If Y, user has verified that user is not in the exclusion list from SAM.
     */
    private String nonSAMExclusionVerified;

    /**
     * If Y, user has verified the BGS ID.
     */
    private String bgsVerified;

    /**
     * Empty constructor.
     */
    public ApprovalDTO() {

    }

    /**
     * Gets the value of the field <code>verifiedLicenses</code>.
     * 
     * @return the verifiedLicenses
     */
    public List<String> getVerifiedLicenses() {
        return verifiedLicenses;
    }

    /**
     * Sets the value of the field <code>verifiedLicenses</code>.
     * 
     * @param verifiedLicenses
     *            the verifiedLicenses to set
     */
    public void setVerifiedLicenses(List<String> verifiedLicenses) {
        this.verifiedLicenses = verifiedLicenses;
    }

    /**
     * Gets the value of the field <code>npiVerified</code>.
     * 
     * @return the npiVerified
     */
    public String getNpiVerified() {
        return npiVerified;
    }

    /**
     * Sets the value of the field <code>npiVerified</code>.
     * 
     * @param npiVerified
     *            the npiVerified to set
     */
    public void setNpiVerified(String npiVerified) {
        this.npiVerified = npiVerified;
    }

    /**
     * Gets the value of the field <code>ssnVerified</code>.
     * 
     * @return the ssnVerified
     */
    public String getSsnVerified() {
        return ssnVerified;
    }

    /**
     * Sets the value of the field <code>ssnVerified</code>.
     * 
     * @param ssnVerified
     *            the ssnVerified to set
     */
    public void setSsnVerified(String ssnVerified) {
        this.ssnVerified = ssnVerified;
    }

    /**
     * Gets the value of the field <code>nonExclusionVerified</code>.
     * 
     * @return the nonExclusionVerified
     */
    public String getNonExclusionVerified() {
        return nonExclusionVerified;
    }

    /**
     * Sets the value of the field <code>nonExclusionVerified</code>.
     * 
     * @param nonExclusionVerified
     *            the nonExclusionVerified to set
     */
    public void setNonExclusionVerified(String nonExclusionVerified) {
        this.nonExclusionVerified = nonExclusionVerified;
    }

    /**
     * Gets the value of the field <code>bgsVerified</code>.
     * 
     * @return the bgsVerified
     */
    public String getBgsVerified() {
        return bgsVerified;
    }

    /**
     * Sets the value of the field <code>bgsVerified</code>.
     * 
     * @param bgsVerified
     *            the bgsVerified to set
     */
    public void setBgsVerified(String bgsVerified) {
        this.bgsVerified = bgsVerified;
    }

    /**
     * Gets the <code>npiLookupVerified</code>.
     * 
     * @return the npiLookupVerified
     */
    public String getNpiLookupVerified() {
        return npiLookupVerified;
    }

    /**
     * Sets the <code>npiLookupVerified</code>.
     * 
     * @param npiLookupVerified
     *            the npiLookupVerified to set
     */
    public void setNpiLookupVerified(String npiLookupVerified) {
        this.npiLookupVerified = npiLookupVerified;
    }

    /**
     * Gets the <code>nonSAMExclusionVerified</code>.
     * 
     * @return the nonSAMExclusionVerified
     */
    public String getNonSAMExclusionVerified() {
        return nonSAMExclusionVerified;
    }

    /**
     * Sets the <code>nonSAMExclusionVerified</code>.
     * 
     * @param nonSAMExclusionVerified
     *            the nonSAMExclusionVerified to set
     */
    public void setNonSAMExclusionVerified(String nonSAMExclusionVerified) {
        this.nonSAMExclusionVerified = nonSAMExclusionVerified;
    }
}
