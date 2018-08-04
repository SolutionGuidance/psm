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
<c:if test="${requestScope['_38_bound'] eq 'Y'}">
<div class="section">
    <div class="wholeCol">
        <div class="row">
            <label>Does your facility provide physical or occupational therapy to community residents?</label>
            <span >${requestScope['_38_therapyIndicator']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>Bed Count</label>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>SKILLED NURSING FACILITY (TITLE 18 ONLY)</label>
            <span >${requestScope['_38_title18BedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>NURSING FACILITY (TITLE 19 ONLY)</label>
            <span >${requestScope['_38_title19BedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>SKILLED NURSING FACILITY DUAL CERTIFIED (TITLE 18/19)</label>
            <span >${requestScope['_38_dualCertBedCount']}</span>
        </div>
    </div>
    <div class="wholeCol">
        <div class="row">
            <label>ICF/DD</label>
            <span >${requestScope['_38_icfBedCount']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
