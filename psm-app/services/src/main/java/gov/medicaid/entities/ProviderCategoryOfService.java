package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Represents services allowed for the given provider.
 */
@javax.persistence.Entity
@Table(name = "provider_category_of_service_approvals")
@NamedEntityGraph(
        name = "ProviderCategoryOfService with categories",
        attributeNodes = {@NamedAttributeNode("categories")}
)
public class ProviderCategoryOfService implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "provider_category_of_service_approval_id")
    private long id;

    @ManyToMany
    @JoinTable(
            name = "provider_approved_categories_of_service",
            joinColumns = @JoinColumn(
                    name = "provider_category_of_service_approval_id"
            ),
            inverseJoinColumns = @JoinColumn(
                    name = "category_of_service_code"
            )
    )
    private List<CategoryOfService> categories;

    @Column(name = "profile_id")
    private long profileId;

    @Column(name = "ticket_id")
    private long ticketId;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public List<CategoryOfService> getCategories() {
        return categories;
    }

    public void setCategories(List<CategoryOfService> categories) {
        this.categories = categories;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }
}
