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
<c:set var="formIdPrefix" value="personal_information"></c:set>

<%-- BUGR-9673 (optional NPI for some provider types) --%>
<c:set var="requireNPI" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Personal Information Form'].settings['requireNPI']}"></c:set>
<c:set var="showEmailRequired" value="${requestScope['_02_showEmailRequired']}"/>


<div class="newApplicationPanel">
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.PERSONAL_INFO_FORM %>">
        <div class="wholeCol">
            <div class="row requireField">
                <c:set var="formName" value="_02_firstName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="firstName">
                  First Name
                  <span class="required">*</span>
                </label>
                <input type="text" class="normalInput" id="firstName" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_02_middleName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="middleName">Middle Name</label>
                <input type="text" class="normalInput" id="middleName" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_02_lastName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  Last Name
                  <span class="required">*</span>
                </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row requireField">
                <%-- BUGR-9673 (optional NPI for some provider types) --%>
                <c:set var="formName" value="_02_npi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  <abbr title="National Provider Identifier">NPI</abbr>
                  <span class="required">${requireNPI ? '*' : ''}</span>
                  <a href="javascript:" class="userHelpLink NPIdefinition">?</a>
                </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="npiMasked normalInput" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_02_ssn"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  Social Security Number
                  <span class="required">*</span>
                </label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_02_dob"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">
                  Date of Birth
                  <span class="required">*</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}" maxlength="10"/>
                </span>
            </div>
            <div class="row ${showEmailRequired ? 'requireField' : ''}">
                <c:set var="formName" value="_02_email"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="emailAddress">
                    Email Address                  
                    <span id="requireEmailAddressLabel" class="${showEmailRequired ? '' : 'hidden'} required">*</span>                    
                </label>
                <input id="emailAddress" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="50"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="tableHeader"><span>Contact Info</span></div>
        <div class="clearFixed"></div>
        <div class="wholeCol">
            <div class="row">
                <c:set var="formName" value="_02_useProviderAsContact"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <c:set var="disableContact" value="${formValue eq 'Y' ? 'disabled' : ''}"></c:set>
                <label>
                    <input
                        type="checkbox"
                        class="checkbox"
                        id="sameAsAbove"
                        ${formValue eq 'Y' ? 'checked' : ''}
                        name="${formName}" />
                    Same as Above
                </label>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_02_contactName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="contactName">
                  Contact Name
                  <span class="required">*</span>
                </label>
                <input id="contactName" ${disableContact} type="text" class="${disableContact} normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_02_contactEmail"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="contactEmail">Contact Email Address <span class="required">*</span></label>
                <input id="contactEmail" ${disableContact} type="text" class="${disableContact} normalInput" name="${formName}" value="${formValue}" maxlength="50"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_02_contactPhone1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label>Contact Phone Number</label>
                <input ${disableContact}
                    id="contactPhone1"
                    type="text"
                    title="Contact Phone Area Code"
                    class="${disableContact} autotab smallInput"
                    name="${formName}"
                    value="${formValue}"
                    maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_02_contactPhone2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input ${disableContact}
                    id="contactPhone2"
                    type="text"
                    title="Contact Phone Prefix"
                    class="${disableContact}
                    autotab smallInput"
                    name="${formName}"
                    value="${formValue}"
                    maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_02_contactPhone3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input ${disableContact}
                    id="contactPhone3"
                    type="text"
                    title="Contact Phone Line Number"
                    class="${disableContact} autotab smallInputP"
                    name="${formName}"
                    value="${formValue}"
                    maxlength="4"/>
                <span class="sep"><strong>ext.</strong></span>
                <c:set var="formName" value="_02_contactPhone4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input ${disableContact}
                    id="contactPhone4"
                    type="text"
                    title="Contact Phone Extension"
                    class="${disableContact} autotab smallInput"
                    name="${formName}"
                    value="${formValue}"
                    maxlength="3"/>
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
<!-- /.newApplicationPanel -->
