 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the dashboard service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Dashboard"/>
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
						<span class="text">Dashboard</span>
					</div>
					<div class="head">
						<h1>Dashboard</h1>
					</div>
					<div class="clearFixed"></div>
					<%@include file="/WEB-INF/pages/includes/flash.jsp" %>
                    <div class="dashboardPanel">
                        <div class="tableData">
                        	<div class="tableTitle">
                            	 <a href="<c:url value="/provider/enrollment/start" />">New Enrollment / Renewal</a>
                            	<h2>Latest Actions</h2>
                            </div>
                            <c:choose>
                                <c:when test="${empty profiles}"><div style="color: red" class="noData">No matched data found.</div></c:when>
                                <c:otherwise>
                                    <table cellpadding="0" cellspacing="0" class="generalTable fixedWidthTable">
                                        <thead>
                                            <tr>
                                                <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                                                <th class="alignCenter">Provider Type<span class="sep"></span></th>
                                                <th class="alignCenter">Provider Name<span class="sep"></span></th>
                                                <th class="alignCenter">Request Type<span class="sep"></span></th>
                                                <th class="alignCenter">Date<span class="sep"></span></th>
                                                <th class="alignCenter">Action<span class="sep"></span></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${profiles}" var="item">
                                                <tr>
                                                    <td>
                                                        <a href="${ctx}/provider/enrollment/view?id=${item.ticketId}">${item.npi}</a>
                                                    </td>
                                                    <td>${item.providerType}</td>
                                                    <td>${item.providerName}</td>
                                                    <td>${item.requestType}</td>
                                                    <td><fmt:formatDate value="${item.statusDate}" pattern="MM/dd/yyyy"/></td>
                                                    <td>${item.status}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                            <div class="clearFixed"></div>
                            <div class="tl"></div>
                            <div class="tr"></div>
                        </div>
                        <!-- /.tableData -->
                        <div class="sideBar">
                        	<div class="queryEnrollmentStatusPanel panel">
                            	<div class="panelHeader">
                                	<h2>Query Enrollment Status</h2>
                                </div>
                                <div class="panelSection">
                                	<label>Enrollment Number:</label>
                                    <input id="enrollmentNumber" type="text" class="text" value="${invalidEnrollmentNumberValue}" />
                                    <input type="hidden" id="invalidEnrollmentNumber" value="${invalidEnrollmentNumber}"/>
                                    <a id="queryEnrollmentStatus" href="javascript:;" class="purpleBtn"><span class="btR"><span class="btM">Query Status</span></span></a>
                                </div>
                                <div id="invalidEnrollmentNumberError" class="enrollmentNumberError hide">
                                    <span class="red">Invalid 'Enrollment Number' ( not exist ).</span>
                                </div>
                                <div id="requiredEnrollmentNumberError" class="enrollmentNumberError hide">
                                    <span class="red">This field is required.</span>
                                </div>
                                <div class="tl"></div>
                                <div class="tr"></div>
                            </div>
                            <!-- /.queryEnrollmentStatus -->
                            <div class="notificationsPanel panel">
                            	<div class="panelHeader">
                                	<h2>Notifications</h2>
                                </div>
                                <div class="panelSection">
                                    <c:choose>
                                        <c:when test="${empty notifications}"><div style="color: red" class="noData">No matched data found.</div></c:when>
                                        <c:otherwise>
                                            <ul>
                                                <c:forEach items="${notifications}" var="item">
                                                    <li>
                                                        <p><strong>NPI/UMPI</strong>
                                                            <a href="${ctx}/provider/enrollment/view?id=${item.ticketId}">${item.npi}</a> has been 
                                                        <c:choose>
                                                            <c:when test="${fn:toLowerCase(item.status)=='approved'}"><span class="green">${item.status}</span></c:when>
                                                            <c:when test="${fn:toLowerCase(item.status)=='rejected'}"><span class="red">Denied</span></c:when>
                                                            <c:otherwise>${item.status}</c:otherwise>
                                                         </c:choose>
                                                        .</p>
                                                        <span class="date"><fmt:formatDate value="${item.createdOn}" pattern="MM/dd/yyyy hh:mm:ss a"/></span>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="tl"></div>
                                <div class="tr"></div>
                            </div>
                            <!-- /.notifications -->
                        </div>
                        <!-- /.sideBar -->
                    </div>
                    <!-- /.dashboardPanel -->
				</div>
			</div>
			<!-- /#mainContent -->

			<%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
		</div>
		<!-- /#wrapper -->
	</body>
</html>