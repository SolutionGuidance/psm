package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;

public class LicenseInfoPage extends PsmPage {
    public void clickNo() {
        click($("input[value='N'"));
    }

    public void addLicense() {
        click($("#addLicense"));
    }

    public void addLicenseType(String licenseType) {
        $("[name=_03_licenseType_0]").selectByVisibleText(licenseType);
    }

    public void uploadSampleFile() throws IOException {
        File temporaryFile = File.createTempFile("License.", ".txt");
        try (PrintWriter writer = new PrintWriter(
                new FileOutputStream(temporaryFile))) {
            writer.println("License");
        }
        upload(temporaryFile.getAbsolutePath()).to($("[name=_03_attachment_0]"));
        temporaryFile.deleteOnExit();
    }

    public void enterLicenseNumber(String licenseNumber) {
        $("[name=_03_licenseNumber_0]").type(licenseNumber);
    }

    public void enterIssueDate(LocalDate issueDate) {
        $("[name=_03_originalIssueDate_0]").type(
                format(issueDate)
        );
    }

    public void enterRenewalDate(LocalDate renewalDate) {
        $("[name=_03_renewalDate_0]").type(
                format(renewalDate)
        );
    }

    public void enterIssueState(String issueState) {
        $("[name=_03_issuingState_0]").selectByVisibleText(issueState);
    }

    public void clickNext() {
        click($(".nextBtn"));
        assertThat(getTitle()).contains("Practice Information");
    }
}
