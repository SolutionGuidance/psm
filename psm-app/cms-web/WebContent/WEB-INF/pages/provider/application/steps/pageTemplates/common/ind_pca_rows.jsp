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
<div class="row">
    <label>First Name</label>
    <span>${requestScope['_10_firstName']}</span>
</div>
<div class="row">
    <label>Middle Name</label>
    <span>${requestScope['_10_middleName']}</span>
</div>
<div class="row">
    <label>Last Name</label>
    <span>${requestScope['_10_lastName']}</span>
</div>
<div class="row">
    <label>Social Security Number</label>
    <span>${requestScope['_10_ssn']}</span>
</div>
<div class="row address">
    <label>Residential Address</label>
    <h:address name="residential"
        streetAddress="${requestScope['_10_addressLine1']}"
        extendedAddress="${requestScope['_10_addressLine2']}"
        city="${requestScope['_10_city']}"
        state="${requestScope['_10_state']}"
        postalCode="${requestScope['_10_zip']}"
        county="${requestScope['_10_county']}" />
</div>

<div class="row">
    <label>UMPI</label>
    <span>${requestScope['_10_npi']}</span>
</div>

<div class="row">
    <label>Date of Birth</label>
    <span>${requestScope['_10_dob']}</span>
</div>

<div class="row">
    <label>Phone Number</label>
    <span>
    ${requestScope['_10_phone1']}<c:if test="${requestScope['_10_phone2'] ne ''}">-</c:if>${requestScope['_10_phone2']}<c:if test="${requestScope['_10_phone3'] ne ''}">-</c:if>${requestScope['_10_phone3']}<c:if test="${requestScope['_10_phone4'] ne ''}">ext.</c:if>${requestScope['_10_phone4']}
    </span>
</div>

<div class="row">
    <label>Are you 18 years or older?</label>
    <span><c:choose>
        <c:when test="${requestScope['_10_adultInd'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_10_adultInd'] eq 'N'}">No</c:when>
    </c:choose></span>
</div>
