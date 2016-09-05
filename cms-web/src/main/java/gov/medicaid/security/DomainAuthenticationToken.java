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
     * Profile NPI.
     */
	private String profileNPI;
	
	/**
	 * Referrer URL.
	 */
	private String referrer;

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
     * Creates a new instance from the given properties.
     * 
     * @param userNPI the NPI of the user
     * @param profileNPI the requested profile
     * @param token the token for verification
     * @param referrer the domain referrer
     * @param domain the domain
     */
    public DomainAuthenticationToken(String userNPI, String profileNPI,
			String token, String referrer, String domain) {
    	super(userNPI, token);
		this.profileNPI = profileNPI;
		this.referrer = referrer;
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

	/**
	 * Gets the value of the field <code>profileNPI</code>.
	 * @return the profileNPI
	 */
	public String getProfileNPI() {
		return profileNPI;
	}

	/**
	 * Sets the value of the field <code>profileNPI</code>.
	 * @param profileNPI the profileNPI to set
	 */
	public void setProfileNPI(String profileNPI) {
		this.profileNPI = profileNPI;
	}

	/**
	 * Gets the value of the field <code>referrer</code>.
	 * @return the referrer
	 */
	public String getReferrer() {
		return referrer;
	}

	/**
	 * Sets the value of the field <code>referrer</code>.
	 * @param referrer the referrer to set
	 */
	public void setReferrer(String referrer) {
		this.referrer = referrer;
	}
}
