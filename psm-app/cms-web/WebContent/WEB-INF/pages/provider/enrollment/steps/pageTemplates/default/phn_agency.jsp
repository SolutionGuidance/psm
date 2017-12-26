<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="phn_agency"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.PHN_AGENCY_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>PHN Agency must be a county or have a contract with a county</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div>
            <div class="row">
                <div class="rowWrapper">
                    <div class="row">
                    </div>
                    <div class="row">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_26_countyIndicator"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/>
                                      Is a county, specify county name
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_26_countyName"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="text" title="County Name" class="normalInput" name="${formName}" value="${formValue}" maxlength="20"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_26_countyIndicator"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="N" name="${formName}"  ${formValue eq 'N' ? 'checked' : ''}/>
                                      Have a contract with a county, upload copy
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_26_contractAttachment"></c:set>
                                    <input type="file" title="Contract File" class="fileUpload" name="${formName}" />
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
