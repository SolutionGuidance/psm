/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * This is a container for lookup entries referenced by the rules.
 * @author TCSASSEMBLER
 * @version 1.0
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
