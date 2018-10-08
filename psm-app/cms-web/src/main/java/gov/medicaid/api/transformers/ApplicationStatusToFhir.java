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

import gov.medicaid.entities.EnrollmentStatus;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class EnrollmentStatusToFhir
        implements Function<EnrollmentStatus, Task.TaskStatus> {
    @Override
    public Task.TaskStatus apply(EnrollmentStatus enrollmentStatus) {
        if (enrollmentStatus == null) {
            return Task.TaskStatus.NULL;
        }

        if ("Draft".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.DRAFT;
        } else if ("Pending".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.REQUESTED;
        } else if ("Rejected".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.REJECTED;
        } else if ("Approved".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.ACCEPTED;
        } else {
            return Task.TaskStatus.NULL;
        }
    }
}
