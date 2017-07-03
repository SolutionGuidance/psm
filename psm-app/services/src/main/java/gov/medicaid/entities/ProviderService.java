package gov.medicaid.entities;

/**
 * Represents services allowed for the given provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */

import javax.persistence.*;
import java.io.Serializable;

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

    @Column(name = "ticket_id", nullable = false)
    private long ticketId = 0;

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

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
