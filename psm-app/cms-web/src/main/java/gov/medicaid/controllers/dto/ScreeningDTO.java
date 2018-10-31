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

package gov.medicaid.controllers.dto;

import gov.medicaid.entities.AutomaticScreening;
import java.util.Date;

public class ScreeningDTO {
    public Date date;
    public String npi;
    public String providerName;
    public String providerType;
    public String screeningType;
    public String reason;
    public AutomaticScreening.Result result;
    public long applicationId;
    public long screeningId;

    public Date getDate() {
        return date;
    }

    public String getNpi() {
        return npi;
    }

    public String getProviderName() {
        return providerName;
    }

    public String getProviderType() {
        return providerType;
    }

    public String getScreeningType() {
        return screeningType;
    }

    public String getReason() {
        return reason;
    }

    public AutomaticScreening.Result getResult() {
        return result;
    }

    public long getApplicationId() {
        return applicationId;
    }

    public long getScreeningId() {
        return screeningId;
    }

}
