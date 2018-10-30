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
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${requestScope['_18_bound'] eq 'Y'}">
<div class="tableHeader">
    <span>Provider Disclosure</span>
</div>

<div class="section orgDisclosureRd">

    <div class="eightytwenty">
        <div class="row">
            <h3>Has any person having an ownership or control interest ever:</h3>
        </div>

        <div class="row">
            <label>Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs?</label>
            <c:if test="${requestScope['_18_empCriminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empCriminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
            <c:if test="${requestScope['_18_empCivilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empCivilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Been excluded from participation in Medicare or any of the State health care programs?</label>
            <c:if test="${requestScope['_18_empPreviousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_empPreviousExclusionInd'] eq 'N'}"><span>No</span></c:if>
        </div>

        <div class="row">
            <h3>Has any managing employee or agent ever:</h3>
        </div>

        <div class="row">
            <label>Been convicted of a criminal offense related to that person's involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in Minnesota or any other state or jurisdiction since the inception of these programs?</label>
            <c:if test="${requestScope['_18_criminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_criminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
            <c:if test="${requestScope['_18_civilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_civilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="row">
            <label>Been excluded from participation in Medicare or any of the State health care programs?</label>
            <c:if test="${requestScope['_18_previousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
            <c:if test="${requestScope['_18_previousExclusionInd'] eq 'N'}"><span>No</span></c:if>
        </div>
        <div class="clearFixed"></div>
    </div>
</div>
</c:if>
