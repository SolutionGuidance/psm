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
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@javax.persistence.Entity
@Table(name = "external_profile_links")
public class ExternalProfileLink implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "external_profile_link_id")
    private long id;

    @Column(name = "profile_id")
    private long profileId;

    @Enumerated(EnumType.STRING)
    @Column(name = "system_id")
    private SystemId systemId;

    @Column(name = "external_profile_id")
    private String externalProfileId;

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

    public SystemId getSystemId() {
        return systemId;
    }

    public void setSystemId(SystemId systemId) {
        this.systemId = systemId;
    }

    public String getExternalProfileId() {
        return externalProfileId;
    }

    public void setExternalProfileId(String externalProfileId) {
        this.externalProfileId = externalProfileId;
    }
}
