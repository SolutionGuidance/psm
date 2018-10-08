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
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Draft Applications"/>
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <c:set var="pageScripts" value="${[ctx.concat('/js/admin/draftsReport.js')]}" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabReports" value="true" />
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            <a href="<c:url value='/admin/reports' />">Reports</a>
            <span>Draft Applications</span>
          </div>
          <div class="head">
            <h1 class="text">Draft Applications</h1>
            <a
              href="${ctx}/admin/reports/draftapplications.csv"
              class="downloadDraftApplications"
            >Download this report</a>
          </div>

          <div id="draftApplicationsLineGraph" class="lineGraphContainer">
            <em>Loading...</em>
          </div>

          <div class="reportTable dashboardPanel">
            <c:forEach var="applicationMonth" items="${applicationMonths}">
              <div class="wideTableData tableData">
                <div class="tableTitle">
                  <h2>${applicationMonth.month}</h2>
                </div>
                <table class="generalTable linedTable">
                  <thead>
                    <tr>
                      <th>Application ID</th>
                      <th>NPI</th>
                      <th>Provider Name</th>
                      <th>Provider Type</th>
                      <th>Creation Date</th>
                      <th>Submission Date</th>
                    </tr>
                  </thead>
                  <c:forEach
                    var="application"
                    items="${applicationMonth.applications}"
                    varStatus="status"
                  >
                  <tr class="reportRow ${status.index % 2 == 0 ? 'odd' : 'even'}">
                    <td class="reportDatum nonedisplay" reportField="month" reportValue="${applicationMonth.month}"></td>
                    <td class="reportDatum" reportField="applicationId" reportValue="${application.applicationId}">
                      <a href="${ctx}/provider/application/view?id=${application.applicationId}">
                        ${application.applicationId}
                      </a>
                    </td>
                    <td>${application.details.entity.npi}</td>
                    <td>${application.details.entity.name}</td>
                    <td>${application.details.entity.providerType.description}</td>
                    <td class="reportDatum" reportField="createdOn" reportValue="${application.createdOn}">
                      <fmt:formatDate value="${application.createdOn}" pattern="dd MMMM yyyy" />
                    </td>
                    <td class="reportDatum" reportField="submissionDate" reportValue="${application.submissionDate}">
                      <fmt:formatDate value="${application.submissionDate}" pattern="dd MMMM yyyy" />
                    </td>
                  </tr>
                  </c:forEach>
                </table>
              </div>
            </c:forEach>
          </div>
          <!-- /.section -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
