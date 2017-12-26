<%--
    JSP Fragment for facility type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_TYPE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Facility Type</span></div>
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
                                    <c:set var="formName" value="_36_facilityType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="A Community Mental Health Center" name="${formName}"  ${formValue eq 'A Community Mental Health Center' ? 'checked' : ''}/> A Community Mental Health Center
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_36_facilityType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="An outpatient Hospital" name="${formName}"  ${formValue eq 'An outpatient Hospital' ? 'checked' : ''}/> An outpatient Hospital
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_36_facilityType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="radio" value="A county contracted provider" name="${formName}"  ${formValue eq 'A county contracted provider' ? 'checked' : ''}/> Others, please upload a county contract 
                                </td>
                                <td>
                                    <c:set var="formName" value="_36_countyContract"></c:set>
                                    <input title="County Contract" type="file" class="fileUpload" name="${formName}" />
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
