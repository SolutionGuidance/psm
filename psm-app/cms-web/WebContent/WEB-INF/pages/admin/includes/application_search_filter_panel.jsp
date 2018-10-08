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
  The filter panel for: admin user login > Applications > All, Draft, etc. pages.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div
  id="applicationFilterPanel"
  class="filterPanel"
  <c:choose>
    <c:when test="${searchCriteria.showFilterPanel}">
      style="display: block"
    </c:when>
    <c:otherwise>
      style="display: none"
    </c:otherwise>
  </c:choose>
>
  <div class="floatW">
    <div class="leftCol">
      <div class="row">
        <label for="applicationSearchFilterNpiInput">
          NPI/UMPI
        </label>
        <input
          id="applicationSearchFilterNpiInput"
          type="text"
          class="normalInput"
          value="${searchCriteria.npi}"
        />
      </div>
      <div class="row">
        <label>Date Submitted</label>
        <span class="dateWrapper floatL">
          <input
            id="submissionDateStartInput"
            title="Submission Date Start"
            value='<fmt:formatDate value="${searchCriteria.submissionDateStart}" pattern="MM/dd/yyyy"/>'
            class="date"
            type="text"
            readonly="readonly"
          />
        </span>
        <span class="floatL"> - </span>
        <span class="dateWrapper floatL">
          <input
            id="submissionDateEndInput"
            title="Submission Date End"
            value='<fmt:formatDate value="${searchCriteria.submissionDateEnd}" pattern="MM/dd/yyyy"/>'
            class="date"
            type="text"
            readonly="readonly"
          />
        </span>
      </div>
      <div class="row">
        <label for="applicationSearchFilterProviderTypeInput">
          Provider Type
        </label>
        <select
          id="applicationSearchFilterProviderTypeInput"
          class="longSelect"
        >
          <option value="">All</option>
          <c:forEach var="item" items="${providerTypesLookup}">
            <option
              value="${item.description}"
              <c:if test="${item.description == searchCriteria.providerType}">
                selected="selected"
              </c:if>
            >
              ${item.description}
            </option>
          </c:forEach>
        </select>
      </div>
      </div>
      <div class="rightCol">
        <div class="row">
          <label for="applicationSearchFilterProviderNameInput">
            Provider Name
          </label>
          <input
            id="applicationSearchFilterProviderNameInput"
            value="${searchCriteria.providerName}"
            type="text"
            class="normalInput"
          />
        </div>
        <div class="row">
          <label for="applicationSearchFilterRequestTypeInput">
            Request Type
          </label>
          <select
            id="applicationSearchFilterRequestTypeInput"
            class="longSelect"
          >
            <option value="">All</option>
            <c:forEach var="item" items="${requestTypesLookup}">
              <option
                <c:forEach
                  var="selectedItem"
                  items="${searchCriteria.requestTypes}"
                >
                  <c:if test="${item.description == selectedItem}">
                    selected="selected"
                  </c:if>
                </c:forEach>
                value="${item.description}"
              >
                ${item.description}
              </option>
            </c:forEach>
          </select>
        </div>
        <div class="row">
          <label for="applicationSearchFilterRiskLevelInput">
            Risk Level
          </label>
          <select
            id="applicationSearchFilterRiskLevelInput"
            class="longSelect"
          >
            <option value="">All</option>
            <c:forEach var="item" items="${riskLevelsLookup}">
              <option
                <c:forEach
                  var="selectedItem"
                  items="${searchCriteria.riskLevels}"
                >
                  <c:if test="${item.description == selectedItem}">
                    selected="selected"
                  </c:if>
                </c:forEach>
                value="${item.description}"
              >
                ${item.description}
              </option>
            </c:forEach>
          </select>
        </div>
      </div>
    </div>
    <a
      id="showSearchApplicationsResultBtn"
      href="javascript:;"
      class="purpleBtn showResultBtn"
    >
      Filter
    </a>
</div>
<div class="clearFixed"></div>
<div class="tabCorner hide">
  <div class="tabCornerR">
    <div class="tabCornerM"></div>
  </div>
</div>
<!-- /.filterPanel -->
