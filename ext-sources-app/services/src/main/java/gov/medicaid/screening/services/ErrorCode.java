/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

/**
 * This centralizes all application error messages that reaches the client.
 *
 * @author j3_guile
 * @version 1.0
 */
public enum ErrorCode {

    /*
     * Error range 10000 - 19999, missing or invalid parameters.
     */
    /**
     * Last name is required.
     */
    MITA10001("10001", "Last name is required."),
    /**
     * Page size requested is not valid.
     */
    MITA10002("10002", "Page size requested is not valid."),
    /**
     * Sort column requested is not valid.
     */
    MITA10003("10003", "Sort column requested is not valid."),
    /**
     * Identifier is required.
     */
    MITA10004("10004", "Identifier is required."),
    /**
     * At least one search criteria must be provided.
     */
    MITA10005("10005", "At least one search criteria must be provided."),
    /**
     * Specialty is required.
     */
    MITA10006("10006", "Specialty is required."),
    /**
     * Specialty provided is not valid.
     */
    MITA10007("10007", "Specialty provided is not valid."),
    /**
     * License type is required.
     */
    MITA10008("10008", "License type is required."),
    /**
     * License type provided is not valid.
     */
    MITA10009("10009", "License type provided is not valid."),
    /**
     * Identifier must be numeric.
     */
    MITA10010("10010", "Identifier must be numeric."),
    /**
     * Check digit is required.
     */
    MITA10011("10011", "Check digit is required."),
    /**
     * Check digit must be numeric.
     */
    MITA10012("10012", "Check digit must be numeric."),
    /**
     * City is required.
     */
    MITA10013("10013", "City is required."),
    /**
     * Zip Code is required.
     */
    MITA10014("10014", "Zip Code is required."),
    /**
     * State provided is not valid.
     */
    MITA10015("10015", "State provided is not valid."),
    /**
     * Country provided is not valid.
     */
    MITA10016("10016", "Country provided is not valid."),
    /**
     * Agency provided is not valid.
     */
    MITA10017("10017", "Agency provided is not valid."),
    /**
     * CT Code (Reciprocal) provided is not valid.
     */
    MITA10018("10018", "CT Code (Reciprocal) provided is not valid."),
    /**
     * CT Code (Procurement) provided is not valid.
     */
    MITA10019("10019", "CT Code (Procurement) provided is not valid."),
    /**
     * CT Code (Non-Procurement) provided is not valid.
     */
    MITA10020("10020", "CT Code (Non-Procurement) provided is not valid."),
    /**
     * Exclusion type provided is not valid.
     */
    MITA10021("10021", "Exclusion type provided is not valid."),
    /**
     * Name is required.
     */
    MITA10022("10022", "Name is required."),
    /**
     * Business Name is required.
     */
    MITA10023("10023", "Business name is required."),
    /**
     * File number is required.
     */
    MITA10024("10024", "File number is required."),
    /**
     * Last 4 digits of the SSN must be provided.
     */
    MITA10025("10025", "Last 4 digits of the SSN must be provided."),
    /**
     * AANA number must be provided.
     */
    MITA10026("10026", "AANA number must be provided."),
    /**
     * Paging parameters must be valid.
     */
    MITA10027("10027", "Invalid page number and size combination."),
    /**
     * External host name is required.
     */
    MITA10028("10028", "External host name is required."),
    /**
     * External host name is required.
     */
    MITA10029("10029", "Log entry is required."),
    /**
     * External host name is required.
     */
    MITA10030("10030", "Statistics is required."),
    /**
     * Provider type is required.
     */
    MITA10031("10031", "Provider type is required."),
    /**
     * Criteria should be a valid value.
     */
    MITA10032("10032", "Criteria should be a valid value."),
    /**
     * County should be a valid (number) value.
     */
    MITA10033("10033", "County should be a valid (number) value."),
    /**
     * City to find should be provided.
     */
    MITA10034("10034", "City to find should be provided."),
    /**
     * Provider name to find should be provided.
     */
    MITA10035("10035", "Provider name to find should be provided."),

    /*
     * Error range 50000 - 59999, external service errors.
     */
    /**
     * A database call failed.
     */
    MITA50000("50000", "A database call failed."),
    /**
     * An external call failed.
     */
    MITA50001("50001", "An external call failed."),
    /**
     * An external call returned an invalid value or format.
     */
    MITA50002("50002", "An external call returned an invalid value or format."),
    /**
     * An external service login failed.
     */
    MITA50003("50003", "An external service login failed."),
    /**
     * General, uncaught failure.
     */
    MITA99999("99999", "Service Unavailable, Please try again later.");

    /**
     * Short code for the error.
     */
    private final String code;

    /**
     * Descriptive text for the error.
     */
    private final String desc;

    /**
     * Creates a new instance with the given code and message.
     *
     * @param code the error code
     * @param desc the error description
     */
    private ErrorCode(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    /**
     * Gets the value of the field <code>code</code>.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Gets the value of the field <code>desc</code>.
     *
     * @return the desc
     */
    public String getDesc() {
        return desc;
    }
}
