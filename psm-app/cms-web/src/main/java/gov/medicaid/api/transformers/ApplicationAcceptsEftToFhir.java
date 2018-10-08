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

import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;

import org.hl7.fhir.dstu3.model.BooleanType;
import org.hl7.fhir.dstu3.model.CodeableConcept;
import org.hl7.fhir.dstu3.model.Task;

import java.util.List;
import java.util.function.Function;

public class ApplicationAcceptsEftToFhir
        implements Function<Application, Task.ParameterComponent> {
    @Override
    public Task.ParameterComponent apply(Application application) {
        boolean isEftAccepted = isEftAccepted(application);
        return new Task.ParameterComponent(
                new CodeableConcept().setText("Accepts EFT"),
                new BooleanType(isEftAccepted)
        );
    }

    // If any primary affiliations accept EFT, this application is considered
    // to accept EFT.
    private boolean isEftAccepted(Application application) {
        List<Affiliation> affiliations = application.getDetails().getAffiliations();
        if (affiliations != null) {
            for (Affiliation affiliation : affiliations) {
                if ("Y".equals(affiliation.getPrimaryInd())) {
                    Entity entity = affiliation.getEntity();
                    if (entity instanceof Organization) {
                        if (Boolean.TRUE.equals(
                                ((Organization) entity).isEftAccepted())) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
}
