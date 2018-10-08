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
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import java.time.LocalDateTime;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "automatic_screenings")
public abstract class AutomaticScreening implements java.io.Serializable {
    public enum Result {
        PASS,
        FAIL,
        ERROR
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "automatic_screening_id")
    private long automaticScreeningId;

    @ManyToOne
    @JoinColumn(
            name = "application_id",
            nullable = false
    )
    private Application application;

    @Column(
            name = "created_at",
            nullable = false
    )
    private LocalDateTime createdAt = LocalDateTime.now();

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Result result;

    @Column(name = "manual_confirmation")
    private Boolean manualConfirmation;

    public long getAutomaticScreeningId() {
        return automaticScreeningId;
    }

    public void setAutomaticScreeningId(long automaticScreeningId) {
        this.automaticScreeningId = automaticScreeningId;
    }

    public Application getApplication() {
        return application;
    }

    public void setApplication(Application application) {
        this.application = application;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public Boolean getManualConfirmation() {
        return manualConfirmation;
    }

    public void setManualConfirmation(Boolean manualConfirmation) {
        this.manualConfirmation = manualConfirmation;
    }

    public abstract String getType();
}
