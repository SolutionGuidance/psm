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
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;

import java.util.Iterator;
import java.util.List;

/**
 * This matcher compares the provider name. The comparison ignores non alphanumeric characters.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class ProviderNameMatcher implements ResultMatchResolver {

    /**
     * Some services have no filters, so they always return results. This flag, when set to true, assumes all filtering
     * are done locally and therefore non-matches should be suppressed.
     */
    private final boolean suppressNonMatches;

    /**
     * Some services never return middle names. Set this flag to true for such matching considerations.
     */
    private final boolean ignoreMiddleName;

    /**
     * Creates a new instance of this class.
     */
    public ProviderNameMatcher() {
        this(false);
    }

    /**
     * Creates a new instance.
     *
     * @param suppressNonMatches set to true if filtering is not done by the external source
     */
    public ProviderNameMatcher(boolean suppressNonMatches) {
        this(suppressNonMatches, false);
    }

    /**
     * Creates a new instance.
     *
     * @param suppressNonMatches set to true if filtering is not done by the external source
     * @param ignoreMiddleName set to true if middle name is not an important criteria
     */
    public ProviderNameMatcher(boolean suppressNonMatches, boolean ignoreMiddleName) {
        this.suppressNonMatches = suppressNonMatches;
        this.ignoreMiddleName = ignoreMiddleName;
    }

    /**
     * This handles resolving specific matches from the external search results by comparing the provider names.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results) {
        String providerName = "";

        if (provider.getApplicantInformation() == null) {
            return MatchStatus.NO_MATCH;
        }

        if (provider.getApplicantInformation().getOrganizationInformation() != null) {
            providerName = provider.getApplicantInformation().getOrganizationInformation().getName();
        } else {
            IndividualApplicantType individual = provider.getApplicantInformation().getPersonalInformation();
            if (individual != null) {
                if (ignoreMiddleName) {
                    providerName = defaultString(individual.getFirstName()) + " "
                        + defaultString(individual.getLastName());
                } else {
                    providerName = defaultString(individual.getFirstName()) + " "
                        + defaultString(individual.getMiddleName()) + " " + defaultString(individual.getLastName());
                }
            }
        }

        SearchResultType matches = results.getSearchResults();
        List<SearchResultItemType> items = matches.getSearchResultItem();
        SearchResultItemType match = null;
        for (Iterator<SearchResultItemType> iterator = items.iterator(); iterator.hasNext();) {
            SearchResultItemType searchResultItemType = iterator.next();

            PropertyListType props = searchResultItemType.getColumnData();
            List<NameValuePairType> cols = props.getNameValuePair();
            for (NameValuePairType col : cols) {
                if (!col.getName().equals("Provider Name")) {
                    continue;
                }
                if (normalize(col.getValue()).equals(normalize(providerName))) {
                    match = searchResultItemType;
                    break;
                }
            }

            if (match != null) {
                break;
            }
        }

        if (match != null) {
            // we have an exact match, discard all other results
            matches.getSearchResultItem().clear();
            matches.getSearchResultItem().add(match);
            return MatchStatus.EXACT_MATCH;
        } else {

            // there is no match, suppress service results based on configuration
            if (suppressNonMatches) {
                matches.getSearchResultItem().clear();
            }

            if (matches.getSearchResultItem().isEmpty()) {
                return MatchStatus.NO_MATCH;
            }
            return MatchStatus.PARTIAL_MATCH;
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

    /**
     * Returns a blank string if the value is null.
     *
     * @param value the value to check
     * @return a blank string if the value is null.
     */
    protected static String defaultString(String value) {
        return value == null ? "" : value;
    }
}
