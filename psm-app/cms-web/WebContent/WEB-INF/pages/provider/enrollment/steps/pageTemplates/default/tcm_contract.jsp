<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<input type="hidden" name="formNames" value="<%= ViewStatics.TCM_CONTRACT_FORM %>">
<div class="newEnrollmentPanel practicePanel">
    <div class="tableHeader topHeader"><span>TCM contract with county</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <label>Upload copy of contract<span class="required">*</span></label>
                <span class="floatL"><b>:</b></span>

                <c:set var="formName" value="_28_contractAttachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="clearFixed"></div>
       </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<div class="newEnrollmentPanel practicePanel">
    <div class="tableHeader topHeader"><span>Contract Cover Sheet</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <label>Mental Health TCM Contract Cover Sheet (DHS-5638)</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_28_coverSheet1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row requireField">
                <label> Relocation Service Coordination TCM Contract Cover Sheet (DHS-5639)</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_28_coverSheet2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row requireField">
                <label> Child Welfare TCM Contract Cover Sheet (DHS-5702)</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_28_coverSheet3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="clearFixed"></div>
       </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

