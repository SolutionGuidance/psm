package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Represents services allowed for the given provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */

@javax.persistence.Entity
@Table(name = "provider_services")
public class ProviderService implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "provider_service_id")
    private long id;

    @ManyToOne
    @JoinColumn(name = "service_category_code")
    private ServiceCategory category;

    @Column(name = "profile_id", nullable = false)
    private long profileId = 0;

    public ServiceCategory getCategory() {
        return category;
    }

    public void setCategory(ServiceCategory category) {
        this.category = category;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
