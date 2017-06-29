package gov.medicaid.features.enrollment.steps;

import net.thucydides.core.annotations.Step;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Date;

/**
 * Some libraries to help with enrollment tests
 */
public class EnrollmentSteps {

    // Keys to all of the fields on the organizational information page
    public enum OrganizationalInformation {
        NPI,
        EFFECTIVE_DATE
    }

    // Formats a string so it can be typed into a data field
    private SimpleDateFormat dateFieldFormat = new SimpleDateFormat("MMDDYYYY");


    @Step
    public Map<OrganizationalInformation, String> generateTestData(){
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(new Date());
        cal.add(Calendar.DAY_OF_MONTH, -2);

        Map<OrganizationalInformation, String> result = new HashMap<>();
        result.put(OrganizationalInformation.NPI, "1234567893");
        result.put(OrganizationalInformation.EFFECTIVE_DATE,
            dateFieldFormat.format(cal.getTime()));
        return result;
    }
}
