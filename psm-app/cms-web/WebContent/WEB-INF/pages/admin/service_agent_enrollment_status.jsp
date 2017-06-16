 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollment status service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Status Query"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="1"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        <a href="${ctx}/agent/enrollment/viewDashboard">Dashboard</a>
                        <span>Enrollment Status</span>
                    </div>
                    <div class="head">
                        <h1>Enrollment Status</h1>
                    </div>
                    <div class="tabSection">
                        <div class="detailPanel">
                            <div class="section">
                                <div class="wholeCol">
                                    <div class="row">
                                        <label>NPI / UMPI</label>
                                        <span class="floatL"><b>:</b></span>
                                        <a href="${ctx}/provider/enrollment/view?id=${profile.ticketId}">${profile.npi}</a>
                                    </div>
                                    <div class="row">
                                        <label>Date Submitted</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><fmt:formatDate value="${profile.submissionDate}" pattern="MM/dd/yyyy"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Provider Type</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${profile.providerType}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Provider Name</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${profile.providerName}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Request Type</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${profile.requestType}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Status</label>
                                        <span class="floatL"><b>:</b></span>
                                        <c:choose>
                                            <c:when test="${fn:toLowerCase(profile.status)=='approved'}"><span class="green">Approved</span></c:when>
                                            <c:when test="${fn:toLowerCase(profile.status)=='rejected'}"><span class="red">Denied</span></c:when>
                                            <c:otherwise>${profile.status}</c:otherwise>
                                         </c:choose>
                                    </div>
                                    <div class="row">
                                        <label>Risk Level</label>
                                        <span class="floatL"><b>:</b></span>
                                        <c:choose>
                                            <c:when test="${fn:toLowerCase(profile.riskLevel)=='limited'}"><span class="green">Limited</span></c:when>
                                            <c:when test="${fn:toLowerCase(profile.riskLevel)=='high'}"><span class="red">High</span></c:when>
                                            <c:otherwise>${profile.riskLevel}</c:otherwise>
                                         </c:choose>
                                    </div>
                                </div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>