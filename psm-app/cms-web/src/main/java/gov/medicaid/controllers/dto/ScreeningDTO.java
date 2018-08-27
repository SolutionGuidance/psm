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
    public long enrollmentId;
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

    public long getEnrollmentId() {
        return enrollmentId;
    }

    public long getScreeningId() {
        return screeningId;
    }

}
