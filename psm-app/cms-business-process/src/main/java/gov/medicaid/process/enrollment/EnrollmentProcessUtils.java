package gov.medicaid.process.enrollment;

import gov.medicaid.domain.model.EnrollmentProcess;
import org.jbpm.task.AccessType;
import org.jbpm.task.Content;
import org.jbpm.task.Task;
import org.jbpm.task.service.ContentData;
import org.jbpm.task.service.local.LocalTaskService;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * Enrollment process support methods
 */
public class EnrollmentProcessUtils {
    private EnrollmentProcessUtils() {
    }

    /**
     * Retrieves the current model.
     *
     * @param localTaskService the client to be used
     * @param taskId           the task id associated
     * @return the process model for the waiting task
     */
    @SuppressWarnings("unchecked")
    public static EnrollmentProcess getEnrollmentForReview(
        LocalTaskService localTaskService,
        long taskId
    ) throws IOException, ClassNotFoundException {
        Task task = localTaskService.getTask(taskId);
        Content content = localTaskService.getContent(
            task.getTaskData().getDocumentContentId());
        ByteArrayInputStream bis = new ByteArrayInputStream(content.getContent());
        ObjectInputStream in = new ObjectInputStream(bis);
        Map<String, Object> taskModel = (Map<String, Object>) in.readObject();
        in.close();
        return (EnrollmentProcess) taskModel.get("ProcessModel");
    }

    /**
     * Converts the process model to the output content data.
     *
     * @param enrollmentProcess the process model
     * @return the content data model
     * @throws IOException if the objects cannot be written.
     */
    public static ContentData marshalEnrollmentProcess(
        EnrollmentProcess enrollmentProcess,
        String isAbort
    ) throws IOException {
        Map<String, Object> data = new HashMap<>();
        data.put("model", enrollmentProcess);
        data.put("isAbort", isAbort);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(bos);
        out.writeObject(data);
        out.close();
        ContentData contentData = new ContentData();
        contentData.setContent(bos.toByteArray());
        contentData.setAccessType(AccessType.Inline);
        return contentData;
    }
}
