package gov.medicaid.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "leie_automatic_screenings")
@NamedEntityGraph(
        name = "Screening with matches",
        attributeNodes = {@NamedAttributeNode("matches")}
)
public class LeieAutomaticScreening extends AutomaticScreening {
    @Column(
            name = "npi_search_term",
            nullable = false
    )
    private String npiSearchTerm;

    @OneToMany(
            mappedBy = "leieAutomaticScreening",
            cascade = CascadeType.ALL
    )
    private List<LeieAutomaticScreeningMatch> matches = new ArrayList<>();

    public String getNpiSearchTerm() {
        return npiSearchTerm;
    }

    public void setNpiSearchTerm(String npiSearchTerm) {
        this.npiSearchTerm = npiSearchTerm;
    }

    public List<LeieAutomaticScreeningMatch> getMatches() {
        return matches;
    }

    public void setMatches(List<LeieAutomaticScreeningMatch> matches) {
        this.matches = matches;
    }

    public void addMatch(LeieAutomaticScreeningMatch match) {
        match.setLeieAutomaticScreening(this);
        matches.add(match);
    }
}
