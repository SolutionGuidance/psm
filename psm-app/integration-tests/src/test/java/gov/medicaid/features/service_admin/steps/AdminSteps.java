package gov.medicaid.features.service_admin.steps;

import gov.medicaid.features.PsmPage;
import net.thucydides.core.annotations.Step;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class AdminSteps {

    private PsmPage psmPage;

    @Step
    public void openWriteNoteModal() {
        psmPage.click$(".writeNotes");
        assertThat(psmPage.$("#writeNotesModal h2").getText().contains("Write Notes"));
    }

    @Step
    public void advanceFromPendingPageToViewOrganizationInfoPage() {
        WebElement row = psmPage.getTableRowForProviderType("Head Start");
        WebElement viewLink = row.findElement(By.className("viewLink"));
        psmPage.click(viewLink);
        assertThat(psmPage.getTitle().contains("Organization Information"));
    }
}
