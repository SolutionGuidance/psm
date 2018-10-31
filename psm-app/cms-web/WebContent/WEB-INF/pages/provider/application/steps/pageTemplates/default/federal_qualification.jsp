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
<input type="hidden" name="formNames" value="<%= ViewStatics.FEDERAL_QUALIFICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
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
                                    <label class="radioLabel">
                                      <input type="radio" value="Approval Letter from Health Care Finance Administration (HCFA)" name="${formName}"  ${formValue eq 'Approval Letter from Health Care Finance Administration (HCFA)' ? 'checked' : ''}/>
                                      Approval Letter from Health Care Finance Administration (HCFA)
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_hcfaApproval"></c:set>
                                    <input type="file" title="Approval Letter File" class="fileUpload" name="${formName}" />
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
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="Copies of the 330 Grant documents" name="${formName}"  ${formValue eq 'Copies of the 330 Grant documents' ? 'checked' : ''}/>
                                      Copies of the 330 Grant documents
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_grantDocuments"></c:set>
                                    <input type="file" title="Grant Documents File" class="fileUpload" name="${formName}" />
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
                                <td>For Tribes:</td>
                            </tr>
                            <tr>
                                <td>
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="Cover page of Public Law 93-638 status contract" name="${formName}"  ${formValue eq 'Cover page of Public Law 93-638 status contract' ? 'checked' : ''}/>
                                      Cover page of Public Law 93-638 status contract
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_statusContract"></c:set>
                                    <input type="file" title="Cover Page File" class="fileUpload" name="${formName}" />
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
                                    <c:set var="formName" value="_37_qualificationType"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <label class="radioLabel">
                                      <input type="radio" value="Compact with the Indian Health Service" name="${formName}"  ${formValue eq 'Compact with the Indian Health Service' ? 'checked' : ''}/>
                                      Compact with the Indian Health Service
                                    </label>
                                </td>
                                <td>
                                    <c:set var="formName" value="_37_indianHealthServiceContract"></c:set>
                                    <input type="file" title="Indian Health Service Contract File" class="fileUpload" name="${formName}" />
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
