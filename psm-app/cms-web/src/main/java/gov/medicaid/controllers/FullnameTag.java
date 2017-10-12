/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.controllers;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.util.Util;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * This tag library will print the full name of the user given the id.
 *
 * @author j3_guile
 * @version 1.0
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
                    out.println(StringEscapeUtils.escapeHtml(user.getFirstName() + " " + user.getLastName()));
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
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Sets the value of the field <code>userId</code>.
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }
}
