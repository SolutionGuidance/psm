<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<input type="hidden" name="formNames" value="<%= ViewStatics.ADULT_DAY_TREATMENT_APPLICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Adult Day Treatment Application</span></div>
    <div class="clearFixed"></div>

    <div class="section">
        <div class="">
            <div class="row requireField">
                <label class="mediumLbl">Please upload a copy of application*</label>
                <span class="floatL">
                    <c:set var="formName" value="_35_application" />
                    <h:attachment
                        name="${formName}"
                        title="Adult Day Treatment Application"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download" />
                </span>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
