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
  <c:set var="title" value="Reviewed Documents"/>
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <c:set var="pageScripts" value="${[ctx.concat('/js/admin/reviewedDocumentsReport.js')]}" />
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
            <span>Reviewed Documents</span>
          </div>
          <div class="head">
            <h1 class="text">Reviewed Documents</h1>
            <a
              href="${ctx}/admin/reports/revieweddocuments.csv"
              class="downloadReviewedDocuments"
            >Download this report</a>
          </div>

          <div id="reviewedDocumentsLineGraph" class="lineGraphContainer">
            <em>Loading...</em>
          </div>

          <div class="reportTable dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <h2>Reviewed Documents</h2>
              </div>
              <table class="generalTable linedTable">
                <thead>
                  <tr>
                    <th>Month</th>
                    <th>Number of Documents</th>
                  </tr>
                </thead>
                <c:forEach
                  var="month"
                  items="${months}"
                  varStatus="status"
                >
                  <tr class="reportRow ${status.index % 2 == 0 ? 'odd' : 'even'}">
                    <td
                      class="reportDatum"
                      reportField="month"
                      reportValue="${month.month}"
                    >
                      ${month.month}
                    </td>
                    <td
                      class="reportDatum"
                      reportField="documents"
                      reportValue="${month.numDocuments}"
                    >
                      ${month.numDocuments}
                    </td>
                  </tr>
                </c:forEach>
              </table>
            </div>
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
