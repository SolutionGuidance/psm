/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.entities.SystemId;

/**
 * This defines a sequence generation interface used by the persistence implementation to maintain unique references.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface SequenceGenerator {

    /**
     * Retrieves the next value for the sequence.
     *
     * @param sequenceName the name of the sequence
     * @return the next value for the named sequence
     */
    long getNextValue(String sequenceName);

    /**
     * Creates a unique string by combining a sequence and the system name.
     *
     * @param system the system name to prepend to the unique value
     * @param sequenceName the name of the sequence
     * @return the next value for the named sequence
     */
    String getNextSystemValue(SystemId system, String sequenceName);

}