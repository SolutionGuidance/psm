package gov.medicaid.entities;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "dmf_automatic_screenings")
public class DmfAutomaticScreening extends AutomaticScreening {
    @OneToMany(
            mappedBy = "dmfAutomaticScreening",
            cascade = CascadeType.ALL,
            fetch = FetchType.EAGER
    )
    private Set<DmfAutomaticScreeningMatch> dmfMatches = new LinkedHashSet<>();

    public Set<DmfAutomaticScreeningMatch> getMatches() {
        return dmfMatches;
    }

    public void setMatches(Set<DmfAutomaticScreeningMatch> dmfMatches) {
        this.dmfMatches = dmfMatches;
    }

    public void addMatch(DmfAutomaticScreeningMatch match) {
        match.setDmfAutomaticScreening(this);
        dmfMatches.add(match);
    }

    public String getType() {
        return "DMF";
    }
}
