/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Common utility methods.
 *
 * <strong>This defines only static methods and is thread safe.</strong>
 *
 * @author j3_guile
 * @version 1.0
 */
public class Util {

    /**
     * Private constructor.
     */
    private Util() {
    }

    /**
     * Returns true if the value is null or an empty string.
     *
     * @param value the value to check
     * @return true if the value is null or an empty string.
     */
    public static boolean isBlank(String value) {
        return value == null || value.trim().length() == 0;
    }

    /**
     * Returns true if the value contains non whitespace characters.
     *
     * @param value the value to check
     * @return true if the value contains non whitespace characters.
     */
    public static boolean isNotBlank(String value) {
        return !isBlank(value);
    }

    /**
     * Returns a blank string if the value is null.
     *
     * @param value the value to check
     * @return a blank string if the value is null.
     */
    public static String defaultString(String value) {
        return value == null ? "" : value;
    }
    
    /**
     * Returns a string "All" if the value is null.
     *
     * @param value the value to check
     * @return a string "All" if the value is null.
     */
    public static String defaultAllString(String value) {
        return value == null ? "All" : value;
    }

    /**
     * Returns a blank string if the value is zero.
     *
     * @param value the value to check
     * @return a blank string if the value is null.
     */
    public static String defaultLongString(long value) {
        return value == 0 ? "" : Long.toString(value);
    }

    /**
     * Replace page and query string.
     *
     * @param original the original url
     * @param lastPart the last part to use
     * @return the original url up to the last / appended with the given last part
     */
    public static String replaceLastURLPart(String original, String lastPart) {
        StringBuffer sb = new StringBuffer();
        sb.append(original.substring(0, original.lastIndexOf("/") + 1));
        sb.append(lastPart);
        return sb.toString();
    }

    /**
     * Checks if the given value contains only digits.
     *
     * @param value the value to check
     * @return true if only digits are included
     */
    public static boolean isDigits(String value) {
        return value.matches("[0-9]+");
    }

    /**
     * Gets the string in between two sets of strings.
     *
     * @param str the string where to extract from
     * @param start the start boundary
     * @param end the end boundary
     * @return the extracted string
     */
    public static String getStringInBetween(String str, String start, String end) {
        // make sure indices are valid
        if (str.indexOf(start) == -1 || str.indexOf(end) == -1 || str.length() <= (str.indexOf(start) + start.length())
            || str.length() <= str.indexOf(end)) {
            return "";
        }
        return str.substring(str.indexOf(start) + start.length(), str.indexOf(end)).trim();
    }

    /**
     * Clean string array of any empty strings.
     *
     * @param args the array to be cleaned
     * @return clean string array
     */
    public static String[] cleanArray(String[] args) {
        if (args == null) {
            return args;
        }
        List<String> clean = new ArrayList<String>();
        for (String str : args) {
            if (!"".equals(str.trim())) {
                clean.add(str.trim());
            }
        }
        return clean.toArray(new String[clean.size()]);
    }

    /**
     * Parses the day field from the given date.
     *
     * @param value the date value to parse
     * @param defaultValue the default value returned
     * @return the day value, or the default for null dates
     */
    public static String parseDay(Date value, String defaultValue) {
        if (value == null) {
            return defaultValue;
        }
        return new SimpleDateFormat("d").format(value);
    }

    /**
     * Parses the month field from the given date.
     *
     * @param value the date value to parse
     * @param defaultValue the default value returned
     * @return the month text, or the default for null dates
     */
    public static String parseMonth(Date value, String defaultValue) {
        if (value == null) {
            return defaultValue;
        }
        return new SimpleDateFormat("MMM").format(value).toUpperCase();
    }

    /**
     * Parses the month field from the given date.
     *
     * @param value the date value to parse
     * @param defaultValue the default value returned
     * @return the month text, or the default for null dates
     */
    public static String parseYear(Date value, String defaultValue) {
        if (value == null) {
            return defaultValue;
        }
        return new SimpleDateFormat("yyyy").format(value);
    }
}