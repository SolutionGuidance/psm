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
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;

import java.util.List;

/**
 * This matcher compares the license type. Some services return multiple license types and this can be used to filter
 * the desired types.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class LicenseTypeMatcher implements ResultMatchResolver {

    /**
     * Creates a new instance of this class.
     */
    public LicenseTypeMatcher() {
    }

    /**
     * This handles resolving specific matches from the external search results by comparing the license type.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results) {
        LicenseType license = (LicenseType) object;

        List<SearchResultItemType> matches = results.getSearchResults().getSearchResultItem();
        SearchResultItemType match = null;

        for (SearchResultItemType searchResultItemType : matches) {
            PropertyListType props = searchResultItemType.getColumnData();
            List<NameValuePairType> cols = props.getNameValuePair();
            for (NameValuePairType col : cols) {
                if (!col.getName().equals("License Type")) {
                    continue;
                }
                if (normalize(col.getValue()).equals(normalize(license.getLicenseType()))) {
                    match = searchResultItemType;
                    break;
                }
            }

            if (match != null) {
                break;
            }
        }

        matches.clear();
        if (match != null) {
            matches.add(match);
            return MatchStatus.EXACT_MATCH;
        } else {
            return MatchStatus.NO_MATCH;
        }
    }

    /**
     * Removes any non alphanumeric characters from the given string.
     * @param value the string to be filtered
     * @return the filtered string
     */
    protected static String normalize(String value) {
        return value.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
    }
}
