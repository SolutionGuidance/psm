<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.ORGANIZATION_DISCLOSURE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Provider Disclosure</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="">
            <div class="row">
                <h3>Has any person having an ownership or control interest ever:</h3>
            </div>
            
            <c:set var="formName" value="_18_renewalBlankInit"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <input type="hidden" name="${formName}" value="${formValue}" />
            
            <div class="row">
                <label class="longLbl">Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs? <span class="required">*</span></label>

                <c:set var="formName" value="_18_empCriminalConvictionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                
                <div class="clear"></div>
            </div>
            <div class="row">
                <label class="longLbl">Had civil money penalties or assessments imposed under section 1128A of the Social Security Act? <span class="required">*</span></label>

                <c:set var="formName" value="_18_empCivilPenaltyInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>

                <div class="clear"></div>
                <div class="hideSection">
                    <label>Full Legal Name<span class="required">*</span></label>
                    <input class="normalInput" type="text"  maxlength="100"/>
                    <label>Social Security Number<span class="required">*</span></label>
                    <input class="normalInput" type="text" maxlength="9"/>
                    <div class="clear"></div>
                    <label>Reason for Answer yes<span class="required">*</span></label>
                    <span class="floatL inputCnt">
                        <input class="wholeInput reason" type="text"  maxlength="200"/>
                        <span class="label">(for example, conviction, money penalties, exclusion from Medicare or state health care programs)</span>
                    </span>
                </div>
            </div>
            <div class="row">
                <label class="longLbl">Been excluded from participation in Medicare or any of the State health care programs? <span class="required">*</span></label>

                <c:set var="formName" value="_18_empPreviousExclusionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
            </div>
            <div class="row">
                <h3>Has any managing employee or agent ever:</h3>
            </div>
            <div class="row">
                <label class="longLbl">Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs?  <span class="required">*</span></label>

                <c:set var="formName" value="_18_criminalConvictionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
            </div>
            <div class="row">
                <label class="longLbl">Had civil money penalties or assessments imposed under section 1128A of the Social Security Act? <span class="required">*</span></label>

                <c:set var="formName" value="_18_civilPenaltyInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>

                <div class="clear"></div>
                <div class="hideSection">
                    <label>Full Legal Name<span class="required">*</span></label>
                    <input class="normalInput" type="text" maxlength="100"/>
                    <label>Social Security Number<span class="required">*</span></label>
                    <input class="normalInput" type="text" maxlength="9"/>
                    <div class="clear"></div>
                    <label>Reason for anser yes<span class="required">*</span></label>
                    <span class="floatL inputCnt">
                        <input class="wholeInput reason" type="text" maxlength="200"/>
                        <span class="label">(for example, conviction, money penalties, exclusion from Medicare or state health care programs)</span>
                    </span>
                </div>
            </div>
            <div class="row">
                <label class="longLbl">Been excluded from participation in Medicare or any of the State health care programs? <span class="required">*</span></label>

                <c:set var="formName" value="_18_previousExclusionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
            </div>
            <div class="clearFixed"></div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>