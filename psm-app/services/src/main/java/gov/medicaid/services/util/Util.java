/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.util;

import gov.medicaid.services.PortalServiceConfigurationException;

import org.apache.commons.codec.binary.Base64;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Common utility methods.
 */
public class Util {

    /**
     * Environment mode for production.
     */
    public static final String PRODUCTION = "PROD";

    /**
     * Environment variable expected for the environment type.
     */
    public static final String CMS_ENV = "cms.env";

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
     * Checks of the given array contains any elements.
     *
     * @param values the array to check
     * @return true if the array is null or empty
     */
    public static boolean isEmpty(Object[] values) {
        return values == null || values.length == 0;
    }

    /**
     * Checks of the given array contains any elements.
     *
     * @param values the array to check
     * @return true if the array is not empty
     */
    public static boolean isNotEmpty(Object[] values) {
        return !isEmpty(values);
    }

    /**
     * Checks of the given list contains any elements.
     *
     * @param values the list to check
     * @return true if the list is null or empty
     */
    @SuppressWarnings("rawtypes")
    public static boolean isEmpty(List values) {
        return values == null || values.isEmpty();
    }

    /**
     * Checks of the given list contains any elements.
     *
     * @param values the list to check
     * @return true if the list is not empty
     */
    @SuppressWarnings("rawtypes")
    public static boolean isNotEmpty(List values) {
        return !isEmpty(values);
    }

    /**
     * Hashes the given string using the given salt value.
     * @param value the value to be hashed
     * @param salt the salt for the hash
     * @return Base 64 encoded SHA hash of the salted value
     */
    public static String hash(String value, String salt) {
        try {
            String saltedValue = value + salt;
            MessageDigest sha = MessageDigest.getInstance("SHA");
            sha.update(saltedValue.getBytes());
            byte[] hash = sha.digest();
            return new String(Base64.encodeBase64(hash));
        } catch (NoSuchAlgorithmException e) {
            throw new PortalServiceConfigurationException("No valid encryption algorithm was found.", e);
        }
    }
}
