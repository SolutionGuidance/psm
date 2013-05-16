/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemHandler;
import org.drools.runtime.process.WorkItemManager;

/**
 * This is a generic handler for BPMN work items.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class GenericHandler implements WorkItemHandler {

    /**
     * Aborts the work item.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void abortWorkItem(WorkItem item, WorkItemManager manager) {
        System.err.println("ABORTING WORK ITEM: " + item.getProcessInstanceId());
        manager.abortWorkItem(item.getId());
    }
}