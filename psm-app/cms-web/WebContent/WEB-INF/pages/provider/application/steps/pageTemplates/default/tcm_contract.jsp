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
<%-- TCM is for Targeted Case Management application --%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="tcm_contract"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.TCM_CONTRACT_FORM %>">
<div class="newApplicationPanel practicePanel">
    <div class="tableHeader topHeader"><span>TCM contract with county</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <c:set var="formName" value="_28_contractAttachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Upload copy of contract <span class="required">*</span></label>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input id="${formIdPrefix}_${formName}" type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="clearFixed"></div>
       </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<div class="newApplicationPanel practicePanel">
    <div class="tableHeader topHeader"><span>Contract Cover Sheet</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <c:set var="formName" value="_28_coverSheet1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Mental Health TCM Contract Cover Sheet (DHS-5638)</label>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input id="${formIdPrefix}_${formName}" type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_28_coverSheet2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Relocation Service Coordination TCM Contract Cover Sheet (DHS-5639)</label>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input id="${formIdPrefix}_${formName}" type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_28_coverSheet3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}"> Child Welfare TCM Contract Cover Sheet (DHS-5702)</label>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <div><a href="${downloadLink}">Download</a></div>
                </c:if>
                <input id="${formIdPrefix}_${formName}" type="file" class="fileUpload" name="${formName}" />
            </div>
            <div class="clearFixed"></div>
       </div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

