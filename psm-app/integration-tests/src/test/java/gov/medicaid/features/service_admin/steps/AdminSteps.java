package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.Step;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class AdminSteps {

    private PsmPage psmPage;

    @Step
    public void openWriteNoteModal() {
        psmPage.click$(".writeNotes");
        assertThat(psmPage.$("#writeNotesModal h2").getText().contains("Write Notes"));
    }
}
