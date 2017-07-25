<%--
    JSP Fragment for facility type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.AMBULANCE_SERVICES_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Ambulance Services</span></div>
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
                                    <c:set var="formName" value="_39_basicServicesIndicator"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/> Basic Service 
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_basicServices"></c:set>
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
                                    <c:set var="formName" value="_39_advancedLifeSupportIndicator"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/> Advanced Life Support 
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_advancedLifeSupport"></c:set>
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
                                    <c:set var="formName" value="_39_airTransportIndicator"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/> Air Transport with FAA Air Worthiness Certificate 
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_airTransport"></c:set>
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