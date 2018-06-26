package gov.medicaid.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "leie_automatic_screenings")
public class LeieAutomaticScreening extends AutomaticScreening {
    @Column(
            name = "npi_search_term",
            nullable = false
    )
    private String npiSearchTerm;

    @OneToMany(
            mappedBy = "leieAutomaticScreening",
            cascade = CascadeType.ALL,
            fetch = FetchType.EAGER
    )
    private Set<LeieAutomaticScreeningMatch> matches = new LinkedHashSet<>();

    public String getNpiSearchTerm() {
        return npiSearchTerm;
    }

    public void setNpiSearchTerm(String npiSearchTerm) {
        this.npiSearchTerm = npiSearchTerm;
    }

    public Set<LeieAutomaticScreeningMatch> getMatches() {
        return matches;
    }

    public void setMatches(Set<LeieAutomaticScreeningMatch> matches) {
        this.matches = matches;
    }

    public void addMatch(LeieAutomaticScreeningMatch match) {
        match.setLeieAutomaticScreening(this);
        matches.add(match);
    }
}
