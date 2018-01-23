/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
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
import javax.persistence.Table;

/**
 * Represents a help item.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */

@javax.persistence.Entity
@Table(name = "help_items")
public class HelpItem {

    @Id
    @GeneratedValue(
        strategy = GenerationType.AUTO
    )
    @Column(name = "help_item_id")
    private long id;

    /**
     * The title.
     */
    private String title;

    /**
     * The description.
     */
    private String description;

    /**
     * Default empty constructor.
     */
    public HelpItem() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    /**
     * Gets the value of the field <code>title</code>.
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the value of the field <code>title</code>.
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the value of the field <code>description</code>.
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
