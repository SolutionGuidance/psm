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
<c:if test="${requestScope['_24_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <div class="row">
            <label>Name of Responsible Billing Person</label>
            <span >${requestScope['_24_billingContactName']}</span>
        </div>
        <div class="row">
            <label>Title</label>
            <span >${requestScope['_24_billingContactTitle']}</span>
        </div>
        <div class="row">
            <label>Date of Employment</label>
            <span >${requestScope['_24_billingContactHireDate']}</span>
        </div>
        <div class="row">
            <label>Social Security Number</label>
            <span >${requestScope['_24_billingContactSSN']}</span>
        </div>
        <div class="row">
            <label>Date of Birth</label>
            <span >${requestScope['_24_billingContactDOB']}</span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
