/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This entity holds data of NETStudy web service response.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@SuppressWarnings("serial")
public class NETStudyResponse implements Serializable {
    /**
     * The response result XML.
     */
    private String response;

    /**
     * Whether it is denied.
     */
    private boolean denied;
    
    /**
     * Default empty constructor.
     */
    public NETStudyResponse() {
    }

    /**
     * Gets the value of the field <code>response</code>.
     *
     * @return the response
     */
    public String getResponse() {
        return response;
    }

    /**
     * Sets the value of the field <code>response</code>.
     *
     * @param response the response to set
     */
    public void setResponse(String response) {
        this.response = response;
    }

    /**
     * Gets the value of the field <code>denied</code>.
     *
     * @return the denied
     */
    public boolean isDenied() {
        return denied;
    }

    /**
     * Sets the value of the field <code>denied</code>.
     *
     * @param denied the denied to set
     */
    public void setDenied(boolean denied) {
        this.denied = denied;
    }
}

