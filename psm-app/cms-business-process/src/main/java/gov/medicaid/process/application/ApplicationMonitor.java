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

package gov.medicaid.process.application;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;

import org.drools.event.process.ProcessCompletedEvent;
import org.drools.event.process.ProcessEventListener;
import org.drools.event.process.ProcessNodeLeftEvent;
import org.drools.event.process.ProcessNodeTriggeredEvent;
import org.drools.event.process.ProcessStartedEvent;
import org.drools.event.process.ProcessVariableChangedEvent;
import org.drools.runtime.process.NodeInstance;

/**
 * This tracks the progress of the application process.
 */
public class ApplicationMonitor implements ProcessEventListener {

    /**
     * Called when a node is started.
     *
     * @param event the event trigger.
     */
    public void beforeNodeTriggered(ProcessNodeTriggeredEvent event) {
        NodeInstance node = event.getNodeInstance();
        ApplicationProcess model = (ApplicationProcess) node.getVariable("model");
        XMLUtility.auditStart(model, node.getId(), node.getNodeName());
    }

    /**
     * Called when a node is completed. Note that this will only be called if the node is not sequential (start time is
     * the end time of the previous node)
     *
     * @param event the event trigger.
     */
    public void afterNodeLeft(ProcessNodeLeftEvent event) {
        NodeInstance node = event.getNodeInstance();
        ApplicationProcess model = (ApplicationProcess) node.getVariable("model");
        XMLUtility.auditEnd(model, node.getId());
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void beforeProcessStarted(ProcessStartedEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void afterProcessStarted(ProcessStartedEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void beforeProcessCompleted(ProcessCompletedEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void afterProcessCompleted(ProcessCompletedEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void afterNodeTriggered(ProcessNodeTriggeredEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void beforeNodeLeft(ProcessNodeLeftEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void beforeVariableChanged(ProcessVariableChangedEvent event) {
    }

    /**
     * Not implemented.
     * @param event not used
     */
    public void afterVariableChanged(ProcessVariableChangedEvent event) {
    }
}
