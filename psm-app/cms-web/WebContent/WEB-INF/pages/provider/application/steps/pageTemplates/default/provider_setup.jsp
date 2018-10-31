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
<c:set var="formIdPrefix" value="provider_setup"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.PROVIDER_SETUP_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div id="setupTable">
<c:set var="formName" value="_20_payToSize"></c:set>

<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="section">
        <c:set var="formName" value="_20_objectId_${status.index - 1}"></c:set>
        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
        <input type="hidden" class="objectIdInput" name="${formName}" value="${formValue}"/>

        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_20_npi_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">NPI <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="npiMasked smallInput" name="${formName}" value="${formValue}" maxlength="10"/>
                <a href="javascript:;" class="purpleBtn NPISetupLookup"><span class="icon">NPI Lookup</span></a>
                <span class="errorMsg">No records found with NPI number <span></span></span>
            </div>
        </div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_20_name_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Pay-to Provider Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_20_contactName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Contact Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="contactNameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_20_effectiveDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Effective Date <span class="required">*</span></label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <label>Phone Number <span class="required">*</span></label>
                <c:set var="formName" value="_20_phone1_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Area Code" class="phone1Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_20_phone2_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Prefix" class="phone2Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_20_phone3_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Line Number" class="phone3Input smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                <span class="sep"><strong>ext.</strong></span>
                <c:set var="formName" value="_20_phone4_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Extension" class="phone4Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
            </div>
            <div class="row requireField">
                <label class="multiLine">Choose One <span class="required">*</span></label>
                <c:set var="formName" value="_20_type_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline"><input type="radio" ${formValue eq 'Claim' ? 'checked' : ''} name="${formName}" value="Claim"/>Claim</label>
                <label class="inline"><input type="radio" ${formValue eq 'ERA' ? 'checked' : ''} name="${formName}" value="ERA"/>ERA</label>
                <label class="inline"><input type="radio" ${formValue eq 'Both' ? 'checked' : ''} name="${formName}" value="Both"/>Both</label>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close" type="button"></button>
</div>
</c:forEach>
</div>

<div class="hide">
<div class="newApplicationPanel practicePanel memberInfoPanel" id="setupTemplate">
<div class="section">
        <c:set var="formName" value="_20_objectId_${status.index - 1}"></c:set>
        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
        <input type="hidden" class="objectIdInput" name="${formName}" value="${formValue}"/>

        <div class="">
            <div class="row requireField">
                <c:set var="formName" value="_20_npi_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">NPI <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="npiMasked smallInput" name="${formName}" value="${formValue}" maxlength="10"/>
                <a href="javascript:;" class="purpleBtn NPISetupLookup"><span class="icon">NPI Lookup</span></a>
                <span class="errorMsg">No records found with NPI number <span></span></span>
            </div>
        </div>
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_20_name_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Pay-to Provider Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="nameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_20_contactName_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Contact Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="contactNameInput normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_20_startDate_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Effective Date <span class="required">*</span></label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <label>Phone Number <span class="required">*</span></label>
                <c:set var="formName" value="_20_phone1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Area Code" class="phone1Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_20_phone2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Prefix" class="phone2Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_20_phone3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Line Number" class="phone3Input smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
                <span class="sep"><strong>ext.</strong></span>
                <c:set var="formName" value="_20_phone4"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Phone Number Extension" class="phone4Input tinyInput" name="${formName}" value="${formValue}" maxlength="3"/>
            </div>
            <div class="row requireField">
                <label class="multiLine">Choose One <span class="required">*</span></label>
                <c:set var="formName" value="_20_iboRelationship_${status.index - 1}"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline"><input type="radio" ${formValue eq 'Claim' ? 'checked' : ''} name="${formName}" value="Claim"/>Claim</label>
                <label class="inline"><input type="radio" ${formValue eq 'ERA' ? 'checked' : ''} name="${formName}" value="ERA"/>ERA</label>
                <label class="inline"><input type="radio" ${formValue eq 'Both' ? 'checked' : ''} name="${formName}" value="Both"/>Both</label>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clear"></div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
    <button class="closeSection" title="Close" aria-label="Close"  type="button"></button>
</div>

<c:url var="lookupUrl" value="/provider/application/lookupProvider" />
<input type="hidden" id="setupLookupURL" value="${lookupUrl}"/>

</div>

<div class="tableBottom">
    <a href="javascript:;" id="addPayTo">+ Add Another Pay-To Provider</a>
</div>
