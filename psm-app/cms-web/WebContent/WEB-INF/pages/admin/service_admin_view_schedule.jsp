 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin screening schedules page.
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
                            <div id="screenSchedulePanel">
                                <div class="pagination">
                                    <div class="right">
                                        <a class="purpleBtn changeScheduleBtn" href="${ctx}/admin/beginEditScreeningSchedule"><span class="btR"><span class="btM">Change Schedule</span></span></a>
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

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>