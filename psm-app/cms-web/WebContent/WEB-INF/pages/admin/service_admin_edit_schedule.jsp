 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin screening schedules edit page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Functions (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="4"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="screeningSchedules"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
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
                                                    <label>Upcoming screening date</label>
                                                    <span class="floatL"><b>:</b></span>
                                                    <span class="marginLeft10 dateWrapper">
                                                        <input id="upcomingScreeningDateDatePart" type="text" readonly="readonly" class="date" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="MM/dd/yyyy" />' />
                                                    </span>
                                                </div>
                                                <div id="screeningTimeRow" class="row">
                                                    <label>Upcoming screening Time</label>
                                                    <span class="floatL"><b>:</b></span>
                                                    <input name="upcomingScreeningDateHourPart" id="upcomingScreeningDateHourPart" type="text" class="shortInput text" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="hh" />'/>
                                                    <span class="floatL"><b>:</b></span>
                                                    <input name="upcomingScreeningDateMinutePart" id="upcomingScreeningDateMinutePart" type="text" class="shortInput text" value='<fmt:formatDate value="${schedule.upcomingScreeningDate}" pattern="mm" />'/>
                                                    <fmt:formatDate var="upcomingScreeningDateTimeSelect" value="${schedule.upcomingScreeningDate}" pattern="a" />
                                                    <select id="upcomingScreeningDateSelect" class="timeSelect">
                                                        <option <c:if test="${upcomingScreeningDateTimeSelect=='AM'}">selected="selected"</c:if> value="AM">AM</option>
                                                        <option <c:if test="${upcomingScreeningDateTimeSelect=='PM'}">selected="selected"</c:if> value="PM">PM</option>
                                                    </select>
                                                    <form:hidden path="upcomingScreeningDate" id="upcomingScreeningDateField"/>
                                                    <form:hidden path="id"/>
                                                </div>
                                                <div id="intervalRow" class="row">
                                                    <label>Screening interval</label>
                                                    <span class="floatL"><b>:</b></span>
                                                    <span class="marginLeft10 floatL">
                                                        <span class="floatL">Every</span>
                                                        <form:input path="interval" cssClass="text shortInput marginLeft20"/>
                                                        <form:select id="intervalType" cssClass="timeSelect" path="intervalType">
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
                                        <a href="${ctx}/admin/getScreeningSchedule" class="greyBtn canceleScheduleBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                                        <a href="javascript:;" class="greyBtn saveScheduleBtn"><span class="btR"><span class="btM">Save</span></span></a>
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

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>