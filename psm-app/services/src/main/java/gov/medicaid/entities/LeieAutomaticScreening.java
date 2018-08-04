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

    public String getType() {
        return "LEIE";
    }
}
