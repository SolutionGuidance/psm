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

import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class ApplicationStatusToPsmName implements Function<String, String> {
    private static final String INVALID_STATUS_CODE_MESSAGE =
            "Invalid task status code. Must be one of 'draft'," +
            " 'requested', 'rejected', or 'accepted'.";

    @Override
    public String apply(String s) {
        if (Task.TaskStatus.DRAFT.toCode().equalsIgnoreCase(s)) {
            return "Draft";
        } else if (Task.TaskStatus.REQUESTED.toCode().equalsIgnoreCase(s)) {
            return "Pending";
        } else if (Task.TaskStatus.REJECTED.toCode().equalsIgnoreCase(s)) {
            return "Rejected";
        } else if (Task.TaskStatus.ACCEPTED.toCode().equalsIgnoreCase(s)) {
            return "Approved";
        } else {
            throw new InvalidRequestException(INVALID_STATUS_CODE_MESSAGE);
        }
    }
}
