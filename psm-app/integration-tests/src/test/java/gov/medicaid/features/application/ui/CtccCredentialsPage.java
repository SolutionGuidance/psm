package gov.medicaid.features.application.ui;

import gov.medicaid.features.PsmPage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

public class CtccCredentialsPage extends PsmPage {
    public void checkCommunityHealthBoard() {
        $("[name=_30_chbIndicator]").click();
    }

    public void uploadSampleFile() throws IOException {
        File temporaryFile = File.createTempFile("Contract.", ".txt");
        try (PrintWriter writer = new PrintWriter(
                new FileOutputStream(temporaryFile))) {
            writer.println("Contract");
        }
        upload(temporaryFile.getAbsolutePath()).to($("[name=_30_dhsContract]"));
        temporaryFile.deleteOnExit();
    }
}
