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
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProviderInformationType;

/**
 * This matcher executes a combination of {@link LicenseTypeMatcher} and {@link ProviderNameMatcher}.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class NameAndTypeMatcher implements ResultMatchResolver {

    /**
     * License type matcher.
     */
    private LicenseTypeMatcher typeMatcher = new LicenseTypeMatcher();

    /**
     * Provider name matcher.
     */
    private ProviderNameMatcher nameMatcher = new ProviderNameMatcher();

    /**
     * Creates a new instance of this class.
     */
    public NameAndTypeMatcher() {
    }

    /**
     * This handles resolving specific matches from the external search results by comparing the license type and
     * provider name.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results) {
        LicenseType license = (LicenseType) object;

        // use exact matching for license type
        MatchStatus status = typeMatcher.match(provider, license, results);
        if (status == MatchStatus.EXACT_MATCH) {
            // allow partial matching of provider name
            return nameMatcher.match(provider, license, results);
        } else {
            return status;
        }
    }
}
