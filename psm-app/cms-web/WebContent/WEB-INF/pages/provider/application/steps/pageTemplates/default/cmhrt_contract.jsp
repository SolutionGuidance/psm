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
<input type="hidden" name="formNames" value="<%= ViewStatics.CMHRT_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Childrens Mental Health Residential Treatment county contract</span></div>
    <div class="clearFixed"></div>

    <div class="section">
        <div class="">
            <div class="row requireField">
                <label for="coverSheet_${formName}" class="mediumLbl">Please upload a copy of cover sheet with contract summary <span class="required">*</span></label>

                <c:set var="formName" value="_31_countyContract"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:if test="${not empty formValue}">
                    <c:url var="downloadLink" value="/provider/application/attachment">
                         <c:param name="id" value="${requestScope[formName]}"></c:param>
                    </c:url>
                    <a href="${downloadLink}">Download</a>
                </c:if>
                <input id="coverSheet_${formName}" type="file" class="fileUpload" name="${formName}" />
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
