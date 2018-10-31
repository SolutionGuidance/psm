package gov.medicaid.features.application.ui;

import gov.medicaid.features.PsmPage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

public class CcmhrCredentialsPage extends PsmPage {
    public void addCtssCertification(LocalDate beginDate, LocalDate endDate) throws IOException {
        $("[name=_34_certificateInd_1]").click();
        sendKeysIndividually("[name=_34_beginDate_1]", format(beginDate));
        sendKeysIndividually("[name=_34_endDate_1]", format(endDate));
        uploadSampleFile("Certification", "_34_attachment_1");
    }

    public void addCrisisStabilizationContract(LocalDate beginDate, LocalDate endDate) throws IOException {
        $("[name=_34_certificateInd_3]").click();
        sendKeysIndividually("[name=_34_beginDate_3]", format(beginDate));
        sendKeysIndividually("[name=_34_endDate_3]", format(endDate));
        uploadSampleFile("Certification", "_34_attachment_3");
    }

    private void uploadSampleFile(String typeName, String formName) throws IOException {
        File temporaryFile = File.createTempFile(typeName + ".", ".txt");
        try (PrintWriter writer = new PrintWriter(
                new FileOutputStream(temporaryFile))) {
            writer.println(typeName);
        }
        upload(temporaryFile.getAbsolutePath()).to($("[name=" + formName + "]"));
        temporaryFile.deleteOnExit();
    }
}
