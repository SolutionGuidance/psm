/*
 * Copyright 2012, 2013 TopCoder, Inc.
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
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Represents a user entity.
 */
@javax.persistence.Entity
@Table(name = "cms_authentication")
public class Authentication implements Serializable {
    @Id
    private String username;

    /**
     * The hashed password.
     */
    @Column(nullable = false)
    private String password;

    /**
     * Creates a new instance.
     */
    public Authentication() {
    }

    /**
     * Gets the value of the field <code>username</code>.
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the value of the field <code>username</code>.
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the value of the field <code>password</code>.
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the value of the field <code>password</code>.
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
}
