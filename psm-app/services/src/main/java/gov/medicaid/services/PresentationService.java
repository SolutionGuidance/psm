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

package gov.medicaid.services;

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.ViewModel;

import java.util.List;

/**
 * Defines the UI related services.
 */
public interface PresentationService {

    /**
     * Retrieves the presentation model to be used for the given provider. This is shared between the screen and some
     * other views like exporting providers.
     *
     * @param provider the provider to determine how to display
     * @return the model having some instructions on how to present the given provider
     */
    ViewModel getProviderViewModel(ProviderProfile provider);

    /**
     * Retrieves the presentation model to be used for the given provider. This is shared between the screen and some
     * other views like exporting providers.
     *
     * @param provider the provider to determine how to display
     * @return the model having some instructions on how to present the given provider
     */
    ViewModel getProviderViewModel(ProviderInformationType provider);

    /**
     * This calls the business rules to validation the given application. It is used by the frontend whenever validation
     * is needed. It can be used to validate the entire request or a subset of views.
     *
     * @param application the application to be validated.
     * @param tabs the tabs to validate, if null or empty, the entire application is checked
     * @return the set of error messages found, empty if the application is valid
     */
    ValidationResponse checkForErrors(ApplicationType applicationType, List<String> tabs);
}
