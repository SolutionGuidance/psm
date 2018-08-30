package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "dmf_automatic_screening_matches")
public class DmfAutomaticScreeningMatch {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "dmf_automatic_screening_match_id")
    private long id;

    @ManyToOne
    @JoinColumn(
            name = "dmf_automatic_screening_id",
            nullable = false
    )
    private DmfAutomaticScreening dmfAutomaticScreening;

    @Column(nullable = false)
    private String result;

    private String name;

    @Column(nullable = false)
    private String ssn;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public DmfAutomaticScreening getDmfAutomaticScreening() {
        return dmfAutomaticScreening;
    }

    public void setDmfAutomaticScreening(DmfAutomaticScreening dmfAutomaticScreening) {
        this.dmfAutomaticScreening = dmfAutomaticScreening;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
