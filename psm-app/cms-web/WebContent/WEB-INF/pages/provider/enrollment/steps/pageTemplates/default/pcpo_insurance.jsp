<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.PCPO_INSURANCE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel memberInfoPanel">
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <label class="mediumLbl">Copy of certificate of liability insurance</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_25_liabilityInsuranceId"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <a href="${downloadLink}">Download</a>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row">
            </div>
            
            <div class="row">
                <label class="mediumLbl">Copy of Workers' Compensation insurance</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_25_compensationInsuranceId"></c:set>
                <c:if test="${not empty  requestScope[formName]}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <a href="${downloadLink}">Download</a>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row">
            </div>
            
            <div class="row requireField">
                <label class="mediumLbl">Copy of fidelity bond</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_25_fidelityBondId"></c:set>
                <c:if test="${not empty  requestScope[formName]}">
                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <a href="${downloadLink}">Download</a>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row">
            </div>
            
            <div class="row requireField">
                <label class="mediumLbl">Copy of surety bond</label>
                <span class="floatL"><b>:</b></span>
    
                <c:set var="formName" value="_25_suretyBondId"></c:set>
                <c:if test="${not empty  requestScope[formName]}">
	                <c:url var="downloadLink" value="/provider/enrollment/attachment">
	                     <c:param name="id" value="${requestScope[formName]}"></c:param>
	                </c:url>
	                <a href="${downloadLink}">Download</a>
                </c:if>
                <input type="file" class="fileUpload" name="${formName}" />
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