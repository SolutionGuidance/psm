/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.process.enrollment.GenericHandler;
import org.drools.runtime.KnowledgeRuntime;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;
import org.jbpm.eventmessaging.EventResponseHandler;
import org.jbpm.eventmessaging.Payload;
import org.jbpm.process.workitem.wsht.HumanTaskHandlerHelper;
import org.jbpm.task.AccessType;
import org.jbpm.task.Content;
import org.jbpm.task.Group;
import org.jbpm.task.I18NText;
import org.jbpm.task.OrganizationalEntity;
import org.jbpm.task.PeopleAssignments;
import org.jbpm.task.Status;
import org.jbpm.task.Task;
import org.jbpm.task.TaskData;
import org.jbpm.task.User;
import org.jbpm.task.event.TaskEventKey;
import org.jbpm.task.event.entity.TaskCompletedEvent;
import org.jbpm.task.event.entity.TaskEvent;
import org.jbpm.task.event.entity.TaskFailedEvent;
import org.jbpm.task.event.entity.TaskSkippedEvent;
import org.jbpm.task.service.ContentData;
import org.jbpm.task.service.local.LocalTaskService;
import org.jbpm.task.service.responsehandlers.AbstractBaseResponseHandler;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This is a port of org.jbpm.process.workitem.wsht.CommandBasedWSHumanTaskHandler to use local connections.
 * 
 * See https://community.jboss.org/thread/201834
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class LocalHumanTaskHandler extends GenericHandler {

    /**
     * For backward compatibility to <code>org.jbpm.process.workitem.wsht.CommandBasedWSHumanTaskHandler</code>
     */
    public static final String LOCALE_DEFAULT = "en-UK";

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(LocalHumanTaskHandler.class.getName());

    /**
     * Associated session.
     */
    private KnowledgeRuntime session;

    /**
     * The local task service.
     */
    private LocalTaskService service;

    /**
     * Creates a new instance using the given session and service.
     * 
     * @param session the knowledge session
     * @param service the task service
     */
    public LocalHumanTaskHandler(KnowledgeRuntime session, LocalTaskService service) {
        this.session = session;
        this.service = service;
        registerTaskEventHandlers();
    }

    /**
     * Registers the event handlers to make sure we get notified.
     */
    private void registerTaskEventHandlers() {
        TaskEventKey key = new TaskEventKey(TaskCompletedEvent.class, -1);
        TaskCompletedHandler eventResponseHandler = new TaskCompletedHandler();
        service.registerForEvent(key, false, eventResponseHandler);
        key = new TaskEventKey(TaskFailedEvent.class, -1);
        service.registerForEvent(key, false, eventResponseHandler);
        key = new TaskEventKey(TaskSkippedEvent.class, -1);
        service.registerForEvent(key, false, eventResponseHandler);
    }

    /**
     * Executes the human task. Maps the work item to the Task table and persists it.
     * 
     * @param workItem the task work item
     * @param manager the work item manager.
     */
    public void executeWorkItem(WorkItem workItem, WorkItemManager manager) {
        Task task = new Task();
        String taskName = (String) workItem.getParameter("TaskName");
        if (taskName != null) {
            List<I18NText> names = new ArrayList<I18NText>();
            names.add(new I18NText(LOCALE_DEFAULT, taskName));
            task.setNames(names);
        }
        
        // set default values
        List<I18NText> empty = new ArrayList<I18NText>();
        empty.add(new I18NText(LOCALE_DEFAULT, ""));
        task.setDescriptions(new ArrayList<I18NText>(empty));
        task.setSubjects(new ArrayList<I18NText>(empty));
        task.setPriority(0);

        TaskData taskData = new TaskData();
        taskData.setWorkItemId(workItem.getId());
        taskData.setProcessInstanceId(workItem.getProcessInstanceId());
        if (session != null && session.getProcessInstance(workItem.getProcessInstanceId()) != null) {
            taskData.setProcessId(session.getProcessInstance(workItem.getProcessInstanceId()).getProcess().getId());
        }
        if (session != null && (session instanceof StatefulKnowledgeSession)) {
            taskData.setProcessSessionId(((StatefulKnowledgeSession) session).getId());
        }
        taskData.setSkipable(false);

        PeopleAssignments assignments = new PeopleAssignments();
        List<OrganizationalEntity> potentialOwners = new ArrayList<OrganizationalEntity>();
        taskData.setCreatedBy(new User("Administrator"));

        // set allowed groups
        String groupId = (String) workItem.getParameter("GroupId");
        if (groupId != null && groupId.trim().length() > 0) {
            String[] groupIds = groupId.split(",");
            for (String id : groupIds) {
                potentialOwners.add(new Group(id.trim()));
            }
        }

        assignments.setPotentialOwners(potentialOwners);
        List<OrganizationalEntity> businessAdministrators = new ArrayList<OrganizationalEntity>();
        businessAdministrators.add(new User("Administrator"));
        assignments.setBusinessAdministrators(businessAdministrators);
        task.setPeopleAssignments(assignments);
        task.setTaskData(taskData);

        ContentData content = saveContent(workItem);
        task.setDeadlines(HumanTaskHandlerHelper.setDeadlines(
                workItem, businessAdministrators, null));
        service.addTask(task, content);
    }

    /**
     * Saves the task content data.
     * @param workItem the current work item
     * @return the content data 
     */
    private ContentData saveContent(WorkItem workItem) {
        ContentData content = null;
        Object contentObject = workItem.getParameter("Content");
        if (contentObject != null) {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream out;
            try {
                out = new ObjectOutputStream(bos);
                out.writeObject(contentObject);
                out.close();
                content = new ContentData();
                content.setContent(bos.toByteArray());
                content.setAccessType(AccessType.Inline);
            } catch (IOException e) {
                logger.log(Level.SEVERE, e.getMessage(), e);
            }
        } else {
            contentObject = workItem.getParameters();
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            ObjectOutputStream out;
            try {
                out = new ObjectOutputStream(bos);
                out.writeObject(contentObject);
                out.close();
                content = new ContentData();
                content.setContent(bos.toByteArray());
                content.setAccessType(AccessType.Inline);
                content.setType("java.util.map");
            } catch (IOException e) {
                logger.log(Level.SEVERE, e.getMessage(), e);
            }
        }
        return content;
    }

    /**
     * Delegates to the local service.
     */
    public void dispose() {
        service.dispose();
    }

    /**
     * Callback for completed human task.
     * 
     * @author TCSASSEMBLER
     * @version 1.0
     */
    private class TaskCompletedHandler extends AbstractBaseResponseHandler implements EventResponseHandler {

        /**
         * Executes the callback logic.
         * 
         * @param payload the work parameters
         */
        @SuppressWarnings("rawtypes")
        public void execute(Payload payload) {
            TaskEvent event = (TaskEvent) payload.get();
            long taskId = event.getTaskId();
            Task task = service.getTask(taskId);
            long workItemId = task.getTaskData().getWorkItemId();
            if (task.getTaskData().getStatus() == Status.Completed) {
                String userId = task.getTaskData().getActualOwner().getId();
                Map<String, Object> results = new HashMap<String, Object>();
                results.put("ActorId", userId);
                long contentId = task.getTaskData().getOutputContentId();
                if (contentId != -1) {
                    Content content = service.getContent(contentId);

                    ByteArrayInputStream bis = new ByteArrayInputStream(content.getContent());
                    ObjectInputStream in;
                    try {
                        in = new ObjectInputStream(bis);
                        Object result = in.readObject();
                        in.close();
                        results.put("Result", result);
                        if (result instanceof Map) {
                            Map<?, ?> map = (Map) result;
                            for (Map.Entry<?, ?> entry : map.entrySet()) {
                                if (entry.getKey() instanceof String) {
                                    results.put((String) entry.getKey(), entry.getValue());
                                }
                            }
                        }
                        
                        if ("Y".equals(results.get("isAbort"))) {
                            session.getWorkItemManager().abortWorkItem(workItemId);
                        } else {
                        	session.getWorkItemManager().completeWorkItem(task.getTaskData().getWorkItemId(), results);
                        }
                    } catch (IOException e) {
                        logger.log(Level.SEVERE, e.getMessage(), e);
                    } catch (ClassNotFoundException e) {
                        logger.log(Level.SEVERE, e.getMessage(), e);
                    }
                } else {
                    session.getWorkItemManager().completeWorkItem(workItemId, results);
                }
            } else {
                session.getWorkItemManager().abortWorkItem(workItemId);
            }
        }

        /**
         * Return false.
         * 
         * @return false
         */
        public boolean isRemove() {
            return false;
        }
    }
}