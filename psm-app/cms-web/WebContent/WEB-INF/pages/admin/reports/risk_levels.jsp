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
  <c:set var="title" value="Risk Levels"/>
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <c:set var="pageScripts" value="${[ctx.concat('/js/admin/riskLevelsReport.js')]}" />
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
            <a href="<c:url value='/admin/reports' />">Reports</a>
            <span>Risk Levels</span>
          </div>
          <div class="head">
            <h1 class="text">Risk Levels</h1>
            <a
              href="${ctx}/admin/reports/risklevels.csv"
              class="downloadRiskLevels"
            >Download this report</a>
          </div>

          <div id="riskLevelsLineGraph" class="lineGraphContainer">
            <em>Loading...</em>
          </div>

          <p>
            This report covers only the applications that have been reviewed
            (approved or denied), and not applications that have been
            submitted but not yet reviewed.
          </p>

          <div class="reportTable dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <h2>Risk Levels</h2>
              </div>
              <table class="generalTable linedTable">
                <thead>
                  <tr>
                    <th>Month</th>
                    <c:forEach var="riskLevel" items="${riskLevels}">
                      <th>${riskLevel}</th>
                    </c:forEach>
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
                    <c:forEach var="riskLevel" items="${riskLevels}">
                      <td
                        class="reportDatum"
                        reportField="${riskLevel.toLowerCase()}"
                        reportValue="${month.getNum(riskLevel)}"
                      >
                        ${month.getNum(riskLevel)}
                      </td>
                    </c:forEach>
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
