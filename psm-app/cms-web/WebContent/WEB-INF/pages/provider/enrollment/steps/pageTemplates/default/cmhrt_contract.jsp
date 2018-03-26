<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.CMHRT_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Childrens Mental Health Residential Treatment county contract</span></div>
    <div class="clearFixed"></div>

    <div class="section">
        <div class="">
            <div class="row requireField">
                <label for="coverSheet_${formName}" class="mediumLbl">Please upload a copy of cover sheet with contract summary <span class="required">*</span></label>

                <c:set var="formName" value="_31_countyContract"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <a href="${downloadLink}">Download</a>
                </c:if>
                <input id="coverSheet_${formName}" type="file" class="fileUpload" name="${formName}" />
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
