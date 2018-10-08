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
<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_TYPE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
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
                                    <label class="radioLabel">
                                      <input type="radio" value="A Community Mental Health Center" name="${formName}"  ${formValue eq 'A Community Mental Health Center' ? 'checked' : ''}/>
                                      A Community Mental Health Center
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_36_facilityType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="An outpatient Hospital" name="${formName}"  ${formValue eq 'An outpatient Hospital' ? 'checked' : ''}/>
                                      An outpatient Hospital
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_36_facilityType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="A county contracted provider" name="${formName}"  ${formValue eq 'A county contracted provider' ? 'checked' : ''}/>
                                      Others, please upload a county contract
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_36_countyContract"></c:set>
                                    <input title="County Contract" type="file" class="fileUpload" name="${formName}" />
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
