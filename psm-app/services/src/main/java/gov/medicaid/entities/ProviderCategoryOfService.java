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

    @Column(name = "application_id")
    private long applicationId;

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

    public long getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(long applicationId) {
        this.applicationId = applicationId;
    }
}
