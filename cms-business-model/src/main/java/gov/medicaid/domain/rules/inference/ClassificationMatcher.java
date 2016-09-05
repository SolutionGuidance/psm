/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.LicenseNames;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;

import java.util.List;

/**
 * This matcher compares the license type to the classifications. Some services return multiple license types and this
 * can be used to filter the desired types.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class ClassificationMatcher implements ResultMatchResolver {

    /**
     * Creates a new instance of this class.
     */
    public ClassificationMatcher() {
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
                if (!col.getName().equals("State Classifications")) {
                    continue;
                }
                if (normalize(col.getValue()).equals(normalize(getMappedClassification(license.getLicenseType())))) {
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
     * Returns the classification mapped to the given license type.
     * @param licenseType the type
     * @return the mapped classification
     */
    private String getMappedClassification(String licenseType) {
        if (LicenseNames.CLASS_A_PROFESSIONAL_HOME_CARE_LICENSE.value().equals(licenseType)) {
            return "Class A - Professional Home Care Agency";
        }
        return licenseType;
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
