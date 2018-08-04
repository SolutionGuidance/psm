/*
 * Copyright 2013 TopCoder Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
