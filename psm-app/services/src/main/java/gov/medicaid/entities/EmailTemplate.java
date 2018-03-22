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
 * Represents supported templates.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum EmailTemplate {

    /**
     * Email template for new registrations.
     */
    NEW_REGISTRATION,

    /**
     * Email template for new registrations.
     */
    NEW_REGISTRATION_BY_ADMIN,

    /**
     * Email template for logged in user initiated password change.
     */
    UPDATE_PASSWORD,

    /**
     * Email template for "forgot password" reset.
     */
    FORGOT_PASSWORD,
    
    /**
     * Email template for pending enrollment sent to an indivudal provider.
     */
    PENDING_ENROLLMENT_INDIVIDUAL,
    
    /**
     * Email template for pending enrollment sent to an organizational provider.
     */
    PENDING_ENROLLMENT_ORGANIZATION,
    
    /**
     * Email template for pending enrollment sent to a service admin or agent.
     */
    PENDING_ENROLLMENT_ADMIN,
    
    /**
     * Email template for modified enrollment sent to an indivudal provider.
     */
    MODIFIED_ENROLLMENT_INDIVIDUAL,
    
    /**
     * Email template for v enrollment sent to an organizational provider.
     */
    MODIFIED_ENROLLMENT_ORGANIZATION,
    
    /**
     * Email template for modified enrollment sent to a service admin or agent.
     */
    MODIFIED_ENROLLMENT_ADMIN,
    
    /**
     * Email template for approved enrollment sent to an indivudal provider.
     */
    APPROVED_ENROLLMENT_INDIVIDUAL,
    
    /**
     * Email template for approved enrollment sent to an organizational provider.
     */
    APPROVED_ENROLLMENT_ORGANIZATION,
    
    /**
     * Email template for approved enrollment sent to a service admin or agent.
     */
    APPROVED_ENROLLMENT_ADMIN,
    
    /**
     * Email template for rejected enrollment sent to an indivudal provider.
     */
    REJECTED_ENROLLMENT_INDIVIDUAL,
    
    /**
     * Email template for rejected enrollment sent to an organizational provider.
     */
    REJECTED_ENROLLMENT_ORGANIZATION,
    
    /**
     * Email template for rejected enrollment sent to a service admin or agent.
     */
    REJECTED_ENROLLMENT_ADMIN,

}
