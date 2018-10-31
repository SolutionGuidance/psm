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
<c:set var="formIdPrefix" value="organization_disclosure"></c:set>

<input type="hidden" name="formNames" value="<%= ViewStatics.ORGANIZATION_DISCLOSURE_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Provider Disclosure</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div class="">
            <div class="row">
                <h3>Has any person having an ownership or control interest ever:</h3>
            </div>

            <c:set var="formName" value="_18_renewalBlankInit"></c:set>
            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
            <input type="hidden" name="${formName}" value="${formValue}" />

            <div class="row">
                <c:set var="formName" value="_18_empCriminalConvictionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">
                  Been convicted of a criminal offense related to that person's
                  involvement in any program under Medicare, Medicaid, Title XX,
                  or Title XXI in Minnesota or any other state or jurisdiction
                  since the inception of these programs?
                  <span class="required">*</span>
                  <a href="javascript:;" class="userHelpLink titleVHelpLink">?</a>
                </label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>

                <div class="clear"></div>
            </div>
            <div class="row">
                <c:set var="formName" value="_18_empCivilPenaltyInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">Had civil money penalties or assessments imposed under section 1128A of the Social Security Act? <span class="required">*</span></label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>

                <div class="clear"></div>
                <div class="hideSection">
                    <label for="${formIdPrefix}_owner_full_name">Full Legal Name <span class="required">*</span></label>
                    <input id="${formIdPrefix}_owner_full_name" class="normalInput" type="text"  maxlength="100"/>

                    <label for="${formIdPrefix}_owner_ssn">Social Security Number <span class="required">*</span></label>
                    <input id="${formIdPrefix}_owner_ssn" class="normalInput" type="text" maxlength="9"/>
                    <div class="clear"></div>

                    <label for="${formIdPrefix}_owner_reason">Reason for Answer yes <span class="required">*</span></label>
                    <span class="floatL inputCnt">
                        <input id="${formIdPrefix}_owner_reason" class="wholeInput reason" type="text"  maxlength="200"/>
                        <span class="label">(for example, conviction, money penalties, exclusion from Medicare or state health care programs)</span>
                    </span>
                </div>
            </div>
            <div class="row">
                <c:set var="formName" value="_18_empPreviousExclusionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">Been excluded from participation in Medicare or any of the State health care programs? <span class="required">*</span></label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
            </div>
            <div class="row">
                <h3>Has any managing employee or agent ever:</h3>
            </div>
            <div class="row">
                <c:set var="formName" value="_18_criminalConvictionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">
                  Been convicted of a criminal offense related to that person's
                  involvement in any program under Medicare, Medicaid, Title XX,
                  or Title XXI in Minnesota or any other state or jurisdiction
                  since the inception of these programs?
                  <span class="required">*</span>
                  <a href="javascript:;" class="userHelpLink titleVHelpLink">?</a>
                </label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
            </div>
            <div class="row">
                <c:set var="formName" value="_18_civilPenaltyInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">Had civil money penalties or assessments imposed under section 1128A of the Social Security Act? <span class="required">*</span></label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>

                <div class="clear"></div>
                <div class="hideSection">
                    <label for="${formIdPrefix}_employee_full_name">Full Legal Name <span class="required">*</span></label>
                    <input id="${formIdPrefix}_employee_full_name" class="normalInput" type="text" maxlength="100"/>

                    <label for="${formIdPrefix}_employee_ssn">Social Security Number <span class="required">*</span></label>
                    <input id="${formIdPrefix}_employee_ssn" class="normalInput" type="text" maxlength="9"/>
                    <div class="clear"></div>

                    <label for="${formIdPrefix}_employee_reason">Reason for anser yes <span class="required">*</span></label>
                    <span class="floatL inputCnt">
                        <input id="${formIdPrefix}_employee_reason" class="wholeInput reason" type="text" maxlength="200"/>
                        <span class="label">(for example, conviction, money penalties, exclusion from Medicare or state health care programs)</span>
                    </span>
                </div>
            </div>
            <div class="row">
                <c:set var="formName" value="_18_previousExclusionInd"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label class="longLbl">Been excluded from participation in Medicare or any of the State health care programs? <span class="required">*</span></label>
                <label class="inline leftPadding"><input type="radio" value="Y" name="${formName}" ${formValue eq 'Y' ? 'checked' : ''} />Yes</label>
                <label class="inline leftPadding"><input type="radio" value="N" name="${formName}" ${formValue eq 'N' ? 'checked' : ''} />No</label>
                <div class="clear"></div>
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
