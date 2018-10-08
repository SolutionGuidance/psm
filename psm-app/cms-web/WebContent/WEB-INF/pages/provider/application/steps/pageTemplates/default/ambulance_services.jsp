<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%--
    JSP Fragment for facility type selection form.

 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.AMBULANCE_SERVICES_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
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
                                    <label class="checkboxLabel">
                                      <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/>
                                      Basic Service
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_basicServices"></c:set>
                                    <input type="file" title="Basic Service Form" class="fileUpload" name="${formName}" />
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <c:if test="${not empty formValue}">
                                        <c:url var="downloadLink" value="/provider/application/attachment">
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
                                    <label class="checkboxLabel">
                                      <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/>
                                      Advanced Life Support
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_advancedLifeSupport"></c:set>
                                    <input type="file" title="Advanced Life Support Form" class="fileUpload" name="${formName}" />
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <c:if test="${not empty formValue}">
                                        <c:url var="downloadLink" value="/provider/application/attachment">
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
                                    <label class="checkboxLabel">
                                      <input type="checkbox" value="Y" name="${formName}"  ${formValue eq 'Y' ? 'checked' : ''}/>
                                      Air Transport with FAA Air Worthiness Certificate
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_39_airTransport"></c:set>
                                    <input type="file" title="Air Transport with FAA Certification Form" class="fileUpload" name="${formName}" />
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <c:if test="${not empty formValue}">
                                        <c:url var="downloadLink" value="/provider/application/attachment">
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
