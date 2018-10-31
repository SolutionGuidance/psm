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
<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="practice_type"></c:set>

<div class="radioPanel">
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.PRACTICE_TYPE_FORM %>">
        <div id="RadioWrapper" class="row">
            <label>
              Do you maintain your own private practice?
              <a href="javascript:" class="userHelpLink maintainOwnPrivatePractice">?</a>
            </label>
            <div>
                <c:set var="formName" value="_04_maintainsOwnPrivatePractice"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:url var="rebindUrl" value="/provider/application/steps/rebind" />
                <label class="span">
                  <input onchange="javascript:submitFormById('applicationForm', '${rebindUrl}')" type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}>
                  Yes
                </label>
                <label class="span">
                  <input onchange="javascript:submitFormById('applicationForm', '${rebindUrl}')" type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}>
                  No
                </label>
            </div>
        </div>
        <div id="switchRadioWrapper" class="row">
            <label>
              Are you employed and/or independently contracted by a group practice?
              <a href="javascript:" class="userHelpLink employedByGroupPractice">?</a>
            </label>
            <div>
                <c:set var="formName" value="_04_employedOrContractedByGroup"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="span">
                  <input onchange="javascript:submitFormById('applicationForm', '${rebindUrl}')" type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}>
                  Yes
                </label>
                <label class="span">
                  <input onchange="javascript:submitFormById('applicationForm', '${rebindUrl}')" type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}>
                  No
                </label>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
