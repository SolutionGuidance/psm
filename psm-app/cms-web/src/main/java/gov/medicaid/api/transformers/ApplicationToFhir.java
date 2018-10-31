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

package gov.medicaid.api.transformers;

import gov.medicaid.entities.Application;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.Reference;
import org.hl7.fhir.dstu3.model.Task;
import java.util.function.Function;

public class ApplicationToFhir implements Function<Application, Task> {
    @Override
    public Task apply(Application application) {
        DomainResource requester = new ProviderProfileToFhir().apply(
                application.getDetails()
        );

        Task task = new Task();
        task.setId(Long.toString(application.getApplicationId()));
        task.setStatus(
                new ApplicationStatusToFhir().apply(application.getStatus())
        );
        task.setIntent(Task.TaskIntent.PROPOSAL);
        task.setRequester(new Task.TaskRequesterComponent(new Reference(requester)));
        task.addInput(
                new ProviderTypeToFhir().apply(
                        application.getDetails().getEntity().getProviderType()
                )
        );

        task.addInput(
                new ApplicationAcceptsEftToFhir().apply(application)
        );

        task.addContained(requester);

        return task;
    }
}
