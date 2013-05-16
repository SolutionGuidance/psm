/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ProviderInformationType;

/**
 * This interface defines the matcher logic between external search results and the provider process. For example, if
 * the external search is done by license number, then the matcher should locally check for the provider name, while if
 * the external search is done by name, then the local check should be for license number.
 *
 * @author TCSASSEMBER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public interface ResultMatchResolver {

    /**
     * This handles resolving specific matches from the external search results.
     *
     * @param provider the applicant
     * @param object the object being verified
     * @param results the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object,
        ExternalSourcesScreeningResultType results);
}
