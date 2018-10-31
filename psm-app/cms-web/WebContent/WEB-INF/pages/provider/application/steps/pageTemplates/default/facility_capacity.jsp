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
<%-- Used for Regional Treatment Center application --%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:set var="formIdPrefix" value="facility_capacity"></c:set>
<c:set var="selectedMarkup" value='selected="selected"' />

<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_CAPACITY_FORM %>">
<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="section">
        <div class="leftCol">
            <div class="row requireField">
                <c:set var="formName" value="_27_numberOfBeds"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Number of Beds <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="6"/>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="rightCol">
            <div class="row requireField">
                <c:set var="formName" value="_27_effectiveDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Effective Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
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
</div>
