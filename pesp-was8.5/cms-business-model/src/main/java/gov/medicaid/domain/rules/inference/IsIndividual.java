/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ProviderInformationType;

/**
 * This class is used by the rules to differentiate individual from organizational requests.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class IsIndividual {

    /**
     * The individual provider.
     */
    private final ProviderInformationType provider;

    /**
     * Creates a new instance using the given entity.
     *
     * @param provider the provider to wrap.
     */
    public IsIndividual(ProviderInformationType provider) {
        this.provider = provider;
    }

    /**
     * Gets the value of the field <code>provider</code>.
     *
     * @return the provider
     */
    public ProviderInformationType getProvider() {
        return provider;
    }
}
