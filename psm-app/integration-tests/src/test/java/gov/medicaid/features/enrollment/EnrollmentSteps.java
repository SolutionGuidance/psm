package gov.medicaid.features.enrollment;

import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.EnrollmentPage;
import gov.medicaid.features.general.ui.LoginPage;
import net.thucydides.core.annotations.Step;
import org.apache.commons.lang3.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@SuppressWarnings("unused")
public class EnrollmentSteps {
    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    private EnrollmentPage enrollmentPage;

    private SimpleDateFormat formFieldDateFormat = new SimpleDateFormat("MMddyyyy");

    @Step
    public void loginAsProvider(){
        loginPage.open();
        loginPage.enterProviderCredentials();
        loginPage.login();
        loginPage.checkUserLoggedIn("p1");
    }

    public void createEnrollment() {
        dashboardPage.clickOnNewEnrollment();
    }

    public void selectOrganizationalProviderType() {
        enrollmentPage.selectProviderType("Dental Clinic");
        enrollmentPage.clickNext();
    }

    public void selectIndividualProviderType() {
        enrollmentPage.selectProviderType("Podiatrist");
        enrollmentPage.clickNext();
    }

    public void enterOrganizationInfo() {
        enrollmentPage.setNPI("1234567893");
        enrollmentPage.setEffectiveDate(generateEffectiveDate());
        enrollmentPage.setDoingBusinessAs("Test DBA");
        enrollmentPage.setLegalName("Test Name");
        enrollmentPage.setAddr1("123 Test St");
        enrollmentPage.setCity("TestCity");
        enrollmentPage.selectState("Texas");
        enrollmentPage.setZipcode("77706");
        enrollmentPage.selectCounty("Beltrami");
        enrollmentPage.setPhoneNumber("2221113333");
        enrollmentPage.setFEIN("123456789");
    }

    public void enterContactInfo(){
        enrollmentPage.setContactName("Test Contact");
        enrollmentPage.setContactPhone("4445556666");
    }


    public String generateEffectiveDate() {
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(new Date());
        cal.add(Calendar.DAY_OF_YEAR, -6);
        String dateStr = formFieldDateFormat.format(cal.getTime());
        return dateStr;
    }
}
