package gov.medicaid.entities;

/**
 * Represents services allowed for the given provider.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderService extends IdentifiableEntity {

    private ServiceCategory category;

    private long profileId;

    private long ticketId;

    public ProviderService() {
    }

    /**
     * Gets the value of the field <code>category</code>.
     * @return the category
     */
    public ServiceCategory getCategory() {
        return category;
    }

    /**
     * Sets the value of the field <code>category</code>.
     * @param category the category to set
     */
    public void setCategory(ServiceCategory category) {
        this.category = category;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }
}
