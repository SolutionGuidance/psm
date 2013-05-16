/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.sql.Blob;

/**
 * Stores BLOB contents.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class BinaryContent {

    /**
     * The binary content.
     */
    private Blob content;

    /**
     * The content id.
     */
    private String contentId;

    /**
     * Empty constructor.
     */
    public BinaryContent() {
    }

    /**
     * Gets the value of the field <code>content</code>.
     *
     * @return the content
     */
    public Blob getContent() {
        return content;
    }

    /**
     * Sets the value of the field <code>content</code>.
     *
     * @param content the content to set
     */
    public void setContent(Blob content) {
        this.content = content;
    }

    /**
     * Gets the value of the field <code>contentId</code>.
     *
     * @return the contentId
     */
    public String getContentId() {
        return contentId;
    }

    /**
     * Sets the value of the field <code>contentId</code>.
     *
     * @param contentId the contentId to set
     */
    public void setContentId(String contentId) {
        this.contentId = contentId;
    }
}
