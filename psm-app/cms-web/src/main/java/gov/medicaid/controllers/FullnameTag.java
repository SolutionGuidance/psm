/*
 * Copyright 2013 TopCoder, Inc., All Rights Reserved.
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

import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.util.Util;
import org.springframework.web.util.HtmlUtils;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 * This tag library will print the full name of the user given the id.
 */
public class FullnameTag extends SimpleTagSupport {

    /**
     * The entity manager to use when getting the user information.
     */
    private final EntityManager em;

    /**
     * Creates a new instance.
     */
    public FullnameTag() {
        CMSConfigurator config = new CMSConfigurator();
        em = config.getPortalEntityManager();
    }

    /**
     * The user id to be retrieved.
     */
    private String userId;

    /**
     * Prints the full name of the user with the provided id.
     */
    @Override
    public void doTag() throws JspException, IOException {
        if (userId != null) {
            Query query = em.createQuery("FROM CMSUser where userId = :userId");
            query.setParameter("userId", userId);
            CMSUser user = (CMSUser) query.getSingleResult();

            PageContext pageContext = (PageContext) getJspContext();
            JspWriter out = pageContext.getOut();
            try {
                if (Util.isNotBlank(user.getFirstName())) {
                    out.println(HtmlUtils.htmlEscape(
                            user.getFirstName() + " " + user.getLastName())
                    );
                } else {
                    out.println(userId);
                }
            } catch (Exception e) {
                // Ignore.
            }
        }
    }

    /**
     * Gets the value of the field <code>userId</code>.
     *
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Sets the value of the field <code>userId</code>.
     *
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }
}
