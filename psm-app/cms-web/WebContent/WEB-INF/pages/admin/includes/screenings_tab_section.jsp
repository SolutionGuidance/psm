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
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a
        class="tab screeningsAllTab
          <c:if test="${activeTab=='all'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            All
          </span>
        </span>
      </a>
      <a
        class="tab screeningsFailedTab
          <c:if test="${activeTab=='fail'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            Failed
          </span>
        </span>
      </a>
      <a
        class="tab screeningsPassedTab
          <c:if test="${activeTab=='pass'}">active</c:if>"
        href="#"
      >
        <span class="aR">
          <span class="aM">
            Passed
          </span>
        </span>
      </a>
      <a
        class="tab screeningsErrorsTab
          <c:if test="${activeTab=='error'}">active</c:if>"
        href="#" 
      >
        <span class="aR">
          <span class="aM">
            Errors
          </span>
        </span>
      </a>
    </div>
  </div>
</div>
