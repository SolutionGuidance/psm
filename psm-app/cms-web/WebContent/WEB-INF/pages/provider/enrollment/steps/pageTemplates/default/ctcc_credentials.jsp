<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.CTCC_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="section">
        <div class="">
        </div>
        <div class="clear"></div>
        <span class="control">
            <c:set var="formName" value="_30_chbIndicator"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label class="checkboxLabel">
              <input class="showHidePanel" ${formValue eq 'Y' ? 'checked' : ''} type="checkbox" name="${formName}" value="Y" />
              This clinic is a Community Health Board
            </label>
        </span>
    </div>

    <div class="section line hiddenSection" style="display: ${formValue eq 'Y' ? 'block' : 'none'};">
        <div class="">
            <div class="row requireField">
                <label for="dhsContract">Please upload a copy of contract with DHS<span class="required">*</span></label>

                <c:set var="formName" value="_30_dhsContract"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input id="dhsContract" type="file" class="fileUpload" name="${formName}" />
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>
