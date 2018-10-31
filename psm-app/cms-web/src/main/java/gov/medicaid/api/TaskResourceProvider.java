/*
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

package gov.medicaid.api;

import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.OptionalParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.annotation.Search;
import ca.uhn.fhir.rest.param.StringOrListParam;
import ca.uhn.fhir.rest.param.StringParam;
import ca.uhn.fhir.rest.server.IResourceProvider;
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;

import gov.medicaid.api.transformers.ApplicationStatusToPsmName;
import gov.medicaid.api.transformers.ApplicationToFhir;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;

import org.hl7.fhir.dstu3.model.IdType;
import org.hl7.fhir.dstu3.model.Task;
import org.hl7.fhir.instance.model.api.IBaseResource;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class TaskResourceProvider implements IResourceProvider {
    private final ProviderApplicationService providerApplicationService;
    private final CMSUser systemUser;

    TaskResourceProvider(ProviderApplicationService providerApplicationService) {
        this.providerApplicationService = providerApplicationService;
        systemUser = new CMSConfigurator().getSystemUser();
    }

    @Override
    public Class<? extends IBaseResource> getResourceType() {
        return Task.class;
    }

    @Read
    public Task getResourceById(@IdParam IdType id) {
        return applicationIdToTask(id.getIdPartAsLong());
    }

    @Search
    public List<Task> search(
            @OptionalParam(name = "npi") String npi,
            @OptionalParam(name = "status") StringOrListParam statuses,
            @OptionalParam(name = "providerType") String providerType,
            @OptionalParam(name = "name") String name
    ) {
        validateNpi(npi);

        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setNpi(npi);
        criteria.setStatuses(fhirStatusesToPsmStatusList(statuses));
        criteria.setProviderType(providerType);
        criteria.setProviderName(name);

        SearchResult<UserRequest> results = providerApplicationService.searchApplications(
                systemUser,
                criteria
        );

        return results.getItems()
                .stream()
                .map(result -> applicationIdToTask(result.getApplicationId()))
                .collect(Collectors.toList());
    }

    private void validateNpi(String npi) {
        if (npi == null) {
            return;
        }
        if (npi.matches("[0-9]{10}")) {
            return;
        }

        throw new InvalidRequestException(
                "An NPI must be 10 digits."
        );
    }

    private List<String> fhirStatusesToPsmStatusList(StringOrListParam listParam) {
        if (listParam == null) {
            return null;
        } else {
            return listParam.getValuesAsQueryTokens()
                    .stream()
                    .map(StringParam::getValue)
                    .map(new ApplicationStatusToPsmName())
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        }
    }

    private Task applicationIdToTask(long applicationId) {
        Application application;
        try {
            application = providerApplicationService.getApplicationDetails(
                    systemUser,
                    applicationId
            );
        } catch (PortalServiceException e) {
            return null;
        }
        if (application == null) {
            return null;
        }

        return new ApplicationToFhir().apply(application);
    }
}
