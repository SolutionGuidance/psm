/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * This enum represents the possible verification outcomes.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public enum MatchStatus {

    /**
     * There is an exact match.
     */
    EXACT_MATCH,

    /**
     * There is a possible match.
     */
    PARTIAL_MATCH,

    /**
     * There are not matches.
     */
    NO_MATCH;
}
