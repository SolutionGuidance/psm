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
package gov.medicaid.services.util;

/**
 * List of used sequence names for this application.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Sequences {
    /**
     * Used for provider group association table.
     */
    public static final String PROV_GRP_SEQ = "PROV_GRP_SEQ";

    /**
     * Used for provider license table.
     */
    public static final String LICENSE_SEQ = "LICENSE_SEQ";

    /**
     * Used for designated contacts table.
     */
    public static final String DESIGNATED_CONTACT_SEQ = "DESIGNATED_CONTACT_SEQ";

    /**
     * Used for provider statement table.
     */
    public static final String STATEMENT_ID = "STATEMENT_ID";

    /**
     * Used for notes.
     */
    public static final String NOTES_SEQ = "NOTES_SEQ";

    /**
     * Used for each new provider enrollment.
     */
    public static final String PROVIDER_NUMBER_SEQ = "PROVIDER_NUMBER_SEQ";

    /**
     * Used for each account link.
     */
    public static final String ACOUNT_LINK_SEQ = "ACOUNT_LINK_SEQ";

    /**
     * The agreements accepted.
     */
    public static final String AGREEMENT_SEQ = "AGREEMENT_SEQ";

    /**
     * Ownership information.
     */
    public static final String OWNERSHIP_SEQ = "OWNERSHIP_SEQ";

    /**
     * Asset sequence.
     */
    public static final String ASSET_SEQ = "ASSET_SEQ";

    /**
     * Beneficial owners.
     */
    public static final String BEN_OWNER_SEQ = "BEN_OWNER_SEQ";

    /**
     * External profile link.
     */
    public static final String EXT_PROF_LINK_SEQ = "EXT_PROF_LINK_SEQ";

    /**
     * For help items.
     */
    public static final String HELP_ITEM_SEQ = "HELP_ITEM_SEQ";

    /**
     * Event sequence.
     */
    public static final String EVENT_SEQ = "CMS_EVENT_SEQ";

    public static final String PAY_TO_SEQ = "PAY_TO_SEQ";

    public static final String SERVICE_SEQ = "SERVICE_SEQ";
    
    /**
     * For Assured Services.
     */
    public static final String ASSURED_SERVICE_SEQ = "ASSURED_SERVICE_SEQ";

    public static final String PROVIDER_COS_SEQ = "PROVIDER_COS_SEQ";
    
    /**
     * Private constructor.
     */
    private Sequences() {
    }
}
