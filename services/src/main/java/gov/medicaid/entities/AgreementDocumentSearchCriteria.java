/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for agreement document.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class AgreementDocumentSearchCriteria extends SearchCriteria {

    /** The title. */
    private String title;

    /** The type. */
    private AgreementDocumentType type;

    /**
     * Empty constructor.
     */
    public AgreementDocumentSearchCriteria() {
    }

    /**
     * Getter of the title.
     *
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Setter of the title.
     *
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Getter of the type.
     *
     * @return the type
     */
    public AgreementDocumentType getType() {
        return type;
    }

    /**
     * Setter of the type.
     *
     * @param type the type to set
     */
    public void setType(AgreementDocumentType type) {
        this.type = type;
    }
}
