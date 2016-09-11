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
     * Flag to delete or not.
     */
    private boolean canDelete;

   /**
     * Default empty constructor.
     */
    public ProviderType() {
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

	public boolean isCanDelete() {
		return canDelete;
	}

	public void setCanDelete(boolean canDelete) {
		this.canDelete = canDelete;
	}

}
