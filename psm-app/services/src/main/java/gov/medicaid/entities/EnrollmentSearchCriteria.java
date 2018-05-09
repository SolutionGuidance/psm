package gov.medicaid.entities;

import java.util.Date;

public class EnrollmentSearchCriteria extends SearchCriteria {
    private Date createDateStart;
    private Date createDateEnd;

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
}
