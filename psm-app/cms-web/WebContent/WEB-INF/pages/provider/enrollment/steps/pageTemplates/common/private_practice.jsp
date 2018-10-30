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
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<div class="row">
    <label>Private Practice Name</label>
    <span id="privatePracticeName">${requestScope['_05_name']}</span>
</div>
<div class="row">
    <label>Effective Date</label>
    <span id="effectiveDate">${requestScope['_05_effectiveDate']}</span>
</div>
<div class="row">
    <label>Group NPI/UMPI</label>
    <span id="groupNPI">${requestScope['_05_npi']}</span>
</div>
<div class="row">
    <label>Practice Address</label>
    <h:address name="practice"
        streetAddress="${requestScope['_05_addressLine1']}"
        extendedAddress="${requestScope['_05_addressLine2']}"
        city="${requestScope['_05_city']}"
        state="${requestScope['_05_state']}"
        postalCode="${requestScope['_05_zip']}"
        county="${requestScope['_05_county']}" />
</div>
<div class="row">
    <label>Practice Phone Number</label>
    <span id="practicePhoneNumber">
    ${requestScope['_05_phone1']}<c:if test="${requestScope['_05_phone2'] ne ''}"> - </c:if>${requestScope['_05_phone2']}<c:if test="${requestScope['_05_phone3'] ne ''}"> - </c:if>${requestScope['_05_phone3']}<c:if test="${requestScope['_05_phone4'] ne ''}"> ext. </c:if>${requestScope['_05_phone4']}
    </span>
</div>
<div class="row">
    <label>Practice Fax Number</label>
    <c:set var="formName" value="_05_faxNumber"></c:set>
    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
    <span id="practiceFaxNumber">
    ${requestScope['_05_fax1']}<c:if test="${requestScope['_05_fax2'] ne ''}"> - </c:if>${requestScope['_05_fax2']}<c:if test="${requestScope['_05_fax3'] ne ''}"> - </c:if>${requestScope['_05_fax3']}
    </span>
</div>
<div class="row">
    <label>Billing Address</label>
    <c:if test="${requestScope['_05_billingSameAsPrimary'] eq 'Y'}">
        <span id="billingSameAsPrimary">Same As Above</span>
    </c:if>
    <c:if test="${requestScope['_05_billingSameAsPrimary'] ne 'Y'}">
        <h:address name="billing"
            streetAddress="${requestScope['_05_billingAddressLine1']}"
            extendedAddress="${requestScope['_05_billingAddressLine2']}"
            city="${requestScope['_05_billingCity']}"
            state="${requestScope['_05_billingState']}"
            postalCode="${requestScope['_05_billingZip']}"
            county="${requestScope['_05_billingCounty']}" />
    </c:if>
</div>
<div class="row">
    <label>
      <abbr title="Federal Employer Identification Number">FEIN</abbr>
    </label>
    <span id="fein">${requestScope['_05_fein']}</span>
</div>
<div class="row">
    <label>State Tax ID</label>
    <span id="stateTaxId">${requestScope['_05_stateTaxId']}</span>
</div>
<div class="row">
    <label>Fiscal Year End</label>
    <span id="fiscalYearEnd">
        ${requestScope['_05_fye1']}
        <c:if test="${requestScope['_05_fye2'] ne ''}">/</c:if>
        ${requestScope['_05_fye2']}
    </span>
</div>
<div class="row">
    <label>Do you accept <abbr title="Electronic Funds Transfer">EFT</abbr>?</label>
    <span id="eftAccepted">${requestScope['_05_eftAccepted'] ? 'Yes' : 'No'}</span>
</div>
<div class="row">
    <label>Remittance Sequence</label>
    <span id="remittanceSequence"><c:choose>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER'}">
            Patient Account or Own Reference Number Order
        </c:when>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'DHS_TRANSACTION_CONTROL_ORDER'}">
            DHS Transaction Control Number Order
        </c:when>
        <c:when test="${requestScope['_05_remittanceSequence'] eq 'RECIPIENT_MHCP_ID_NUMBER_ORDER'}">
            Recipient MHCP ID Number Order
        </c:when>
    </c:choose></span>
</div>
