/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents supported Remittance sequence order.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum RemittanceSequenceOrder {

    /**
     * By enrollee name.
     */
    BY_ENROLLEE_NAME,

    /**
     * By patient account.
     */
    PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER,

    /**
     * By transaction control.
     */
    DHS_TRANSACTION_CONTROL_ORDER,

    /**
     * By MHCP ID.
     */
    RECIPIENT_MHCP_ID_NUMBER_ORDER;
}
