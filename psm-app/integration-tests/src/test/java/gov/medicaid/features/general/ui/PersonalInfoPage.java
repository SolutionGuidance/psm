package gov.medicaid.features.general.ui;

import com.google.common.base.Function;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import net.thucydides.core.pages.PageObject;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
// import static org.hamcrest.MatcherAssert.assertThat;
// import static org.hamcrest.core.StringContains.containsString;
import static org.assertj.core.api.Assertions.assertThat;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.HashMap;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.lang.Exception;

import java.util.concurrent.TimeUnit;

public class PersonalInfoPage extends PageObject {

    public Map<String, String> getErrorInformation() throws Exception {
        Map<String, String> info = new HashMap<String, String>();
        BufferedReader in = new BufferedReader(new FileReader("src/test/resources/files/error_messages.txt"));
        String line = "";
        while((line = in.readLine()) != null) {
            String[] parts = line.split(",");
            info.put(parts[0].replaceAll("\\s+",""), parts[1]);
        }
        in.close();
        return info;
    }
    public void checkForTooYoungError() throws Exception {
        Map<String, String> errorMap = getErrorInformation();
        assertThat($(".errorInfo > ._02_dob").getText().contains(errorMap.get("provider_too_young")));
//        System.out.println(errorMap.get("provider_too_young"));
    }
    public void enterFirstName(String firstName) {

        $("#firstName").type(firstName);
    }
    public void enterMiddleName(String middleName) {
        $("#middleName").type(middleName);
    }
    public void enterLastName(String lastName) {
        $("[name=_02_lastName]").type(lastName);
    }
    public void enterNPI(String NPI) {
        $("[name=_02_npi]").type(NPI);
    }
    public void enterSSN(String SSN) {
        $("[name=_02_ssn]").type(SSN);
    }
    public void enterDOB(String DOB) {
        $("[name=_02_dob]").type(DOB);
    }
    public void enterEmail(String email) {
        $("#emailAddress").type(email);
    }
    public void checkSameAsAbove() {
        $("#sameAsAbove").click();
    }
    public void enterContactName(String contactName) {
        $("#contactName").type(contactName);
    }
    public void enterContactEmail(String contactEmail) {
        $("#contactEmail").type(contactEmail);
    }
    public void clickNext() {
        $("#nextBtn").click();
    }
    public void clickPrevious() {
        $(".prevBtn").click();
    }
    public void confirmNoErrors() {
        assertThat(getTitle().contains("License Information"));    }



}
