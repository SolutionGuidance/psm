package gov.medicaid.process.application;

import gov.medicaid.entities.DmfAutomaticScreeningMatch;

public class DmfResult {
    private boolean dmfRecordPresent;
    private String fullName;
    private String ssn;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public boolean getDmfRecordPresent() {
        return dmfRecordPresent;
    }

    public void setDmfRecordPresent(boolean dmfRecordPresent) {
        this.dmfRecordPresent = dmfRecordPresent;
    }

    public DmfAutomaticScreeningMatch toMatch() {
        DmfAutomaticScreeningMatch match = new DmfAutomaticScreeningMatch();

        match.setResult(dmfRecordPresent ? "Y" : "N");
        match.setName(fullName);
        match.setSsn(ssn);

        return match;
    }
}
