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
    <label>Contact Name</label>
    <span id="contactName">${requestScope['_02_contactName']}</span>
</div>

<div class="row">
    <label>Contact Email Address</label>
    <span id="contactEmail">${requestScope['_02_contactEmail']}</span>
</div>

<div class="row">
    <label>Contact Phone Number</label>
    <span>
        ${requestScope['_02_contactPhone1']}
        <c:if test="${requestScope['_02_contactPhone2'] ne ''}"> - </c:if>
        ${requestScope['_02_contactPhone2']}
        <c:if test="${requestScope['_02_contactPhone3'] ne ''}"> - </c:if>
        ${requestScope['_02_contactPhone3']}
        <c:if test="${requestScope['_02_contactPhone4'] ne ''}"> ext. </c:if>
        ${requestScope['_02_contactPhone4']}
    </span>
</div>
