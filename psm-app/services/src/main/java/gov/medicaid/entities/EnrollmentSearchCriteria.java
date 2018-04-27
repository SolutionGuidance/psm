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
 * Represents an enrollment search criteria.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class EnrollmentSearchCriteria extends SearchCriteria {

    /**
     * Request create start date filter.
     */
    private Date createDateStart;

    /**
     * Request create end date filter.
     */
    private Date createDateEnd;

    /**
     * Default empty constructor.
     */
    public EnrollmentSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>createDateStart</code>.
     * @return the createDateStart
     */
    public Date getCreateDateStart() {
        return createDateStart;
    }

    /**
     * Sets the value of the field <code>createDateStart</code>.
     * @param createDateStart the createDateStart to set
     */
    public void setCreateDateStart(Date createDateStart) {
        this.createDateStart = createDateStart;
    }

    /**
     * Gets the value of the field <code>createDateEnd</code>.
     * @return the createDateEnd
     */
    public Date getCreateDateEnd() {
        return createDateEnd;
    }

    /**
     * Sets the value of the field <code>createDateEnd</code>.
     * @param createDateEnd the createDateEnd to set
     */
    public void setCreateDateEnd(Date createDateEnd) {
        this.createDateEnd = createDateEnd;
    }
}
