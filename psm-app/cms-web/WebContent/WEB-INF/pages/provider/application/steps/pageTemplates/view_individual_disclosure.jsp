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
<div id="tabStatement" class="tabContent">
    <div class="topPanel">
        <div class="tableHeader">
            <span>Provider Disclosure</span>
        </div>
        <div class="wideCol">
            <div class="row">
                <label>Have you ever been convicted of a criminal offense related to involvement in any program under Medicare, Medicaid, Title XX, or Title XXI in
                    Minnesota or any other state or jurisdiction since the inception of these programs?</label>
                <c:if test="${requestScope['_08_criminalConvictionInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_criminalConvictionInd'] eq 'N'}"><span>No</span></c:if>
            </div>
            <div class="row">
                <label>Have you had civil money penalties or assessments imposed under section 1128A of the Social Security Act?</label>
                <c:if test="${requestScope['_08_civilPenaltyInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_civilPenaltyInd'] eq 'N'}"><span>No</span></c:if>
            </div>
            <div class="row">
                <label>Have you ever been excluded or terminated from participation in Medicare, Medicaid, Children's Health Insurance Program (CHIP),
                    or the Title XXI services program in Minnesota or any other state since the inception of these programs? </label>
                <c:if test="${requestScope['_08_previousExclusionInd'] eq 'Y'}"><span>Yes</span></c:if>
                <c:if test="${requestScope['_08_previousExclusionInd'] eq 'N'}"><span>No</span></c:if>
            </div>
        </div>
    </div>
    <div class="tableHeader">
        <span>Provider Statement</span>
    </div>
    <div class="bottomPanel">
        <div class="row">
            <p>
                I certify that the information provided on this form is accurate, complete and truthful.
                I will notify MHCP Provider Application of any changes to this information. I acknowledge
                that any misrepresentations in the information submitted to MHCP, including false claims,
                statements, documents, or concealment of a material fact, may be cause for denial or termination
                of participation as a Medicaid provider.
            </p>
        </div>
        <div class="row">
            <div class="leftCol">
                <div class="row">
                    <label>Provider Name</label>
                    <span>${requestScope['_08_name']}</span>
                </div>
                <div class="row">
                    <label>Provider Title</label>
                    <span>${requestScope['_08_title']}</span>
                </div>
            </div>
        </div>
        <div class="row">&nbsp;</div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
