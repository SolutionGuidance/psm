<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Draft Applications"/>
  <c:set var="adminPage" value="true" />
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
            <c:forEach var="enrollmentMonth" items="${enrollmentMonths}">
              <div class="tableData">
                <div class="tableTitle">
                  <h2>${enrollmentMonth.month}</h2>
                </div>
                <table class="generalTable">
                  <thead>
                    <tr>
                      <th>Application ID</th>
                      <th>Creation Date</th>
                      <th>Submission Date</th>
                    </tr>
                  </thead>
                  <c:forEach var="enrollment" items="${enrollmentMonth.enrollments}">
                  <tr class="reportRow">
                    <td class="reportDatum nonedisplay" reportField="month" reportValue="${enrollmentMonth.month}"></td>
                    <td class="reportDatum" reportField="ticketId" reportValue="${enrollment.ticketId}">
                      ${enrollment.ticketId}
                    </td>
                    <td class="reportDatum" reportField="createdOn" reportValue="${enrollment.createdOn}">
                      <fmt:formatDate value="${enrollment.createdOn}" pattern="dd MMMM yyyy" />
                    </td>
                    <td class="reportDatum" reportField="submissionDate" reportValue="${enrollment.submissionDate}">
                      <fmt:formatDate value="${enrollment.submissionDate}" pattern="dd MMMM yyyy" />
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
