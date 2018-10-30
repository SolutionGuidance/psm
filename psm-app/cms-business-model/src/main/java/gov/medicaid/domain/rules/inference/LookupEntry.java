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
 * This is a container for lookup entries referenced by the rules.
 */
public class LookupEntry {

    /**
     * The lookup category.
     */
    private final String type;

    /**
     * The lookup code.
     */
    private final String code;

    /**
     * The lookup value.
     */
    private final String value;

    /**
     * Creates an instance using the provided values for the fields.
     * @param type the lookup type
     * @param code the lookup code/key
     * @param value the lookup value/description
     */
    public LookupEntry(String type, String code, String value) {
        super();
        this.type = type;
        this.code = code;
        this.value = value;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
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
     * Gets the value of the field <code>value</code>.
     *
     * @return the value
     */
    public String getValue() {
        return value;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "LookupEntry [type=" + type + ", code=" + code + ", value=" + value + "]";
    }
}
