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

<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Eligibity</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_ELIGIBILITY_FORM %>">
        <div class="row">
            <label class="longLbl">Does your facility provide physical or occupational therapy to community residents?</label>
            <div>
                <c:set var="formName" value="_38_therapyIndicator"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''}>Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''}>No</label>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="row">
            <table class="eligibilityTable">
                <thead>
                <tr>
                    <th colspan="4">
                        Bed Count
                    </th>
                </tr>
                <tr>
                    <th>SKILLED NURSING FACILITY (TITLE 18 ONLY)</th>
                    <th>NURSING FACILITY (TITLE 19 ONLY)</th>
                    <th>SKILLED NURSING FACILITY DUAL CERTIFIED (TITLE 18/19)</th>
                    <th>ICF/DD</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <c:set var="formName" value="_38_title18BedCount"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Skilled Nursing Facility (Title 18) Bed Count" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_38_title19BedCount"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Nursing Facility (Title 19) Bed Count" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_38_dualCertBedCount"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="Dual Certified Facility (Title 18/19) Bed Count" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    </td>
                    <td>
                        <c:set var="formName" value="_38_icfBedCount"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="text" title="ICF/DD Bed Count" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
