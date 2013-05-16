/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProviderInformationType;

/**
 * This matcher executes a combination of {@link LicenseNumberMatcher} and {@link ProviderNameMatcher}.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class NameAndNumberMatcher implements ResultMatchResolver {

    /**
     * License number matcher.
     */
    private LicenseNumberMatcher numberMatcher = new LicenseNumberMatcher();

    /**
     * Provider name matcher.
     */
    private ProviderNameMatcher nameMatcher = new ProviderNameMatcher();

    /**
     * Creates a new instance of this class.
     */
    public NameAndNumberMatcher() {
    }

    /**
     * This handles resolving specific matches from the external search results by comparing the license number.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results) {
        LicenseType license = (LicenseType) object;

        // use exact matching for license number
        MatchStatus status = numberMatcher.match(provider, license, results);
        if (status == MatchStatus.EXACT_MATCH) {
            // allow partial matching of provider name
            return nameMatcher.match(provider, license, results);
        } else {
            return status;
        }
    }
}
