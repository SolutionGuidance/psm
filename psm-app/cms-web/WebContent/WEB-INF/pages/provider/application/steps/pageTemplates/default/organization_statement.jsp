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
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="organization_statement"></c:set>

<div class="providerPanel">
    <input type="hidden" name="formNames" value="<%= ViewStatics.ORGANIZATION_STATEMENT_FORM %>">
    <div class="tableHeader">
        <span>Provider Statement</span>
    </div>
    <div class="clearFixed"></div>
    <div class="statement">
        <div class="section">
            <div class="row">
                <p>
                    I certify that the information provided on this form is accurate, complete and truthful.
                    I will notify MHCP Provider Application of any changes to this information. I acknowledge
                    that any misrepresentations in the information submitted to MHCP, including false claims,
                    statements, documents, or concealment of a material fact, may be cause for denial or termination
                    of participation as a Medicaid provider.
                </p>
            </div>

            <c:set var="formName" value="_19_renewalBlankInit"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <input type="hidden" name="${formName}" value="${formValue}" />

            <div class="row">
                <c:set var="formName" value="_19_name"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Provider Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row titleRow">
                <c:set var="formName" value="_19_title"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Provider Title <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <c:set var="formName" value="_19_requiredAgreementsSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <div class="checkRow">
                    <c:set var="formName" value="_19_accepted_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <label class="checkboxLabel">
                      <input type="checkbox" value="" class="checkbox" ${formValue eq 'Y' ? 'checked' : ''} name="${formName}"/>
                      I have read and agree to the terms of the
                      <c:set var="formName" value="_19_documentId_${status.index - 1}"/>
                      <c:set var="documentId" value="${requestScope[formName]}"/>
                      <input type="hidden" value="${documentId}" name="${formName}"/>
                      <c:set var="formName" value="_19_documentName_${status.index - 1}"/>
                      <c:set var="documentName" value="${requestScope[formName]}"/>
                      <c:url var="viewDocumentUrl" value="/provider/application/agreement">
                        <c:param name="id" value="${documentId}"/>
                      </c:url>
                      <a href="${viewDocumentUrl}" target="_blank">${documentName}</a>
                      <c:set var="formName" value="_19_updatedVersion_${status.index - 1}"/>
                      <c:set var="formValue" value="${requestScope[formName]}"/>
                      <c:if test="${formValue eq 'Y'}">(Updated)</c:if>
                    </label>
                </div>
            </c:forEach>
            <div class="clearFixed"></div>
        </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
