 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the dashboard service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Dashboard"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent" class="detailPage">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabDashboard" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>

          <div class="breadCrumb">
            <span class="text">Dashboard</span>
          </div>
          <div class="head">
            <h1>Dashboard</h1>
          </div>
          <div class="clearFixed"></div>
          <h:handlebars template="includes/flash" context="${pageContext}" />
          <div class="dashboardPanel">
            <div class="tableData">
              <div class="tableTitle">
                <a href="<c:url value="/provider/enrollment/start" />">New Enrollment / Renewal</a>
                <h2>Latest Actions</h2>
              </div>
              <c:choose>
              <c:when test="${empty profiles}">
                <div class="noData">No matched data found.</div>
              </c:when>
              <c:otherwise>
                <table class="generalTable fixedWidthTable">
                  <thead>
                    <tr>
                      <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                      <th class="alignCenter">Provider Type<span class="sep"></span></th>
                      <th class="alignCenter">Provider Name<span class="sep"></span></th>
                      <th class="alignCenter">Request Type<span class="sep"></span></th>
                      <th class="alignCenter">Date<span class="sep"></span></th>
                      <th class="alignCenter">Status<span class="sep"></span></th>
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
                  <label for="dashboardEnrollmentNumber">Enrollment Number:</label>
                  <input id="dashboardEnrollmentNumber" type="text" class="text" value="${invalidEnrollmentNumberValue}" />
                  <input type="hidden" id="invalidEnrollmentNumber" value="${invalidEnrollmentNumber}"/>
                  <a id="queryEnrollmentStatus" href="javascript:;" class="purpleBtn">Query Status</a>
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
                  <c:when test="${empty notifications}">
                    <div class="noData">No matched data found.</div>
                  </c:when>
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

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
