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

import gov.medicaid.entities.Enrollment;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.Reference;
import org.hl7.fhir.dstu3.model.Task;
import java.util.function.Function;

public class EnrollmentToFhir implements Function<Enrollment, Task> {
    @Override
    public Task apply(Enrollment enrollment) {
        DomainResource requester = new ProviderProfileToFhir().apply(
                enrollment.getDetails()
        );

        Task task = new Task();
        task.setId(Long.toString(enrollment.getEnrollmentId()));
        task.setStatus(
                new EnrollmentStatusToFhir().apply(enrollment.getStatus())
        );
        task.setIntent(Task.TaskIntent.PROPOSAL);
        task.setRequester(new Task.TaskRequesterComponent(new Reference(requester)));
        task.addInput(
                new ProviderTypeToFhir().apply(
                        enrollment.getDetails().getEntity().getProviderType()
                )
        );

        task.addInput(
                new EnrollmentAcceptsEftToFhir().apply(enrollment)
        );

        task.addContained(requester);

        return task;
    }
}
