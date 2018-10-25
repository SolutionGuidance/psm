package gov.medicaid.features.enrollment.ui;

import gov.medicaid.features.PsmPage;

import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentDetailsPage extends PsmPage {
    public void verifySubmitModal() {
        assertThat($("#submitEnrollmentModal > div.inner > " +
                "div.modal-content > div.right > div.middle").getText())
                .contains("The enrollment has been successfully submitted");
    }

    public void closeSubmitModal() {
        click($("#submitEnrollmentModal a.okBtn"));
    }

    public void closeSaveAsDraftModal() {
        click$("#saveAsDraftModal a.okBtn");
    }
}
