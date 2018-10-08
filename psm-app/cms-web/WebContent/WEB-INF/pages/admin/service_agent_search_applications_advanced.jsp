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
  - Description: This is the advanced search page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Advanced Search"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->
          <div class="breadCrumb">
            <span class="text">Advanced Search</span>
          </div>
          <h1>Advanced Search</h1>
          <div class="tabSection" id="advancedSearch">
            <c:set var="applicationSearchFormAction" value="${ctx}/provider/search/advanced"/>
            <c:set var="searchResult" value="${results}"/>
            <%@ include file="/WEB-INF/pages/admin/includes/application_search_form.jsp" %>
            <div class="detailPanel" id="advancedFilterPanel">
              <div class="section">
                <div class="leftCol">
                  <div class="row">
                    <label for="npiInput">Application #</label>
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
                <!-- /.leftCol -->
                <div class="rightCol">
                  <div class="row checkRow">
                    <label>Request Type</label>
                    <div class="checkWrapper">
                      <label class="checkboxLabel">
                        <input type="checkbox" name="requestType" class="checkAll" />
                        <span class="label">All</span>
                      </label>
                      <c:forEach var="item" items="${requestTypesLookup}">
                        <label class="checkboxLabel">
                          <input type="checkbox" name="requestType" class="requestType" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.requestTypes}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                          <span class="label">${item.description}</span>
                        </label>
                      </c:forEach>
                    </div>
                  </div>
                  <div class="row checkRow">
                    <label>Status</label>
                    <div class="checkWrapper">
                      <label class="checkboxLabel">
                        <input type="checkbox" name="applicationStatus" class="checkAll" />
                        <span class="label">All</span>
                      </label>
                      <c:forEach var="item" items="${applicationStatusesLookup}">
                        <label class="checkboxLabel">
                          <input type="checkbox" name="applicationStatus" class="applicationStatus" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.statuses}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                          <span class="label">${item.description eq 'Rejected' ? 'Denied' : item.description}</span>
                        </label>
                      </c:forEach>
                    </div>
                  </div>
                  <div class="row checkRow">
                    <label>Risk Level</label>
                    <div class="checkWrapper">
                      <label class="checkboxLabel">
                        <input type="checkbox" name="riskLevel" class="checkAll" />
                        <span class="label">All</span>
                      </label>
                      <c:forEach var="item" items="${riskLevelsLookup}">
                        <label class="checkboxLabel">
                          <input type="checkbox" name="riskLevel" class="riskLevel" value="${item.description}" <c:forEach var="selectedItem" items="${searchCriteria.riskLevels}"><c:if test="${item.description == selectedItem}">checked="checked"</c:if></c:forEach>/>
                          <span class="label">${item.description}</span>
                        </label>
                      </c:forEach>
                    </div>
                  </div>
                </div>
                <!-- /.rightCol -->
                <div class="clearFixed"></div>
              </div>
              <!-- /.section -->
              <div class="tl"></div>
              <div class="tr"></div>
            </div>
            <div class="clearFixed"></div>
            <div class="buttons">
              <a id="showSearchApplicationsResultBtn" href="javascript:;" class="purpleBtn"><span class="icon">Search</span><span class="arrow"></span></a>
            </div>
          </div>
          <!-- /.tabSection -->
          <div class="tabSection" id="searchResultsSection">
            <div class="sectionHeader">
              <h2>Search Results</h2>
              <div class="tl"></div>
              <div class="tr"></div>
            </div>
            <c:choose>
            <c:when test="${searchResult.total == 0}">
              <div class="tabContent">
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
              </div>
            </c:when>
            <c:otherwise>
              <div class="tabContent">
                <div class="pagination">
                  <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
                  <div class="right">
                    <a id="exportApplicationsToPDF" href="javascript:;" class="greyBtn iconPdf">Export to PDF</a>
                  </div>
                </div>
                <!-- /.pagination -->
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
                <%@ include file="/WEB-INF/pages/admin/includes/high_risk_level_means.jsp" %>
              </div>
            </c:otherwise>
            </c:choose>

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
