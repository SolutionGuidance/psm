/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.util;

import gov.medicaid.services.PortalServiceConfigurationException;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Properties;

import org.apache.commons.codec.binary.Base64;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.properties.EncryptableProperties;

/**
 * Common utility methods.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * Environment variable expected for the encryption key.
     */
    public static final String CMS_CRYPT_PASSWORD = "cms.crypt.password";

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
     * Creates a new properties instance, it checks the environment if the app is running in production mode, if yes,
     * then the properties file supports encrypted values.
     *
     * @return the properties implementation
     */
    public static Properties newEncryptionEnabledProps() {
        Properties props;
        // for production, we expect all sensitive properties to be encrypted
        if (PRODUCTION.equals(System.getProperty(CMS_ENV))) {
            String password = System.getProperty(CMS_CRYPT_PASSWORD);
            if (isBlank(password)) {
                throw new PortalServiceConfigurationException(CMS_CRYPT_PASSWORD
                    + " is not found, please set the environment "
                    + "variable before starting up the application in PROD mode.");
            }

            StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
            encryptor.setPassword(password);
            props = new EncryptableProperties(encryptor);
        } else {
            props = new Properties();
        }
        return props;
    }

    /**
     * Left pads the given value with the given character to a specific width.
     * @param value the value to be padded
     * @param i the width expected
     * @param c the padding character
     * @return the padded string
     */
    public static String pad(String value, int i, char c) {
        return String.format("%" + i + "s", value).replace(' ', c);
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