package gov.medicaid.controllers.admin.report;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.function.Function;

import gov.medicaid.entities.Enrollment;

public class ReportControllerUtils {
    public static String buildCsvName(String baseName) {
        return baseName + "_" +
            LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-hhmm")) +
            ".csv";
    }

    public static LocalDate toLocalDate(Date d) {
        return toLocalDateTime(d).toLocalDate();
    }

    public static LocalDateTime toLocalDateTime(Date d) {
        return LocalDateTime.ofInstant(d.toInstant(), ZoneId.systemDefault());
    }

    public interface EnrollmentInMonthPredicate {
        boolean test(Enrollment e, LocalDate monthStart, LocalDate monthEnd);
    }

    public static List<EnrollmentMonth> groupEnrollments(
        List<Enrollment> enrollments,
        Function<Enrollment, Date> dateFunc,
        EnrollmentInMonthPredicate eimPred
    ) {
        List<EnrollmentMonth> enrollmentMonths = new ArrayList<>();

        if (enrollments.size() > 0) {
            LocalDate earliestDate =
                enrollments.stream().map(e -> toLocalDate(dateFunc.apply(e))).
                    min(Comparator.comparing(LocalDate::toEpochDay)).get();

            LocalDate firstMonth = earliestDate.withDayOfMonth(1);
            LocalDate thisMonth = LocalDate.now().withDayOfMonth(1);

            LocalDate workingMonth = thisMonth;
            while (workingMonth.isAfter(firstMonth.minusDays(1))) {
                EnrollmentMonth em = new EnrollmentMonth(workingMonth);
                enrollmentMonths.add(em);

                for (Enrollment enrollment : enrollments) {
                    em.addEnrollment(enrollment, eimPred);
                }

                workingMonth = workingMonth.minusMonths(1);
            }
        }
        return enrollmentMonths;
    }

    /**
     * Helper class for arranging the Enrollments into months.
     */
    public static class EnrollmentMonth {
        private LocalDate month;
        List<Enrollment> enrollments;

        public EnrollmentMonth(LocalDate month) {
          this.month = month;
          enrollments = new ArrayList<>();
        }

        public void addEnrollment(Enrollment enrollment, EnrollmentInMonthPredicate pred) {
          LocalDate nextMonth = month.plusMonths(1);

          if (pred.test(enrollment, month, nextMonth.minusDays(1))) {
              enrollments.add(enrollment);
          }
        }

        public LocalDate getMonth() {
          return month;
        }

        public List<Enrollment> getEnrollments() {
          return enrollments;
        }
    }
}
