 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin screening schedules page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Screening Schedules - Functions (Service Admin)"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabFunctions" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuScreeningSchedules" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabScreeningSchedules">
              <div id="screenSchedulePanel">
                <div class="pagination">
                  <div class="right">
                    <a class="purpleBtn changeScheduleBtn" href="${ctx}/admin/beginEditScreeningSchedule">Change Schedule</a>
                  </div>
                </div>
                <!-- /.pagination -->
                <div class="newEnrollmentPanel">
                  <div class="section">
                    <div class="wholeCol">
                      <div class="row">
                        <p class="borderBottom">The system will use the following schedule to automatically screen all pending enrollments that have not been manually scheduled for screening.</p>
                      </div>
                      <div class="row">
                        <label>Upcoming screening date</label>
                        <span class="floatL"><b>:</b></span>
                        <span class="marginLeft10"><fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="MM / dd / yyyy hh:mm a"/></span>
                      </div>
                      <div class="row">
                        <label>Screening interval</label>
                        <span class="floatL"><b>:</b></span>
                        <span class="marginLeft10">Every ${schedule.interval}
                          <c:choose>
                          <c:when test="${schedule.intervalType=='DAYS'}">day<c:if test="${schedule.interval>1}">s</c:if></c:when>
                          <c:when test="${schedule.intervalType=='WEEKS'}">week<c:if test="${schedule.interval>1}">s</c:if></c:when>
                          <c:when test="${schedule.intervalType=='MONTHS'}">month<c:if test="${schedule.interval>1}">s</c:if></c:when>
                          </c:choose>
                        </span>
                      </div>
                    </div>
                  </div>

                  <div class="bl"></div>
                  <div class="br"></div>
                </div>
              </div>
              <!-- /#screenSchedulePanel -->
            </div>
            <!-- /#tabScreeningSchedules -->
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
