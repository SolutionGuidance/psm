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

package gov.medicaid.domain.rules.inference;

/**
 * This class is used by the rules to perform validation on an address within a context, since an address may appear in
 * different levels of a profile.
 */
public class NPIEntry {

    /**
     * The address to be checked.
     */
    private final String npi;

    /**
     * The path to this address.
     */
    private String path;

    /**
     * The npi name.
     */
    private String name;

    /**
     * Represents the NPI validated flag.
     */
    private String validated = "N";

    /**
     * Represents the validation result flag.
     */
    private final String valid;

    /**
     * Creates a new instance using the given entity.
     *
     * @param type
     *            the phone number type
     * @param path
     *            the path to the field
     * @param address
     *            the value
     */
    public NPIEntry(String name, String path, String npi) {
        this.name = name;
        this.path = path;
        this.npi = npi;
        this.valid = doValidation();
    }

    /**
     * NPI validation algorithm.
     *
     * @return Y/N based on the validation.
     */
    public String doValidation() {
        if (npi.length() != 10) {
            return "N";
        }

        if (!npi.matches("\\d{10}")) {
            return "N";
        }

        String nineDigits = npi.substring(0, 9);
        String pre = "80840" + nineDigits;
        char[] charArray = pre.toCharArray();
        int total = 0;
        int counter = 0;
        for (int i = charArray.length - 1; i > -1; i--) {
            counter++;
            if (counter % 2 == 1) {
                String x2 = "" + (Integer.parseInt("" + charArray[i]) * 2);
                char[] doubled = x2.toCharArray();
                for (char c : doubled) {
                    total += Integer.parseInt("" + c);
                }
            } else {
                total += Integer.parseInt("" + charArray[i]);
            }
        }

        int checkdigit = total % 10 == 0 ? 0 : 10 - (total % 10);
        return npi.substring(9).equals("" + checkdigit) ? "Y" : "N";
    }

    /**
     * Gets the value of the field <code>path</code>.
     *
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * Sets the value of the field <code>path</code>.
     *
     * @param path
     *            the path to set
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name
     *            the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Gets the value of the field <code>validated</code>.
     *
     * @return the validated
     */
    public String getValidated() {
        return validated;
    }

    /**
     * Sets the value of the field <code>validated</code>.
     *
     * @param validated
     *            the validated to set
     */
    public void setValidated(String validated) {
        this.validated = validated;
    }

    /**
     * Gets the value of the field <code>valid</code>.
     *
     * @return the valid
     */
    public String getValid() {
        return valid;
    }
}
