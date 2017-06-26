package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents services allowed for the given provider.
 */
public class ProviderCategoryOfService extends IdentifiableEntity {

    private List<CategoryOfService> categories;

    private long profileId;
    private long ticketId;
    private Date startDate;
    private Date endDate;

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
