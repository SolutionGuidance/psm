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
        class="tab allTab <c:if test="${active_application_tab == 'all'}">active</c:if>"
        href="${ctx}/provider/applications/all?showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">All</span>
        </span>
      </a>
      <a
        class="tab draftTab <c:if test="${active_application_tab=='draft'}">active</c:if>"
        href="${ctx}/provider/applications/draft?statuses=Draft&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Draft</span>
        </span>
      </a>
      <a
        class="tab pendingTab <c:if test="${active_application_tab=='pending'}">active</c:if>"
        href="${ctx}/provider/applications/pending?statuses=Pending&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Pending</span>
        </span>
      </a>
      <a
        class="tab approvedTab <c:if test="${active_application_tab=='approved'}">active</c:if>"
        href="${ctx}/provider/applications/approved?statuses=Approved&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Approved</span>
        </span>
      </a>
      <a
        class="tab deniedTab <c:if test="${active_application_tab=='rejected'}">active</c:if>"
        href="${ctx}/provider/applications/rejected?statuses=Rejected&showFilterPanel=true"
      >
        <span class="aR">
          <span class="aM">Denied</span>
        </span>
      </a>
      <a href="${ctx}/provider/application/start" class="purpleBtn">
        New Application/Renewal
      </a>
    </div>
  </div>
</div>
