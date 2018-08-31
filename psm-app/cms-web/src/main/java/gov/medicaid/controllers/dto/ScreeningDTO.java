package gov.medicaid.controllers.dto;

import gov.medicaid.entities.AutomaticScreening;

import java.time.LocalDateTime;

public class ScreeningDTO {
    public LocalDateTime date;
    public String npi;
    public String providerName;
    public String providerType;
    public String screeningType;
    public String reason;
    public AutomaticScreening.Result result;

    public LocalDateTime getDate() {
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
}
