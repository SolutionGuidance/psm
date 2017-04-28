<%--
    JSP Fragment for facility type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.FEDERAL_QUALIFICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Facility Qualifications</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="">
            <div class="row">
                <div class="rowWrapper">
                    <div class="row">
                    </div>
                    <div class="row">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="Approval Letter from Health Care Finance Administration (HCFA)" name="${formName}"  ${formValue eq 'Approval Letter from Health Care Finance Administration (HCFA)' ? 'checked' : ''}/> Approval Letter from Health Care Finance Administration (HCFA) 
                                </td>
                                <td>
			                        <c:set var="formName" value="_37_hcfaApproval"></c:set>
			                        <input type="file" class="fileUpload" name="${formName}" />
			                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
			                        <c:if test="${not empty formValue}">
			                            <c:url var="downloadLink" value="/provider/enrollment/attachment">
			                                 <c:param name="id" value="${formValue}"></c:param>
			                            </c:url>
			                            <div><a href="${downloadLink}">Download</a></div>
			                        </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="Copies of the 330 Grant documents" name="${formName}"  ${formValue eq 'Copies of the 330 Grant documents' ? 'checked' : ''}/> Copies of the 330 Grant documents 
                                </td>
                                <td>
			                        <c:set var="formName" value="_37_grantDocuments"></c:set>
			                        <input type="file" class="fileUpload" name="${formName}" />
			                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
			                        <c:if test="${not empty formValue}">
			                            <c:url var="downloadLink" value="/provider/enrollment/attachment">
			                                 <c:param name="id" value="${formValue}"></c:param>
			                            </c:url>
			                            <div><a href="${downloadLink}">Download</a></div>
			                        </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td>For Tribes:</td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="Cover page of Public Law 93-638 status contract" name="${formName}"  ${formValue eq 'Cover page of Public Law 93-638 status contract' ? 'checked' : ''}/> Cover page of Public Law 93-638 status contract 
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_statusContract"></c:set>
                                    <input type="file" class="fileUpload" name="${formName}" />
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <c:if test="${not empty formValue}">
                                        <c:url var="downloadLink" value="/provider/enrollment/attachment">
                                             <c:param name="id" value="${formValue}"></c:param>
                                        </c:url>
                                        <div><a href="${downloadLink}">Download</a></div>
                                    </c:if>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="Compact with the Indian Health Service" name="${formName}"  ${formValue eq 'Compact with the Indian Health Service' ? 'checked' : ''}/> Compact with the Indian Health Service 
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_indianHealthServiceContract"></c:set>
                                    <input type="file" class="fileUpload" name="${formName}" />
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <c:if test="${not empty formValue}">
                                        <c:url var="downloadLink" value="/provider/enrollment/attachment">
                                             <c:param name="id" value="${formValue}"></c:param>
                                        </c:url>
                                        <div><a href="${downloadLink}">Download</a></div>
                                    </c:if>
                                </td>
                            </tr>
                            
                            </tbody>
                        </table>
                    </div>
                </div>
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