/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
