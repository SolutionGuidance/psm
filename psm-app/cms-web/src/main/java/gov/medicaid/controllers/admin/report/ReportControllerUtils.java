package gov.medicaid.controllers.admin.report;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ReportControllerUtils {
    public static String buildCsvName(String baseName) {
        return baseName + "_" +
            LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-hhmm")) +
            ".csv";
    }
}
