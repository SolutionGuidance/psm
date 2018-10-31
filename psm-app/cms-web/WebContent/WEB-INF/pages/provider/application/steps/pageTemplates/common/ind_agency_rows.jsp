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
    <label>Agency Name</label>
    <span>${requestScope['_11_name']}</span>
</div>
<div class="row">
    <label>Agency Id</label>
    <span>${requestScope['_11_agencyId']}</span>
</div>
<div class="row">
    <label>Agency NPI/UMPI</label>
    <span>${requestScope['_11_npi']}</span>
</div>
<div class="row">
    <label>Fax Number</label>
    <span>
        ${requestScope['_11_fax1']}<c:if test="${requestScope['_11_fax2'] ne ''}">-</c:if>${requestScope['_11_fax2']}<c:if test="${requestScope['_11_fax3'] ne ''}">-</c:if>${requestScope['_11_fax3']}
    </span>
</div>
<div class="row">
    <label>Agency Contact Name</label>
    <span>${requestScope['_11_contactName']}</span>
</div>
<div class="row">
    <label>Background Study ID</label>
    <span>${requestScope['_11_bgsId']}</span>
</div>
<div class="row">
    <label>Clearance Date</label>
    <span>${requestScope['_11_clearanceDate']}</span>
</div>
<div class="row">
    <label>Has this individual maintained continuous employment with your agency since this BGS was completed?</label>
    <span><c:choose>
        <c:when test="${requestScope['_11_continuousEmployment'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_11_continuousEmployment'] eq 'N'}">No</c:when>
    </c:choose></span>
</div>
<div class="row">
    <label> You have the option to affiliate/enroll the individual PCA  with other agencies you own without completing another
            application and agreement. Do you want to affiliate this individual PCA with any other agency(ies) you own?</label>
    <span><c:choose>
        <c:when test="${requestScope['_11_additionalAgency'] eq 'Y'}">Yes</c:when>
        <c:when test="${requestScope['_11_additionalAgency'] eq 'N'}">No</c:when>
    </c:choose></span>
</div>
