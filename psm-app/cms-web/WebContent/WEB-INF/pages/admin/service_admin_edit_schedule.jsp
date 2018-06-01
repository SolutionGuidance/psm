 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin screening schedules edit page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Edit Screening Schedule - Functions (Service Admin)"/>
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
              <form:form id="updateScreeningScheduleForm" modelAttribute="schedule" action="${ctx}/admin/updateScreeningSchedule" method="post">
                <div id="changeScreenSchedulePanel">
                  <div class="newEnrollmentPanel">
                    <div class="section">
                      <div class="wholeCol">
                        <div class="row">
                          <p class="borderBottom">The system will use the following schedule to automatically screen all pending enrollments that have not been manually scheduled for screening.</p>
                        </div>
                        <div class="row">
                          <label for="editScheduleUpcomingScreeningDateDatePart">Upcoming screening date</label>
                          <span class="floatL"><b>:</b></span>
                          <span class="marginLeft10 dateWrapper">
                            <input id="editScheduleUpcomingScreeningDateDatePart" type="text" readonly="readonly" class="date" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="MM/dd/yyyy" />' />
                          </span>
                        </div>
                        <div id="screeningTimeRow" class="row">
                          <label>Upcoming screening Time</label>
                          <span class="floatL"><b>:</b></span>
                          <input name="upcomingScreeningDateHourPart" id="upcomingScreeningDateHourPart" title="Upcoming Screening Hour" type="text" class="shortInput text" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="hh" />'/>
                          <span class="floatL"><b>:</b></span>
                          <input title="Upcoming Screening Minute" name="upcomingScreeningDateMinutePart" id="upcomingScreeningDateMinutePart" type="text" class="shortInput text" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="mm" />'/>
                          <fmt:formatDate var="upcomingScreeningDateTimeSelect" value="${schedule.upcomingScreeningDate}" pattern="a" />
                          <select title="Upcoming Screening Time Period" id="upcomingScreeningDateSelect" class="timeSelect">
                            <option <c:if test="${upcomingScreeningDateTimeSelect=='AM'}">selected="selected"</c:if> value="AM">AM</option>
                            <option <c:if test="${upcomingScreeningDateTimeSelect=='PM'}">selected="selected"</c:if> value="PM">PM</option>
                          </select>
                          <form:hidden path="upcomingScreeningDate" id="upcomingScreeningDateField"/>
                          <form:hidden path="id"/>
                        </div>
                        <div id="intervalRow" class="row">
                          <label for="screeningInterval">Screening interval</label>
                          <span class="floatL"><b>:</b></span>
                          <span class="marginLeft10 floatL">
                            <span class="floatL">Every</span>
                            <form:input id="screeningInterval" path="interval" cssClass="text shortInput marginLeft20"/>
                            <form:select id="intervalType" title="Interval Type" cssClass="timeSelect" path="intervalType">
                              <form:option value="DAYS">day(s)</form:option>
                              <form:option value="WEEKS">week(s)</form:option>
                              <form:option value="MONTHS">month(s)</form:option>
                            </form:select>
                          </span>
                        </div>
                      </div>
                    </div>
                    <div class="bl"></div>
                    <div class="br"></div>
                  </div>
                  <div class="buttons">
                    <a href="${ctx}/admin/getScreeningSchedule" class="greyBtn">Cancel</a>
                    <button class="greyBtn saveScheduleBtn" type="submit">Save</button>
                  </div>
                </div>
              </form:form>
              <!-- /#changeScreenSchedulePanel -->
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
