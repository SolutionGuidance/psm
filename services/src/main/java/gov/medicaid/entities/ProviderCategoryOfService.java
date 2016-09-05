package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents services allowed for the given provider.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderCategoryOfService extends IdentifiableEntity {

    private List<CategoryOfService> categories;

    private long profileId;
    private Date startDate;
    private Date endDate;

    public ProviderCategoryOfService() {
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * 
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     * 
     * @param profileId
     *            the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the <code>categories</code>.
     * 
     * @return the categories
     */
    public List<CategoryOfService> getCategories() {
        return categories;
    }

    /**
     * Sets the <code>categories</code>.
     * 
     * @param categories
     *            the categories to set
     */
    public void setCategories(List<CategoryOfService> categories) {
        this.categories = categories;
    }

    /**
     * Gets the <code>startDate</code>.
     * 
     * @return the startDate
     */
    public Date getStartDate() {
        return startDate;
    }

    /**
     * Sets the <code>startDate</code>.
     * 
     * @param startDate
     *            the startDate to set
     */
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    /**
     * Gets the <code>endDate</code>.
     * 
     * @return the endDate
     */
    public Date getEndDate() {
        return endDate;
    }

    /**
     * Sets the <code>endDate</code>.
     * 
     * @param endDate
     *            the endDate to set
     */
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
