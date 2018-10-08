<%--
  Copyright 2012 TopCoder Inc.
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
  - Description: This is the quick search result page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Search Results"/>
  <c:set var="quickSearchNpi" value="${param.npi}" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <span class="text">Search Results</span>
          </div>
          <h1>Search Results</h1>
          <div class="tabSection" id="searchResultsSection">
            <c:set var="applicationSearchFormAction" value="${ctx}/provider/search/quick"/>
            <c:set var="searchResult" value="${results}"/>
            <%@ include file="/WEB-INF/pages/admin/includes/application_search_form.jsp" %>
            <div class="sectionHeader">
              <h2>Search Results</h2>
              <div class="tl"></div>
              <div class="tr"></div>
            </div>
            <div class="tabContent">
              <div class="pagination">
                <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
                <%@ include file="/WEB-INF/pages/admin/includes/application_buttons.jsp" %>
              </div>
              <div <c:choose><c:when test="${searchCriteria.showFilterPanel}">style="display: block"</c:when><c:otherwise>style="display: none"</c:otherwise></c:choose> id="quickApplicationFilterPanel" class="filterPanel">
                <div class="floatW">
                  <div class="leftCol">
                    <div class="row">
                      <label for="npiInput">NPI/UMPI</label>
                      <input id="npiInput" type="text" class="normalInput" value="${searchCriteria.npi}"/>
                    </div>
                    <div class="row">
                      <label>Date Submitted</label>
                      <span class="dateWrapper floatL">
                        <input id="submissionDateStartInput" title="Submission Date Start" value='<fmt:formatDate value="${searchCriteria.submissionDateStart}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
                      </span>
                      <span class="floatL"> - </span>
                      <span class="dateWrapper floatL">
                        <input id="submissionDateEndInput" title="Submission Date End" value='<fmt:formatDate value="${searchCriteria.submissionDateEnd}" pattern="MM/dd/yyyy"/>' class="date" type="text" readonly="readonly"/>
                      </span>
                    </div>
                    <div class="row">
                      <label for="providerTypeInput">Provider Type</label>
                      <select id="providerTypeInput" class="longSelect">
                        <option value="">All</option>
                        <c:forEach var="item" items="${providerTypesLookup}">
                          <option <c:if test="${item.description == searchCriteria.providerType}">selected="selected"</c:if> value="${item.description}">${item.description}</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="row">
                      <label for="providerNameInput">Provider Name</label>
                      <input id="providerNameInput" value="${searchCriteria.providerName}" type="text" class="normalInput"/>
                    </div>
                  </div>
                  <div class="rightCol">
                    <div class="row">
                      <label for="requestTypeInput">Request Type</label>
                      <select id="requestTypeInput" class="longSelect">
                        <option value="">All</option>
                        <c:forEach var="item" items="${requestTypesLookup}">
                          <option <c:forEach var="selectedItem" items="${searchCriteria.requestTypes}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="row">
                      <label for="applicationStatusesInput">Status</label>
                      <select id="applicationStatusesInput" class="longSelect">
                        <option value="">All</option>
                        <c:forEach var="item" items="${applicationStatusesLookup}">
                          <option <c:forEach var="selectedItem" items="${searchCriteria.statuses}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="row">
                      <label for="riskLevelInput">Risk Level</label>
                      <select id="riskLevelInput" class="longSelect">
                        <option value="">All</option>
                        <c:forEach var="item" items="${riskLevelsLookup}">
                          <option <c:forEach var="selectedItem" items="${searchCriteria.riskLevels}"><c:if test="${item.description == selectedItem}">selected="selected"</c:if></c:forEach> value="${item.description}">${item.description}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                </div>
                <a id="showSearchApplicationsResultBtn" href="javascript:;" class="purpleBtn showResultBtn">Filter</a>
              </div>
              <!-- /.filterPanel -->
              <c:choose>
              <c:when test="${searchResult.total == 0}">
                <div class="tableWrapper">
                  <div class="tableContainer"></div>
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM red">
                        No matched data found.
                      </div>
                    </div>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <div class="tableWrapper">
                  <div class="tableContainer">
                    <c:set var="addStatusColumn" value="yes"/>
                    <c:set var="searchTableId" value="resultsTable"/>
                    <%@ include file="/WEB-INF/pages/admin/includes/application_search_result_table.jsp" %>
                  </div>
                  <!-- /.tableContainer -->
                  <div class="tabFoot">
                    <div class="tabR">
                      <div class="tabM">
                        <%@ include file="/WEB-INF/pages/includes/pagination_details_and_links.jsp" %>
                      </div>
                    </div>
                  </div>
                  <!-- /.tabFoot -->
                </div>
              </c:otherwise>
              </c:choose>
              <%@ include file="/WEB-INF/pages/admin/includes/high_risk_level_means.jsp" %>
            </div>
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->
      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <!-- #footer -->
    </div>
    <!-- /#wrapper -->
  </body>
</html>
