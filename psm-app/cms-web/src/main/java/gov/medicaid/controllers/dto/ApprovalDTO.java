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
}
