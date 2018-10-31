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

package gov.medicaid.controllers.admin.report;

import gov.medicaid.entities.Application;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.function.Function;

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

    public interface ApplicationInMonthPredicate {
        boolean test(Application e, LocalDate monthStart, LocalDate monthEnd);
    }

    public static List<ApplicationMonth> groupApplications(
        List<Application> applications,
        Function<Application, Date> dateFunc,
        ApplicationInMonthPredicate eimPred
    ) {
        List<ApplicationMonth> applicationMonths = new ArrayList<>();

        if (applications.size() > 0) {
            LocalDate earliestDate =
                applications.stream()
                    .map(e -> toLocalDate(dateFunc.apply(e)))
                    .min(Comparator.comparing(LocalDate::toEpochDay)).get();

            LocalDate firstMonth = earliestDate.withDayOfMonth(1);
            LocalDate thisMonth = LocalDate.now().withDayOfMonth(1);

            LocalDate workingMonth = thisMonth;
            while (workingMonth.isAfter(firstMonth.minusDays(1))) {
                ApplicationMonth em = new ApplicationMonth(workingMonth);
                applicationMonths.add(em);

                for (Application application : applications) {
                    em.addApplication(application, eimPred);
                }

                workingMonth = workingMonth.minusMonths(1);
            }
        }
        return applicationMonths;
    }

    /**
     * Helper class for arranging the Applications into months.
     */
    public static class ApplicationMonth {
        private LocalDate month;
        List<Application> applications;

        public ApplicationMonth(LocalDate month) {
            this.month = month;
            applications = new ArrayList<>();
        }

        public void addApplication(Application application, ApplicationInMonthPredicate pred) {
            LocalDate nextMonth = month.plusMonths(1);

            if (pred.test(application, month, nextMonth.minusDays(1))) {
                applications.add(application);
            }
        }

        public LocalDate getMonth() {
            return month;
        }

        public List<Application> getApplications() {
            return applications;
        }
    }
}
