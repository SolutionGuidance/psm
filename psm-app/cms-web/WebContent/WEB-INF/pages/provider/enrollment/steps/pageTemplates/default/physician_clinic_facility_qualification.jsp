<%--
    JSP Fragment for facility type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="physician_clinic_facility_qualification"></c:set>
<input type="hidden" name="formNames" value="<%= ViewStatics.PHYSICIAN_CLINIC_FACILITY_QUALIFICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Facility Qualification</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div>
            <div class="row">
                <table>
                    <tbody>
                    <tr>
                        <td>
                            <c:set var="formName" value="_40_designationApprovalIndicator"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/> Hospital Based Clinic Designation:  approval letter from CMS
                        </td>
                        <td>
                   <c:set var="formName" value="_40_designationApproval"></c:set>
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
            <div class="clearFixed"></div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
