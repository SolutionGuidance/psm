/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.controllers;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;

/**
 * This tag library will truncate a text to a specified limit and append an ellipsis.
 *
 * since PESP
 */
public class TruncateTextTag extends SimpleTagSupport {

    private int limit = 15;

    private String text;

    @Override
    public void doTag() throws JspException, IOException {
        if (text != null) {
            PageContext pageContext = (PageContext) getJspContext();
            JspWriter out = pageContext.getOut();
            try {
                if (limit > 0 && text.trim().length() > limit) {
                    out.print(text.substring(0, limit) + "...");
                } else {
                    out.print(text);
                }
            } catch (Exception e) {
                // Ignore.
            }
        }
    }


    /**
     * Gets the value of the field <code>limit</code>.
     * @return the limit
     */
    public int getLimit() {
        return limit;
    }


    /**
     * Sets the value of the field <code>limit</code>.
     * @param limit the limit to set
     */
    public void setLimit(int limit) {
        this.limit = limit;
    }


    /**
     * Gets the value of the field <code>text</code>.
     * @return the text
     */
    public String getText() {
        return text;
    }


    /**
     * Sets the value of the field <code>text</code>.
     * @param text the text to set
     */
    public void setText(String text) {
        this.text = text;
    }
}
