package gov.medicaid.features.enrollment.steps;

import gov.medicaid.features.enrollment.ui.IndividualInfoPage;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import gov.medicaid.features.enrollment.ui.PersonalInfoPage;
import gov.medicaid.features.enrollment.ui.SelectProviderTypePage;
import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.LoginPage;
import net.thucydides.core.annotations.Step;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

@SuppressWarnings("unused")
public class EnrollmentSteps {
    private LoginPage loginPage;
    private DashboardPage dashboardPage;
    private SelectProviderTypePage selectProviderTypePage;
    private OrganizationInfoPage organizationInfoPage;
    private IndividualInfoPage individualInfoPage;
    private PersonalInfoPage personalInfoPage;

    private SimpleDateFormat formFieldDateFormat = new SimpleDateFormat("MMddyyyy");

    @Step
    public void loginAsProvider() {
        loginPage.open();
        loginPage.enterProviderCredentials();
        loginPage.login();
        loginPage.checkUserLoggedIn("p1");
    }

    public void createEnrollment() {
        dashboardPage.clickOnNewEnrollment();
    }

    public void selectOrganizationalProviderType() {
        selectProviderTypePage.selectProviderType("Dental Clinic");
        selectProviderTypePage.clickNext();
    }

    public void selectIndividualProviderType() {
        selectProviderTypePage.selectProviderType("Podiatrist");
        selectProviderTypePage.clickNext();
    }

    public void enterOrganizationInfo() {
        organizationInfoPage.setNPI("1234567893");
        organizationInfoPage.setEffectiveDate(generateEffectiveDate());
        organizationInfoPage.setDoingBusinessAs("Test DBA");
        organizationInfoPage.setLegalName("Test Name");
        organizationInfoPage.setAddr1("123 Test St");
        organizationInfoPage.setCity("TestCity");
        organizationInfoPage.selectState("Texas");
        organizationInfoPage.setZipcode("77706");
        organizationInfoPage.selectCounty("Beltrami");
        organizationInfoPage.setPhoneNumber("2221113333");
        organizationInfoPage.setFEIN("123456789");
    }

    public void enterContactInfo() {
        organizationInfoPage.setContactName("Test Contact");
        organizationInfoPage.setContactPhone("4445556666");
    }


    public String generateEffectiveDate() {
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(new Date());
        cal.add(Calendar.DAY_OF_YEAR, -6);
        String dateStr = formFieldDateFormat.format(cal.getTime());
        return dateStr;
    }

    public void enterIndividualMember() {
        individualInfoPage.enterIndividualMember();
        individualInfoPage.setIndividualOwnerNPI("1234567893");
        individualInfoPage.setIndividualOwnerName("Test Owner");
        individualInfoPage.setIndividualProviderType("Dentist");
        individualInfoPage.setIndividualOwnerSoSec("123456789");
        individualInfoPage.setIndividualOwnerDOB("01011970");
        individualInfoPage.setIndividualHireDate("01012000");
    }

    @Step
    public void checkForTooYoungError() throws Exception {
        personalInfoPage.checkForTooYoungError();
    }
}
