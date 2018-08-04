/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.ProviderInformationType;

/**
 * This class is used by the rules to differentiate individual from organizational requests.
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
