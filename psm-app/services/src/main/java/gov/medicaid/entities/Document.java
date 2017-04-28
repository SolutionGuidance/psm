/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.entities;

import java.io.InputStream;
import java.util.Date;

/**
 * Represents an attachment.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Document extends IdentifiableEntity implements Cloneable {

    /**
     * The profile id.
     */
    private long profileId;

    /**
     * The ticket id.
     */
    private long ticketId;

    /**
     * The document type.
     */
    private String type;

    /**
     * The document name.
     */
    private String filename;

    /**
     * The document description.
     */
    private String description;

    /**
     * The document content id.
     */
    private String contentId;

    /**
     * The document stream.
     */
    private InputStream stream;

    /**
     * Creator.
     */
    private String createdBy;

    /**
     * Timestamp.
     */
    private Date createdOn;

    /**
     * Empty constructor.
     */
    public Document() {
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
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>filename</code>.
     *
     * @return the filename
     */
    public String getFilename() {
        return filename;
    }

    /**
     * Sets the value of the field <code>filename</code>.
     *
     * @param filename the filename to set
     */
    public void setFilename(String filename) {
        this.filename = filename;
    }

    /**
     * Gets the value of the field <code>description</code>.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     *
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     *
     * @return the createdBy
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     *
     * @param createdBy the createdBy to set
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>createdOn</code>.
     *
     * @return the createdOn
     */
    public Date getCreatedOn() {
        return createdOn;
    }

    /**
     * Sets the value of the field <code>createdOn</code>.
     *
     * @param createdOn the createdOn to set
     */
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     *
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     *
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     *
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     *
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
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

    /**
     * Gets the value of the field <code>stream</code>.
     *
     * @return the stream
     */
    public InputStream getStream() {
        return stream;
    }

    /**
     * Sets the value of the field <code>stream</code>.
     *
     * @param stream the stream to set
     */
    public void setStream(InputStream stream) {
        this.stream = stream;
    }
}
