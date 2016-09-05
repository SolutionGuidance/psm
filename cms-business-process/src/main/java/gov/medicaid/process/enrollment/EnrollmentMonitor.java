/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;

import org.drools.event.process.ProcessCompletedEvent;
import org.drools.event.process.ProcessEventListener;
import org.drools.event.process.ProcessNodeLeftEvent;
import org.drools.event.process.ProcessNodeTriggeredEvent;
import org.drools.event.process.ProcessStartedEvent;
import org.drools.event.process.ProcessVariableChangedEvent;
import org.drools.runtime.process.NodeInstance;

/**
 * This tracks the progress of the enrollment process.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class EnrollmentMonitor implements ProcessEventListener {

    /**
     * Called when a node is started.
     *
     * @param event the event trigger.
     */
    public void beforeNodeTriggered(ProcessNodeTriggeredEvent event) {
        NodeInstance node = event.getNodeInstance();
        EnrollmentProcess model = (EnrollmentProcess) node.getVariable("model");
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
        EnrollmentProcess model = (EnrollmentProcess) node.getVariable("model");
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
