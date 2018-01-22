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
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;

import java.util.List;

/**
 * This matcher assumes all filtering have been done externally.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class NullMatcher implements ResultMatchResolver {

    /**
     * Creates a new instance of this class.
     */
    public NullMatcher() {
    }

    /**
     * This assumes all filtering are done on the external sources.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results) {

        if (provider.getApplicantInformation() == null) {
            return MatchStatus.NO_MATCH;
        }

        SearchResultType matches = results.getSearchResults();
        List<SearchResultItemType> items = matches.getSearchResultItem();

        if (items.size() == 1) {
            return MatchStatus.EXACT_MATCH;
        } else if (items.size() > 1) {
            return MatchStatus.PARTIAL_MATCH;
        }
        return MatchStatus.NO_MATCH;
    }
}
