/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.security;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

/**
 * An authentication token that supports the domain field.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DomainAuthenticationToken extends UsernamePasswordAuthenticationToken {

    /**
     * The domain.
     */
    private final String domain;

    /**
     * Creates a new instance from the given properties.
     * @param username the login username
     * @param password the login password
     * @param domain the login domain
     */
    public DomainAuthenticationToken(String username, String password, String domain) {
        super(username, password);
        this.domain = domain;
    }

    /**
     * Gets the value of the field <code>domain</code>.
     *
     * @return the domain
     */
    public String getDomain() {
        return domain;
    }
}
