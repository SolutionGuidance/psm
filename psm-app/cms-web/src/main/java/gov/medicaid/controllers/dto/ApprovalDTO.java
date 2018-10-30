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

package gov.medicaid.controllers.dto;

/**
 * This class is used to perform manual verification.
 */
public class ApprovalDTO {
    /**
     * If Y, user has verified that user is not in the exclusion list from OIG.
     */
    private String nonExclusionVerified;

    /**
     * If Y, user has verified that user is not in the Death Master File.
     */
    private String notInDmfVerified;

    /**
     * Empty constructor.
     */
    public ApprovalDTO() {

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

    public String getNotInDmfVerified() {
        return notInDmfVerified;
    }

    public void setNotInDmfVerified(String notInDmfVerified) {
        this.notInDmfVerified = notInDmfVerified;
    }

}
