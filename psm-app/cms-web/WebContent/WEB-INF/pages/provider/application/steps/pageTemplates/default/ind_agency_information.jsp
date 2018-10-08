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
<c:set var="formIdPrefix" value="ind_agency_information"></c:set>

<div class="practicePanel">
    <div class="tableHeader otherTableHeader">
        <span>Group Affiliation Information</span>
        <a href="javascript:openAgencyLookup(true);" class="purpleSmallBtn practiceLookupModalBtn">Agency Lookup</a>
    </div>

    <div>
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.INDIVIDUAL_AGENCY_FORM %>">
        <div class="wholeCol">
            <div class="row requireField">
                <c:set var="formName" value="_11_name"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Agency Name <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_11_agencyId"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="agencyId">Agency Id <span class="required">*</span></label>
                <input type="text" class="normalInput" id="agencyId" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_11_npi"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="agencyNpiUmpi">
                  Agency NPI/UMPI
                  <span class="required">*</span>
                  <a href="javascript:;" class="userHelpLink NPIdefinition">?</a>
                </label>
                <input type="text" class="npiMasked normalInput" id="agencyNpiUmpi" name="${formName}" value="${formValue}" maxlength="10"/>
            </div>

            <div class="row">
                <label>Fax Number <span class="required">*</span></label>
                <c:set var="formName" value="_11_fax1"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Fax Number Area Code" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_11_fax2"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Fax Number Prefix" class="autotab smallInput" name="${formName}" value="${formValue}" maxlength="3"/>
                <span class="sep">-</span>
                <c:set var="formName" value="_11_fax3"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <input type="text" title="Fax Number Line Number" class="autotab smallInputP" name="${formName}" value="${formValue}" maxlength="4"/>
            </div>

            <div class="row">
                <c:set var="formName" value="_11_contactName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="contactName">Agency Contact Name <span class="required">*</span></label>
                <input type="text" class="normalInput" id="contactName" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>

            <div class="row">
                <c:set var="formName" value="_11_bgsId"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="bgsId">Background Study ID <span class="required">*</span></label>
                <input type="text" class="normalInput" id="bgsId" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>

            <div class="row">
                <c:set var="formName" value="_11_clearanceDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Clearance Date <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
            </div>

            <div class="clearFixed"></div>
        </div>
    </div>
    <!-- /.section -->
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<!-- /.newApplicationPanel -->
<div class="radioPanel">
    <div class="section">
        <div id="RadioWrapper" class="row">
            <c:set var="formName" value="_11_continuousEmployment"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label>Has this individual maintained continuous employment with your agency since this BGS was completed?</label>
            <div>
              <label class="span">
                <input type="radio" title="Continuous" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}>
                Yes
              </label>
              <label class="span">
                <input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}>
                No
              </label>
            </div>
        </div>
        <c:url var="rebindUrl" value="/provider/application/steps/rebind" />
        <div id="RadioWrapper" class="row">
            <c:set var="formName" value="_11_additionalAgency"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <label>You have the option to affiliate/enroll the individual PCA  with other agencies you own without completing another <br/>
            application and agreement. Do you want to affiliate this individual PCA with any other agency(ies) you own?</label>
            <div>
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
