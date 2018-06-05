<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Risk Levels"/>
  <c:set var="adminPage" value="true" />
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
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
          <div class="reportTable dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <h2>Risk Levels</h2>
              </div>
              <table class="generalTable">
                <thead>
                  <tr>
                    <th>Month</th>
                    <c:forEach var="riskLevel" items="${riskLevels}">
                      <th>${riskLevel}</th>
                    </c:forEach>
                  </tr>
                </thead>
                <c:forEach var="month" items="${months}">
                  <tr>
                    <td>${month.month}</td>
                    <c:forEach var="riskLevel" items="${riskLevels}">
                      <td>${month.getNum(riskLevel)}</td>
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
