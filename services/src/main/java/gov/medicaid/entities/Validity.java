/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Validity status for tickets.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum Validity {

    /**
     * Ticket is still valid.
     */
    VALID,

    /**
     * Ticket is superseded by another one.
     */
    SUPERSEDED,

    /**
     * Ticket is stale.
     */
    STALE
}
