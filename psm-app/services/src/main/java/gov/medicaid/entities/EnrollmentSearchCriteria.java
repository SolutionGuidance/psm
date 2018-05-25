package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

public class EnrollmentSearchCriteria extends SearchCriteria {
    private Date createDateStart;
    private Date createDateEnd;
    private List<String> providerTypes;

    public EnrollmentSearchCriteria() {
    }

    public Date getCreateDateStart() {
        return createDateStart;
    }

    public void setCreateDateStart(Date createDateStart) {
        this.createDateStart = createDateStart;
    }

    public Date getCreateDateEnd() {
        return createDateEnd;
    }

    public void setCreateDateEnd(Date createDateEnd) {
        this.createDateEnd = createDateEnd;
    }

    public List<String> getProviderTypes() {
        return providerTypes;
    }

    public void setProviderTypes(List<String> providerTypes) {
        this.providerTypes = providerTypes;
    }
}
