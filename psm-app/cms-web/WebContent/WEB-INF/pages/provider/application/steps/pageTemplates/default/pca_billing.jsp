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
<c:set var="formIdPrefix" value="pca_billing"></c:set>

<div class="newApplicationPanel practicePanel">
    <div class="tableHeader topHeader"><span>Designation of PCA Billing Person</span></div>
    <div class="sectionInfo">By signing below, I, the above named owner of the named PCA agency, am assigning the following individual as responsible and accountable for understanding my agency's billing practices related to reimbursement of MHCP claims for PCA services provided.</div>
    <div class="clearFixed"></div>
    <div class="section line">
        <input type="hidden" name="formNames" value="<%= ViewStatics.PCA_BILLING_CONTACT_FORM %>">
        <div class="wholeCol organizationInfo">
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactName"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Name of Responsible Billing Person <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="100"/>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactTitle"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Title <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_24_billingContactHireDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Employment</label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_24_billingContactSSN"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Social Security Number <span class="required">*</span></label>
                <input id="${formIdPrefix}_${formName}" type="text" class="ssnMasked normalInput" name="${formName}" value="${formValue}" maxlength="11"/>
            </div>
            <div class="row">
                <c:set var="formName" value="_24_billingContactDOB"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="${formIdPrefix}_${formName}">Date of Birth</label>
                <span class="dateWrapper floatL">
                    <input id="${formIdPrefix}_${formName}" class="date" type="text" name="${formName}" value="${formValue}"/>
                </span>
            </div>
            <div class="clearFixed"></div>
        </div>
       <div class="clearFixed"></div>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
