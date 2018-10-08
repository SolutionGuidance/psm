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
<%--
  The filter panel for the provider login > Dashboard page.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url var="filterResultsURL" value="/provider/dashboard/list/filter" />

<form:form
  action="${filterResultsURL}"
  id="filterForm"
  cssClass="paginationForm"
  method="get"
  commandName="criteria"
>
  <div
    class="filterPanel"
    style="display: ${param.filterViewState == 'visible' ? 'block' : 'none'};"
  >
    <div class="floatW">
      <input
        type="hidden"
        id="filterViewStateId"
        name="filterViewState"
        value="${param.filterViewState == 'visible' ? 'visible' : 'hidden'}"
      />
      <form:hidden path="pageSize" />
      <form:hidden path="pageNumber" />
      <form:hidden path="sortColumn" />
      <form:hidden path="ascending" />

      <div class="leftCol">
        <div class="row">
          <label for="dashboardFilterNpi">NPI/UMPI</label>
          <form:input
            id="dashboardFilterNpi"
            path="npi"
            cssClass="normalInput"
          />
        </div>
        <div class="row">
          <label for="dashboardFilterRequestTypes">Request Type</label>
          <form:select
            id="dashboardFilterRequestTypes"
            path="requestTypes"
            cssClass="longSelect"
            multiple="false"
          >
            <form:option value="">All</form:option>
            <form:option value="Application">Application</form:option>
            <form:option value="Renewal">Renewal</form:option>
            <form:option value="Update">Update</form:option>
            <form:option value="Import Profile">Import Profile</form:option>
          </form:select>
        </div>
        <div class="row">
          <label>Date Submitted</label>
          <span class="dateWrapper floatL">
            <form:input
              title="Submission Start"
              path="submissionDateStart"
              cssClass="date"
              readonly=""
            />
          </span>
          <span class="floatL"> - </span>
          <span class="dateWrapper floatL">
            <form:input
              title="Submission End"
              path="submissionDateEnd"
              cssClass="date"
              readonly=""
            />
          </span>
        </div>
      </div>

      <div class="rightCol">
        <div class="row">
          <label for="dashboardFilterStatuses">Status</label>
          <form:select
            id="dashboardFilterStatuses"
            path="statuses"
            cssClass="longSelect"
            multiple="false"
          >
            <form:option value="">All</form:option>
            <form:option value="Draft">Draft</form:option>
            <form:option value="Pending">Pending</form:option>
            <form:option value="Approved">Approved</form:option>
            <form:option value="Rejected">Denied</form:option>
          </form:select>
        </div>
        <div class="row">
          <label for="dashboardFilterRiskLevel">Risk Level</label>
          <form:select
            id="dashboardFilterRiskLevel"
            path="riskLevel"
            cssClass="longSelect"
          >
            <form:option value="">All</form:option>
            <form:option value="NULL">Not screened yet</form:option>
            <form:option value="Low">Low</form:option>
            <form:option value="Moderate">Moderate</form:option>
            <form:option value="High">High</form:option>
          </form:select>
        </div>
        <div class="row">
          <label>Status Date</label>
          <span class="dateWrapper floatL">
            <form:input
              title="Status Start"
              path="statusDateStart"
              cssClass="date"
              readonly=""
            />
          </span>
          <span class="floatL"> - </span>
          <span class="dateWrapper floatL">
            <form:input
              title="Status End"
              path="statusDateEnd"
              cssClass="date"
              readonly=""
            />
          </span>
        </div>
      </div>

    </div>
    <button class="purpleBtn" type="submit">Filter</button>
  </div>
</form:form>
