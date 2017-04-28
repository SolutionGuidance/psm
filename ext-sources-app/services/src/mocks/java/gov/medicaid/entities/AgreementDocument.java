/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents an agreement document.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class AgreementDocument extends AuditableEntity {
    /** The generated serial version id. */
    private static final long serialVersionUID = -1961148619506459400L;

    /** The title. */
    private String title;

    /** The version. */
    private String version;

    /** The content. */
    private String content;

    /** The type. */
    private AgreementDocumentType type;

    /**
     * Empty constructor.
     */
    public AgreementDocument() {
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
     * Getter of the content.
     *
     * @return the content
     */
    public String getContent() {
        return content;
    }

    /**
     * Setter of the content.
     *
     * @param content the content to set
     */
    public void setContent(String content) {
        this.content = content;
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

    /**
     * Getter of the version.
     *
     * @return the version
     */
    public String getVersion() {
        return version;
    }

    /**
     * Setter of the version.
     *
     * @param version the version to set
     */
    public void setVersion(String version) {
        this.version = version;
    }
}
