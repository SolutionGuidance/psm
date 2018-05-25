<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Time to Review"/>
  <c:set var="adminPage" value="true" />
  <c:set var="reportPage" value="true" />
  <c:set var="includeD3" value="true" />
  <c:set var="pageScripts" value="${[ctx.concat('/js/admin/timeToReviewReport.js')]}" />
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
            <span>Time to Review</span>
          </div>
          <div class="head">
            <h1 class="text">Time to Review</h1>
            <a
              href="${ctx}/admin/reports/timetoreview.csv"
              class="downloadTimeToReview"
            >Download this report</a>
          </div>

          <div id="timeToReviewLineGraph" class="lineGraphContainer">
           <em>Loading...</em>
          </div>

          <div class="reportTable dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <h2>Time to Review</h2>
              </div>
              <table class="generalTable">
                <thead>
                  <tr>
                    <th>Month</th>
                    <th>Number Reviewed</th>
                    <th>Mean Review Time</th>
                    <th>Median Review Time</th>
                  </tr>
                </thead>
                <c:forEach var="month" items="${months}">
                  <tr class="reportRow">
                    <td
                      class="reportDatum"
                      reportField="month"
                      reportValue="${month.month}"
                    >
                      ${month.month}
                    </td>
                    <td
                      class="reportDatum"
                      reportField="numberReviewed"
                      reportValue="${month.enrollments.size()}"
                    >
                      ${month.enrollments.size()}
                    </td>
                    <td
                      class="reportDatum"
                      reportField="meanReviewTime"
                      reportValue="${month.mean.toDays()}"
                    >
                      <c:choose>
                        <c:when test="${month.mean.isZero()}">N/A</c:when>
                        <c:otherwise>${month.meanAsString}</c:otherwise>
                      </c:choose>
                    </td>
                    <td
                      class="reportDatum"
                      reportField="medianReviewTime"
                      reportValue="${month.median.toDays()}"
                    >
                      <c:choose>
                        <c:when test="${month.median.isZero()}">N/A</c:when>
                        <c:otherwise>${month.medianAsString}</c:otherwise>
                      </c:choose>
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
