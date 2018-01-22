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
    FORGOT_PASSWORD

}
